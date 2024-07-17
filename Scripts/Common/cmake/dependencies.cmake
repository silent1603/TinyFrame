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

if(BUILD_IMGUI)
FetchContent_Declare(imgui 
	URL https://github.com/ocornut/imgui/archive/refs/tags/v1.90.9.tar.gz 
  SOURCE_DIR     ${CMAKE_SOURCE_DIR}/Libs/Externals/imgui 
	EXCLUDE_FROM_ALL
)

FetchContent_MakeAvailable(imgui)

set(IMGUI_SOURCE 
  ${imgui_SOURCE_DIR}/imgui.h
  ${imgui_SOURCE_DIR}/imgui_internal.h
  ${imgui_SOURCE_DIR}/imstb_textedit.h
  ${imgui_SOURCE_DIR}/imstb_truetype.h
  ${imgui_SOURCE_DIR}/imgui.cpp
  ${imgui_SOURCE_DIR}/imgui_draw.cpp
  ${imgui_SOURCE_DIR}/imgui_tables.cpp
  ${imgui_SOURCE_DIR}/imgui_widgets.cpp 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3_loader.h 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.h 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp )
add_library(imgui STATIC)

if(${EXPORT_PLATFORMS} STREQUAL "Linux")
elseif(${EXPORT_PLATFORMS} STREQUAL "Windows") 
  list(APPEND IMGUI_SOURCE 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_dx11.h 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_dx11.cpp 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_win32.h 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_win32.cpp
)
elseif(${EXPORT_PLATFORMS} STREQUAL "Darwin") 
  list(APPEND IMGUI_SOURCE  
  ${imgui_SOURCE_DIR}/backends/imgui_impl_metal.mm 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_metal.h 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_osx.h 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_osx.mm 
)
elseif(${EXPORT_PLATFORMS} STREQUAL "Android") 
  list(APPEND IMGUI_SOURCE 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_android.h 
  ${imgui_SOURCE_DIR}/backends/imgui_impl_android.cpp 
)
endif()

target_sources(imgui PRIVATE ${IMGUI_SOURCE})
target_include_directories(imgui PRIVATE "${imgui_SOURCE_DIR}" "${imgui_SOURCE_DIR}/backends")


endif()


FetchContent_Declare(glad 
	URL https://github.com/Dav1dde/glad/archive/refs/tags/v2.0.6.tar.gz 
  SOURCE_DIR     ${CMAKE_SOURCE_DIR}/Libs/Externals/glad 
)

FetchContent_MakeAvailable(glad)
set(GLAD_SOURCES_DIR "${CMAKE_SOURCE_DIR}/Libs/Externals/glad")
add_subdirectory("${CMAKE_SOURCE_DIR}/Libs/Externals/glad/cmake" glad_cmake)
glad_add_library(glad_gl REPRODUCIBLE glad c API gl:core=4.6)

# Optional Dependency, doesn't trigger error if missing
#find_package(OpenSSL)