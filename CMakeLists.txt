cmake_minimum_required(VERSION 2.8)

if (DEFINED CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING
   "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel.")
else()
   set(CMAKE_BUILD_TYPE Release CACHE STRING
   "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel.")
endif()

set(CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/externals"
    ${CMAKE_MODULE_PATH})

project(visages-superProject)

find_package(medInria-superProject REQUIRED)
include(ExternalProjects)
include(CheckEnvironment)
set(GFORGE_USERNAME "" CACHE STRING "Username of your gforge account used to run svn+ssh.")

set(packages qtShanoir animaMath animaFiltering animaRegistration visagesPlugins)

# This adds global targets that run this step in every subproject
set(global_targets configure update build install)
set_property(DIRECTORY PROPERTY EP_STEP_TARGETS ${global_targets})

foreach (target ${global_targets})
    add_custom_target(${target})
endforeach()

foreach (package ${packages})
    call(${package}_project)
	foreach (target ${global_targets})
		    add_dependencies(${target} ${package}-${target})
	endforeach()
endforeach()

if (

"${GFORGE_USERNAME}" STREQUAL "")
    message(WARNING "GFORGE_USERNAME is empty !\n\nYou must provide a valid username account in order to have ssh access to gforge.inria.fr\nThis is required by Anima and Vistal.\nPlease contact olivier.commowick@irisa.fr for more details")
endif()

