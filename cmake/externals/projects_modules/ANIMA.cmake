function(ANIMA_project)

set(ep ANIMA)

## #############################################################################
## List the dependencies of the project
## #############################################################################

list(APPEND ${ep}_dependencies 
  ""
  )

## #############################################################################
## Prepare the project
## ############################################################################# 


EP_Initialisation(${ep}  
  USE_SYSTEM OFF 
  BUILD_SHARED_LIBS OFF
  REQUIRED_FOR_PLUGINS OFF
  )


if (NOT USE_SYSTEM_${ep})
## #############################################################################
## Set directories
## #############################################################################

EP_SetDirectories(${ep}
  EP_DIRECTORIES ep_dirs
  )


## #############################################################################
## Define repository where get the sources
## #############################################################################

set(url ${GITHUB_PREFIX}Inria-Visages/Anima-Public.git)
if (NOT DEFINED ${ep}_SOURCE_DIR)
  set(location GIT_REPOSITORY ${url})
endif()


## #############################################################################
## Add specific cmake arguments for configuration step of the project
## #############################################################################

# set compilation flags
if (UNIX)
  set(${ep}_c_flags "${${ep}_c_flags} -Wall")
  set(${ep}_cxx_flags "${${ep}_cxx_flags} -Wall")
endif()

set(cmake_args
  ${ep_common_cache_args}
  -DCMAKE_C_FLAGS:STRING=${${ep}_c_flags}
  -DCMAKE_CXX_FLAGS:STRING=${${ep}_cxx_flags}  
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS_${ep}}
  -DBUILD_ANIMA_TOOLS:BOOL=OFF
  -DBUILD_ANIMA_TESTING:BOOL=OFF
  -DUSE_ANIMA_PRIVATE:BOOL=ON
  -DUSE_GITHUB_SSH:BOOL=ON
  -DUSE_NLOPT:BOOL=ON
  -DUSE_RPI:BOOL=ON
  -DUSE_VTK:BOOL=OFF
  -DUSE_SYSTEM_BOOST:BOOL=ON
  -DUSE_SYSTEM_ITK:BOOL=ON
  -DUSE_SYSTEM_NLOPT:BOOL=OFF
  -DUSE_SYSTEM_RPI:BOOL=ON
  -DUSE_SYSTEM_TCLAP:BOOL=ON
  -DUSE_SYSTEM_TinyXML2:BOOL=OFF
  -DBOOST_ROOT:PATH=${BOOST_ROOT}
  -DITK_DIR:FILEPATH=${ITK_DIR}
  -DRPI_DIR:FILEPATH=${RPI_DIR}
  )

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep}
  ${ep_dirs}
  ${location}
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS ${cmake_args}
  DEPENDS ${${ep}_dependencies}
  INSTALL_COMMAND ""  
  UPDATE_COMMAND ""
  )

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_BUILD_DIR ${binary_dir}/Anima PARENT_SCOPE)
set(${ep}_PRIVATE_DIR ${binary_dir}/Anima-Private PARENT_SCOPE)

## #############################################################################
## Add custom targets
## #############################################################################

EP_AddCustomTargets(${ep})

else()
  set(${ep}_BUILD_DIR ${${ep}_DIR} PARENT_SCOPE)
  set(${ep}_PRIVATE_DIR ${${ep}_DIR}/../Anima-Private PARENT_SCOPE)
endif()

endfunction()
