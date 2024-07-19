
#####################################
# Define Target Information
#####################################
set(TARGET_NAME TinyCore)
set(TARGET_INCLUDE_FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/include)
file(GLOB_RECURSE TARGET_SOURCES CONFIGURE_DEPENDS *.c *.h)


project(${TARGET_NAME}  DESCRIPTION "Core GameEngine" LANGUAGES C)
#####################################
# Support IDE Visualization
#####################################
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${TARGET_SOURCES})

#####################################
# Define Target according to options
#####################################
if(BUILD_SHARED_LIBS)
  add_library(${TARGET_NAME} SHARED)
else()
  add_library(${TARGET_NAME} STATIC)
endif()

target_sources(${TARGET_NAME} PRIVATE ${TARGET_SOURCES})

#####################################
# Define Target Properties and Optional OpenSSL Dependency
#####################################


# add target properties such as debug postfix, MSVC Runtime and library version
set_target_properties(${TARGET_NAME} PROPERTIES 
                                      DEBUG_POSTFIX "-d" 
                                      VERSION ${CMAKE_PROJECT_VERSION}
                                      SOVERSION ${CMAKE_PROJECT_VERSION} 
                                      COMPILE_LANGUAGE C 
                                      LINKER_LANGUAGE C 
                                      POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS})

# set target compile options as defined in the cmake/compiler_options.cmake Module
target_compile_options(${TARGET_NAME} PRIVATE ${compiler_options} )

# add compiler definition WITH_OPENSSL, if found
target_compile_definitions(${TARGET_NAME} PRIVATE ${compiler_definitions}  PRIVATE TINYCORE_LIB_EXPORTS PRIVATE $<$<BOOL:${BUILD_SHARED_LIBS}>:BUILD_SHARED_CORE> )#$<$<BOOL:${OPENSSL_FOUND}>:WITH_OPENSSL>)

# set target link options as defined in the cmake/compiler_options.cmake Module
target_link_options(${TARGET_NAME} PRIVATE ${linker_flags})

# include all the necessary directories
target_include_directories(${TARGET_NAME}
  PUBLIC
    ${TARGET_INCLUDE_FOLDER}
    # include OpenSSL directories if present
    #$<$<BOOL:${OPENSSL_FOUND}>:${OPENSSL_INCLUDE_DIR}>
    # Any other extra include required
)


# link OpenSSL libraries if present
# if(OPENSSL_FOUND)
#   target_link_libraries(${TARGET_NAME} PUBLIC OpenSSL::SSL OpenSSL::Crypto)
# endif()

if(BUILD_TESTING)
  add_subdirectory(tests)
endif()