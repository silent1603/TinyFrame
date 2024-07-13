@echo off
setlocal

pushd %~dp0
pushd ..\..\
pushd Builds\Windows
if exist "vs2019" (
   cd vs2019
   ctest 
   popd 
) else (
    echo vs2019 directory isn't exist
)
popd
popd 

endlocal