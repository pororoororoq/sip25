"""
Author: Miguel Tamayo

robot_simulate.py
Handles all aspects of the robot's simulation such as updating its position
"""

from PyQt5.QtCore import QObject, pyqtSignal, QTimer
from model.robot_kinematics import RobotKinematics
from model.states import RobotState, RobotDerivativeState
from inputs.control_inputs import WheelLinearInputs
from utilities.constants import *
import gtsam
import numpy as np

class RobotSimulate1(QObject):
    # sends the robot's state when calculations are finished
    finished_signal = pyqtSignal(RobotState)

    stop_signal = pyqtSignal() # signal to stop the internal timer
    start_signal = pyqtSignal() # signal to start the internal timer

    # sends parameters necessary to update the plots
    update_plots_signal = pyqtSignal(float, RobotState, RobotDerivativeState)

    def __init__(self) -> None:
        super().__init__(parent=None)
        self.dt = dt # time steps
        self.time = 0. # initialize simulation time ot 0
        self.robot_model = RobotKinematics(dt=self.dt)
        self.ticks = 0
        self.noise_std = 0.02  # Set your desired encoder noise std
        self.true_poses = [gtsam.Pose2(0, 0, 0)]
        self.odom_measurements = []
        self.gtsam_result = None

        # setup the timer for the object
        self.simulationTimedThread = QTimer()
        self.simulationTimedThread.timeout.connect(self.takeStep)

        # connect the signals to start and stop the simulation
        self.start_signal.connect(self.run)
        self.stop_signal.connect(self.stop)
        

    def run(self) -> None:
        """
        runs the timer for the main robot updates on this new thread
        """
        self.simulationTimedThread.start(10)

    def stop(self) -> None:
        """
        stops the internal simulation timer
        """
        self.simulationTimedThread.stop()

    def takeStep(self) -> None:
        """
        advances the robot (through its kinematics) in time
        """
        self.ticks += 1
        self.time += self.dt # step in time
        inputs = WheelLinearInputs(vl=0.5, vr=0.5)
        # Save previous state for odometry
        prev_state = self.robot_model.getState()
        # Update with noise
        self.robot_model.update(inputs, noise_std=self.noise_std)
        curr_state = self.robot_model.getState()
        # Convert to gtsam.Pose2 (assuming px, py, phi)
        prev_pose = gtsam.Pose2(prev_state.px, prev_state.py, prev_state.phi)
        curr_pose = gtsam.Pose2(curr_state.px, curr_state.py, curr_state.phi)
        self.true_poses.append(curr_pose)
        # Odometry delta (noisy)
        odom_delta = prev_pose.between(curr_pose)
        self.odom_measurements.append(odom_delta)
        # Run GTSAM estimation every N steps
        if len(self.odom_measurements) > 1 and self.ticks % plotUpdateTicks == 0:
            self.gtsam_result = self.run_gtsam_estimation(self.odom_measurements)
        # Emit both true and estimated state
        self.finished_signal.emit(curr_state)
        if self.ticks % plotUpdateTicks == 0:
            est_pose = None
            if self.gtsam_result is not None:
                est_pose = self.gtsam_result.atPose2(len(self.odom_measurements))
            self.update_plots_signal.emit(self.time, curr_state, self.robot_model.getWheelVelocities())
            # Optionally, emit est_pose for visualization (add a new signal if needed)
        return None

    def run_gtsam_estimation(self, odometry_measurements):
        graph = gtsam.NonlinearFactorGraph()
        initial = gtsam.Values()
        prior_noise = gtsam.noiseModel.Diagonal.Sigmas(np.array([0.01, 0.01, 0.01]))
        odo_noise = gtsam.noiseModel.Diagonal.Sigmas(np.array([self.noise_std]*3))
        graph.add(gtsam.PriorFactorPose2(0, gtsam.Pose2(0, 0, 0), prior_noise))
        initial.insert(0, gtsam.Pose2(0, 0, 0))
        for i, odom in enumerate(odometry_measurements):
            graph.add(gtsam.BetweenFactorPose2(i, i+1, odom, odo_noise))
            prev = initial.atPose2(i)
            initial.insert(i+1, prev.compose(odom))
        params = gtsam.LevenbergMarquardtParams()
        optimizer = gtsam.LevenbergMarquardtOptimizer(graph, initial, params)
        result = optimizer.optimize()
        return result

class RobotSimulate:
    """
    Wrapper class that handles the robot's dynamics, states, and advancing the robot in time

    return:
    -------
        robot_sim (RobotSimulate): Robot simulation instance
    """
    def __init__(self) -> None:
        self.dt = dt # time steps
        self.time = 0. # initialize simulation time to 0
        self.robot_model = RobotKinematics(dt=self.dt)
        self.noise_std = 0.02
        self.true_poses = [gtsam.Pose2(0, 0, 0)]
        self.odom_measurements = []
        self.gtsam_result = None
    def takeStep(self, controls: WheelLinearInputs) -> None:
        self.time += self.dt # step in time
        prev_state = self.robot_model.getState()
        self.robot_model.update(controls, noise_std=self.noise_std)
        curr_state = self.robot_model.getState()
        prev_pose = gtsam.Pose2(prev_state.px, prev_state.py, prev_state.phi)
        curr_pose = gtsam.Pose2(curr_state.px, curr_state.py, curr_state.phi)
        self.true_poses.append(curr_pose)
        odom_delta = prev_pose.between(curr_pose)
        self.odom_measurements.append(odom_delta)
        if len(self.odom_measurements) > 1:
            self.gtsam_result = self.run_gtsam_estimation(self.odom_measurements)
        return None
    def run_gtsam_estimation(self, odometry_measurements):
        graph = gtsam.NonlinearFactorGraph()
        initial = gtsam.Values()
        prior_noise = gtsam.noiseModel.Diagonal.Sigmas(np.array([0.01, 0.01, 0.01]))
        odo_noise = gtsam.noiseModel.Diagonal.Sigmas(np.array([self.noise_std]*3))
        graph.add(gtsam.PriorFactorPose2(0, gtsam.Pose2(0, 0, 0), prior_noise))
        initial.insert(0, gtsam.Pose2(0, 0, 0))
        for i, odom in enumerate(odometry_measurements):
            graph.add(gtsam.BetweenFactorPose2(i, i+1, odom, odo_noise))
            prev = initial.atPose2(i)
            initial.insert(i+1, prev.compose(odom))
        params = gtsam.LevenbergMarquardtParams()
        optimizer = gtsam.LevenbergMarquardtOptimizer(graph, initial, params)
        result = optimizer.optimize()
        return result

