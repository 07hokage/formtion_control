#!/usr/bin/env python
import yaml
import time
import rospy
import math
import tf
from geometry_msgs.msg import PoseStamped
from sensor_msgs.msg import Joy
from math import fabs



lastData = None


def joyChange(data):
    global lastData
    lastData = data


if __name__ == '__main__':
    rospy.init_node('publish_pose', anonymous=True)
    worldFrame = rospy.get_param("~worldFrame", "/world")
    myframe = rospy.get_param("~myframe")
    name = rospy.get_param("~name")
    r = rospy.get_param("~rate")
    joy_topic = rospy.get_param("~joy_topic", "/joy")
    rate = rospy.Rate(r)
    msg = PoseStamped()
    msg.header.seq = 0
    msg.header.stamp = rospy.Time.now()
    msg.header.frame_id = worldFrame
    pub = rospy.Publisher(name, PoseStamped, queue_size=1)
    rospy.Subscriber(joy_topic, Joy, joyChange)
    goal = None
    virtual_agent_position = None
    scaling = None

    while not rospy.is_shutdown():
        global lastData
        with open('/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/config/goals.yaml','r') as file:
            goal_list = yaml.load(file, Loader=yaml.FullLoader)
            goal_list_dict = dict(goal_list.items())
            virtual_agent_position = goal_list_dict["virtual_agent_position"]

            rotation_factor = 0
            scaling_factor = 1

        if myframe in list(goal_list.keys()):
            goal = goal_list_dict[myframe]

            if lastData != None:
                scaling_factor = fabs(lastData.axes[3])
                rotation_factor = ((math.pi/4) * (1 - lastData.axes[4]))

            translation_x = goal_list_dict["translation_x"]
            translation_y = goal_list_dict["translation_y"]
            translation_z = goal_list_dict["translation_z"]

            scaling = goal_list_dict["scaling"] * scaling_factor
            angle = (math.pi/180)*goal_list_dict["rotation"] + rotation_factor

            px = virtual_agent_position[0] + goal[0] + translation_x
            py = virtual_agent_position[1] + goal[1] + translation_y
            pz = virtual_agent_position[2] + goal[2] + translation_z


            msg.pose.position.x = round(((px * math.cos(angle)) + (py * math.sin(-angle))) * scaling , 2)
            msg.pose.position.y = round(((px * math.sin(angle)) + (py * math.cos(angle))) * scaling  , 2)
            msg.pose.position.z = round(pz , 2)
        else:
            goal = [0,0,-1]
            msg.pose.position.x = goal[0]
            msg.pose.position.y = goal[1]
            msg.pose.position.z = goal[2]



        quaternion = tf.transformations.quaternion_from_euler(0, 0, 0)
        msg.pose.orientation.x = quaternion[0]
        msg.pose.orientation.y = quaternion[1]
        msg.pose.orientation.z = quaternion[2]
        msg.pose.orientation.w = quaternion[3]

        msg.header.seq += 1
        msg.header.stamp = rospy.Time.now()
        pub.publish(msg)
        rate.sleep()
