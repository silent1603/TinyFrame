
@echo off
setlocal

pushd %~dp0
pushd ..\..\
pushd Builds\Windows
if exist "vs2019" (
    echo Directory Build\windows\vs2019 already exists.
) else (
    echo Creating vs2019 directory...
    mkdir vs2019
)

:: Change to the directory and run CMake
cd vs2019
cmake -DEXPORT_PLATFORMS=Windows -G "Visual Studio 16 2019" -A x64 ..\..\..

popd 
popd
popd 

endlocal