if(WIN32)
    set(VCPKG_FALLBACK_ROOT ${CMAKE_CURRENT_BINARY_DIR}/vcpkg CACHE STRING "vcpkg configuration directory to use if vcpkg was not installed on the system before")
else()
    set(VCPKG_FALLBACK_ROOT ${CMAKE_CURRENT_BINARY_DIR}/.vcpkg CACHE STRING  "vcpkg configuration directory to use if vcpkg was not installed on the system before")
endif()

# On Windows, Vcpkg defaults to x86, even on x64 systems. If we're 
# doing a 64-bit build, we need to fix that.
if (WIN32)

    # Since the compiler checks haven't run yet, we need to figure
    # out the value of CMAKE_SIZEOF_VOID_P ourselfs

    include(CheckTypeSize)
    enable_language(C)
    check_type_size("void*" SIZEOF_VOID_P BUILTIN_TYPES_ONLY)
    
    if (SIZEOF_VOID_P EQUAL 8)
        message(STATUS "Using Vcpkg triplet 'x64-windows'")
        
        set(VCPKG_TRIPLET x64-windows)
    endif()
endif()

if(NOT DEFINED VCPKG_ROOT)
    if(NOT DEFINED ENV{VCPKG_ROOT})
	    set(VCPKG_ROOT ${VCPKG_FALLBACK_ROOT})
    else()
        set(VCPKG_ROOT $ENV{VCPKG_ROOT})
    endif()
endif()

# Installs a new copy of Vcpkg or updates an existing one
macro(vcpkg_bootstrap)
    _install_or_update_vcpkg()

    # Find out whether the user supplied their own VCPKG toolchain file
    if(NOT DEFINED ${CMAKE_TOOLCHAIN_FILE})
        # We know this wasn't set before so we need point the toolchain file to the newly found VCPKG_ROOT
        set(CMAKE_TOOLCHAIN_FILE ${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake CACHE STRING "")
    
        # Just setting vcpkg.cmake as toolchain file does not seem to actually pull in the code
        include(${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)
    
        set(AUTOMATE_VCPKG_USE_SYSTEM_VCPKG OFF)
    else()
        # VCPKG_ROOT has been defined by the toolchain file already
        set(AUTOMATE_VCPKG_USE_SYSTEM_VCPKG ON)
    endif()
    
    message(STATUS "Automate VCPKG status:")
    message(STATUS "  VCPKG_ROOT.....: ${VCPKG_ROOT}")
    message(STATUS "  VCPKG_EXEC.....: ${VCPKG_EXEC}")
    message(STATUS "  VCPKG_BOOTSTRAP: ${VCPKG_BOOTSTRAP}")
endmacro()

macro(_install_or_update_vcpkg)
    if(NOT EXISTS ${VCPKG_ROOT})
        message(STATUS "Cloning vcpkg in ${VCPKG_ROOT}")
        execute_process(COMMAND git clone https://github.com/Microsoft/vcpkg.git ${VCPKG_ROOT})

        # If a reproducible build is desired (and potentially old libraries are # ok), uncomment the
        # following line and pin the vcpkg repository to a specific githash.
        # execute_process(COMMAND git checkout 745a0aea597771a580d0b0f4886ea1e3a94dbca6 WORKING_DIRECTORY ${VCPKG_ROOT})
    else()
        # The following command has no effect if the vcpkg repository is in a detached head state.
        message(STATUS "Auto-updating vcpkg in ${VCPKG_ROOT}")
        execute_process(COMMAND git pull WORKING_DIRECTORY ${VCPKG_ROOT})
    endif()

    if(NOT EXISTS ${VCPKG_ROOT}/README.md)
        message(FATAL_ERROR "***** FATAL ERROR: Could not clone vcpkg *****")
    endif()

    if(WIN32)
        set(VCPKG_EXEC ${VCPKG_ROOT}/vcpkg.exe)
        set(VCPKG_BOOTSTRAP ${VCPKG_ROOT}/bootstrap-vcpkg.bat)
    else()
        set(VCPKG_EXEC ${VCPKG_ROOT}/vcpkg)
        set(VCPKG_BOOTSTRAP ${VCPKG_ROOT}/bootstrap-vcpkg.sh)
    endif()

    if(NOT EXISTS ${VCPKG_EXEC})
        message("Bootstrapping vcpkg in ${VCPKG_ROOT}")
        execute_process(COMMAND ${VCPKG_BOOTSTRAP} WORKING_DIRECTORY ${VCPKG_ROOT})
    endif()

    if(NOT EXISTS ${VCPKG_EXEC})
        message(FATAL_ERROR "***** FATAL ERROR: Could not bootstrap vcpkg *****")
    endif()
   
endmacro()

# Installs the list of packages given as parameters using Vcpkg
macro(vcpkg_install_packages)
    
    # Need the given list to be space-separated
    #string (REPLACE ";" " " PACKAGES_LIST_STR "${ARGN}")

    message(STATUS "Installing/Updating the following vcpkg-packages: ${PACKAGES_LIST_STR}")

    if (VCPKG_TRIPLET)
        set(ENV{VCPKG_DEFAULT_TRIPLET} "${VCPKG_TRIPLET}")
    endif()

    execute_process(
        COMMAND ${VCPKG_EXEC} install ${ARGN}
        WORKING_DIRECTORY ${VCPKG_ROOT}
        )
endmacro()