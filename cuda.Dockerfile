# docker buildx build \
#     --load \
#     --platform $(uname)/$(uname -m) \
#     --build-arg UBUNTU_VERSION=22.04 \
#     --build-arg TYPE=run \
#     --build-arg CUDA=11.8 \
#     --build-arg CUDNN=8.6.0.163-1 \
#     --build-arg LIBNVINFER=8.5.3-1 \
#     --tag $IMAGE \
#     -f cuda.Dockerfile
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
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,video,graphics

ARG UBUNTU_VERSION
ARG TYPE=run

ARG CUDA=11.8
ARG CUDNN=8.6.0.163-1
ARG CUDNN_MAJOR_VERSION=8
ARG LIBNVINFER=8.5.3-1
ARG LIBNVINFER_MAJOR_VERSION=8

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

# essentials
RUN apt-get update && apt-get install -y wget gnupg2

# CUDA
RUN if [[ "$TARGETARCH" == "amd64" ]]; then \
        wget -q -O /tmp/cuda-keyring_1.0-1_all.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION/./}/x86_64/cuda-keyring_1.0-1_all.deb; \     
    elif [[ "$TARGETARCH" == "arm64" ]]; then \
        wget -q -O /tmp/cuda-keyring_1.0-1_all.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION/./}/arm64/cuda-keyring_1.0-1_all.deb; \
    fi && \
    dpkg -i /tmp/cuda-keyring_1.0-1_all.deb && \
    rm -rf /tmp/cuda-keyring_1.0-1_all.deb

# l4t stuff
RUN if [[ "$TARGETARCH" == "arm64" ]]; then \
        echo "deb https://repo.download.nvidia.com/jetson/common r35.4 main" >> /etc/apt/sources.list && \
        echo "deb https://repo.download.nvidia.com/jetson/t194 r35.4 main" >> /etc/apt/sources.list && \
        apt-key adv --fetch-key http://repo.download.nvidia.com/jetson/jetson-ota-public.asc && \
        mkdir -p /opt/nvidia/l4t-packages/ && \
        touch /opt/nvidia/l4t-packages/.nv-l4t-disable-boot-fw-update-in-preinstall; \
    fi

# install CUDA and its dependencies (includes l4t stuff)
RUN apt-get update && \
    if [[ "$TARGETARCH" == "amd64" ]]; then \
        apt-get install -y cuda-libraries-${CUDA/./-}; \
        if [[ "$TYPE" == "dev" ]]; then apt-get install -y cuda-toolkit-${CUDA/./-} cuda-demo-suite-${CUDA/./-}; fi \
    elif [[ "$TARGETARCH" == "arm64" ]]; then \
        echo "N" | apt-get install -y cuda-${CUDA/./-}; \
    fi
RUN echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.bashrc

# libcudnn8 - make sure you have the correct .deb
COPY cudnn-local-repo-${TARGETARCH}.deb /cudnn-local-repo.deb
RUN gpg_key=$(dpkg -i cudnn-local-repo.deb | grep -oP "(?<=cp )[^ ]+(?= )") && \
    cp ${gpg_key} /usr/share/keyrings/ && \
    apt-get update && \
    apt-get install -y libcudnn${CUDNN_MAJOR_VERSION}=${CUDNN}+cuda${CUDA} && \
    if [[ "$TYPE" == "dev" ]]; then \
        apt-get install -y libcudnn${CUDNN_MAJOR_VERSION}-dev=${CUDNN}+cuda${CUDA}; \
    fi
RUN rm -rf cudnn-local-repo.deb

# libnvinfer8 (TensorRT) - make sure you have the correct .deb
COPY nv-tensorrt-local-repo-${TARGETARCH}.deb /nv-tensorrt-local-repo.deb
RUN gpg_key=$(dpkg -i nv-tensorrt-local-repo.deb | grep -oP "(?<=cp )[^ ]+(?= )") && \
    cp ${gpg_key} /usr/share/keyrings/ && \
    apt-get update && \
    apt-get install -y \
        libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} && \
    if [[ "$TYPE" == "dev" ]]; then \
        apt-get install -y \
        libnvinfer-dev=${LIBNVINFER}+cuda${CUDA} \
        libnvinfer-plugin-dev=${LIBNVINFER}+cuda${CUDA}; \
    fi
RUN rm -rf nv-tensorrt-local-repo.deb

# container startup setup
CMD ["bash"]
