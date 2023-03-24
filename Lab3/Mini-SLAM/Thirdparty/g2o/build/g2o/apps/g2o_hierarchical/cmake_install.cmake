# Install script for directory: /home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical

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
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_hierarchical.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_hierarchical.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_hierarchical.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/lib/libg2o_hierarchical.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_hierarchical.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_hierarchical.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_hierarchical.so"
         OLD_RPATH "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libg2o_hierarchical.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/g2o/apps/g2o_hierarchical" TYPE FILE FILES
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical/backbone_tree_action.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical/edge_creator.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical/edge_labeler.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical/edge_types_cost_function.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical/g2o_hierarchical_api.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical/simple_star_ops.h"
    "/home/kl4ws/Documents/master/SLAM/labs/Lab3/Mini-SLAM/Thirdparty/g2o/g2o/apps/g2o_hierarchical/star.h"
    )
endif()

