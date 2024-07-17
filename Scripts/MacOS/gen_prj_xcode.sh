#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd  ${SCRIPT_DIR}
pushd ../../
pushd ./Builds/Macos
if [ -d "./Xcode" ]; then
    echo "Directory Build\\Macos\\Xcode already exists."
else
    echo "Creating Xcode directory..."
    mkdir Xcode
fi

cd Xcode
echo ${pwd}
cmake -DEXPORT_PLATFORMS=Darwin -G "Xcode" ../../..

popd 
popd
popd 
