function(animaMath_project)

set(ep_name animaMath)
set(EP_NAME animaMath)

## #############################################################################
## List the dependencies of the project
## #############################################################################

list(APPEND ${ep_name}_dependencies 
  ""
  )
  
  
## #############################################################################
## Prepare the project
## ############################################################################# 


EP_Initialisation(${ep_name}  
  CMAKE_VAR_EP_NAME ${EP_NAME}
  USE_SYSTEM OFF 
  BUILD_SHARED_LIBS OFF
  REQUIERD_FOR_PLUGINS OFF
  )


if (NOT USE_SYSTEM_${ep_name})
## #############################################################################
## Set directories
## #############################################################################

EP_SetDirectories(${ep_name}
  CMAKE_VAR_EP_NAME ${EP_NAME}
  ep_dirs
  )


## #############################################################################
## Define repository where get the sources
## #############################################################################

if (NOT DEFINED ${EP_NAME}_SOURCE_DIR)
  set(location 
    SVN_REPOSITORY "svn+ssh://${GFORGE_USERNAME}@scm.gforge.inria.fr/svnroot/anima-maths/trunk"
  )
endif()


## #############################################################################
## Add specific cmake arguments for configuration step of the project
## #############################################################################

# set compilation flags
if (UNIX)
  set(${ep_name}_c_flags "${${ep_name}_c_flags} -Wall")
  set(${ep_name}_cxx_flags "${${ep_name}_cxx_flags} -Wall")
endif()

set(cmake_args
  ${ep_common_cache_args}
  -DCMAKE_C_FLAGS:STRING=${${ep_name}_c_flags}
  -DCMAKE_CXX_FLAGS:STRING=${${ep_name}_cxx_flags}  
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS_${ep_name}}
  -DBUILD_TOOLS:BOOL=OFF
  -DITK_DIR:FILEPATH=${ITK_DIR}
  )

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep_name}
  ${ep_dirs}
  ${location}
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS ${cmake_args}
  DEPENDS ${${ep_name}_dependencies}
  INSTALL_COMMAND ""  
  )


## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep_name} binary_dir)
set(${EP_NAME}_DIR ${binary_dir} PARENT_SCOPE)

endif()

endfunction()
