import cv2
import numpy as np
import glob

# Chessboard dimensions (inner corners)
chessboard_size = (8, 5)
square_size = 0.03  # Real size of each square in meters (adjust as needed)

# Prepare object points
objp = np.zeros((np.prod(chessboard_size), 3), np.float32)
objp[:, :2] = np.indices(chessboard_size).T.reshape(-1, 2)
objp *= square_size

objpoints = []  # 3D points
imgpoints = []  # 2D points

images = glob.glob("calib_images/*.jpg")

for fname in images:
    img = cv2.imread(fname)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    print(f"Processing {fname}...")
    found, corners = cv2.findChessboardCorners(gray, chessboard_size, None)

    if found:
        print(f"{fname} was good enough")
        objpoints.append(objp)
        corners_sub = cv2.cornerSubPix(gray, corners, (11,11), (-1,-1),
                                       criteria=(cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 30, 0.001))
        imgpoints.append(corners_sub)

        cv2.drawChessboardCorners(img, chessboard_size, corners_sub, found)

cv2.destroyAllWindows()

# Calibration
ret, camera_matrix, dist_coeffs, rvecs, tvecs = cv2.calibrateCamera(
    objpoints, imgpoints, gray.shape[::-1], None, None
)

print("Camera Matrix:\n", camera_matrix)
print("Distortion Coefficients:\n", dist_coeffs.ravel())

# Optional: Save to file
np.savez("camera_calibration.npz", camera_matrix=camera_matrix, dist_coeffs=dist_coeffs)

total_error = 0
for i in range(len(objpoints)):
    # Project 3D points to image plane
    imgpoints2, _ = cv2.projectPoints(objpoints[i], rvecs[i], tvecs[i], camera_matrix, dist_coeffs)
    
    # Calculate Euclidean distance between detected and reprojected points
    error = cv2.norm(imgpoints[i], imgpoints2, cv2.NORM_L2) / len(imgpoints2)
    total_error += error

print(f"Mean reprojection error: {total_error / len(objpoints):.6f} pixels")
