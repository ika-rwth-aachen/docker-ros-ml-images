#!/bin/bash

# get container version information
eval $(cat /etc/os-release | grep ^VERSION=)

ARCH=$(uname -m)

if [[ $(command -v nvcc) ]]; then
  CUDA_VERSION=$(nvcc --version | grep ^Cuda | awk '{print $6}' | sed 's/V//')
fi 

if [[ -f /usr/include/cudnn_version.h ]]; then
  CUDNN_MAJOR=$(cat /usr/include/cudnn_version.h | grep "#define CUDNN_MAJOR" | sed "s/#define CUDNN_MAJOR //")
  CUDNN_MINOR=$(cat /usr/include/cudnn_version.h | grep "#define CUDNN_MINOR" | sed "s/#define CUDNN_MINOR //")
  CUDNN_PATCH=$(cat /usr/include/cudnn_version.h | grep "#define CUDNN_PATCHLEVEL" | sed "s/#define CUDNN_PATCHLEVEL //")
  CUDNN_VERSION=$CUDNN_MAJOR.$CUDNN_MINOR.$CUDNN_PATCH
fi

if [[ -f /usr/include/${ARCH}-linux-gnu/NvInferVersion.h ]]; then
  TENSORRT_MAJOR=$(cat /usr/include/${ARCH}-linux-gnu/NvInferVersion.h | grep "#define NV_TENSORRT_MAJOR" | sed "s/#define NV_TENSORRT_MAJOR //" | sed "s#//.*##" | sed "s/ //")
  TENSORRT_MINOR=$(cat /usr/include/${ARCH}-linux-gnu/NvInferVersion.h | grep "#define NV_TENSORRT_MINOR" | sed "s/#define NV_TENSORRT_MINOR //" | sed "s#//.*##" | sed "s/ //")
  TENSORRT_PATCH=$(cat /usr/include/${ARCH}-linux-gnu/NvInferVersion.h | grep "#define NV_TENSORRT_PATCH" | sed "s/#define NV_TENSORRT_PATCH //" | sed "s#//.*##" | sed "s/ //")
  TENSORRT_VERSION=$TENSORRT_MAJOR.$TENSORRT_MINOR.$TENSORRT_PATCH
fi

PYTHON_VERSION=$(python --version | awk '{print $2}')
TF_PIP_VERSION=$(python -c "exec(\"try:\n  import os; os.environ['TF_CPP_MIN_LOG_LEVEL'] = '1'; import tensorflow as tf; print(tf.__version__);\n\rexcept ImportError:\n  pass\")")
PT_PIP_VERSION=$(python -c "exec(\"try:\n  import torch; print(torch.__version__);\n\rexcept ImportError:\n  pass\")")

if [[ -f /usr/local/include/tensorflow/tensorflow/core/public/version.h ]]; then
  TF_C_MAJOR=$(cat /usr/local/include/tensorflow/tensorflow/core/public/version.h | grep "#define TF_MAJOR_VERSION" | sed "s/#define TF_MAJOR_VERSION //")
  TF_C_MINOR=$(cat /usr/local/include/tensorflow/tensorflow/core/public/version.h | grep "#define TF_MINOR_VERSION" | sed "s/#define TF_MINOR_VERSION //")
  TF_C_PATCH=$(cat /usr/local/include/tensorflow/tensorflow/core/public/version.h | grep "#define TF_PATCH_VERSION" | sed "s/#define TF_PATCH_VERSION //")
  TF_C_VERSION=$TF_C_MAJOR.$TF_C_MINOR.$TF_C_PATCH
fi

if [[ -f /opt/libtorch/build-version ]]; then
  PT_C_VERSION=$(cat /opt/libtorch/build-version)
fi

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
CMake: $CMAKE_VERSION
CUDA: $CUDA_VERSION
cuDNN: $CUDNN_VERSION
TensorRT: $TENSORRT_VERSION
TensorFlow Python: $TF_PIP_VERSION
TensorFlow C/C++: $TF_C_VERSION
PyTorch Python: $PT_PIP_VERSION
PyTorch C/C++: $PT_C_VERSION
Available GPUs: $NUM_GPUS
$GPU_INFOS
================================================================================

EOF
