#!/bin/bash

# get container version information
eval $(cat /etc/os-release | grep ^VERSION=)

ARCH=$(uname -m)

[[ -f /etc/nv_tegra_release ]] && JETSON_LINUX_VERSION=$(cat /etc/nv_tegra_release | head -n 1 | sed 's/ (release), REVISION: /./g' | awk '{print $2}' | grep -oE '[0-9.]+')

if [[ -z "$ROS_DOMAIN_ID" ]]; then
  export ROS_DOMAIN_ID=0
fi

if [[ -z "$RMW_IMPLEMENTATION" ]]; then
  export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
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
  NUM_GPUS=$(echo "$GPU_INFOS" | wc -l)
else
  NUM_GPUS="0"
  GPU_INFOS=""
fi

# print information
ENTRY_KEYS=()
ENTRY_VALUES=()

add_entry() {
  local key="$1"
  local value="$2"
  ENTRY_KEYS+=("$key")
  ENTRY_VALUES+=("$value")
}

add_entry "Architecture" "$ARCH"
add_entry "Ubuntu" "$VERSION"
[[ -n "$JETSON_LINUX_VERSION" ]] && add_entry "Jetson Linux" "$JETSON_LINUX_VERSION"
[[ $(getent passwd $DOCKER_USER) ]] && add_entry "User:PW" "$DOCKER_USER:$DOCKER_USER"
[[ -n "$PYTHON_VERSION" ]] && add_entry "Python" "$PYTHON_VERSION"
[[ -n "$ROS_DISTRO" ]] && add_entry "ROS" "$ROS_DISTRO"
[[ -n "$ROS_DOMAIN_ID" ]] && add_entry "ROS Domain ID" "$ROS_DOMAIN_ID"
[[ -n "$RMW_IMPLEMENTATION" ]] && add_entry "RMW" "$RMW_IMPLEMENTATION"
[[ -n "$CMAKE_VERSION" ]] && add_entry "CMake" "$CMAKE_VERSION"
[[ -n "$CUDA_VERSION" ]] && add_entry "CUDA" "$CUDA_VERSION"
[[ -n "$CUDNN_VERSION" ]] && add_entry "cuDNN" "$CUDNN_VERSION"
[[ -n "$TENSORRT_VERSION" ]] && add_entry "TensorRT" "$TENSORRT_VERSION"
[[ -n "$TRITON_VERSION" ]] && add_entry "Triton Client" "$TRITON_VERSION"
[[ -n "$TF_PIP_VERSION" ]] && add_entry "TensorFlow" "$TF_PIP_VERSION"
[[ -n "$PT_PIP_VERSION" ]] && add_entry "PyTorch" "$PT_PIP_VERSION"
[[ -n "$ONNX_RUNTIME_VERSION" ]] && add_entry "ONNX RT" "$ONNX_RUNTIME_VERSION"
[[ -n "$NUM_GPUS" ]] && add_entry "GPUs" "$NUM_GPUS"
if [[ -n "$GPU_INFOS" ]]; then
  while IFS= read -r GPU_INFO; do
    add_entry "" "$GPU_INFO"
  done <<< "$GPU_INFOS"
fi

KEY_WIDTH=13
VALUE_WIDTH=60
for ((i = 0; i < ${#ENTRY_KEYS[@]}; i++)); do
  (( ${#ENTRY_KEYS[$i]} > KEY_WIDTH )) && KEY_WIDTH=${#ENTRY_KEYS[$i]}
  (( ${#ENTRY_VALUES[$i]} > VALUE_WIDTH )) && VALUE_WIDTH=${#ENTRY_VALUES[$i]}
done

TITLE=" CONTAINER INFORMATION "
INNER_WIDTH=$((KEY_WIDTH + VALUE_WIDTH + 5))
if (( ${#TITLE} > INNER_WIDTH )); then
  VALUE_WIDTH=$((VALUE_WIDTH + ${#TITLE} - INNER_WIDTH))
  INNER_WIDTH=$((KEY_WIDTH + VALUE_WIDTH + 5))
fi

LEFT_BORDER_WIDTH=$(((INNER_WIDTH - ${#TITLE}) / 2))
RIGHT_BORDER_WIDTH=$((INNER_WIDTH - ${#TITLE} - LEFT_BORDER_WIDTH))

LEFT_FILL="$(printf '%*s' "$LEFT_BORDER_WIDTH" '')"
LEFT_FILL="${LEFT_FILL// /═}"
RIGHT_FILL="$(printf '%*s' "$RIGHT_BORDER_WIDTH" '')"
RIGHT_FILL="${RIGHT_FILL// /═}"

printf "╔%s%s%s╗\n" "$LEFT_FILL" "$TITLE" "$RIGHT_FILL"

for ((i = 0; i < ${#ENTRY_KEYS[@]}; i++)); do
  printf "║ %${KEY_WIDTH}s | %-${VALUE_WIDTH}s ║\n" "${ENTRY_KEYS[$i]}" "${ENTRY_VALUES[$i]}"
done

BOTTOM_FILL="$(printf '%*s' "$INNER_WIDTH" '')"
BOTTOM_FILL="${BOTTOM_FILL// /═}"
printf "╚%s╝\n\n" "$BOTTOM_FILL"
