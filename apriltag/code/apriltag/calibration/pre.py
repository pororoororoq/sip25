from picamera2 import Picamera2
from time import sleep
import cv2
import os

output_dir = "calib_images"
os.makedirs(output_dir, exist_ok=True)

picam2 = Picamera2()
picam2.configure(picam2.create_still_configuration(main={"format": 'RGB888'}))
picam2.start()
sleep(2)

count = 0
print("Press 's' to save image, 'q' to quit.")

print("Press ENTER to save image, or 'q' then ENTER to quit.")

while True:
    frame = picam2.capture_array()

    user_input = input()
    if user_input.lower() == 'q':
        break
    else:
        cv2.imwrite(f"calib_images/image_{count:02d}.jpg", frame)
        print(f"Saved image_{count:02d}.jpg")
        count += 1

