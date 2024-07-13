Set(FETCHCONTENT_QUIET FALSE)

if(BUILD_TESTING)

FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        v3.6.0 # or a later release 
  SOURCE_DIR     ${CMAKE_SOURCE_DIR}/Libs/Externals/Catch2
)

FetchContent_MakeAvailable(Catch2)
list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
endif()

# Optional Dependency, doesn't trigger error if missing
#find_package(OpenSSL)