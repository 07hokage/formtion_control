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
	return 1

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
    goal = None
    virtual_agent_position = None
    scaling = None
    count = 1
    incremented_angle = 10/r
    last_angle = 0
    while not rospy.is_shutdown():

        with open('/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/config/goals.yaml','r') as file:
            goal_list = yaml.load(file, Loader=yaml.FullLoader)
            goal_list_dict = dict(goal_list.items())
            virtual_agent_position = goal_list_dict["virtual_agent_position"]
        if myframe in list(goal_list.keys()):
            goal = goal_list_dict[myframe]
            translation_x = goal_list_dict["translation_x"]
            translation_y = goal_list_dict["translation_y"]
            translation_z = goal_list_dict["translation_z"]

            scaling = goal_list_dict["scaling"]
            px = virtual_agent_position[0] + goal[0] + translation_x
            py = virtual_agent_position[1] + goal[1] + translation_y
            pz = virtual_agent_position[2] + goal[2] + translation_z
	    
	    angle = goal_list_dict["rotation"]
	    #print('increment angle diff----------', abs(incremented_angle - angle))
	    print('incremenet angle-----', incremented_angle)
	    if abs(incremented_angle - angle) < 20/r:
	    	incremented_angle = angle
		last_angle = angle - 10/r
		count = 1
		print("in negative loop")
	    else:
		incremented_angle = last_angle + signature(-last_angle + angle)*(count * 10) / r
		angle = incremented_angle
		count += 1
		#print(count)
	    angle = (math.pi/180) * angle
            msg.pose.position.x = round(((px * math.cos(angle)) + (py * math.sin(-angle))) * scaling , 2)
            msg.pose.position.y = round(((px * math.sin(angle)) + (py * math.cos(angle))) * scaling , 2)
            msg.pose.position.z = round(pz  , 2)
	    
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
