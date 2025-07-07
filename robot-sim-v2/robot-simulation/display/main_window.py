"""
Author: Miguel Tamayo

main_window.py
Manages all the widgets on the user interface as well as the functions for interactive widgets
"""

import sys
import os
from PyQt5.QtWidgets import (QMainWindow, QWidget, QGridLayout, QGraphicsView,
                             QGraphicsScene, QHBoxLayout)

from PyQt5.QtCore import QThread, QMetaObject, QTimer

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
    def __init__(self, base_names=None, plot_landmarks_enabled=True) -> None:
        super().__init__()
        self.setWindowTitle("Robot Simulation")
        self.simulationPaused = True # begin with a paused simulation
        self.plot_landmarks_enabled = plot_landmarks_enabled
        if base_names is None:
            base_names = ["range"]
        self.base_names = base_names if isinstance(base_names, list) else [base_names]
        self.landmark_files, self.sim_files = self.expand_base_names(self.base_names)

        ### ----- pyqt5 application window ----- ###
        self.setGeometry(100, 100, window_width, window_height)

        ### ----- main widget ----- ###
        # this is the widget that takes the entire screen and is split in cells
        mainWdiget = QWidget()
        layout = QGridLayout()
        self.setCentralWidget(mainWdiget)

        ### ----- simulation canvas widget ----- ###
        self.canvas = QGraphicsView(mainWdiget) # create QGrahicsView object as a viewport to the drawings
        self.canvas.setFixedSize(canvas_width, canvas_height) # set the canvas size

        # create scene to handle robot item
        self.scene = QGraphicsScene(self.canvas)
        self.scene.setBackgroundBrush(background_color)

        self.robot_unopt = RobotDisplay() # create robot instance at the origin facing x+
        self.robot_path_unopt = Path(QColor('red'), 1.5) # path to follow robot's position

        # add robot and path to the scene
        self.scene.addItem(self.robot_unopt)
        self.scene.addItem(self.robot_path_unopt)

        self.canvas.setScene(self.scene) # add the scene to the canvas

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
        layout.addWidget(self.canvas, 0, 0, 2, 1)
        layout.addWidget(button_widget, 2, 0, 1, 1)
        layout.addWidget(state_graph_widget_top, 0, 1, 1, 1)
        layout.addWidget(state_graph_widget_bottom, 1, 1, 1, 1)

        layout.setSpacing(0)
        layout.setRowStretch(3, 2)
        mainWdiget.setLayout(layout)

        ### ----- Simulation Thread ----- ###
        # Unoptimized robot
        self.sim_thread_unopt = QThread()
        self.robot_sim_unopt = RobotSimulate1(self.sim_files[0])
        self.robot_sim_unopt.moveToThread(self.sim_thread_unopt)
        # Optimized robot
        self.sim_thread_opt = QThread()
        self.robot_sim_opt = RobotSimulate1(self.sim_files[1])
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

        if self.plot_landmarks_enabled:
            self.plot_landmarks(self.landmark_files)
            # Fit the view after all items are added and window is shown
            QTimer.singleShot(0, self.fit_canvas_view)

    def plot_landmarks(self, files=None, plot=True):
        """
        Plots landmarks from given files on the scene and sets the scene rect to fit all points.
        Args:
            files (list): List of file paths to read landmarks from.
            plot (bool): Whether to plot the landmarks (default True).
        """
        import os
        from PyQt5.QtWidgets import QGraphicsEllipseItem
        from PyQt5.QtGui import QBrush, QColor
        if files is None:
            files = self.landmark_files
        # Helper to read points
        def read_points(filename):
            points = []
            if not os.path.exists(filename):
                return points
            with open(filename, 'r') as f:
                for line in f:
                    if line.strip() == '':
                        continue
                    try:
                        x_str, y_str = line.strip().split()
                        x, y = float(x_str), float(y_str)
                        points.append((x, y))
                    except Exception:
                        continue
            return points
        all_points = []
        colors = ["#FFA7A7", "#B2FFB2", "#A7C7FF", "#FFD580"]
        for idx, file in enumerate(files):
            pts = read_points(file)
            if plot:
                color = colors[idx % len(colors)]
                for x, y in pts:
                    ellipse = QGraphicsEllipseItem(x*100-3, -y*100-3, 6, 6)
                    ellipse.setBrush(QBrush(QColor(color)))
                    ellipse.setPen(QColor(color))
                    self.scene.addItem(ellipse)
            all_points.extend(pts)
        # Compute bounds
        if all_points:
            xs, ys = zip(*all_points)
            margin = 1.0  # meters, add margin around all points
            min_x, max_x = min(xs)-margin, max(xs)+margin
            min_y, max_y = min(ys)-margin, max(ys)+margin
            # Convert to scene coordinates (scale by 100, flip y)
            left = min_x*100
            right = max_x*100
            top = -max_y*100
            bottom = -min_y*100
            width = right - left
            height = bottom - top
            self.scene.setSceneRect(left, top, width, height)
            # (fitInView will be called after window is shown)

    def fit_canvas_view(self):
        """
        Fits the canvas view to the scene rect (zoom out to fit all content)
        """
        from PyQt5.QtCore import Qt
        self.canvas.fitInView(self.scene.sceneRect(), Qt.KeepAspectRatio)

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

    @staticmethod
    def expand_base_names(base_names):
        """
        Given a list of base names, return lists of landmark files and sim files.
        """
        import os
        landmark_files = []
        sim_files = []
        for base in base_names:
            d = os.path.join(os.path.dirname(__file__), '../data')
            landmark_files.append(os.path.join(d, f'{base}_landmarks_unoptimized.txt'))
            landmark_files.append(os.path.join(d, f'{base}_landmarks_optimized.txt'))
            sim_files.append(f'{base}_unoptimized.txt')
            sim_files.append(f'{base}_optimized.txt')
        return landmark_files, sim_files
