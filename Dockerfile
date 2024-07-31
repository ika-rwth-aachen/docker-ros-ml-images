# docker buildx build \
#     --load \
#     --platform $(uname)/$(uname -m) \
#     --build-arg BUILD_VERSION=$BUILD_VERSION \
#     --build-arg CUDA_VERSION=$CUDA_VERSION \
#     --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
#     --build-arg ROS_VERSION=$ROS_VERSION \
#     --build-arg ROS_DISTRO=$ROS_DISTRO \
#     --build-arg ROS_PACKAGE=$ROS_PACKAGE \
#     --build-arg TORCH_VERSION_PY=$TORCH_VERSION_PY \
#     --build-arg TORCH_VERSION_CPP=$TORCH_VERSION_CPP \
#     --build-arg TF_VERSION_PY=$TF_VERSION_PY \
#     --build-arg TF_VERSION_CPP=$TF_VERSION_CPP \
#     --tag $IMAGE \
#     .

ARG BUILD_VERSION
ARG UBUNTU_VERSION="20.04"
ARG CUDA_VERSION=11.8

# === base (amd64) ===============================================================
FROM ubuntu:${UBUNTU_VERSION} as base-amd64

# === base-ml (amd64) ============================================================
FROM nvcr.io/nvidia/cuda:12.2.2-runtime-ubuntu22.04 as base-amd64-ml

# === base (amd64) ===============================================================
FROM ubuntu:${UBUNTU_VERSION} as base-arm64

# === base-ml (amd64) ============================================================
FROM nvcr.io/nvidia/l4t-cuda:12.2.12-runtime as base-arm64-ml

# === dependencies ===================================================================
FROM "base-${TARGETARCH}${BUILD_VERSION}" as dependencies

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

USER root

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
RUN pip3 install --upgrade pip

# install more essentials
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get update && \
    apt-get install git-lfs && \
    rm -rf /var/lib/apt/lists/*

# --- install and setup ROS ----------------------------------------------------
FROM dependencies as ros
ARG TARGETARCH

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
ARG UBUNTU_VERSION
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

# --- install ML stuff ----------------------------------------------------
FROM ros as ros-ml
ARG TARGETARCH

# install triton client
RUN if [[ "$TARGETARCH" == "amd64" ]]; then \
        wget -q -O /tmp/tritonclient.tar.gz https://github.com/triton-inference-server/server/releases/download/v2.48.0/v2.48.0_ubuntu2204.clients.tar.gz; \
    elif [[ "$TARGETARCH" == "arm64" ]]; then \
        wget -q -O /tmp/tritonclient.tar.gz https://github.com/triton-inference-server/server/releases/download/v2.48.0/tritonserver2.48.0-igpu.tar.gz; \
    fi && \
    mkdir -p /opt/tritonclient && \
    tar -xzf /tmp/tritonclient.tar.gz -C /opt/tritonclient && \
    rm /tmp/tritonclient.tar.gz

# === final ====================================================================
FROM "ros${BUILD_VERSION}" as final

# user setup
ENV DOCKER_USER=dockeruser
ENV DOCKER_UID=
ENV DOCKER_GID=

# print version information during login
RUN echo "source /.version_information.sh" >> ~/.bashrc
COPY .version_information.sh /

# container startup setup
ENV WORKSPACE=/docker-ros/ws
WORKDIR $WORKSPACE
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
