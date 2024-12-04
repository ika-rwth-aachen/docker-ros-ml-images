#!/bin/bash

# get container version information
eval $(cat /etc/os-release | grep ^VERSION=)

ARCH=$(uname -m)

[[ -f /etc/nv_tegra_release ]] && TEGRA_RELEASE=$(cat /etc/nv_tegra_release | grep -o "R[0-9]* (release)" | awk '{print $1}').$(cat /etc/nv_tegra_release | grep -o "REVISION: [0-9]*\.[0-9]*" | awk '{print $2}')

if [[ -z "$RMW_IMPLEMENTATION" && $ROS_DISTRO != "noetic" ]]; then
  if ros2 pkg list | grep -q "rmw_fastrtps_cpp"; then
    export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
  fi
fi

CUDA_VERSION=$(dpkg -l 2> /dev/null | grep -E "cuda-cudart-[0-9]" | awk '{ print $3 }' | head -n 1)
CUDNN_VERSION=$(dpkg -l 2> /dev/null | grep -E "libcudnn[0-9]" | awk '{ print $3 }' | head -n 1)
TENSORRT_VERSION=$(dpkg -l 2> /dev/null | grep -E "libnvinfer[0-9]" | awk '{ print $3 }' | head -n 1)

PYTHON_VERSION=$(python --version | awk '{print $2}')
TF_PIP_VERSION=$(python -c "exec(\"try:\n  import os; os.environ['TF_CPP_MIN_LOG_LEVEL'] = '1'; import tensorflow as tf; print(tf.__version__);\n\rexcept ImportError:\n  pass\")")
PT_PIP_VERSION=$(python -c "exec(\"try:\n  import torch; print(torch.__version__);\n\rexcept ImportError:\n  pass\")")

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
EOF

[[ -n "$TEGRA_RELEASE" ]] && echo "Tegra Release: $TEGRA_RELEASE"
[[ -n "$PYTHON_VERSION" ]] && echo "Python: $PYTHON_VERSION"
[[ -n "$ROS_DISTRO" ]] && echo "ROS: $ROS_DISTRO"
[[ -n "$RMW_IMPLEMENTATION" ]] && echo "RMW: $RMW_IMPLEMENTATION"
[[ -n "$CMAKE_VERSION" ]] && echo "CMake: $CMAKE_VERSION"
[[ -n "$CUDA_VERSION" ]] && echo "CUDA: $CUDA_VERSION"
[[ -n "$CUDNN_VERSION" ]] && echo "cuDNN: $CUDNN_VERSION"
[[ -n "$TENSORRT_VERSION" ]] && echo "TensorRT: $TENSORRT_VERSION"
[[ -n "$TRITON_VERSION" ]] && echo "Triton Client: $TRITON_VERSION"
[[ -n "$TF_PIP_VERSION" ]] && echo "TensorFlow: $TF_PIP_VERSION"
[[ -n "$PT_PIP_VERSION" ]] && echo "PyTorch: $PT_PIP_VERSION"
[[ -n "$NUM_GPUS" ]] && echo "Available GPUs: $NUM_GPUS"
[[ -n "$GPU_INFOS" ]] && echo "$GPU_INFOS"

cat << EOF
================================================================================

EOF
