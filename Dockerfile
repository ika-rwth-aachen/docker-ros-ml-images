# docker buildx build \
#     --load \
#     --platform $(uname)/$(uname -m) \
#     --build-arg BUILD_VERSION=$BUILD_VERSION \
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

# === base-amd64 ===============================================================
FROM --platform=amd64 "ubuntu:${UBUNTU_VERSION}" as base-amd64

# === base-arm64 ===============================================================
FROM --platform=arm64 "ubuntu:${UBUNTU_VERSION}" as base-arm64

# === base-ml-amd64 ===============================================================
# includes: https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html
FROM --platform=amd64 nvcr.io/nvidia/tensorrt:21.06-py3 as base-amd64-ml

# === base-ml-arm64 ===============================================================
# includes: https://catalog.ngc.nvidia.com/orgs/nvidia/containers/l4t-tensorflow
FROM --platform=arm64 nvcr.io/nvidia/l4t-tensorflow:r35.1.0-tf2.9-py3 as base-arm64-ml

# remove cmake 3.14 installation
RUN rm -rf /usr/local/bin/cmake  \
           /usr/local/lib/cmake/ \
           /usr/local/share/cmake/

# === dependencies =============================================================
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

# enable nvidia-docker OpenGL support
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

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
            python3-colcon-common-extensions ; \
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

# install PyTorch
ARG TORCH_VERSION_PY
RUN if [[ -n $TORCH_VERSION_PY ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            pip install torch==${TORCH_VERSION_PY}+cu113 -f https://download.pytorch.org/whl/torch_stable.html ; \
        elif [[ "$TARGETARCH" == "arm64" ]]; then \
            # from: https://forums.developer.nvidia.com/t/pytorch-for-jetson/72048
            wget -q -O /tmp/torch-${TORCH_VERSION_PY}-cp38-cp38-linux_aarch64.whl https://nvidia.box.com/shared/static/ssf2v7pf5i245fk4i0q926hy4imzs2ph.whl && \
            pip install /tmp/torch-${TORCH_VERSION_PY}-cp38-cp38-linux_aarch64.whl && \
            rm /tmp/torch-${TORCH_VERSION_PY}-cp38-cp38-linux_aarch64.whl && \
            apt-get update && \
            apt-get install -y libopenblas-base && \
            rm -rf /var/lib/apt/lists/* ; \
        fi ; \
    fi

# install PyTorch C++ API (not available for arm64)
ARG TORCH_VERSION_CPP
RUN if [[ -n $TORCH_VERSION_CPP ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            wget -q -O /tmp/libtorch111.zip "https://download.pytorch.org/libtorch/cu113/libtorch-cxx11-abi-shared-with-deps-${TORCH_VERSION_CPP}%2Bcu113.zip" && \
            unzip /tmp/libtorch111.zip -d /opt/ && \
            rm /tmp/libtorch111.zip ; \
        fi ; \
    fi

# install TensorFlow C++ API incl. protobuf
ARG TF_VERSION_CPP
RUN if [[ -n $TF_VERSION_CPP ]]; then \
        wget -q -O /tmp/libtensorflow-cc.deb "https://github.com/ika-rwth-aachen/libtensorflow_cc/releases/download/v${TF_VERSION_CPP}/libtensorflow-cc_${TF_VERSION_CPP}-gpu_${TARGETARCH}.deb" && \
        dpkg -i /tmp/libtensorflow-cc.deb && \
        ldconfig && \
        rm /tmp/libtensorflow-cc.deb ; \
    fi

# install TensorFlow (included in arm64-base)
ARG TF_VERSION_PY
RUN if [[ -n $TF_VERSION_PY ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            pip install tensorflow==${TF_VERSION_PY} ; \
        fi ; \
    fi

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
