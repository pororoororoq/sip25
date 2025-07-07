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
import os

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
        self.replay_poses = []
        self.replay_mode = False
        self.replay_index = 0
        self.move_step_interval = 1 # Number of timer ticks for moving between poses
        self.turn_step_interval = 1   # Number of timer ticks for turning in place
        self.replay_step_interval = self.move_step_interval + self.turn_step_interval
        self.replay_interp_step = 0
        self.current_pose = None
        self.next_pose = None
        # Set the replay file path in a variable for easy modification
        self.replay_filename = 'range_optimized.txt'  # Change this to use a different factor graph file
        replay_path = os.path.join(os.path.dirname(__file__), f'../data/{self.replay_filename}')
        if os.path.exists(replay_path):
            with open(replay_path, 'r') as f:
                for line in f:
                    x, y, theta = map(float, line.strip().split())
                    self.replay_poses.append((x, y, theta))
            if self.replay_poses:
                self.replay_mode = True
                self.replay_index = 0
                self.replay_interp_step = 0
                if len(self.replay_poses) > 1:
                    self.current_pose = self.replay_poses[0]
                    self.next_pose = self.replay_poses[1]
                else:
                    self.current_pose = self.replay_poses[0]
                    self.next_pose = self.replay_poses[0]
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
        self.simulationTimedThread.start(1)

    def stop(self) -> None:
        """
        stops the internal simulation timer
        """
        self.simulationTimedThread.stop()

    def takeStep(self) -> None:
        """
        advances the robot (through its kinematics or replay)
        """
        self.ticks += 1
        self.time += self.dt # step in time
        if self.replay_mode and self.replay_poses and self.current_pose and self.next_pose:
            # Move then rotate: use separate intervals for each
            if self.replay_interp_step < self.move_step_interval:
                # Interpolate x, y with constant heading
                t = self.replay_interp_step / self.move_step_interval
                x = (1 - t) * self.current_pose[0] + t * self.next_pose[0]
                y = (1 - t) * self.current_pose[1] + t * self.next_pose[1]
                theta = self.current_pose[2]
                #print(f"x: {x}, y: {y}, theta: {theta}")
            else:
                # Interpolate theta in place
                t = (self.replay_interp_step - self.move_step_interval) / self.turn_step_interval
                x = self.next_pose[0]
                y = self.next_pose[1]
                theta = (1 - t) * self.current_pose[2] + t * self.next_pose[2]
            self.robot_model.setState(RobotState(x, y, theta))
            self.replay_interp_step += 1
            if self.replay_interp_step > self.replay_step_interval:
                self.replay_interp_step = 0
                self.replay_index += 1
                if self.replay_index < len(self.replay_poses) - 1:
                    self.current_pose = self.replay_poses[self.replay_index]
                    self.next_pose = self.replay_poses[self.replay_index + 1]
                else:
                    # Hold at last pose
                    self.current_pose = self.replay_poses[-1]
                    self.next_pose = self.replay_poses[-1]
        else:
            inputs = WheelLinearInputs(vl=0.4, vr=0.5)
            self.robot_model.update(inputs) # update robot state
        self.finished_signal.emit(self.robot_model.getState()) # emit a signal to tell we're done
        if self.ticks % plotUpdateTicks == 0:
            self.update_plots_signal.emit(self.time, self.robot_model.getState(), self.robot_model.getWheelVelocities())
        return None

    def getStates(self) -> list:
        """
        returns the different states of interest from the robot
        """

        return self.robot_model.getState(), self.robot_model.getWheelVelocities()

    def reset(self) -> None:
        """
        resets the robot's states and replay index
        """
        self.time = 0.
        self.robot_model.reset()
        self.replay_index = 0
        self.replay_interp_step = 0
        if self.replay_poses:
            self.current_pose = self.replay_poses[0]
            if len(self.replay_poses) > 1:
                self.next_pose = self.replay_poses[1]
            else:
                self.next_pose = self.replay_poses[0]

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
    
    def takeStep(self, controls: WheelLinearInputs) -> None:
        """
        advances the robot (through its dynamics) in time

        inputs:
        -------
            controls (WheelLinearInputs): robot's left and rigth wheel velocities
        """
        self.time += self.dt # step in time
        self.robot_model.update(controls) # update robot state

        return None

