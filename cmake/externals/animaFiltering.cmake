function(animaFiltering_project)

    set(animaFiltering-package-name animaFiltering PARENT_SCOPE)

    PackageInit(animaFiltering animaFiltering animaFiltering OFF OPTIONALLY_REQUIRED_FOR_PLUGINS)
    if (TARGET animaFiltering)
        return()
    endif()

    ParseProjectArguments(animaFiltering animaFilteringp "TEST" "" ${ARGN})

    set(animaFilteringp_TESTING OFF)
    if (${animaFilteringp_TEST})
        set(animaFilteringp_TESTING ON)
    endif()

    if (NOT DEFINED location)
        set(location SVN_REPOSITORY "svn+ssh://${GFORGE_USERNAME}@scm.gforge.inria.fr/svnroot/anima-filters/trunk")
    endif()

    # -fPIC is need with static lib for gcc on amd64 plateform.
    if (${CMAKE_HOST_UNIX} AND ${CMAKE_SYSTEM_PROCESSOR} MATCHES x86_64|amd64)    
        set(ep_common_cxx_flags "${ep_common_cxx_flags} -fPIC")
        set(ep_common_c_flags "${ep_common_c_flags} -fPIC")        
    endif()         
    
    SetExternalProjectsDirs(animaFiltering ep_build_dirs)
    ExternalProject_Add(animaFiltering
        ${ep_build_dirs}
        ${location}
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        CMAKE_CACHE_ARGS
            ${ep_common_cache_args}
            -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
            -DCMAKE_CXX_FLAGS:STRING=${ep_common_c_flags}            
            -DBUILD_TESTING:BOOL=${animaFilteringp_TESTING}
            -DBUILD_SHARED_LIBS:BOOL=OFF
            -DITK_DIR:FILEPATH=${ITK_DIR}
            -DVTK_DIR:FILEPATH=${VTK_DIR}
            -DANIMA-MATHS_DIR:FILEPATH=${animaMath_DIR}
        DEPENDS animaMath
    )
    ExternalForceBuild(animaFiltering)

    ExternalProject_Get_Property(animaFiltering binary_dir)
    set(animaFiltering_DIR ${binary_dir} PARENT_SCOPE)

endfunction()
