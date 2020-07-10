#!/usr/bin/env python
import yaml
import time
import math


goal = None
virtual_agent_position = None
scaling = None
self_frame = "crazyflie1"
with open(r'goals.yaml') as file:
    goal_list = yaml.load(file, Loader=yaml.FullLoader)
   # print(goal_list)
    goal_list_dict = dict(goal_list.items())
    virtual_agent = goal_list_dict["virtual_agent"]
    agent_goal = goal_list_dict[self_frame]
    scaling = goal_list_dict["scaling"]
    print(virtual_agent)
if agent_goal["land"] == 1:
    goal["x"] == 0
    goal["y"] == 0
    goal["z"] == -10
else:
    goal["x"] = virtual_agent["position"]["x"] + (agent_goal["off_set"]["x"] + agent_goal["translation_agent_x"]) * scaling  + virtual_agent["translation_x"] 
    goal["x"] = virtual_agent["position"]["x"] + (agent_goal["off_set"]["x"] + agent_goal["translation_agent_x"]) * scaling  + virtual_agent["translation_x"] 

    #round((virtual_agent_position[0] + goal[0] + translation_x) * scaling , 2)
    #round((virtual_agent_position[1] + goal[1] + translation_y) * scaling , 2)
    #round((virtual_agent_position[2] + goal[2] + translation_z) * scaling , 2)

    #print(translation_z)


        

