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

    rotated_vector = Rx.dot(Ry).dot(Rz).dot(line)
    
    return rotated_vector


def increment(value, incremented_value,rate):
    return incremented_value + signature(value - incremented_value) * rate



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
    scaling = 1.0
    incremented_angle_x = 0.0
    incremented_angle_y = 0.0
    incremented_angle_z = 0.0
    incremented_linear_x = 0.0
    incremented_linear_y = 0.0
    incremented_linear_z = 0.0
    agent_increment_x_linear = 0.0
    agent_increment_y_linear = 0.0
    agent_increment_z_linear = 0.0
    angle = None
    count = 0
    goal = None
    listener = tf.TransformListener()
    pos = None
    temp = None
    rot = None
    frame_list = ["crazyflie1", "crazyflie2", "crazyflie3"]
    while not rospy.is_shutdown():

        with open('/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/config/goals_graph.yaml','r') as file:
            goal_list = yaml.load(file, Loader=yaml.FullLoader)
            goal_list_dict = dict(goal_list.items())

        adjacencey_self = goal_list_dict[myframe]
        agent = goal_list_dict[str(1) + myframe]
        
        algo = goal_list_dict["algorithm"]
        if algo == 1:
        	for frame in frame_list:
        		print(frame_list)
	        	(pos[frame],rot[frame]) = listener.lookupTransform("/crazyflie1", worldFrame, rospy.Time(0))

	        goal = pos[myframe]

	        for item in adjacencey_self:
	        	if item != 0:
	        		temp = pos[item] - pos[myframe]
	        		goal += temp  * (sqrt(temp[0]**2 + temp[1]**2) - item )
	        msg.pose.position.x = goal[0]
	        msg.pose.position.x = goal[1]
	        msg.pose.position.x = agen["off_set"]["z"]
        else:
	    	msg.pose.position.x = agent["off_set"]['x']
        	msg.pose.position.y = agent["off_set"]['y']
        	msg.pose.position.z = agent["off_set"]['z']

        # virtual_agent = goal_list_dict["virtual_agent"]
        # agent = goal_list_dict[myframe]

        # scaling = increment(goal_list_dict["scaling"], scaling, 0.2/r)

        # agent_increment_x_linear = increment(agent['translation_agent_x'], agent_increment_x_linear, 0.5/r)
        # agent_increment_y_linear = increment(agent['translation_agent_y'], agent_increment_y_linear, 0.5/r)
        # agent_increment_z_linear = increment(agent['translation_agent_z'], agent_increment_z_linear, 0.5/r)

        # agent_x_realisation = agent['off_set']['x'] + agent_increment_x_linear
        # agent_y_realisation = agent['off_set']['y'] + agent_increment_y_linear
        # agent_z_realisation = agent['off_set']['z'] + agent_increment_z_linear

        # vector = np.array([[agent_x_realisation],[agent_y_realisation], [agent_z_realisation]])


        # incremented_angle_x = increment(goal_list_dict["rotation_x"], incremented_angle_x, 20/r)
        # incremented_angle_y = increment(goal_list_dict["rotation_y"], incremented_angle_y, 20/r)
        # incremented_angle_z = increment(goal_list_dict["rotation_z"], incremented_angle_z, 20/r)

        
        # goal_vector = rotation(incremented_angle_x, incremented_angle_y, incremented_angle_z, vector)
        
        # incremented_linear_x = increment(virtual_agent["translation_x"], incremented_linear_x, 0.1/r)
        # incremented_linear_y = increment(virtual_agent["translation_y"], incremented_linear_y, 0.1/r)
        # incremented_linear_z = increment(virtual_agent["translation_z"], incremented_linear_z, 0.1/r)


        # msg.pose.position.x = virtual_agent['position']['x'] + round(goal_vector[0][0] * scaling , 4) + incremented_linear_x
        # msg.pose.position.y = virtual_agent['position']['y'] + round(goal_vector[1][0] * scaling , 4) + incremented_linear_y
        # msg.pose.position.z = virtual_agent['position']['z'] + round(goal_vector[2][0] * scaling , 4) + incremented_linear_z


        

        if agent["takeoff"] == 1 and agent["land"] == 0 and count < 2:
            msg.pose.position.z = 2.5000
            count += 1
        if agent["land"] == 1 and count > 0:
            msg.pose.position.z = 0.0000
            count -= 1

          
        quaternion = tf.transformations.quaternion_from_euler(0, 0, 0)
        msg.pose.orientation.x = quaternion[0]
        msg.pose.orientation.y = quaternion[1]
        msg.pose.orientation.z = quaternion[2]
        msg.pose.orientation.w = quaternion[3]

        msg.header.seq += 1
        msg.header.stamp = rospy.Time.now()
        pub.publish(msg)
        rate.sleep()


