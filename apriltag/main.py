import cv2
import numpy as np
import apriltag
from picamera2 import Picamera2
from time import sleep

# --- Camera Calibration (replace with actual values!) ---
CAMERA_MATRIX = np.array([[600, 0, 320],
                          [0, 600, 240],
                          [0, 0, 1]], dtype=np.float32)
DIST_COEFFS = np.zeros(5)  # Assume no distortion for simplicity

# Tag sizes (in meters)
TAG_SIZE = 0.05  # 5cm

# Known tag IDs
MIRROR_TAG_ID = 0
ROBOT_TAG_ID = 1

# Mirror transformation (if known) - optional
# We assume the mirror is at a fixed pose in world space.

# --- Initialize Camera ---
picam2 = Picamera2()
picam2.configure(picam2.create_still_configuration(main={"format": 'RGB888'}))
picam2.start()
sleep(1)

# --- Capture Image ---
frame = picam2.capture_array()
cv2.imwrite("captured.jpg", frame)

# --- Detect Tags ---
gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
detector = apriltag.Detector()
tags = detector.detect(gray)

poses = {}

# --- Estimate Poses of Detected Tags ---
for tag in tags:
    tag_id = tag.tag_id
    corners = np.array(tag.corners, dtype=np.float32)

    # SolvePnP: estimate 6DoF pose
    obj_points = np.array([
        [-TAG_SIZE / 2, -TAG_SIZE / 2, 0],
        [ TAG_SIZE / 2, -TAG_SIZE / 2, 0],
        [ TAG_SIZE / 2,  TAG_SIZE / 2, 0],
        [-TAG_SIZE / 2,  TAG_SIZE / 2, 0],
    ], dtype=np.float32)

    retval, rvec, tvec = cv2.solvePnP(obj_points, corners, CAMERA_MATRIX, DIST_COEFFS)
    if retval:
        poses[tag_id] = (rvec, tvec)

# --- Analyze Robot Position ---
if MIRROR_TAG_ID in poses and ROBOT_TAG_ID in poses:
    _, mirror_pose = poses[MIRROR_TAG_ID]
    rvec_r, tvec_r = poses[ROBOT_TAG_ID]

    # Flip robot's position across mirror plane (assumed to be Z-normal)
    mirror_normal = np.array([0, 0, 1])  # Assuming mirror lies in XY plane
    reflected_pos = tvec_r - 2 * np.dot(tvec_r.T, mirror_normal) * mirror_normal.T

    print("Direct Robot Position (camera frame):", tvec_r.T)
    print("Reflected Robot Position Estimate (camera frame):", reflected_pos.T)

else:
    print("Required tags not detected.")
