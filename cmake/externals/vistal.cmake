function(vistal_project)

    set(vistal-package-name vistal PARENT_SCOPE)

    PackageInit(vistal vistal vistal OFF OPTIONALLY_REQUIRED_FOR_PLUGINS)
    if (TARGET vistal)
        return()
    endif()

    ParseProjectArguments(vistal vistalp "TEST" "" ${ARGN})

    set(vistalp_TESTING OFF)
    if (${vistalp_TEST})
        set(vistalp_TESTING ON)
    endif()

    if (NOT DEFINED vistal_SOURCE_DIR)
        set(location SVN_REPOSITORY "svn+ssh://${GFORGE_USERNAME}@scm.gforge.inria.fr/svnroot/vistal/trunk/Vistal")
    endif()
    
    # -fPIC is need with static lib for gcc on amd64 plateform.
    if (${CMAKE_HOST_UNIX} AND ${CMAKE_SYSTEM_PROCESSOR} MATCHES x86_64|amd64)    
        set(ep_common_cxx_flags "${ep_common_cxx_flags} -fPIC")
        set(ep_common_c_flags "${ep_common_c_flags} -fPIC")        
    endif() 
    
    SetExternalProjectsDirs(vistal ep_build_dirs)
    ExternalProject_Add(vistal
        ${ep_build_dirs}
        ${location}
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        CMAKE_CACHE_ARGS
            ${ep_common_cache_args}
            -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
            -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}            
            -DBUILD_TESTING:BOOL=${vistalp_TESTING}
            -DBUILD_SHARED_LIBS:BOOL=OFF
            -DVTK_DIR:FILEPATH=${VTK_DIR}
            -DITK_DIR:FILEPATH=${ITK_DIR}
    )
    ExternalForceBuild(vistal)

    ExternalProject_Get_Property(vistal binary_dir)
    set(vistal_DIR ${binary_dir} PARENT_SCOPE)

endfunction()
