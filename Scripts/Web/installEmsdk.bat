@echo off
setlocal

pushd %~dp0
pushd ..\..\
pushd Tools
if exist "emsdk" (
    :: Change to the directory and run CMake
    echo vs2019 directory is exist
) else (

    :: Get the emsdk repo
    git clone https://github.com/emscripten-core/emsdk.git

    :: Enter that directory
    cd emsdk

    :: Download and install the latest SDK tools.
    emsdk.bat install latest

    ::Make the "latest" SDK "active" for the current user. (writes .emscripten file)
    emsdk.bat activate latest

    :: Activate PATH and other environment variables in the current terminal
    emsdk_env.bat
)
popd
popd 
endlocal