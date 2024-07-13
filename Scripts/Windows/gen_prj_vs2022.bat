
@echo off
setlocal

pushd %~dp0
pushd ..\..\
pushd Builds\Windows
if exist "vs2022" (
    echo Directory Build\windows\vs2022 already exists.
) else (
    echo Creating vs2022 directory...
    mkdir vs2022
)

:: Change to the directory and run CMake
cd vs2022
cmake -G "Visual Studio 17 2022" -A x64 ..\..\..

popd 
popd
popd 

endlocal