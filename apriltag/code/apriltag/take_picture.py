from picamera2 import Picamera2
from time import sleep

# Create the camera object
picam2 = Picamera2()

# Configure preview (optional)
picam2.start()

# Wait for camera to adjust settings
sleep(2)

# Capture and save the image
picam2.capture_file("image.jpg")

print("Picture saved as image.jpg")


