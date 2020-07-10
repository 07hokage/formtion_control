# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "crazyflie_demo: 4 messages, 0 services")

set(MSG_I_FLAGS "-Icrazyflie_demo:/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(crazyflie_demo_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg" NAME_WE)
add_custom_target(_crazyflie_demo_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "crazyflie_demo" "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg" NAME_WE)
add_custom_target(_crazyflie_demo_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "crazyflie_demo" "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg" "std_msgs/Header:geometry_msgs/Vector3"
)

get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg" NAME_WE)
add_custom_target(_crazyflie_demo_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "crazyflie_demo" "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg" "geometry_msgs/Twist:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Vector3:geometry_msgs/Point:geometry_msgs/Pose"
)

get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg" NAME_WE)
add_custom_target(_crazyflie_demo_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "crazyflie_demo" "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg" "std_msgs/Header"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_cpp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_cpp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_cpp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/crazyflie_demo
)

### Generating Services

### Generating Module File
_generate_module_cpp(crazyflie_demo
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/crazyflie_demo
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(crazyflie_demo_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(crazyflie_demo_generate_messages crazyflie_demo_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_cpp _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_cpp _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_cpp _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_cpp _crazyflie_demo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(crazyflie_demo_gencpp)
add_dependencies(crazyflie_demo_gencpp crazyflie_demo_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS crazyflie_demo_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_eus(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_eus(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_eus(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/crazyflie_demo
)

### Generating Services

### Generating Module File
_generate_module_eus(crazyflie_demo
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/crazyflie_demo
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(crazyflie_demo_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(crazyflie_demo_generate_messages crazyflie_demo_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_eus _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_eus _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_eus _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_eus _crazyflie_demo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(crazyflie_demo_geneus)
add_dependencies(crazyflie_demo_geneus crazyflie_demo_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS crazyflie_demo_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_lisp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_lisp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_lisp(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/crazyflie_demo
)

### Generating Services

### Generating Module File
_generate_module_lisp(crazyflie_demo
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/crazyflie_demo
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(crazyflie_demo_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(crazyflie_demo_generate_messages crazyflie_demo_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_lisp _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_lisp _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_lisp _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_lisp _crazyflie_demo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(crazyflie_demo_genlisp)
add_dependencies(crazyflie_demo_genlisp crazyflie_demo_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS crazyflie_demo_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_nodejs(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_nodejs(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_nodejs(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/crazyflie_demo
)

### Generating Services

### Generating Module File
_generate_module_nodejs(crazyflie_demo
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/crazyflie_demo
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(crazyflie_demo_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(crazyflie_demo_generate_messages crazyflie_demo_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_nodejs _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_nodejs _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_nodejs _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_nodejs _crazyflie_demo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(crazyflie_demo_gennodejs)
add_dependencies(crazyflie_demo_gennodejs crazyflie_demo_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS crazyflie_demo_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_py(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_py(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo
)
_generate_msg_py(crazyflie_demo
  "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo
)

### Generating Services

### Generating Module File
_generate_module_py(crazyflie_demo
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(crazyflie_demo_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(crazyflie_demo_generate_messages crazyflie_demo_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Hover.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_py _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/VelocityWorld.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_py _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/FullState.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_py _crazyflie_demo_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/haneesh/crazy_ws/src/crazyflie_ros/crazyflie_demo/msg/Position.msg" NAME_WE)
add_dependencies(crazyflie_demo_generate_messages_py _crazyflie_demo_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(crazyflie_demo_genpy)
add_dependencies(crazyflie_demo_genpy crazyflie_demo_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS crazyflie_demo_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/crazyflie_demo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/crazyflie_demo
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(crazyflie_demo_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(crazyflie_demo_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/crazyflie_demo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/crazyflie_demo
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(crazyflie_demo_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(crazyflie_demo_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/crazyflie_demo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/crazyflie_demo
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(crazyflie_demo_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(crazyflie_demo_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/crazyflie_demo)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/crazyflie_demo
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(crazyflie_demo_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(crazyflie_demo_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/crazyflie_demo
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(crazyflie_demo_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(crazyflie_demo_generate_messages_py geometry_msgs_generate_messages_py)
endif()
