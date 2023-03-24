# Install script for directory: /home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_types_slam3d.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_types_slam3d.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_types_slam3d.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/lib/libg2o_types_slam3d.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_types_slam3d.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_types_slam3d.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_types_slam3d.so"
         OLD_RPATH "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_types_slam3d.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/g2o/types/slam3d" TYPE FILE FILES
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/dquat2mat.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_pointxyz.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3_lotsofxyz.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3_offset.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3_pointxyz.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3_pointxyz_depth.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3_pointxyz_disparity.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3_prior.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_se3_xyzprior.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/edge_xyz_prior.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/g2o_types_slam3d_api.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/isometry3d_gradients.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/isometry3d_mappings.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/parameter_camera.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/parameter_se3_offset.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/parameter_stereo_camera.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/se3_ops.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/se3_ops.hpp"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/se3quat.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/types_slam3d.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/vertex_pointxyz.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/types/slam3d/vertex_se3.h"
    )
endif()

