function(animaRegistration_project)

    set(animaRegistration-package-name animaRegistration PARENT_SCOPE)

    PackageInit(animaRegistration animaRegistration animaRegistration OFF OPTIONALLY_REQUIRED_FOR_PLUGINS)
    if (TARGET animaRegistration)
        return()
    endif()

    ParseProjectArguments(animaRegistration animaRegistrationp "TEST" "" ${ARGN})

    set(animaRegistrationp_TESTING OFF)
    if (${animaRegistrationp_TEST})
        set(animaRegistrationp_TESTING ON)
    endif()

    if (NOT DEFINED location)
        set(location SVN_REPOSITORY "svn+ssh://${GFORGE_USERNAME}@scm.gforge.inria.fr/svnroot/anima-reg/trunk")
    endif()
    
    if (${CMAKE_HOST_UNIX} AND ${CMAKE_SYSTEM_PROCESSOR} MATCHES x86_64|amd64)    
        set(ep_common_cxx_flags "${ep_common_cxx_flags} -fPIC")
        set(ep_common_c_flags "${ep_common_c_flags} -fPIC")
    endif() 
    
    SetExternalProjectsDirs(animaRegistration ep_build_dirs)
    ExternalProject_Add(animaRegistration
        ${ep_build_dirs}
        ${location}
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        CMAKE_CACHE_ARGS
            ${ep_common_cache_args}
            -DCMAKE_CXX_FLAGS:STRING=${ep_common_cxx_flags}
            -DCMAKE_C_FLAGS:STRING=${ep_common_c_flags}            
            -DBUILD_TESTING:BOOL=${animaRegistrationp_TESTING}
            -DBUILD_SHARED_LIBS:BOOL=OFF
            -DITK_DIR:FILEPATH=${ITK_DIR}
            -DVTK_DIR:FILEPATH=${VTK_DIR}
            -DANIMA-MATHS_DIR:FILEPATH=${animaMath_DIR}
            -DANIMA-FILTERING_DIR:FILEPATH=${animaFiltering_DIR}
            -DUSE_RPI:BOOL=ON
            -DRPI_DIR:FILEPATH=${RPI_DIR}            
        DEPENDS animaMath animaFiltering
    )
    ExternalForceBuild(animaRegistration)

    ExternalProject_Get_Property(animaRegistration binary_dir)
    set(animaRegistration_DIR ${binary_dir} PARENT_SCOPE)

endfunction()
