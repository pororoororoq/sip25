from display.main_window import MainWindow

import sys
from PyQt5.QtWidgets import QApplication
import pyqtgraph.opengl as gl

def main():
    app = QApplication(sys.argv)
    window = MainWindow("loop", False, move_speed=150, turn_speed=50)
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()