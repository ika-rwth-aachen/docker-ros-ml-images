# docker buildx build \
#     --load \
#     --platform $(uname)/$(uname -m) \
#     --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
#     --build-arg CUDA_VERSION=$CUDA_VERSION \
#     --build-arg CUDNN_VERSION=$CUDNN_VERSION \
#     --build-arg TENSORRT_VERSION=$TENSORRT_VERSION \
#     --build-arg INSTALL_AS_DEV=$INSTALL_AS_DEV \
#     --tag $IMAGE \
#     .

ARG UBUNTU_VERSION=20.04

# === base-amd64-20.04 ===============================================================
FROM --platform=amd64 ubuntu:20.04 as base-amd64-20.04

# === base-arm64-20.04 ===============================================================
FROM --platform=arm64 nvcr.io/nvidia/l4t-base:35.4.1 as base-arm64-20.04

# === base-amd64-22.04 ===============================================================
FROM --platform=amd64 ubuntu:22.04 as base-amd64-22.04

# === base-arm64-22.04 ===============================================================
# not supported

# === dependencies =============================================================
FROM "base-${TARGETARCH}-${UBUNTU_VERSION}" as dependencies
ARG TARGETARCH
ENV DEBIAN_FRONTEND=noninteractive

ARG UBUNTU_VERSION
ARG CUDA_VERSION=11.8
ARG CUDNN_VERSION=8.6.0.163-1
ARG TENSORRT_VERSION=8.5.3-1
ARG INSTALL_AS_DEV=0

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

SHELL ["/bin/bash", "-c"]

# install essentials
RUN apt-get update && \
    apt-get install -y \
        wget \
        gnupg2 && \
    if [[ "$INSTALL_AS_DEV" == "1" ]]; then apt-get install -y build-essential; fi && \
    rm -rf /var/lib/apt/lists/*

# set up CUDA apt repositories
RUN if [[ "$TARGETARCH" == "amd64" ]]; then \
        wget -q -O /tmp/cuda-keyring_1.0-1_all.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION/./}/x86_64/cuda-keyring_1.0-1_all.deb; \     
    elif [[ "$TARGETARCH" == "arm64" ]]; then \
        wget -q -O /tmp/cuda-keyring_1.0-1_all.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION/./}/arm64/cuda-keyring_1.0-1_all.deb; \
    fi && \
    dpkg -i /tmp/cuda-keyring_1.0-1_all.deb && \
    rm -rf /tmp/cuda-keyring_1.0-1_all.deb

# set up L4T apt repositories (NVIDIA Jetson)
RUN if [[ "$TARGETARCH" == "arm64" ]]; then \
        echo "deb https://repo.download.nvidia.com/jetson/common r35.4 main" >> /etc/apt/sources.list && \
        echo "deb https://repo.download.nvidia.com/jetson/t194 r35.4 main" >> /etc/apt/sources.list && \
        apt-key adv --fetch-key http://repo.download.nvidia.com/jetson/jetson-ota-public.asc && \
        mkdir -p /opt/nvidia/l4t-packages/ && \
        touch /opt/nvidia/l4t-packages/.nv-l4t-disable-boot-fw-update-in-preinstall && \
        rm -rf /var/lib/apt/lists/* ; \
    fi

# install CUDA
RUN apt-get update && \
    if [[ "$TARGETARCH" == "amd64" ]]; then \
        apt-get install -y cuda-libraries-${CUDA_VERSION/./-}; \
        if [[ "$INSTALL_AS_DEV" == "1" ]]; then apt-get install -y cuda-toolkit-${CUDA_VERSION/./-} cuda-demo-suite-${CUDA_VERSION/./-}; fi \
    elif [[ "$TARGETARCH" == "arm64" ]]; then \
        echo "N" | apt-get install -y cuda-${CUDA_VERSION/./-}; \
    fi && \
    echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.bashrc && \
    rm -rf /var/lib/apt/lists/*

# install cuDNN
RUN --mount=type=bind,source=cudnn-local-repo-${TARGETARCH}.deb,target=/cudnn-local-repo.deb,ro \
    gpg_key=$(dpkg -i cudnn-local-repo.deb | grep -oP "(?<=cp )[^ ]+(?= )") && \
    cp ${gpg_key} /usr/share/keyrings/ && \
    CUDNN_MAJOR_VERSION=${CUDNN_VERSION%%.*} && \
    apt-get update && \
    apt-get install -y libcudnn${CUDNN_MAJOR_VERSION}=${CUDNN_VERSION}+cuda${CUDA_VERSION} && \
    if [[ "$INSTALL_AS_DEV" == "1" ]]; then \
        apt-get install -y libcudnn${CUDNN_MAJOR_VERSION}-dev=${CUDNN_VERSION}+cuda${CUDA_VERSION}; \
    fi && \
    rm -rf /var/lib/apt/lists/*

# install TensorRT
RUN --mount=type=bind,source=nv-tensorrt-local-repo-${TARGETARCH}.deb,target=/nv-tensorrt-local-repo.deb,ro \
    gpg_key=$(dpkg -i nv-tensorrt-local-repo.deb | grep -oP "(?<=cp )[^ ]+(?= )") && \
    cp ${gpg_key} /usr/share/keyrings/ && \
    TENSORRT_MAJOR_VERSION=${TENSORRT_VERSION%%.*} && \
    apt-get update && \
    apt-get install -y \
        libnvinfer${TENSORRT_MAJOR_VERSION}=${TENSORRT_VERSION}+cuda${CUDA_VERSION} \
        libnvinfer-plugin${TENSORRT_MAJOR_VERSION}=${TENSORRT_VERSION}+cuda${CUDA_VERSION} && \
    if [[ "$INSTALL_AS_DEV" == "1" ]]; then \
        apt-get install -y \
        libnvinfer-dev=${TENSORRT_VERSION}+cuda${CUDA_VERSION} \
        libnvinfer-plugin-dev=${TENSORRT_VERSION}+cuda${CUDA_VERSION}; \
    fi && \
    rm -rf /var/lib/apt/lists/*

# container startup setup
CMD ["bash"]
