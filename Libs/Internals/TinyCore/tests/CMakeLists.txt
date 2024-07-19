
set(TARGET_NAME TinyCore_UnitTests)
file(GLOB_RECURSE TARGET_SOURCES CONFIGURE_DEPENDS *.cpp *.h)
add_executable(${TARGET_NAME} ${TARGET_SOURCES})
target_link_libraries(${TARGET_NAME} PRIVATE TinyCore  GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)
target_compile_options(${TARGET_NAME} PRIVATE ${compiler_options})
target_compile_definitions(${TARGET_NAME} PRIVATE ${compiler_definitions})
target_link_options(${TARGET_NAME} PRIVATE ${linker_flags})
target_include_directories(${TARGET_NAME}
  PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR} 
    ${CMAKE_CURRENT_SOURCE_DIR}/../include
    # Any other extra include required
)


include(GoogleTest)
include(Ctest)
gtest_discover_tests(${TARGET_NAME})
