#!/bin/bash

# get container version information
eval $(cat /etc/os-release | grep ^VERSION=)

ARCH=$(uname -m)

if [[ -z "$RMW_IMPLEMENTATION" ]]; then
  if ros2 pkg list | grep -q "rmw_fastrtps_cpp"; then
    export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
  fi
fi

CUDA_VERSION=$(dpkg -l 2> /dev/null | grep -E "cuda-cudart-[0-9]" | awk '{ print $3 }')
PYTHON_VERSION=$(python --version | awk '{print $2}')
CMAKE_VERSION=$(cmake --version  | grep version | awk '{print $3}')
if [[ $(command -v nvidia-smi) ]]; then
  NUM_GPUS=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
  GPU_INFOS=$(nvidia-smi --query-gpu=name,driver_version,utilization.gpu,utilization.memory,memory.used,memory.total --format=csv | column -t -s, | sed 's/^/  /')
else
  NUM_GPUS="0"
  GPU_INFOS=""
fi

# print information
cat << EOF
=== CONTAINER INFORMATION ======================================================
Architecture: $ARCH
Ubuntu: $VERSION
Python: $PYTHON_VERSION
ROS: $ROS_DISTRO
RMW: $RMW_IMPLEMENTATION
CMake: $CMAKE_VERSION
CUDA: $CUDA_VERSION
Triton: $TRITON_VERSION
Available GPUs: $NUM_GPUS
$GPU_INFOS
================================================================================

EOF
