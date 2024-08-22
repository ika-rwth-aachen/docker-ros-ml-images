# docker buildx build \
#     --load \
#     --platform $(uname)/$(uname -m) \
#     --build-arg BASE_IMAGE_TYPE=$BASE_IMAGE_TYPE \
#     --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
#     --build-arg ROS_VERSION=$ROS_VERSION \
#     --build-arg ROS_DISTRO=$ROS_DISTRO \
#     --build-arg ROS_PACKAGE=$ROS_PACKAGE \
#     --build-arg TORCH_VERSION=$TORCH_VERSION \
#     --build-arg TF_VERSION=$TF_VERSION \
#     --build-arg TRITON_VERSION=$TRITON_VERSION \
#     --tag $IMAGE \
#     .

ARG BASE_IMAGE_TYPE
ARG UBUNTU_VERSION="22.04"

# === ubuntu base images ==========================================================================
FROM --platform=amd64 ubuntu:20.04 AS base-ubuntu20.04-amd64
FROM --platform=amd64 ubuntu:22.04 AS base-ubuntu22.04-amd64
FROM --platform=amd64 ubuntu:24.04 AS base-ubuntu24.04-amd64

FROM --platform=arm64 ubuntu:20.04 AS base-ubuntu20.04-arm64
FROM --platform=arm64 ubuntu:22.04 AS base-ubuntu22.04-arm64
FROM --platform=arm64 ubuntu:24.04 AS base-ubuntu24.04-arm64

# === cuda base images ============================================================================
FROM --platform=amd64 nvcr.io/nvidia/cuda:11.4.3-runtime-ubuntu20.04 AS base-cuda-ubuntu20.04-amd64
FROM --platform=amd64 nvcr.io/nvidia/cuda:12.2.2-runtime-ubuntu22.04 AS base-cuda-ubuntu22.04-amd64
FROM --platform=amd64 nvcr.io/nvidia/cuda:12.6.0-runtime-ubuntu24.04 AS base-cuda-ubuntu24.04-amd64

FROM --platform=arm64 nvcr.io/nvidia/l4t-cuda:11.4.19-runtime AS base-cuda-ubuntu20.04-arm64
FROM --platform=arm64 nvcr.io/nvidia/l4t-cuda:12.2.12-runtime AS base-cuda-ubuntu22.04-arm64
# no l4t-cuda image for ubuntu24 available

# === tensorrt base images ========================================================================
FROM --platform=amd64 nvcr.io/nvidia/tensorrt:23.04-py3 AS base-tensorrt-ubuntu20.04-amd64 # TODO: change to version with CUDA 11.4
FROM --platform=amd64 nvcr.io/nvidia/tensorrt:23.09-py3 AS base-tensorrt-ubuntu22.04-amd64
# no tensorrt image for ubuntu24 available

FROM --platform=arm64 nvcr.io/nvidia/l4t-tensorrt:r8.5.2-runtime AS base-tensorrt-ubuntu20.04-arm64
FROM --platform=arm64 nvcr.io/nvidia/l4t-tensorrt:r8.6.2-runtime AS base-tensorrt-ubuntu22.04-arm64
# no l4t-tensorrt image for ubuntu24 available


# === dependencies ================================================================================
FROM "base${BASE_IMAGE_TYPE}-ubuntu${UBUNTU_VERSION}-${TARGETARCH}" AS dependencies

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

USER root

ARG TARGETARCH
ARG UBUNTU_VERSION
RUN if [[ $TARGETARCH == "arm64" && $UBUNTU_VERSION == "22.04" && $BASE_IMAGE_TYPE != "" ]]; then \
        # bug in base image -> replace line in /etc/apt/sources.list to use "r36.3" instead of "r36.0"
        sed -i 's/https:\/\/repo.download.nvidia.com\/jetson\/common r36.0 main/https:\/\/repo.download.nvidia.com\/jetson\/common r36.3 main/g' /etc/apt/sources.list && \
        echo "deb https://repo.download.nvidia.com/jetson/t234 r36.3 main" >> /etc/apt/sources.list; \
    fi

# install essentials via apt
RUN apt-get update && \
    apt-get install -y \
        bsdmainutils \
        build-essential \
        curl \
        dirmngr \
        gdb \
        git \
        gnupg2 \
        gosu \
        iputils-ping \
        less \
        libglvnd-dev \
        libssl-dev \
        nano \
        python-is-python3 \
        python3-pip \
        sed \
        software-properties-common \
        tzdata \
        unzip \
        vim \
        wget \
        x11-apps \
        zip \
    && rm -rf /var/lib/apt/lists/*
RUN if [[ $UBUNTU_VERSION == "24.04" ]]; then python -m pip config --global set global.break-system-packages true; \
    else python -m pip install --upgrade pip; fi

# install more essentials
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get update && \
    apt-get install git-lfs && \
    rm -rf /var/lib/apt/lists/*

# === install and setup ROS =======================================================================
FROM dependencies AS ros
ARG TARGETARCH
ARG UBUNTU_VERSION

# setup keys and sources.list
ARG ROS_VERSION
ENV ROS_VERSION=${ROS_VERSION}
RUN if [[ "$ROS_VERSION" == "1" ]]; then \
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
        echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list ; \
    elif [[ "$ROS_VERSION" == "2" ]]; then \
        curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null ; \
    fi

# install ROS bootstrapping tools
RUN apt-get update && \
    apt-get install -y \
        python3-rosdep \
        python3-vcstool \
    && rm -rf /var/lib/apt/lists/* && \
    rosdep init

# install essential ROS CLI tools
RUN apt-get update && \
    if [[ "$ROS_VERSION" == "1" ]]; then \
        apt-get install -y \
            python3-catkin-tools ; \
    elif [[ "$ROS_VERSION" == "2" ]]; then \
        apt-get install -y \
            python3-colcon-common-extensions \
        && pip install colcon-clean ; \
    fi \
    && rm -rf /var/lib/apt/lists/*

# install ROS
ARG ROS_DISTRO
ENV ROS_DISTRO=${ROS_DISTRO}
ARG ROS_PACKAGE=ros-core
RUN apt-get update && \
    if [[ "$TARGETARCH" == "arm64" && "$UBUNTU_VERSION" == "20.04" ]]; then \
        apt-get upgrade -y && \
        apt-get purge -y '*opencv*' ; \
    fi && \
    apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-${ROS_PACKAGE} && \
    rm -rf /var/lib/apt/lists/*

# source ROS
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# === install ML frameworks on tensorrt base ======================================================
FROM ros AS ros-tensorrt
ARG TARGETARCH
ARG UBUNTU_VERSION

# install PyTorch
ARG TORCH_VERSION
RUN if [[ -n $TORCH_VERSION ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            pip3 install torch==${TORCH_VERSION}; \
        elif [[ "$TARGETARCH" == "arm64" ]]; then \
            # from: https://forums.developer.nvidia.com/t/pytorch-for-jetson/72048
            # and: https://docs.nvidia.com/deeplearning/frameworks/install-pytorch-jetson-platform/index.html#prereqs-install
            apt-get update && \
            apt-get install -y libopenblas-base && \
            rm -rf /var/lib/apt/lists/* ; \
            if [[ $UBUNTU_VERSION == "20.04" ]]; then \
                pip install --no-cache https://developer.download.nvidia.com/compute/redist/jp/v512/pytorch/torch-${TORCH_VERSION}a0+41361538.nv23.06-cp38-cp38-linux_aarch64.whl; \
            else \
                pip install --no-cache https://developer.download.nvidia.com/compute/redist/jp/v60/pytorch/torch-${TORCH_VERSION}a0+f70bd71a48.nv24.06.15634931-cp310-cp310-linux_aarch64.whl; \
            fi; \
        fi; \
    fi

# install TensorFlow
ARG TF_VERSION
RUN if [[ -n $TF_VERSION ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            pip3 install tensorflow==${TF_VERSION}; \
        elif [[ "$TARGETARCH" == "arm64" ]]; then \
            apt-get update && \
            apt-get install -y libhdf5-dev && \
            rm -rf /var/lib/apt/lists/* && \
            if [[ $UBUNTU_VERSION == "20.04" ]]; then \
                pip3 install h5py==3.7.0 && \
                pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v512 tensorflow==${TF_VERSION}+nv23.06; \
            else \
                pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v60 tensorflow==${TF_VERSION}+nv24.07; \
            fi; \
        fi; \
    fi

# === install tritonclient on cuda base ===========================================================
FROM ros AS ros-cuda
ARG TARGETARCH

# install triton client
ARG TRITON_VERSION
ENV TRITON_VERSION=${TRITON_VERSION}
RUN if [[ -n $TRITON_VERSION ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            wget -q -O /tmp/tritonclient.tar.gz https://github.com/triton-inference-server/server/releases/download/v${TRITON_VERSION}/v${TRITON_VERSION}_ubuntu2204.clients.tar.gz; \
        elif [[ "$TARGETARCH" == "arm64" ]]; then \
            wget -q -O /tmp/tritonclient.tar.gz https://github.com/triton-inference-server/server/releases/download/v${TRITON_VERSION}/tritonserver${TRITON_VERSION}-igpu.tar.gz; \
        fi && \
        mkdir -p /opt/tritonclient && \
        tar -xzf /tmp/tritonclient.tar.gz -C /opt/tritonclient && \
        rm /tmp/tritonclient.tar.gz ; \
    fi

# === final ====================================================================
FROM "ros${BASE_IMAGE_TYPE}" AS final

# user setup
ENV DOCKER_USER=dockeruser
ENV DOCKER_UID=
ENV DOCKER_GID=

# print version information during login
RUN echo "source /.version_information.sh" >> ~/.bashrc
COPY .version_information.sh /.version_information.sh

# container startup setup
ENV WORKSPACE=/docker-ros/ws
WORKDIR $WORKSPACE
ENV TINI_VERSION=v0.19.0
ARG TARGETARCH
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TARGETARCH} /tini
RUN chmod +x /tini
COPY entrypoint.sh /
ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]
CMD ["bash"]
