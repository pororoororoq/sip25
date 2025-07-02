"""
GTSAM State Estimation Example for Differential Drive Robot
This script demonstrates how to use GTSAM for state estimation using noisy odometry.
Adapt this template to your data flow and robot parameters.
"""

import gtsam
import numpy as np

# Example: 2D Pose2 estimation with odometry
# You will need to install gtsam (pip install gtsam)

def simulate_noisy_odometry(true_poses, noise_std=0.01):
    """Simulate noisy odometry measurements from true poses."""
    odometry_measurements = []
    for i in range(1, len(true_poses)):
        delta = true_poses[i-1].between(true_poses[i])
        noisy_delta = gtsam.Pose2(
            delta.x() + np.random.normal(0, noise_std),
            delta.y() + np.random.normal(0, noise_std),
            delta.theta() + np.random.normal(0, noise_std)
        )
        odometry_measurements.append(noisy_delta)
    return odometry_measurements

def run_gtsam_estimation(odometry_measurements):
    graph = gtsam.NonlinearFactorGraph()
    initial = gtsam.Values()
    prior_noise = gtsam.noiseModel.Diagonal.Sigmas(np.array([0.01, 0.01, 0.01]))
    odo_noise = gtsam.noiseModel.Diagonal.Sigmas(np.array([0.05, 0.05, 0.05]))

    # Initial pose
    graph.add(gtsam.PriorFactorPose2(0, gtsam.Pose2(0, 0, 0), prior_noise))
    initial.insert(0, gtsam.Pose2(0, 0, 0))

    # Add odometry factors
    for i, odom in enumerate(odometry_measurements):
        graph.add(gtsam.BetweenFactorPose2(i, i+1, odom, odo_noise))
        # Initial guess: chain odometry
        if i == 0:
            prev = gtsam.Pose2(0, 0, 0)
        else:
            prev = initial.atPose2(i)
        initial.insert(i+1, prev.compose(odom))

    # Optimize
    params = gtsam.LevenbergMarquardtParams()
    optimizer = gtsam.LevenbergMarquardtOptimizer(graph, initial, params)
    result = optimizer.optimize()
    return result

if __name__ == "__main__":
    # Example: simulate a straight line
    true_poses = [gtsam.Pose2(i*0.1, 0, 0) for i in range(20)]
    odometry_measurements = simulate_noisy_odometry(true_poses, noise_std=0.02)
    result = run_gtsam_estimation(odometry_measurements)
    print("Estimated poses:")
    for i in range(result.size()):
        pose = result.atPose2(i)
        print(f"Pose {i}: x={pose.x():.3f}, y={pose.y():.3f}, theta={pose.theta():.3f}")
