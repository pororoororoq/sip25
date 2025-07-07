"""
Author: Miguel Tamayo

main_window.py
Manages all the widgets on the user interface as well as the functions for interactive widgets
"""

import sys
from PyQt5.QtWidgets import (QMainWindow, QWidget, QGridLayout, QGraphicsView,
                             QGraphicsScene, QHBoxLayout)

from PyQt5.QtCore import QThread, QMetaObject

import numpy as np

from .robot_display import RobotDisplay
from .path import Path
from .plotter import Plotter
from .button import Button
from model.states import RobotState, RobotDerivativeState
from .robot_simulate import RobotSimulate, RobotSimulate1
from utilities.constants import *

from PyQt5.QtWidgets import QWidget
from PyQt5.QtGui import QColor

class MainWindow(QMainWindow):
    """
    Class representing PyQt5 window
    
    return:
    -------
        window (MainWindow): PyQt5 window object
    """
    def __init__(self) -> None:
        super().__init__()
        self.setWindowTitle("Robot Simulation")
        self.simulationPaused = True # begin with a paused simulation

        ### ----- pyqt5 application window ----- ###
        self.setGeometry(100, 100, window_width, window_height)

        ### ----- main widget ----- ###
        # this is the widget that takes the entire screen and is split in cells
        mainWdiget = QWidget()
        layout = QGridLayout()
        self.setCentralWidget(mainWdiget)

        ### ----- simulation canvas widget ----- ###
        canvas = QGraphicsView(mainWdiget) # create QGrahicsView object as a viewport to the drawings
        canvas.setFixedSize(canvas_width, canvas_height) # set the canvas size

        # create scene to handle robot item
        self.scene = QGraphicsScene(canvas)
        self.scene.setBackgroundBrush(background_color)

        self.robot_unopt = RobotDisplay() # create robot instance at the origin facing x+
        self.robot_path_unopt = Path(QColor('red'), 1.5) # path to follow robot's position

        # add robot and path to the scene
        self.scene.addItem(self.robot_unopt)
        self.scene.addItem(self.robot_path_unopt)

        canvas.setScene(self.scene) # add the scene to the canvas

        ### ----- play, stop, and reset buttons ----- ###
        # create button area
        button_layout = QHBoxLayout()
        button_widget = QWidget()

        # create buttons and connect them to their functions
        self.play_button = Button(txt="Play", width=button_width)
        self.play_button.buttonClickedSignal.connect(self.playSimulation)

        self.pause_button = Button(txt="Pause", width=button_width)
        self.pause_button.buttonClickedSignal.connect(self.pauseSimulation)

        self.reset_button = Button(txt="Reset", width=button_width)
        self.reset_button.buttonClickedSignal.connect(self.resetSimulation)

        # add the button objects to the button area
        button_layout.addWidget(self.play_button)
        button_layout.addWidget(self.pause_button)
        button_layout.addWidget(self.reset_button)

        button_widget.setLayout(button_layout)

        ### ----- state graphs ----- ###
        # create graph area
        state_graph_widget = QWidget()
        state_graph_layout = QHBoxLayout()

        # create graph objects for unoptimized robot
        self.x_pos_plot_unopt = Plotter(title= "Unopt x-axis position", x_label="time (s)", y_label="position (m)")
        self.y_pos_plot_unopt = Plotter(title="Unopt y-axis position", x_label="time (s)", y_label="position (m)")
        self.phi_plot_unopt = Plotter(title="Unopt heading", x_label="time (s)", y_label="heading (deg)")
        # create graph objects for optimized robot
        self.x_pos_plot_opt = Plotter(title= "Opt x-axis position", x_label="time (s)", y_label="position (m)")
        self.y_pos_plot_opt = Plotter(title="Opt y-axis position", x_label="time (s)", y_label="position (m)")
        self.phi_plot_opt = Plotter(title="Opt heading", x_label="time (s)", y_label="heading (deg)")

        # add the graphs to the graph areas
        state_graph_layout_top = QHBoxLayout()
        state_graph_layout_top.addWidget(self.x_pos_plot_unopt)
        state_graph_layout_top.addWidget(self.y_pos_plot_unopt)
        state_graph_layout_top.addWidget(self.phi_plot_unopt)
        state_graph_widget_top = QWidget()
        state_graph_widget_top.setLayout(state_graph_layout_top)

        state_graph_layout_bottom = QHBoxLayout()
        state_graph_layout_bottom.addWidget(self.x_pos_plot_opt)
        state_graph_layout_bottom.addWidget(self.y_pos_plot_opt)
        state_graph_layout_bottom.addWidget(self.phi_plot_opt)
        state_graph_widget_bottom = QWidget()
        state_graph_widget_bottom.setLayout(state_graph_layout_bottom)

        ### ----- Add widgets to the main layout ----- ###
        # row | column | rowSpan | ColumnSpan
        layout.addWidget(canvas, 0, 0, 2, 1)
        layout.addWidget(button_widget, 2, 0, 1, 1)
        layout.addWidget(state_graph_widget_top, 0, 1, 1, 1)
        layout.addWidget(state_graph_widget_bottom, 1, 1, 1, 1)

        layout.setSpacing(0)
        layout.setRowStretch(3, 2)
        mainWdiget.setLayout(layout)

        ### ----- Simulation Thread ----- ###
        # Unoptimized robot
        self.sim_thread_unopt = QThread()
        self.robot_sim_unopt = RobotSimulate1("range_unoptimized.txt")
        self.robot_sim_unopt.moveToThread(self.sim_thread_unopt)
        # Optimized robot
        self.sim_thread_opt = QThread()
        self.robot_sim_opt = RobotSimulate1("range_optimized.txt")
        self.robot_sim_opt.moveToThread(self.sim_thread_opt)

        # Add second robot and path to the scene (different color for clarity)
        self.robot_opt = RobotDisplay()
        self.robot_path_opt = Path(QColor('green'), 1.5)
        self.scene.addItem(self.robot_opt)
        self.scene.addItem(self.robot_path_opt)

        # Connect thread signals for both robots
        self.sim_thread_unopt.started.connect(self.robot_sim_unopt.start_signal.emit)
        self.sim_thread_unopt.finished.connect(self.robot_sim_unopt.stop_signal.emit)
        self.robot_sim_unopt.finished_signal.connect(self.updateGUIUnopt)
        self.robot_sim_unopt.update_plots_signal.connect(self.updatePlotsUnopt)

        self.sim_thread_opt.started.connect(self.robot_sim_opt.start_signal.emit)
        self.sim_thread_opt.finished.connect(self.robot_sim_opt.stop_signal.emit)
        self.robot_sim_opt.finished_signal.connect(self.updateGUIOpt)
        self.robot_sim_opt.update_plots_signal.connect(self.updatePlotsOpt)

    def updateGUIUnopt(self, robot_state: RobotState) -> None:
        """
        Updates the canvas and graphs for the unoptimized robot
        """
        self.robot_path_unopt.updatePath(robot_state.px, robot_state.py)
        self.robot_unopt.updatePosition(robot_state.px, robot_state.py, robot_state.phi)

    def updateGUIOpt(self, robot_state: RobotState) -> None:
        """
        Updates the canvas and graphs for the optimized robot
        """
        self.robot_path_opt.updatePath(robot_state.px, robot_state.py)
        self.robot_opt.updatePosition(robot_state.px, robot_state.py, robot_state.phi)

    def updatePlotsUnopt(self, time: float, state: RobotState, wheel_vel: RobotDerivativeState) -> None:
        """
        Updates GUI graphs for the unoptimized robot
        """
        self.x_pos_plot_unopt.update_plot_signal.emit(time, [state.px])
        self.y_pos_plot_unopt.update_plot_signal.emit(time, [state.py])
        self.phi_plot_unopt.update_plot_signal.emit(time, [np.rad2deg(state.phi)])

    def updatePlotsOpt(self, time: float, state: RobotState, wheel_vel: RobotDerivativeState) -> None:
        """
        Updates GUI graphs for the optimized robot
        """
        self.x_pos_plot_opt.update_plot_signal.emit(time, [state.px])
        self.y_pos_plot_opt.update_plot_signal.emit(time, [state.py])
        self.phi_plot_opt.update_plot_signal.emit(time, [np.rad2deg(state.phi)])

    def playSimulation(self):
        """
        Starts simulation if currently stopped
        """
        self.sim_thread_unopt.start()
        self.sim_thread_opt.start()

        # update button statuses
        self.play_button.setDisabled(True)
        self.pause_button.setDisabled(False)
        self.simulationPaused = False

    def pauseSimulation(self):
        """
        Pauses simulation if currently playing
        """
        self.sim_thread_unopt.quit()
        self.sim_thread_opt.quit()

        # update the button statues
        self.play_button.setDisabled(False)
        self.pause_button.setDisabled(True)

        self.simulationPaused = True

    def resetSimulation(self):
        """
        Stops and resets the simulation
        """
        self.pauseSimulation() # pause the simulation

        # reset robot objects
        self.robot_sim_unopt.reset()
        self.robot_sim_opt.reset()
        robot_state_unopt = self.robot_sim_unopt.robot_model.getState()
        robot_state_opt = self.robot_sim_opt.robot_model.getState()
        self.scene.removeItem(self.robot_unopt)
        self.scene.removeItem(self.robot_opt)
        self.scene.addItem(self.robot_unopt)
        self.scene.addItem(self.robot_opt)
        self.robot_unopt.updatePosition(robot_state_unopt.px, robot_state_unopt.py, robot_state_unopt.phi)
        self.robot_opt.updatePosition(robot_state_opt.px, robot_state_opt.py, robot_state_opt.phi)

        # reset path objects
        self.robot_path_unopt.clear_path()
        self.robot_path_opt.clear_path()

        # reset the plots
        self.x_pos_plot_unopt.reset_plot()
        self.y_pos_plot_unopt.reset_plot()
        self.phi_plot_unopt.reset_plot()
        self.x_pos_plot_opt.reset_plot()
        self.y_pos_plot_opt.reset_plot()
        self.phi_plot_opt.reset_plot()
