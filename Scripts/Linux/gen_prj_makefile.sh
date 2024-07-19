#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd  ${SCRIPT_DIR}
pushd ../../
pushd ./Builds/Linux
if [ -d "./gmake" ]; then
    echo "Directory Build/Linux/gmake already exists."
else
    echo "Creating gmake directory..."
    mkdir gmake
fi

cd gmake
echo ${pwd}
cmake -DEXPORT_PLATFORMS=Linux -G "Unix Makefiles" ../../..

popd 
popd
popd 
