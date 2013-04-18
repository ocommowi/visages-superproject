function(qtShanoir_project)

    set(qtShanoir-package-name qtShanoir PARENT_SCOPE)

    PackageInit(qtShanoir qtShanoir qtShanoir OFF OPTIONALLY_REQUIRED_FOR_PLUGINS)
    if (TARGET qtShanoir)
        return()
    endif()

    ParseProjectArguments(qtShanoir qtShanoirp "TEST" "" ${ARGN})

    set(qtShanoirp_TESTING OFF)
    if (${qtShanoirp_TEST})
        set(qtShanoirp_TESTING ON)
    endif()

    if (NOT DEFINED location)
        set(location GIT_REPOSITORY "git://scm.gforge.inria.fr/qtshanoir/qtshanoir.git")
    endif()
    
    if (${CMAKE_HOST_UNIX} AND ${CMAKE_SYSTEM_PROCESSOR} MATCHES x86_64|amd64)    
        set(ep_common_cxx_flags "${ep_common_cxx_flags} -fPIC")
    endif() 
    
    SetExternalProjectsDirs(qtShanoir ep_build_dirs)
    ExternalProject_Add(qtShanoir
        ${ep_build_dirs}
        ${location}
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        CMAKE_CACHE_ARGS
            ${ep_common_cache_args}
            -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
            -DBUILD_TESTING:BOOL=${qtShanoirp_TESTING}
            -DBUILD_SHARED_LIBS:BOOL=OFF
    )
    ExternalForceBuild(qtShanoir)

    ExternalProject_Get_Property(qtShanoir binary_dir)
    set(qtShanoir_DIR ${binary_dir} PARENT_SCOPE)

endfunction()
