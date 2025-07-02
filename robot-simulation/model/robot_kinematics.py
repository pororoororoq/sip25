"""
Author: Miguel Tamayo

robot_dynamics.py
Contains class describing the robot's dynamics
"""

from .states import RobotState, RobotDerivativeState
from inputs.control_inputs import WheelLinearInputs
from utilities.constants import *

import numpy as np

class RobotKinematics:
    """
    class that hold robot's kinematics model

    inputs:
    -------
        dt (float): robot's step time

    return:
    -------
        kinematics (RobotKinematics): robot's kinematics instance
    """
    def __init__(self,
                 dt: float=0.01) -> None:
        
        self.state = RobotState()           # initialize current robot state to 0
        self.dot = RobotDerivativeState()   # initialize current robot derivative to 0
        self.local_dot = RobotDerivativeState() # derivative state to keep track of local vx, vy
        self.dt = dt                        # sampling time

    def setState(self, state:RobotState) -> None:
        """
        sets state to desired state
        
        inputs:
        -------
            state (RobotState): new robot's state
        """
        self.state = state

        return None

    def setDotState(self, dot:RobotDerivativeState) -> None:
        """
        sets derivative state to desired derivative state

        inputs:
        -------
            dot (RobotDerivativeState): robot's new derivative state
        """
        self.dot = dot

        return None

    def reset(self) -> None:
        """
        makes the robot's state and derivative state zero
        """
        self.setState(RobotState()) # reset state
        self.setDotState(RobotDerivativeState()) # reset derivative state


        return None


    def getState(self) -> RobotState:
        """
        gets the robot's current state

        return:
        -------
            state (RobotState): robot's state
        """
        return self.state
    
    def getDotState(self) -> RobotDerivativeState:
        """
        gets the robot's derivative state

        return:
        -------
            derivative (RobotDerivativeState): robot's derivative state
        """
        return self.dot
    
    def getWheelVelocities(self) -> RobotDerivativeState:
        """
        gets the robot's left and right wheel velocities

        return:
        -------
            velocities (RobotDerivativeState): robot's left and right wheel velocities
        """
        return self.local_dot
    
    def update(self, controls: WheelLinearInputs, noise_std: float = 0.0) -> None:
        """
        updates the robot's dynamics, with optional encoder noise

        inputs:
        -------
            controls (ControlsInputs): robot's inputs
            noise_std (float): standard deviation of Gaussian noise for encoders
        """
        # Simulate encoder noise
        noisy_vl = controls.vl + np.random.normal(0, noise_std) if noise_std > 0 else controls.vl
        noisy_vr = controls.vr + np.random.normal(0, noise_std) if noise_std > 0 else controls.vr

        avg_vel = (noisy_vl + noisy_vr) / 2
        self.local_dot.vx = avg_vel
        self.local_dot.vy = avg_vel

        self.dot = self.computeDerivative(state=self.state, vl=noisy_vl, vr=noisy_vr) # calculate new derivative
        self.state = self.integrateState(state=self.state, dot=self.dot) # integrate by dT
        
        return None

    def computeDerivative(self, state: RobotState, vl: float, vr: float) -> RobotDerivativeState:
        """
        computes the robot's time-derivative give the linear velocities in the robot's loca frame

        inputs:
        -------
            state (RobotState): robot's current state
            vl (float): left wheel linear velocity input [m/s]
            vr (float): right wheel linear velocity input [m/s]

        return:
        -------
            dot (RobotDerivativeState): time derivative state
        """
        dot = RobotDerivativeState() # empty state
        v = (vr + vl) / 2. # robot's linear velocity in robot's frame
        w = (vr - vl) / L # robot's angular velocity around center

        # create derivative state
        dot.vx = v * np.cos(state.phi + (w*self.dt)/2) # vel in global frame
        dot.vy = v * np.sin(state.phi + (w*self.dt)/2) # vel in global frame
        dot.w = w

        return dot
    
    def integrateState(self, state: RobotState, dot: RobotDerivativeState) -> RobotState:
        """
        integrates the vehicle state using trapezoidal integration

        inputs:
        -------
            state (RobotState): robot state to integrate
            dot (RobotDerivativeState): robot derivative state

        return:
        -------
            new_state (RobotState): new robot state with integrated components
        """
        new_state = RobotState() # create empty instance
        new_state.px = state.px + dot.vx * self.dt
        new_state.py = state.py + dot.vy * self.dt
        new_state.phi = state.phi + dot.w * self.dt

        return new_state