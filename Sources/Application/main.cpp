#include <iostream>
extern "C"
{
#include "TinyCore.h"
}
int main()
{
    std::cout << addInt(5,6) << '\n';
    return 0;
}