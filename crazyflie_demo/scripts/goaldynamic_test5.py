#!/usr/bin/env python
import yaml
import time
import rospy
import math
import tf
from geometry_msgs.msg import PoseStamped


def signature(x):
    if x>0:
	return 1
    elif x<0:
	return -1
    else:
	return 0

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
    incremented_angle = 0.0
    angle = None
    count = 0
    while not rospy.is_shutdown():

        with open('/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/config/goals.yaml','r') as file:
            goal_list = yaml.load(file, Loader=yaml.FullLoader)
            goal_list_dict = dict(goal_list.items())
            virtual_agent = goal_list_dict["virtual_agent"]
            agent = goal_list_dict[myframe]
            scaling = goal_list_dict["scaling"]
	    angle = goal_list_dict["rotation"]
	    agent_x_realisation = agent['offset']['x'] + agent['translation_agent_x']
	    agent_x_realisation = agent['offset']['y'] + agent['translation_agent_y']
	    agent_x_realisation = agent['offset']['z'] + agent['translation_agent_z']
	    incremented_angle += signature(angle - incremented_angle) * (5/r)
	    angle = (math.pi/180) * incremented_angle
	    msg.pose.position.x = virtual_agent['position']['x'] + round(((agent_x_realisation * math.cos(angle)) + (agent_y_realisation * math.sin(-angle))) * scaling , 2) + virtual_agent['translation_x']
            msg.pose.position.y = virtual_agent['position']['y'] + round(((agent_x_realisation * math.sin(angle)) + (agent_y_realisation * math.cos(angle))) * scaling , 2) + virtual_agent['translation_y']
	    msg.pose.position.z = round(virtual_agent['position']['z'] + virtual_agent['translation_z'] , 2)
	    if agent['takeoff'] == 1 and count < 2:
		msg.pos.position.z = 100
		count += 1
	    if agent['land'] == 1 and 2 <= count <= 3:
		msg.pose.position.z = -100
                count += 1
	    




        quaternion = tf.transformations.quaternion_from_euler(0, 0, 0)
        msg.pose.orientation.x = quaternion[0]
        msg.pose.orientation.y = quaternion[1]
        msg.pose.orientation.z = quaternion[2]
        msg.pose.orientation.w = quaternion[3]

        msg.header.seq += 1
        msg.header.stamp = rospy.Time.now()
        pub.publish(msg)
        rate.sleep()
