#!/bin/bash

# get container version information
eval $(cat /etc/os-release | grep ^VERSION=)

ARCH=$(uname -m)

[[ -f /etc/nv_tegra_release ]] && JETSON_LINUX_VERSION=$(cat /etc/nv_tegra_release | head -n 1 | sed 's/ (release), REVISION: /./g' | awk '{print $2}' | grep -oE '[0-9.]+')

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
ONNX_RUNTIME_VERSION=$(python -c "exec(\"try:\n  import onnxruntime; print(onnxruntime.__version__);\n\rexcept ImportError:\n  pass\")")

CMAKE_VERSION=$(cmake --version  | grep version | awk '{print $3}')
if [[ $(command -v nvidia-smi) ]]; then
  GPU_INFOS=$(nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv,noheader)
  NUM_GPUS=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
else
  NUM_GPUS="0"
  GPU_INFOS=""
fi

# print information
cat << EOF
╔══════════════════════════════════════════════════ CONTAINER INFORMATION ═════╗
EOF
printf "║ %13s | %-60s ║\n" "Architecture" "$ARCH"
printf "║ %13s | %-60s ║\n" "Ubuntu" "$VERSION"
[[ -n "$JETSON_LINUX_VERSION" ]] && printf "║ %13s | %-60s ║\n" "Jetson Linux" "$JETSON_LINUX_VERSION"
[[ $(getent passwd $DOCKER_USER) ]] && printf "║ %13s | %-60s ║\n" "User:PW" "$DOCKER_USER:$DOCKER_USER"
[[ -n "$PYTHON_VERSION" ]] && printf "║ %13s | %-60s ║\n" "Python" "$PYTHON_VERSION"
[[ -n "$ROS_DISTRO" ]] && printf "║ %13s | %-60s ║\n" "ROS" "$ROS_DISTRO"
[[ -n "$RMW_IMPLEMENTATION" ]] && printf "║ %13s | %-60s ║\n" "RMW" "$RMW_IMPLEMENTATION"
[[ -n "$CMAKE_VERSION" ]] && printf "║ %13s | %-60s ║\n" "CMake" "$CMAKE_VERSION"
[[ -n "$CUDA_VERSION" ]] && printf "║ %13s | %-60s ║\n" "CUDA" "$CUDA_VERSION"
[[ -n "$CUDNN_VERSION" ]] && printf "║ %13s | %-60s ║\n" "cuDNN" "$CUDNN_VERSION"
[[ -n "$TENSORRT_VERSION" ]] && printf "║ %13s | %-60s ║\n" "TensorRT" "$TENSORRT_VERSION"
[[ -n "$TRITON_VERSION" ]] && printf "║ %13s | %-60s ║\n" "Triton Client" "$TRITON_VERSION"
[[ -n "$TF_PIP_VERSION" ]] && printf "║ %13s | %-60s ║\n" "TensorFlow" "$TF_PIP_VERSION"
[[ -n "$PT_PIP_VERSION" ]] && printf "║ %13s | %-60s ║\n" "PyTorch" "$PT_PIP_VERSION"
[[ -n "$ONNX_RUNTIME_VERSION" ]] && printf "║ %13s | %-60s ║\n" "ONNX RT" "$ONNX_RUNTIME_VERSION"
[[ -n "$NUM_GPUS" ]] && printf "║ %13s | %-60s ║\n" "GPUs" "$NUM_GPUS"
if [[ -n "$GPU_INFOS" ]]; then
  IFS=$'\n'
  for GPU_INFO in $GPU_INFOS; do
    printf "║ %13s | %-60s ║\n" "" "$GPU_INFO"
  done
  unset IFS
fi

cat << EOF
╚══════════════════════════════════════════════════════════════════════════════╝

EOF
