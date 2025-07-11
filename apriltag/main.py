import cv2
import numpy as np
import apriltag
from picamera2 import Picamera2
from time import sleep

# === Camera Calibration ===
# perfect values used here--calibration did not work very well
CAMERA_MATRIX = np.array([
    [3208, 0, 1640],
    [0, 3212, 1232],
    [0, 0, 1]
], dtype=np.float64)

# randomly generated values that typically happen in practic
DIST_COEFFS = np.array([-0.27, 0.12, 0.002, -0.003, -0.01], dtype=np.float64)

# === Tag Configuration ===
TAG_SIZE = 0.04  # meters
MIRROR_TAG_ID = 0
ROBOT_TAG_ID = 1

# === Initialize Camera ===
picam2 = Picamera2()
picam2.configure(picam2.create_still_configuration(main={"format": 'RGB888'}))
picam2.start()
sleep(1)

# === Capture Image ===
frame = picam2.capture_array()
print("Captured frame shape:", frame.shape)
cv2.imwrite("captured.jpg", frame)

# === Detect Tags ===
# --- Detect Tags at lower resolution ---
gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
h_original, w_original = gray.shape

# Resize for faster detection
resized_w, resized_h = 800, 600
gray_small = cv2.resize(gray, (resized_w, resized_h))
scale_x = w_original / resized_w
scale_y = h_original / resized_h

# Run detector
detector = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
tags = detector.detect(gray_small)

poses = {}

for tag in tags:
    tag_id = tag.tag_id

    # Scale corners back to original image resolution
    corners = np.array(tag.corners, dtype=np.float32)
    corners[:, 0] *= scale_x  # scale x coords
    corners[:, 1] *= scale_y  # scale y coords

    # Define real-world object points
    obj_points = np.array([
        [-TAG_SIZE / 2, -TAG_SIZE / 2, 0],
        [ TAG_SIZE / 2, -TAG_SIZE / 2, 0],
        [ TAG_SIZE / 2,  TAG_SIZE / 2, 0],
        [-TAG_SIZE / 2,  TAG_SIZE / 2, 0],
    ], dtype=np.float32)

    retval, rvec, tvec = cv2.solvePnP(obj_points, corners, CAMERA_MATRIX, DIST_COEFFS)
    if retval:
        poses[tag_id] = (rvec, tvec)

# === Helper: Reflect a point across a plane ===
def reflect_point(point, plane_point, plane_normal):
    plane_normal = plane_normal / np.linalg.norm(plane_normal)
    v = point - plane_point
    dist = np.dot(v, plane_normal)
    reflected = point - 2 * dist * plane_normal
    return reflected

# === Analyze Robot Position ===
if MIRROR_TAG_ID in poses and ROBOT_TAG_ID in poses:
    # Mirror tag pose
    rvec_m, tvec_m = poses[MIRROR_TAG_ID]
    tvec_m = tvec_m.reshape(-1)

    # Compute mirror normal from tag rotation
    R_m, _ = cv2.Rodrigues(rvec_m)
    tag_normal_local = np.array([0, 0, 1])   # Tag's local Z axis = normal
    mirror_normal = R_m @ tag_normal_local   # Now in camera frame

    # Robot tag pose
    rvec_r, tvec_r = poses[ROBOT_TAG_ID]
    tvec_r = tvec_r.reshape(-1)

    # Reflect robot's position across the mirror plane
    reflected_pos = reflect_point(tvec_r, tvec_m, mirror_normal)

    print("Direct Robot Position (camera frame):", tvec_r)
    print("Mirror Plane Normal (camera frame):", mirror_normal)
    print("Reflected Robot Position Estimate (camera frame):", reflected_pos)

else:
    print("Required tags not detected.")

print("Mirror tag position:", tvec_m)
mirror_distance = np.linalg.norm(tvec_m)
print("Camera to mirror distance:", mirror_distance)
