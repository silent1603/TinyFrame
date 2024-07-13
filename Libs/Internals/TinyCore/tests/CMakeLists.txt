
set(TARGET_NAME TinyCore_UnitTests)
add_executable(${TARGET_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/test_TinyCore.cpp)
target_link_libraries(${TARGET_NAME} PRIVATE TinyCore Catch2::Catch2WithMain)
target_compile_options(${TARGET_NAME} PRIVATE ${compiler_options})
target_compile_definitions(${TARGET_NAME} PRIVATE ${compiler_definitions} $<$<BOOL:${OPENSSL_FOUND}>:WITH_OPENSSL>)
target_link_options(${TARGET_NAME} PRIVATE ${linker_flags})
target_include_directories(${TARGET_NAME}
  PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR} 
    ${CMAKE_CURRENT_SOURCE_DIR}/../include
    # Any other extra include required
)


include(CTest)
include(Catch)
catch_discover_tests(${TARGET_NAME})