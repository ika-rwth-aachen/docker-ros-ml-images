# docker buildx build \
#     --load \
#     --platform $(uname)/$(uname -m) \
#     --build-arg IMAGE_VERSION=$CI_COMMIT_TAG \
#     --build-arg BASE_IMAGE_TYPE=$BASE_IMAGE_TYPE \
#     --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
#     --build-arg ROS_DISTRO=$ROS_DISTRO \
#     --build-arg ROS_PACKAGE=$ROS_PACKAGE \
#     --build-arg ROS_BUILD_FROM_SRC=$ROS_BUILD_FROM_SRC \
#     --build-arg TORCH_VERSION=$TORCH_VERSION \
#     --build-arg TF_VERSION=$TF_VERSION \
#     --build-arg ONNX_RUNTIME_VERSION=$ONNX_RUNTIME_VERSION \
#     --build-arg TRITON_VERSION=$TRITON_VERSION \
#     --tag $IMAGE \
#     .

ARG BASE_IMAGE_TYPE
ARG UBUNTU_VERSION="24.04"

# === ubuntu base images ==========================================================================
FROM --platform=amd64 ubuntu:22.04 AS base-ubuntu22.04-amd64
FROM --platform=amd64 ubuntu:24.04 AS base-ubuntu24.04-amd64

FROM --platform=arm64 ubuntu:22.04 AS base-ubuntu22.04-arm64
FROM --platform=arm64 ubuntu:24.04 AS base-ubuntu24.04-arm64

# === cuda base images ============================================================================
FROM --platform=amd64 nvcr.io/nvidia/cuda:12.6.1-runtime-ubuntu22.04 AS base-cuda-ubuntu22.04-amd64
FROM --platform=amd64 nvcr.io/nvidia/cuda:12.6.1-runtime-ubuntu24.04 AS base-cuda-ubuntu24.04-amd64

FROM --platform=arm64 nvcr.io/nvidia/l4t-cuda:12.6.11-runtime AS base-cuda-ubuntu22.04-arm64
# no l4t-cuda image for ubuntu24 available

# === tensorrt base images ========================================================================
FROM --platform=amd64 nvcr.io/nvidia/tensorrt:24.08-py3 AS base-tensorrt-ubuntu22.04-amd64
FROM --platform=amd64 nvcr.io/nvidia/tensorrt:24.11-py3 AS base-tensorrt-ubuntu24.04-amd64

FROM --platform=arm64 nvcr.io/nvidia/l4t-tensorrt:r10.3.0-runtime AS base-tensorrt-ubuntu22.04-arm64
# no l4t-tensorrt image for ubuntu24 available

# ================================================================================================
FROM "base${BASE_IMAGE_TYPE}-ubuntu${UBUNTU_VERSION}-${TARGETARCH}"

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

USER root

# set all locale settings to a sensible default, allowing to override via LC_ALL
ENV LANG="C.utf8"
ENV LANGUAGE="C.utf8"
ENV LC_CTYPE="C.utf8"
ENV LC_NUMERIC="C.utf8"
ENV LC_TIME="C.utf8"
ENV LC_COLLATE="C.utf8"
ENV LC_MONETARY="C.utf8"
ENV LC_MESSAGES="C.utf8"
ENV LC_PAPER="C.utf8"
ENV LC_NAME="C.utf8"
ENV LC_ADDRESS="C.utf8"
ENV LC_TELEPHONE="C.utf8"
ENV LC_MEASUREMENT="C.utf8"
ENV LC_IDENTIFICATION="C.utf8"

ARG BASE_IMAGE_TYPE
ARG TARGETARCH
ARG UBUNTU_VERSION
RUN if [[ $TARGETARCH == "arm64" && $UBUNTU_VERSION == "22.04" && $BASE_IMAGE_TYPE != "" ]]; then \
        # add nvidia apt repositories for l4t base images
        # touch: https://forums.balena.io/t/getting-linux-for-tegra-into-a-container-on-balena-os/179421/20
        apt-key adv --fetch-key http://repo.download.nvidia.com/jetson/jetson-ota-public.asc && \
        echo "deb https://repo.download.nvidia.com/jetson/common r36.4 main" >> /etc/apt/sources.list && \
        echo "deb https://repo.download.nvidia.com/jetson/t234 r36.4 main" >> /etc/apt/sources.list && \
        mkdir -p /opt/nvidia/l4t-packages/ && \
        touch /opt/nvidia/l4t-packages/.nv-l4t-disable-boot-fw-update-in-preinstall; \
    elif [[ $TARGETARCH == "amd64" && $BASE_IMAGE_TYPE == "-tensorrt" ]]; then \
        # add cuda apt repository for tensorrt base images
        wget -q -O /tmp/cuda-keyring_1.1-1_all.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION/./}/x86_64/cuda-keyring_1.1-1_all.deb && \
        dpkg -i /tmp/cuda-keyring_1.1-1_all.deb && \
        rm -rf /tmp/cuda-keyring_1.1-1_all.deb; \
    fi

# install essentials
RUN apt-get update && \
    apt-get install -y \
        bsdmainutils \
        build-essential \
        bash-completion \
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

# enable bash completion
RUN sed -i '/^#if \[ -f \/etc\/bash_completion \]/,/^#fi/ s/^#//' ~/.bashrc

# install more essentials
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get update && \
    apt-get install git-lfs && \
    rm -rf /var/lib/apt/lists/*

# --- install and setup ROS ----------------------------------------------------------------------

# set up ROS apt sources
RUN ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}') && \
    curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $UBUNTU_CODENAME)_all.deb" && \
    apt-get install -y /tmp/ros2-apt-source.deb

# install ROS bootstrapping tools
RUN apt-get update && \
    apt-get install -y \
        python3-rosdep \
        python3-vcstool \
    && rm -rf /var/lib/apt/lists/* && \
    rosdep init

ARG ROS_DISTRO
ENV ROS_DISTRO=${ROS_DISTRO}
# set up 3rd party ROS deb sources for arm64 | Ubuntu 22 | Jazzy (required due to NVIDIA base images being stuck at Ubuntu 22)
RUN if [[ "$ROS_DISTRO" == "jazzy" && $UBUNTU_VERSION == "22.04" ]]; then \
        add-apt-repository universe && \
        wget -O /etc/apt/keyrings/ros2-tier3-pkgs-pub.gpg.key https://raw.githubusercontent.com/meetgandhi-dev/ros2_tier3_packages/main/ros2-tier3-pkgs-pub.gpg.key && \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ros2-tier3-pkgs-pub.gpg.key] https://raw.githubusercontent.com/meetgandhi-dev/ros2_tier3_packages/main/debian_packages $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2-tier3-pkgs.list > /dev/null && \
        apt-get update && \
        apt-get install -y ros-jazzy-rosdep-jammy && \
        rosdep update --rosdistro ${ROS_DISTRO} && \
        rm -rf /var/lib/apt/lists/* ; \
    fi

# install essential ROS CLI tools
RUN apt-get update && \
    apt-get install -y \
        python3-colcon-common-extensions && \
    pip install colcon-clean && \
    pip install --ignore-installed ros2-pkg-create && \
    rm -rf /var/lib/apt/lists/*

# install ROS
ARG ROS_PACKAGE=ros-core
ARG ROS_BUILD_FROM_SRC=false
RUN if [[ "$ROS_BUILD_FROM_SRC" == "true" ]]; then \
        apt-get update && \
        apt-get install -y \
            python3-flake8-blind-except \
            python3-flake8-class-newline \
            python3-flake8-deprecated \
            python3-mypy \
            python3-pip \
            python3-pytest \
            python3-pytest-cov \
            python3-pytest-mock \
            python3-pytest-repeat \
            python3-pytest-rerunfailures \
            python3-pytest-runner \
            python3-pytest-timeout \
            ros-dev-tools && \
        if [[ "$TARGETARCH" == "arm64" && "$UBUNTU_VERSION" == "22.04" && "$BASE_IMAGE_TYPE" != "" ]]; then \
            apt-get install -y libopencv; \
        fi && \
        mkdir -p /ros2_${ROS_DISTRO}/src && \
        cd /ros2_${ROS_DISTRO} && \
        vcs import --input https://raw.githubusercontent.com/ros2/ros2/${ROS_DISTRO}/ros2.repos src && \
        rosdep update --rosdistro ${ROS_DISTRO} && \
        rosdep install -y --ignore-src --from-paths src --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers" && \
        mkdir -p /opt/ros/${ROS_DISTRO} && \
        colcon build --parallel-workers 32 --install-base /opt/ros/${ROS_DISTRO} --merge-install --cmake-args -DCMAKE_BUILD_TYPE=Release && \
        cd - && \
        rm -rf /ros2_${ROS_DISTRO} && \
        rm -rf /var/lib/apt/lists/*; \
    else \
        apt-get update && \
        apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-${ROS_PACKAGE} && \
        rm -rf /var/lib/apt/lists/*; \
    fi

# source ROS
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# install NVIDIA Triton Client
ARG TRITON_VERSION
ENV TRITON_VERSION=${TRITON_VERSION}
ENV TRITON_CLIENT_DIR="/opt/tritonclient"
RUN if [[ -n $TRITON_VERSION ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            wget -q -O /tmp/tritonclient.tar.gz https://github.com/triton-inference-server/server/releases/download/v${TRITON_VERSION}/v${TRITON_VERSION}_ubuntu2404.clients.tar.gz; \
        elif [[ "$TARGETARCH" == "arm64" ]]; then \
            wget -q -O /tmp/tritonclient.tar.gz https://github.com/triton-inference-server/server/releases/download/v${TRITON_VERSION}/tritonserver${TRITON_VERSION}-igpu.tar; \
        fi && \
        mkdir -p ${TRITON_CLIENT_DIR} && \
        tar -xzf /tmp/tritonclient.tar.gz -C ${TRITON_CLIENT_DIR} && \
        rm /tmp/tritonclient.tar.gz && \
        echo "export LD_LIBRARY_PATH=$TRITON_CLIENT_DIR/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc ; \
    fi

# install libcudnn as it is not installed in nvcr.io/nvidia/l4t-tensorrt:r10.3.0-runtime
RUN if [[ $BASE_IMAGE_TYPE == "-tensorrt" && $TARGETARCH == "arm64" && $UBUNTU_VERSION == "22.04" ]]; then \
        apt-get update && \
        apt-get install -y cudnn9-cuda-12-6 && \
        rm -rf /var/lib/apt/lists/*; \
    fi

# install PyTorch
ARG TORCH_VERSION
RUN if [[ -n $TORCH_VERSION ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            # --ignore-installed, because of dependency conflicts
            pip3 install --ignore-installed torch==${TORCH_VERSION} && \
            if [[ "$TORCH_VERSION" == "2.5.0" ]]; then pip3 install torchvision==0.20.0; fi; \
        elif [[ "$TARGETARCH" == "arm64" ]]; then \
            # from: https://forums.developer.nvidia.com/t/pytorch-for-jetson/72048
            # and: https://docs.nvidia.com/deeplearning/frameworks/install-pytorch-jetson-platform/index.html#prereqs-install
            apt-get update && \
            apt-get install -y libopenblas-base libopenmpi-dev libomp-dev && \
            rm -rf /var/lib/apt/lists/* && \
            wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/${TARGETARCH}/cuda-keyring_1.1-1_all.deb && \
            dpkg -i cuda-keyring_1.1-1_all.deb && \
            apt-get update && \
            apt-get install -y libcusparselt0 libcusparselt-dev cuda-cupti-12-6 && \
            rm -rf /var/lib/apt/lists/* && \
            wget -q -O /tmp/torch-${TORCH_VERSION}a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl https://developer.download.nvidia.com/compute/redist/jp/v61/pytorch/torch-${TORCH_VERSION}a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl && \
            wget -q -O /tmp/torchvision-0.20.0-cp310-cp310-linux_aarch64.whl http://jetson.webredirect.org/jp6/cu126/+f/5f9/67f920de3953f/torchvision-0.20.0-cp310-cp310-linux_aarch64.whl && \
            python3 -m pip install numpy=="1.26.1" && \
            python3 -m pip install --ignore-installed --no-cache /tmp/torch*.whl && \
            rm -f /tmp/torch*.whl; \
        fi; \
    fi

# install TensorFlow
ARG TF_VERSION
RUN if [[ -n $TF_VERSION ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            if [[ $UBUNTU_VERSION == "22.04" ]]; then pip install opencv-python matplotlib; fi && \
            pip3 install tensorflow==${TF_VERSION}; \
        elif [[ "$TARGETARCH" == "arm64" ]]; then \
            apt-get update && \
            apt-get install -y libhdf5-dev && \
            rm -rf /var/lib/apt/lists/* && \
            pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v61 tensorflow==2.16.1+nv24.08; \
        fi; \
    fi

# install ONNX Runtime
ARG ONNX_RUNTIME_VERSION
RUN if [[ -n $ONNX_RUNTIME_VERSION ]]; then \
        if [[ "$TARGETARCH" == "amd64" ]]; then \
            pip3 install onnxruntime-gpu==${ONNX_RUNTIME_VERSION}; \
        fi; \
    fi

# --- finalization -------------------------------------------------------------------------------

# user setup
ENV DOCKER_USER=dockeruser
ENV DOCKER_UID=
ENV DOCKER_GID=
# remove user with uid 1000, if existing (standard user in ubuntu)
RUN if id -u 1000 >/dev/null 2>&1; then userdel --force --remove $(getent passwd 1000 | cut -d: -f1); fi

# print version information during login
RUN echo "source /.version_information.sh" >> ~/.bashrc
COPY .version_information.sh /.version_information.sh

# enable all GPU capabilities
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

# container startup setup
ENV WORKSPACE=/docker-ros/ws
WORKDIR $WORKSPACE
ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TARGETARCH} /tini
RUN chmod +x /tini
COPY entrypoint.sh /
ENTRYPOINT ["/tini", "--", "/entrypoint.sh"]
CMD ["bash"]

# image labels
ARG IMAGE_VERSION=""
LABEL maintainer="Institute for Automotive Engineering (ika), RWTH Aachen University <opensource@ika.rwth-aachen.de>"
LABEL org.opencontainers.image.authors="Institute for Automotive Engineering (ika), RWTH Aachen University <opensource@ika.rwth-aachen.de>"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://github.com/ika-rwth-aachen/docker-ros-ml-images"
LABEL org.opencontainers.image.version="$IMAGE_VERSION"
