#include <catch2/catch_test_macros.hpp>
extern "C"
{
    #include "TinyCore.h"
}

TEST_CASE("TinyCoreTest - Add", "[TinyCore]") 
{
    REQUIRE(addInt(2, 3) == 5);
    REQUIRE(addInt(-2, 3) == 1);
    REQUIRE(addInt(0, 0) == 0);
}