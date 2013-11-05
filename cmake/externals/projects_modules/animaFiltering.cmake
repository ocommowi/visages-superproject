function(animaFiltering_project)

set(ep animaFiltering)

## #############################################################################
## List the dependencies of the project
## #############################################################################

list(APPEND ${ep}_dependencies 
  animaMath
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

set (url svn+ssh://${GFORGE_USERNAME}@scm.gforge.inria.fr/svnroot/anima-filters/trunk)
if (NOT DEFINED ${ep}_SOURCE_DIR)
  set(location SVN_REPOSITORY ${url})
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
  -DBUILD_TOOLS:BOOL=OFF
  -DITK_DIR:FILEPATH=${ITK_DIR}
  -DANIMA-MATHS_DIR:FILEPATH=${animaMath_DIR}
  )

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep}
  ${ep_dirs}
  ${location}
  UPDATE_COMMAND ""
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS ${cmake_args}
  DEPENDS ${${ep}_dependencies}
  INSTALL_COMMAND ""  
  UPDATE_COMMAND ""
  )


## #############################################################################
## Add custom targets
## #############################################################################

EP_AddCustomTargets(${ep})

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_DIR ${binary_dir} PARENT_SCOPE)

endif()

endfunction()
