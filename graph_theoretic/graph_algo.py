import time
from dronekit import connect, VehicleMode, LocationGlobalRelative, Command, LocationGlobal
from pymavlink import mavutil
import math
import utm as utm
import matplotlib.pyplot as plt
import csv




w = [[0,100,141.4,100],[100,0,100,141.4],[141.4,100,0,100],[100,141.4,100,0]]

def arm_and_takeoff(vehicle,altitude):

   while not vehicle.is_armable:
      print("waiting to be armable")
      time.sleep(1)

   print("Arming motors")
   vehicle.mode = VehicleMode("GUIDED")
   vehicle.armed = True

   while not vehicle.armed: time.sleep(1)

   print("Taking Off")
   vehicle.simple_takeoff(altitude)

   while True:
      v_alt = vehicle.location.global_relative_frame.alt
      print(">> Altitude = %.1f m"%v_alt)
      if v_alt >= altitude - 1.0:
          print("Target altitude reached")
          break
      time.sleep(1)


# def saturateit(value):
# 	if value > 0:
# 		return 1
#   	if value < 0:
#     	return -1
#   	else:
#     	return 0


# def set_velocity_body(vehicle, vx, vy, vz):
#     msg = vehicle.message_factory.set_position_target_local_ned_encode(
#             0,
#             0, 0,
#             mavutil.mavlink.MAV_FRAME_BODY_NED,
#             0b0000111111000111, #-- BITMASK -> Consider only the velocities
#             0, 0, 0,        #-- POSITION
#             vx, vy, vz,     #-- VELOCITY
#             0, 0, 0,        #-- ACCELERATIONS
#             0, 0)
#     vehicle.send_mavlink(msg)


# def get_x_y_coordinate(vehicle,origin):
#   current_location = vehicle.location.global_relative_frame
#   distance = get_distance_metres(current_location,origin)
#   lat_diff = vehicle.location.global_relative_frame.lat - origin.lat
#   lon_diff = vehicle.location.global_relative_frame.lon - origin.lon
#   angle = math.atan2(lon_diff,lat_diff)
#   x = distance * math.cos(angle)
#   y = distance * math.sin(angle)
#   return [x,y]

# def get_distance_metres(location1, location2):
#     d_lat = location2.lat - location1.lat
#     d_long = location2.lon - location1.lon
#     return math.sqrt((d_lat * d_lat) + (d_long * d_long)) * 1.113195e5

def add_list(list1,list2):
  newlist = [i+j for i,j in zip(list1,list2)]
  return newlist
  
def weight_calculate(value):
	if abs(value) <5:
		return 0
	else:
		return value
def get_location_metres(vehicle, d_north, d_east):

	original_location = vehicle.location.global_relative_frame
	earth_radius = 6378137.0
	d_lat = d_north/earth_radius
	d_lon = d_east/(earth_radius*math.cos(math.pi*original_location.lat/180))
	new_lat = original_location.lat + (d_lat * 180/math.pi)
	new_lon = original_location.lon + (d_lon * 180/math.pi)
	return LocationGlobalRelative(new_lat, new_lon, original_location.alt)

def get_distance(x1,y1,x2,y2):

	return math.sqrt((x1-x2)**2+(y1-y2)**2)

def get_next_lat_lon(vehicle, vehiclelist, _operation, _attribute):

	tx, ty, tz, _scale = 0, 0, 0, 1

	if _operation == "translate":
		tx = _attribute[0]
		ty = _attribute[1]
		tz = _attribute[2]
	if _operation == "scaling":
		_scale = _attribute[0]

	diff_x,diff_y =0,0
	self_x,self_y,self_zc,self_zL = utm.from_latlon(vehicle.location.global_relative_frame.lat,vehicle.location.global_relative_frame.lon)
	for element in vehiclelist:
		if element != vehicle:
			x,y,zc,zL = utm.from_latlon(element.location.global_relative_frame.lat,element.location.global_relative_frame.lon)
			diff_x = tx + diff_x+0.005*(self_x-x)*weight_calculate(_scale * w[vehiclelist.index(element)][vehiclelist.index(vehicle)]-get_distance(self_x,self_y,x,y)) 
			diff_y = ty + diff_y+0.005*(self_y-y)*weight_calculate(_scale * w[vehiclelist.index(element)][vehiclelist.index(vehicle)]-get_distance(self_x,self_y,x,y))
	new_lat,new_lon = utm.to_latlon(self_x+diff_x,self_y+diff_y,self_zc,self_zL)
	new_lat = round(new_lat,7)
	new_lon = round(new_lon,7) 
	return LocationGlobalRelative(new_lat,new_lon,tz+vehicle.location.global_relative_frame.alt)

# def get_next_lat_lon2(vehicle, vehiclelist):

# 	diff_x,diff_y =0,0
# 	self_x,self_y,self_zc,self_zL = utm.from_latlon(vehicle.location.global_relative_frame.lat,vehicle.location.global_relative_frame.lon)
# 	for element in vehiclelist:
# 		if element != vehicle:
# 			x,y,zc,zL = utm.from_latlon(element.location.global_relative_frame.lat,element.location.global_relative_frame.lon)
# 			diff_x = 100+diff_x+0.005*(self_x-x)*weight_calculate(w[vehiclelist.index(element)][vehiclelist.index(vehicle)]-get_distance(self_x,self_y,x,y)) 
# 			diff_y = diff_y +0.005*(self_y-y)*weight_calculate(w[vehiclelist.index(element)][vehiclelist.index(vehicle)]-get_distance(self_x,self_y,x,y))
# 	new_lat,new_lon = utm.to_latlon(self_x+diff_x,self_y+diff_y,self_zc,self_zL)
# 	new_lat = round(new_lat,7)
# 	new_lon = round(new_lon,7) 
# 	return LocationGlobalRelative(new_lat,new_lon,vehicle.location.global_relative_frame.alt)


# def get_next_lat_lon3(vehicle, vehiclelist):

# 	w = [[0,2*100,2*141.4,2*100],[2*100,0,2*100,2*141.4],[2*141.4,2*100,0,2*100],[2*100,2*141.4,2*100,0]]
# 	diff_x,diff_y =0,0
# 	self_x,self_y,self_zc,self_zL = utm.from_latlon(vehicle.location.global_relative_frame.lat,vehicle.location.global_relative_frame.lon)
# 	for element in vehiclelist:
# 		if element != vehicle:
# 			x,y,zc,zL = utm.from_latlon(element.location.global_relative_frame.lat,element.location.global_relative_frame.lon)
# 			diff_x = diff_x+0.005*(self_x-x)*weight_calculate(w[vehiclelist.index(element)][vehiclelist.index(vehicle)]-get_distance(self_x,self_y,x,y)) 
# 			diff_y = diff_y +0.005*(self_y-y)*weight_calculate(w[vehiclelist.index(element)][vehiclelist.index(vehicle)]-get_distance(self_x,self_y,x,y))
# 	new_lat,new_lon = utm.to_latlon(self_x+diff_x,self_y+diff_y,self_zc,self_zL)
# 	new_lat = round(new_lat,7)
# 	new_lon = round(new_lon,7) 
# 	return LocationGlobalRelative(new_lat,new_lon,vehicle.location.global_relative_frame.alt)


print('Connecting...')
#vehicle = connect('udp:127.0.0.1:14551')
vehicle0 = connect('tcp:127.0.0.1:5760', wait_ready=True)
vehicle1 = connect('tcp:127.0.0.1:5770', wait_ready=True)
vehicle2 = connect('tcp:127.0.0.1:5780', wait_ready=True)
vehicle3 = connect('tcp:127.0.0.1:5790', wait_ready=True)

print("all three conneted")

# origin = LocationGlobalRelative(vehicle0.location.global_relative_frame.lat,vehicle0.location.global_relative_frame.lon,0)

vehicles = [vehicle0,vehicle1,vehicle2,vehicle3]
vehicle_list = [vehicle0,vehicle1,vehicle2,vehicle3]
lon = []
lat = []
mode = "Takeoff"
count = 0
x1=[]
y1=[]
trans=False
start = 0
tm=[]

while count<=750:

  if mode == "Takeoff":
    arm_and_takeoff(vehicle0, 10)
    arm_and_takeoff(vehicle1, 10)
    arm_and_takeoff(vehicle2, 10)
    arm_and_takeoff(vehicle3, 10)
    print("all three in air")
    mode = "Swarming"
    start = time.time()

  if mode == "Swarming":
    for vehicle in vehicles:
    	vehicle.simple_goto(get_next_lat_lon(vehicle,vehicle_list,"swarming",[0]))
    if count>=200:
    	mode = "translate"

  if mode == "translate" and not trans:
  	for vehicle in vehicles:
  		vehicle.simple_goto(get_next_lat_lon(vehicle,vehicle_list,"translate",[100,0,0]))
  	trans = True
  	mode = "scaling"

  if mode == "scaling" and count>=500:
  	for vehicle in vehicles:
  		vehicle.groundspeed=5
  		vehicle.simple_goto(get_next_lat_lon(vehicle,vehicle_list,"scaling",[2]))

  tm.append(time.time()-start)
  lat.append([vehicle0.location.global_relative_frame.lat,vehicle1.location.global_relative_frame.lat,
    	vehicle2.location.global_relative_frame.lat,vehicle3.location.global_relative_frame.lat])
  lon.append([vehicle0.location.global_relative_frame.lon,vehicle1.location.global_relative_frame.lon,
    	vehicle2.location.global_relative_frame.lon,vehicle3.location.global_relative_frame.lon])

  time.sleep(0.25)

  count+=1




num=0
with open('data_form.csv', mode='w') as employee_file:
    employee_writer = csv.writer(employee_file, delimiter=',')
    for item in zip(lat,lon):
    	for j in range(0,4):
    		x,y,z,e = utm.from_latlon(item[0][j],item[1][j])
    		x1.append(x)
    		y1.append(y)
    	employee_writer.writerow(tm[num],[x1[0],y1[0],x1[1],y1[1],x1[2],y1[2],x1[3],y1[3]])
    	x1.clear()
    	y1.clear()
    	num+=1

    	x1.append(lat[i][0])
    	x2.append(lat[i][1])
    	x3.append(lat[i][2])
    	x4.append(lat[i][3])
    	y1.append(lon[i][0])
    	y2.append(lon[i][1])
    	y3.append(lon[i][2])
    	y4.append(lon[i][3])
    	



plt.plot(x1,y1,'ro--',label='Agent1')
plt.plot(x2,y2,'go--',label='Agent2')
plt.plot(x3,y3,'bo--',label='Agent3')
plt.plot(x4,y4,'ko--',label='Agent4')
plt.grid()
plt.legend()
plt.title('Formation Acquisition')
plt.xlabel('Latitude')
plt.ylabel('Longitude')
# plt.ylim(0,27.1)
plt.show()

