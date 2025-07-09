import cv2
import numpy as np
import apriltag

def draw_pose(img, corners, center, tag_id, tag_size=0.1, camera_params=None, pose_R=None, pose_t=None):
    """
    Draws the tag outline, center, and ID on the image.
    If pose_R and pose_t are provided, draw coordinate axes.
    """
    # Draw polygon
    corners = corners.reshape((-1,1,2)).astype(int)
    cv2.polylines(img, [corners], isClosed=True, color=(0,255,0), thickness=2)

    # Draw center
    c = tuple(center.astype(int))
    cv2.circle(img, c, 5, (0,0,255), -1)

    # Put tag ID
    cv2.putText(img, str(tag_id), (c[0]+10, c[1]+10),
                cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255,0,0), 2)

    # Draw axes if pose info available
    if pose_R is not None and pose_t is not None and camera_params is not None:
        fx, fy, cx, cy = camera_params
        axis_length = tag_size * 0.5  # scale of axis

        # 3D points in tag coordinate frame
        axis_points = np.float32([
            [0,0,0],
            [axis_length,0,0],
            [0,axis_length,0],
            [0,0,-axis_length]
        ]).reshape(-1,3)

        # Project 3D points to image plane
        rvec, _ = cv2.Rodrigues(pose_R)
        tvec = pose_t.reshape(3,1)
        camera_matrix = np.array([[fx,0,cx],
                                  [0,fy,cy],
                                  [0,0,1]])
        dist_coeffs = np.zeros(4)
        imgpts, _ = cv2.projectPoints(axis_points, rvec, tvec, camera_matrix, dist_coeffs)
        imgpts = np.int32(imgpts).reshape(-1,2)

        # Draw axes lines
        origin = tuple(imgpts[0])
        cv2.line(img, origin, tuple(imgpts[1]), (0,0,255), 3)  # X axis in red
        cv2.line(img, origin, tuple(imgpts[2]), (0,255,0), 3)  # Y axis in green
        cv2.line(img, origin, tuple(imgpts[3]), (255,0,0), 3)  # Z axis in blue

def main(image_path=None):
    # Camera intrinsic parameters (fx, fy, cx, cy)
    # Replace with your own calibrated camera params!
    camera_params = (600, 600, 320, 240)  # example values

    # AprilTag size in meters
    tag_size = 0.1

    # Create detector
    options = apriltag.DetectorOptions(families="tag36h11")
    detector = apriltag.Detector(options)

    if image_path:
        img = cv2.imread(image_path)
        if img is None:
            print(f"Failed to load image {image_path}")
            return
    else:
        # Capture from default webcam
        cap = cv2.VideoCapture(0)
        if not cap.isOpened():
            print("Cannot open camera")
            return
        ret, img = cap.read()
        cap.release()
        if not ret:
            print("Failed to grab frame")
            return

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    detections = detector.detect(gray)

    print(f"Detected {len(detections)} AprilTags")

    for det in detections:
        # Corners: top-left, top-right, bottom-right, bottom-left
        corners = det.corners

        # Center pixel
        center = det.center

        tag_id = det.tag_id

        # Estimate pose
        pose, e0, e1 = detector.detection_pose(det, camera_params, tag_size)
        # pose = (R, t)
        R, t = pose

        draw_pose(img, corners, center, tag_id, tag_size, camera_params, R, t)

    cv2.imshow("AprilTag Detection", img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        main(sys.argv[1])
    else:
        main()
