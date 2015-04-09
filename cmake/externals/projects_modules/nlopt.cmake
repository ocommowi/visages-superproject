function(nlopt_project)

set(ep nlopt)
  
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

#EP_SetDirectories(${ep}
#  EP_DIRECTORIES ep_dirs
#  )

set(dirs PREFIX ${ep})
set(dirs ${dirs} DOWNLOAD_DIR "${ep}/")
set(dirs ${dirs} STAMP_DIR "${ep}/stamp")
set(dirs ${dirs} INSTALL_DIR "${ep}/install/${CMAKE_CFG_INTDIR}")
set(dirs ${dirs} TMP_DIR "${ep}/tmp")
set(dirs ${dirs} SOURCE_DIR ${CMAKE_SOURCE_DIR}/${ep})    

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${ep}/CMakeLists.txt 
OR EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${ep}/configure)
  set(${ep}_SOURCE_DIR SOURCE_DIR ${CMAKE_SOURCE_DIR}/${ep})    
endif()

## #############################################################################
## Define repository where get the sources
## #############################################################################

set(url http://ab-initio.mit.edu/nlopt/nlopt-2.4.2.tar.gz)
if (NOT DEFINED ${ep}_SOURCE_DIR)
  set(location URL ${url} URL_MD5 "d0b8f139a4acf29b76dbae69ade8ac54")
endif()

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep}
  ${dirs}
  ${location}
  CONFIGURE_COMMAND "./configure"
  INSTALL_COMMAND ""  
  UPDATE_COMMAND ""
  BUILD_IN_SOURCE 1
  )

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_DIR ${binary_dir} PARENT_SCOPE)


## #############################################################################
## Add custom targets
## #############################################################################

EP_AddCustomTargets(${ep})

endif()

endfunction()
