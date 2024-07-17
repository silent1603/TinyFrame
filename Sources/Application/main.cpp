#include <iostream>
extern "C"
{
#include "TinyCore.h"
#include "glad/gl.h"
}
int main()
{
    std::cout << addInt(5,6) << '\n';
    return 0;
}