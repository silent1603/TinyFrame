#include <gtest/gtest.h>
extern "C"
{
    #include "TinyCore.h"
}
 
TEST (TinyCoreTest, InvalidParam) { 
    EXPECT_EQ(4, addInt(-1, 5));
    EXPECT_EQ(8, addInt(10, -2));
    EXPECT_EQ(0, addInt(0, 0));
}
 
TEST(TinyCoreTest, ValidParam) {
    EXPECT_EQ(9, addInt(4, 5));
    EXPECT_EQ(7, addInt(5, 2));
    EXPECT_EQ(15, addInt(7, 8));
}
 
int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}