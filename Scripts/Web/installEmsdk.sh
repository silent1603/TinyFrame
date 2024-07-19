#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd  ${SCRIPT_DIR}
pushd ../../
pushd ./Tools
if [ -d "./emsdk" ]; then
    echo "Directory Tools/emsdk already exists."
else
    git clone https://github.com/emscripten-core/emsdk.git

    #Enter that directory
    cd emsdk

    # Download and install the latest SDK tools.
    ./emsdk install latest

    # Make the "latest" SDK "active" for the current user. (writes .emscripten file)
    ./emsdk activate latest

    # Activate PATH and other environment variables in the current terminal
    source ./emsdk_env.sh
fi


popd 
popd
popd 
