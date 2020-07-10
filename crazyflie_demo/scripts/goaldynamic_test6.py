#!/usr/bin/env python
import yaml
import time
import rospy
import math
import tf
from geometry_msgs.msg import PoseStamped
import numpy as np


def signature(x):
    if x>0:
       return 1
    elif x<0:
       return -1
    else:
       return 0


def rotation(angle_x, angle_y, angle_z, line):
    thetax = np.deg2rad(angle_x)
    thetay = np.deg2rad(angle_y)
    thetaz = np.deg2rad(angle_z)

    cz = round(np.cos(thetaz),3)
    sz = round(np.sin(thetaz),3)

    cy = round(np.cos(thetay),3)
    sy = round(np.sin(thetay),3)

    cx = round(np.cos(thetax),3)
    sx = round(np.sin(thetax),3)

    Rz= np.array([[cz, -sz,0],[sz,cz,0],[0,0,1]])

    Ry = np.array([[cy,0,sy],[0,1,0],[-sy,0,cy]])

    Rx = np.array([[1,0,0],[0,cx, -sx],[0,sx,cx]])

    rotated_vector = Rz.dot(Ry).dot(Rx).dot(line)
    
    return rotated_vector


if __name__ == '__main__':
    rospy.init_node('publish_pose', anonymous=True)
    worldFrame = rospy.get_param("~worldFrame", "/world")
    myframe = rospy.get_param("~myframe")
    name = rospy.get_param("~name")
    r = rospy.get_param("~rate")
    rate = rospy.Rate(r)
    msg = PoseStamped()
    msg.header.seq = 0
    msg.header.stamp = rospy.Time.now()
    msg.header.frame_id = worldFrame
    pub = rospy.Publisher(name, PoseStamped, queue_size=1)
    agent = None
    virtual_agent = None
    scaling = None
    incremented_angle_x = 0.0
    incremented_angle_y = 0.0
    incremented_angle_z = 0.0
    angle = None
    count = 0
    while not rospy.is_shutdown():

        with open('/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/config/goals2.yaml','r') as file:
            goal_list = yaml.load(file, Loader=yaml.FullLoader)
            goal_list_dict = dict(goal_list.items())

        virtual_agent = goal_list_dict["virtual_agent"]
        agent = goal_list_dict[myframe]

        scaling = goal_list_dict["scaling"]
        angle_x = goal_list_dict["rotation_x"]
        angle_y = goal_list_dict["rotation_y"]
        angle_z = goal_list_dict["rotation_z"]


        agent_x_realisation = agent['off_set']['x'] + agent['translation_agent_x']
        agent_y_realisation = agent['off_set']['y'] + agent['translation_agent_y']
        agent_z_realisation = agent['off_set']['z'] + agent['translation_agent_z']
        vector = np.array([[agent_x_realisation],[agent_y_realisation], [agent_z_realisation]])


        incremented_angle_x += signature(angle_x - incremented_angle_x) * (10/r)
        incremented_angle_y += signature(angle_y - incremented_angle_y) * (10/r)
        incremented_angle_z += signature(angle_z - incremented_angle_z) * (10/r)

        
        goal_vector = rotation(incremented_angle_x, incremented_angle_y, incremented_angle_z, vector)
        

        msg.pose.position.x = virtual_agent['position']['x'] + round(goal_vector[0][0] * scaling , 4) + virtual_agent['translation_x']
        msg.pose.position.y = virtual_agent['position']['y'] + round(goal_vector[1][0] * scaling , 4) + virtual_agent['translation_y']
        msg.pose.position.z = virtual_agent['position']['z'] + round(goal_vector[2][0] * scaling , 4) + virtual_agent['translation_z']
          
        quaternion = tf.transformations.quaternion_from_euler(0, 0, 0)
        msg.pose.orientation.x = quaternion[0]
        msg.pose.orientation.y = quaternion[1]
        msg.pose.orientation.z = quaternion[2]
        msg.pose.orientation.w = quaternion[3]

        msg.header.seq += 1
        msg.header.stamp = rospy.Time.now()
        pub.publish(msg)
        rate.sleep()


