cmake_minimum_required(VERSION 3.15)

# Enables the Visibility Property on all target types
cmake_policy(SET CMP0063 NEW)
# Enable add link library
cmake_policy(SET CMP0079 NEW)

# Enables the MSVC_RUNTIME_LIBRARY property on targets
cmake_policy(SET CMP0091 NEW)
# Define the Project Name and Description
project(TinyFrame LANGUAGES CXX DESCRIPTION "moderncpp-project is a starter project for Modern C++")

# Set Project version (used for library versioning and for CPack)
set(CMAKE_PROJECT_VERSION_MAJOR 0)
set(CMAKE_PROJECT_VERSION_MINOR 0)
set(CMAKE_PROJECT_VERSION_PATCH 1)
set(CMAKE_PROJECT_VERSION ${CMAKE_PROJECT_VERSION_MAJOR}.${CMAKE_PROJECT_VERSION_MINOR}.${CMAKE_PROJECT_VERSION_PATCH})

# Set required C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
# Generate the compile_commands.json file
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
# Set the Relative Path Configurations
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
# Configure the visibility of symbols in targets
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)

# Define installation folder and the module path (this one required by conan)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)
set(CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR} ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR} ${CMAKE_PREFIX_PATH})

set(VCPKG_ROOT "${CMAKE_SOURCE_DIR}/Tools/vcpkg")
# Define platform
set(EXPORT_PLATFORMS "" CACHE PATH "Current Platforms ")
if ("${EXPORT_PLATFORMS}" STREQUAL "")
    set(EXPORT_PLATFORMS ${CMAKE_SYSTEM_NAME})
endif()

#####################################
# Define Options
#####################################
option(BUILD_TESTING "Build tests" ON)
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)
option(BUILD_WITH_MT "Build libraries as MultiThreaded DLL (Windows Only)" OFF)
option(BUILD_IMGUI "Build embedded with imgui" ON)

#####################################
# Copy Exe and dll , lib  to bin
#####################################
set(COMMON_EXPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Release")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${COMMON_EXPORT_PATH}") # .exe and .dll
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${COMMON_EXPORT_PATH}") # .so and .dylib
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${COMMON_EXPORT_PATH}") # .lib and .a

set(CMAKE_VS_DEBUGGER_WORKING_DIRECTORY "${COMMON_EXPORT_PATH}")
foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER ${CONFIG} CONFIG_UPPER)

    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG_UPPER} "${COMMON_EXPORT_PATH}") # .exe and .dll
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG_UPPER} "${COMMON_EXPORT_PATH}") # .so and .dylib
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG_UPPER} "${COMMON_EXPORT_PATH}") # .lib and .a
endforeach()



#####################################
# Define CMake Module Imports
#####################################
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
include(InstallRequiredSystemLibraries)
include(GenerateExportHeader)
include(FetchContent)

include("${CMAKE_SOURCE_DIR}/Scripts/Common/cmake/clang_format.cmake")
include("${CMAKE_SOURCE_DIR}/Scripts/Common/cmake/compiler_options.cmake")
include("${CMAKE_SOURCE_DIR}/Scripts/Common/cmake/cpack.cmake")
include("${CMAKE_SOURCE_DIR}/Scripts/Common/cmake/cppcheck.cmake")
include("${CMAKE_SOURCE_DIR}/Scripts/Common/cmake/dependencies.cmake")
include("${CMAKE_SOURCE_DIR}/Scripts/Common/cmake/vcpkg.cmake")

vcpkg_bootstrap()
vcpkg_install_packages()

find_package(assimp CONFIG REQUIRED)
find_package(ZLIB REQUIRED)
find_package(GTest CONFIG REQUIRED)
find_package(spdlog CONFIG REQUIRED)
find_package(imgui CONFIG REQUIRED)
find_package(glad CONFIG REQUIRED)
find_package(Tracy CONFIG REQUIRED)
find_package(Freetype REQUIRED)
find_package(sol2 CONFIG REQUIRED)
find_package(RmlUi CONFIG REQUIRED)
find_package(OpenAL CONFIG REQUIRED)
find_path(MLPACK_INCLUDE_DIRS "mlpack/mlpack.hpp")
find_package(Lua REQUIRED)
find_package(unofficial-joltphysics CONFIG REQUIRED)
find_package(unofficial-imguizmo CONFIG REQUIRED)
find_package(unofficial-imgui-node-editor CONFIG REQUIRED)
find_package(glm CONFIG REQUIRED) 
find_package(unofficial-enet CONFIG REQUIRED)
find_package(EASTL CONFIG REQUIRED)
find_package(CURL REQUIRED)
find_package(box2d CONFIG REQUIRED) 
find_package(RapidJSON CONFIG REQUIRED)
find_package(Stb REQUIRED)
find_package(asio CONFIG REQUIRED)
if(BUILD_TESTING)
    enable_testing()
endif()

#####################################
# Copy Data to bin
#####################################
file(COPY "${CMAKE_SOURCE_DIR}/Data" DESTINATION "${COMMON_EXPORT_PATH}")

#####################################
# Define Targets
#####################################
add_subdirectory(Sources)
add_subdirectory(Libs)





