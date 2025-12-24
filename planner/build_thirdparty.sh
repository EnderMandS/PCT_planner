#!/bin/bash

set -e

ROOT_DIR=$(cd $(dirname "$0"); pwd)
echo "ROOT_DIR: ${ROOT_DIR}"

CONDA_PREFIX=${CONDA_PREFIX:-"$HOME/miniconda3"}
PYTHON_INTERPRETER=${CONDA_PREFIX}/bin/python
echo "Using python interpreter: ${PYTHON_INTERPRETER}"

# build gtsam
cd ${ROOT_DIR}/lib/3rdparty/gtsam-4.1.1

if [ ! -d "build" ]; then
  mkdir build
fi
if [ ! -d "install" ]; then
  mkdir install
fi
cd build

cmake .. -GNinja -DCMAKE_INSTALL_PREFIX="../install" -DCMAKE_BUILD_TYPE=Release -DGTSAM_USE_SYSTEM_EIGEN=ON -DPYTHON_EXECUTABLE=${PYTHON_INTERPRETER}
ninja
ninja install

# build osqp
cd ${ROOT_DIR}/lib/3rdparty/osqp

if [ ! -d "build" ]; then
  mkdir build
fi
if [ ! -d "install" ]; then
  mkdir install
fi
cd build

cmake .. -GNinja -DCMAKE_INSTALL_PREFIX="../install" -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=${PYTHON_INTERPRETER}
ninja
ninja install

echo "Thirdparty libraries built successfully."

