cmake_minimum_required(VERSION 2.8.9)

project(visages-superProject)

## #############################################################################
## Add packages
## #############################################################################

list(APPEND external_projects
  ANIMA
  QtShanoir  
  visagesPlugins
  )


## #############################################################################
## Add modules
## #############################################################################

set(CMAKE_MODULE_PATH
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/externals
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/externals/projects_modules
  ${CMAKE_MODULE_PATH}
  )
    
    
## #############################################################################
## Add variables
## #############################################################################

if (DEFINED CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel.")
else()
   
  set(CMAKE_BUILD_TYPE Release CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel.")
endif()

## #############################################################################
## Add Targets
## #############################################################################

set(global_targets 
  configure 
  install
  )
  
# This adds targets that will be run in each external-projects
set_property(DIRECTORY PROPERTY EP_STEP_TARGETS ${global_targets})

foreach (target ${global_targets})
  add_custom_target(${target})
endforeach()


## #############################################################################
## Find medinria-superproject
## #############################################################################

file(TO_CMAKE_PATH "${medInria-superProject_DIR}" medInria-superProject_DIR)
find_package(medInria-superProject REQUIRED)


## #############################################################################
## Configure external-projects
## #############################################################################

include(ConfigureExternalProjects)





