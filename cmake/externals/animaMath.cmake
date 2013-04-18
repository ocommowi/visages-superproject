function(animaMath_project)

    set(animaMath-package-name animaMath PARENT_SCOPE)

    PackageInit(animaMath animaMath animaMath OFF OPTIONALLY_REQUIRED_FOR_PLUGINS)
    if (TARGET animaMath)
        return()
    endif()

    ParseProjectArguments(animaMath animaMathp "TEST" "" ${ARGN})

    set(animaMathp_TESTING OFF)
    if (${animaMathp_TEST})
        set(animaMathp_TESTING ON)
    endif()

    if (NOT DEFINED location)
        set(location SVN_REPOSITORY "svn+ssh://${GFORGE_USERNAME}@scm.gforge.inria.fr/svnroot/anima-maths/trunk")
    endif()
    
    if (${CMAKE_HOST_UNIX} AND ${CMAKE_SYSTEM_PROCESSOR} MATCHES x86_64|amd64)    
        set(ep_common_cxx_flags "${ep_common_cxx_flags} -fPIC")
    endif() 
    
    SetExternalProjectsDirs(animaMath ep_build_dirs)
    ExternalProject_Add(animaMath
        ${ep_build_dirs}
        ${location}
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        CMAKE_CACHE_ARGS
            ${ep_common_cache_args}
            -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
            -DBUILD_TESTING:BOOL=${animaMathp_TESTING}
            -DBUILD_SHARED_LIBS:BOOL=OFF
            -DITK_DIR:FILEPATH=${ITK_DIR}
            -DVTK_DIR:FILEPATH=${VTK_DIR}
    )
    ExternalForceBuild(animaMath)

    ExternalProject_Get_Property(animaMath binary_dir)
    set(animaMath_DIR ${binary_dir} PARENT_SCOPE)

endfunction()
