# *docker-ros-ml-images* – Machine Learning-Enabled ROS Docker Images

<p align="center">
  <img src="https://img.shields.io/github/v/release/ika-rwth-aachen/docker-ros-ml-images"/></a>
  <img src="https://img.shields.io/github/license/ika-rwth-aachen/docker-ros-ml-images"/>
  <img src="https://img.shields.io/badge/ROS-noetic-blueviolet"/>
  <img src="https://img.shields.io/badge/ROS 2-humble|iron|jazzy|rolling-blueviolet"/>
  <img src="https://img.shields.io/badge/NVIDIA Triton-2.48.0-darkgreen"/>
  <img src="https://img.shields.io/badge/PyTorch-2.3.0-red"/>
  <img src="https://img.shields.io/badge/TensorFlow-2.16.1-orange"/>
</p>

*docker-ros-ml-images* provides multi-arch machine learning-enabled ROS Docker images.

> [!IMPORTANT]  
> This repository is open-sourced and maintained by the [**Institute for Automotive Engineering (ika) at RWTH Aachen University**](https://www.ika.rwth-aachen.de/).  
> **DevOps, Containerization and Orchestration of Software-Defined Vehicles** are some of many research topics within our [*Vehicle Intelligence & Automated Driving*](https://www.ika.rwth-aachen.de/en/competences/fields-of-research/vehicle-intelligence-automated-driving.html) domain.  
> If you would like to learn more about how we can support your advanced driver assistance and automated driving efforts, feel free to reach out to us!  
> :email: ***opensource@ika.rwth-aachen.de***

We recommend to use *docker-ros-ml-images* in combination with our other tools for Docker and ROS.
- [*docker-ros*](https://github.com/ika-rwth-aachen/docker-ros) automatically builds minimal container images of ROS applications <a href="https://github.com/ika-rwth-aachen/docker-ros"><img src="https://img.shields.io/github/stars/ika-rwth-aachen/docker-ros?style=social"/></a>
- [*docker-run*](https://github.com/ika-rwth-aachen/docker-run) is a CLI tool for simplified interaction with Docker images <a href="https://github.com/ika-rwth-aachen/docker-run"><img src="https://img.shields.io/github/stars/ika-rwth-aachen/docker-run?style=social"/></a>


## Quick Links to Available Images

[`ros2`](#rwthikaros2-ros-2) | [`ros2-cuda`](#rwthikaros2-cuda-ros-2-nvidia-cuda) | [`ros2-tensorrt`](#rwthikaros2-tensorrt-ros-2-nvidia-cuda-nvidia-tensorrt) | [`ros2-triton`](#rwthikaros2-triton-ros-2-nvidia-cuda-nvidia-triton-client) | [`ros2-torch`](#rwthikaros2-torch-ros-2-nvidia-cuda-nvidia-tensorrt-pytorch) | [`ros2-tf`](#rwthikaros2-tf-ros-2-nvidia-cuda-nvidia-tensorrt-tensorflow) | [`ros2-ml`](#rwthikaros2-ml-ros-2-nvidia-cuda-nvidia-tensorrt-pytorch-tensorflow)  
[`ros`](#rwthikaros-ros) | [`ros-cuda`](#rwthikaros-cuda-ros-nvidia-cuda) | [`ros-tensorrt`](#rwthikaros-tensorrt-ros-nvidia-cuda-nvidia-tensorrt) | [`ros-triton`](#rwthikaros-triton-ros-nvidia-cuda-nvidia-triton-client) | [`ros-torch`](#rwthikaros-torch-ros-nvidia-cuda-nvidia-tensorrt-pytorch) | [`ros-tf`](#rwthikaros-tf-ros-nvidia-cuda-nvidia-tensorrt-tensorflow) | [`ros-ml`](#rwthikaros-ml-ros-nvidia-cuda-nvidia-tensorrt-pytorch-tensorflow)


## Quick Start

```bash
docker run --rm rwthika/ros2-ml:humble \
  python -c 'import os; import tensorflow as tf; import torch; e="ROS_DISTRO"; print(f"Hello from ROS {os.environ[e]}, PyTorch {torch.__version__}, and TensorFlow {tf.__version__}!")'
```


## Variations

With *docker-ros-ml-images*, we provide a variety of lightweight multi-arch machine learning-enabled ROS Docker images. Starting with plain ROS images, we offer successively larger ROS base images that also come with [*NVIDIA CUDA*](https://developer.nvidia.com/cuda-toolkit), [*NVIDIA TensorRT*](https://developer.nvidia.com/tensorrt), [*NVIDIA Triton Client*](https://developer.nvidia.com/triton-inference-server), [*PyTorch*](https://pytorch.org/) and/or [*TensorFlow*](https://www.tensorflow.org/) installations. Combining the components listed in the table below, we have built more than 100 multi-arch images and make them publicly available on [DockerHub](https://hub.docker.com/u/rwthika). In addition to the provided images, we also publish the [generic Dockerfile](./Dockerfile) used to flexibly build images combining the different components.

| Component        | Variations                                                              |
| ---------------- | ----------------------------------------------------------------------- |
| ROS Distribution | noetic, humble, iron, jazzy, rolling                                    |
| ROS Components   | core, base, desktop-full                                                |
| ML Framework     | NVIDIA CUDA, NVIDIA TensorRT, NVIDIA Triton Client, PyTorch, TensorFlow |
| Architecture     | amd64, arm64                                                            |

> [!NOTE]
> All images are targeted at NVIDIA GPUs and therefore base off of official [NVIDIA base images](https://catalog.ngc.nvidia.com/containers). The arm64 images, in particular, target NVIDIA Jetson SoCs and are based off of [NVIDIA L4T base images](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/l4t-base). Ubuntu 22 images are provided with JetPack 6, Ubuntu 20 images with JetPack 5.

> [!NOTE]
> Since robotic applications are often implemented in C++ instead of Python for performance reasons, previous releases of our images also shipped with the C++ APIs of PyTorch and TensorFlow. Installing the C++ libraries often involves cumbersome building from source, so we have decided to drop PyTorch/TensorFlow C++ support for more frequent releases. You may still find those images with ML C++ support under the [23.08 release](https://hub.docker.com/r/rwthika/ros2-ml/tags?page=&page_size=&ordering=&name=-v23.08).


## Image Configuration

### User Setup

Containers of the provided images start with `root` user by default. If the two environment variables `DOCKER_UID` and `DOCKER_GID` are passed, a new user with the corresponding UID/GID is created on the fly. Most importantly, this features allows to mount and edit files of the host user in the container without having to deal with permission issues.

```bash
docker run --rm -it -e DOCKER_UID=$(id -u) -e DOCKER_GID=$(id -g) -e DOCKER_USER=$(id -un) rwthika/ros:latest
```

The password of the custom user is set to its username (`dockeruser:dockeruser` by default).


## Available Images

### ROS 2

#### [`rwthika/ros2`](https://hub.docker.com/r/rwthika/ros2) (ROS 2)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2"><img src="https://img.shields.io/docker/pulls/rwthika/ros2"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      | Ubuntu  | Python  |   ROS   | ROS Package  | CMake  | CUDA  | cuDNN | TensorRT | Triton | PyTorch | TensorFlow |
| :------------------------------------ | :------------: | :-----: | :-----: | :-----: | :----------: | :----: | :---: | :---: | :------: | :----: | :-----: | :--------: |
| `humble-ros-core`                     | amd64<br>arm64 | 22.04.5 | 3.10.12 | humble  |   ros-core   | 3.22.1 |   -   |   -   |    -     |   -    |    -    |     -      |
| `latest`, `humble`, `humble-ros-base` | amd64<br>arm64 | 22.04.5 | 3.10.12 | humble  |   ros-base   | 3.22.1 |   -   |   -   |    -     |   -    |    -    |     -      |
| `humble-desktop-full`                 | amd64<br>arm64 | 22.04.5 | 3.10.12 | humble  | desktop-full | 3.22.1 |   -   |   -   |    -     |   -    |    -    |     -      |
| `iron-ros-core`                       | amd64<br>arm64 | 22.04.5 | 3.10.12 |  iron   |   ros-core   | 3.22.1 |   -   |   -   |    -     |   -    |    -    |     -      |
| `iron`, `iron-ros-base`               | amd64<br>arm64 | 22.04.5 | 3.10.12 |  iron   |   ros-base   | 3.22.1 |   -   |   -   |    -     |   -    |    -    |     -      |
| `iron-desktop-full`                   | amd64<br>arm64 | 22.04.5 | 3.10.12 |  iron   | desktop-full | 3.22.1 |   -   |   -   |    -     |   -    |    -    |     -      |
| `jazzy-ros-core`                      | amd64<br>arm64 | 24.04.1 | 3.12.3  |  jazzy  |   ros-core   | 3.28.3 |   -   |   -   |    -     |   -    |    -    |     -      |
| `jazzy`, `jazzy-ros-base`             | amd64<br>arm64 | 24.04.1 | 3.12.3  |  jazzy  |   ros-base   | 3.28.3 |   -   |   -   |    -     |   -    |    -    |     -      |
| `jazzy-desktop-full`                  | amd64<br>arm64 | 24.04.1 | 3.12.3  |  jazzy  | desktop-full | 3.28.3 |   -   |   -   |    -     |   -    |    -    |     -      |
| `rolling-ros-core`                    | amd64<br>arm64 | 24.04.1 | 3.12.3  | rolling |   ros-core   | 3.28.3 |   -   |   -   |    -     |   -    |    -    |     -      |
| `rolling`, `rolling-ros-base`         | amd64<br>arm64 | 24.04.1 | 3.12.3  | rolling |   ros-base   | 3.28.3 |   -   |   -   |    -     |   -    |    -    |     -      |
| `rolling-desktop-full`                | amd64<br>arm64 | 24.04.1 | 3.12.3  | rolling | desktop-full | 3.28.3 |   -   |   -   |    -     |   -    |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros2-cuda`](https://hub.docker.com/r/rwthika/ros2-cuda) (ROS 2, NVIDIA CUDA)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-cuda"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-cuda"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      |      Ubuntu      |      Python       |   ROS   |    ROS Package    |      CMake       |        CUDA         | cuDNN | TensorRT | Triton | PyTorch | TensorFlow |
| :------------------------------------ | :------------: | :--------------: | :---------------: | :-----: | :---------------: | :--------------: | :-----------------: | :---: | :------: | :----: | :-----: | :--------: |
| `humble-ros-core`                     | amd64<br>arm64 |     22.04.3      |      3.10.12      | humble  |     ros-core      |      3.22.1      |      12.2.140       |   -   |    -     |   -    |    -    |     -      |
| `latest`, `humble`, `humble-ros-base` | amd64<br>arm64 |     22.04.3      |      3.10.12      | humble  |     ros-base      |      3.22.1      |      12.2.140       |   -   |    -     |   -    |    -    |     -      |
| `humble-desktop-full`                 | amd64<br>arm64 |     22.04.3      |      3.10.12      | humble  |   desktop-full    |      3.22.1      |      12.2.140       |   -   |    -     |   -    |    -    |     -      |
| `iron-ros-core`                       | amd64<br>arm64 |     22.04.3      |      3.10.12      |  iron   |     ros-core      |      3.22.1      |      12.2.140       |   -   |    -     |   -    |    -    |     -      |
| `iron`, `iron-ros-base`               | amd64<br>arm64 |     22.04.3      |      3.10.12      |  iron   |     ros-base      |      3.22.1      |      12.2.140       |   -   |    -     |   -    |    -    |     -      |
| `iron-desktop-full`                   | amd64<br>arm64 |     22.04.3      |      3.10.12      |  iron   |   desktop-full    |      3.22.1      |      12.2.140       |   -   |    -     |   -    |    -    |     -      |
| `jazzy-ros-core`                      |     amd64      |      24.04       |      3.12.3       |  jazzy  |     ros-core      |      3.28.3      |       12.6.37       |   -   |    -     |   -    |    -    |     -      |
| `jazzy`, `jazzy-ros-base`             |     amd64      |      24.04       |      3.12.3       |  jazzy  |     ros-base      |      3.28.3      |       12.6.37       |   -   |    -     |   -    |    -    |     -      |
| `jazzy-desktop-full`                  | amd64<br>arm64 | 24.04<br>22.04.3 | 3.12.3<br>3.10.12 |  jazzy  | desktop-full<br>- | 3.28.3<br>3.22.1 | 12.6.37<br>12.2.140 |   -   |    -     |   -    |    -    |     -      |
| `rolling-ros-core`                    |     amd64      |      24.04       |      3.12.3       | rolling |     ros-core      |      3.28.3      |       12.6.37       |   -   |    -     |   -    |    -    |     -      |
| `rolling`, `rolling-ros-base`         |     amd64      |      24.04       |      3.12.3       | rolling |     ros-base      |      3.28.3      |       12.6.37       |   -   |    -     |   -    |    -    |     -      |
| `rolling-desktop-full`                |     amd64      |      24.04       |      3.12.3       | rolling |   desktop-full    |      3.28.3      |       12.6.37       |   -   |    -     |   -    |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros2-tensorrt`](https://hub.docker.com/r/rwthika/ros2-tensorrt) (ROS 2, NVIDIA CUDA, NVIDIA TensorRT)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-tensorrt"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-tensorrt"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      | Ubuntu  | Python  |  ROS   | ROS Package  |      CMake       |         CUDA         |        cuDNN         |      TensorRT      | Triton | PyTorch | TensorFlow |
| :------------------------------------ | :------------: | :-----: | :-----: | :----: | :----------: | :--------------: | :------------------: | :------------------: | :----------------: | :----: | :-----: | :--------: |
| `humble-ros-core`                     | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |     -      |
| `latest`, `humble`, `humble-ros-base` | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |     -      |
| `humble-desktop-full`                 | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |     -      |
| `iron-ros-core`                       | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |     -      |
| `iron`, `iron-ros-base`               | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |     -      |
| `iron-desktop-full`                   | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |     -      |
| `jazzy-desktop-full`                  | amd64<br>arm64 | 22.04.3 | 3.10.12 | jazzy  |      -       | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros2-triton`](https://hub.docker.com/r/rwthika/ros2-triton) (ROS 2, NVIDIA CUDA, NVIDIA Triton Client)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-triton"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-triton"/></a>

<details><summary>Click to expand</summary>

| Tag                                                |      Arch      |      Ubuntu      |      Python       |   ROS   |    ROS Package    |      CMake       |        CUDA         | cuDNN | TensorRT | Triton | PyTorch | TensorFlow |
| :------------------------------------------------- | :------------: | :--------------: | :---------------: | :-----: | :---------------: | :--------------: | :-----------------: | :---: | :------: | :----: | :-----: | :--------: |
| `humble-ros-core-triton2.48.0`                     | amd64<br>arm64 |     22.04.3      |      3.10.12      | humble  |     ros-core      |      3.22.1      |      12.2.140       |   -   |    -     | 2.48.0 |    -    |     -      |
| `latest`, `humble`, `humble-ros-base-triton2.48.0` | amd64<br>arm64 |     22.04.3      |      3.10.12      | humble  |     ros-base      |      3.22.1      |      12.2.140       |   -   |    -     | 2.48.0 |    -    |     -      |
| `humble-desktop-full-triton2.48.0`                 | amd64<br>arm64 |     22.04.3      |      3.10.12      | humble  |   desktop-full    |      3.22.1      |      12.2.140       |   -   |    -     | 2.48.0 |    -    |     -      |
| `iron-ros-core-triton2.48.0`                       | amd64<br>arm64 |     22.04.3      |      3.10.12      |  iron   |     ros-core      |      3.22.1      |      12.2.140       |   -   |    -     | 2.48.0 |    -    |     -      |
| `iron`, `iron-ros-base-triton2.48.0`               | amd64<br>arm64 |     22.04.3      |      3.10.12      |  iron   |     ros-base      |      3.22.1      |      12.2.140       |   -   |    -     | 2.48.0 |    -    |     -      |
| `iron-desktop-full-triton2.48.0`                   | amd64<br>arm64 |     22.04.3      |      3.10.12      |  iron   |   desktop-full    |      3.22.1      |      12.2.140       |   -   |    -     | 2.48.0 |    -    |     -      |
| `jazzy-ros-core-triton2.48.0`                      |     amd64      |      24.04       |      3.12.3       |  jazzy  |     ros-core      |      3.28.3      |       12.6.37       |   -   |    -     | 2.48.0 |    -    |     -      |
| `jazzy`, `jazzy-ros-base-triton2.48.0`             |     amd64      |      24.04       |      3.12.3       |  jazzy  |     ros-base      |      3.28.3      |       12.6.37       |   -   |    -     | 2.48.0 |    -    |     -      |
| `jazzy-desktop-full-triton2.48.0`                  | amd64<br>arm64 | 24.04<br>22.04.3 | 3.12.3<br>3.10.12 |  jazzy  | desktop-full<br>- | 3.28.3<br>3.22.1 | 12.6.37<br>12.2.140 |   -   |    -     | 2.48.0 |    -    |     -      |
| `rolling-ros-core-triton2.48.0`                    |     amd64      |      24.04       |      3.12.3       | rolling |     ros-core      |      3.28.3      |       12.6.37       |   -   |    -     | 2.48.0 |    -    |     -      |
| `rolling`, `rolling-ros-base-triton2.48.0`         |     amd64      |      24.04       |      3.12.3       | rolling |     ros-base      |      3.28.3      |       12.6.37       |   -   |    -     | 2.48.0 |    -    |     -      |
| `rolling-desktop-full-triton2.48.0`                |     amd64      |      24.04       |      3.12.3       | rolling |   desktop-full    |      3.28.3      |       12.6.37       |   -   |    -     | 2.48.0 |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros2-torch`](https://hub.docker.com/r/rwthika/ros2-torch) (ROS 2, NVIDIA CUDA, NVIDIA TensorRT, PyTorch)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-torch"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-torch"/></a>

<details><summary>Click to expand</summary>

| Tag                                              |      Arch      | Ubuntu  | Python  |  ROS   | ROS Package  |      CMake       |         CUDA         |        cuDNN         |      TensorRT      | Triton | PyTorch | TensorFlow |
| :----------------------------------------------- | :------------: | :-----: | :-----: | :----: | :----------: | :--------------: | :------------------: | :------------------: | :----------------: | :----: | :-----: | :--------: |
| `humble-ros-core-torch2.3.0`                     | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |     -      |
| `latest`, `humble`, `humble-ros-base-torch2.3.0` | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |     -      |
| `humble-desktop-full-torch2.3.0`                 | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |     -      |
| `iron-ros-core-torch2.3.0`                       | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |     -      |
| `iron`, `iron-ros-base-torch2.3.0`               | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |     -      |
| `iron-desktop-full-torch2.3.0`                   | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |     -      |
| `jazzy-desktop-full-torch2.3.0`                  | amd64<br>arm64 | 22.04.3 | 3.10.12 | jazzy  |      -       | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |     -      |

</details>
</blockquote>

#### [`rwthika/ros2-tf`](https://hub.docker.com/r/rwthika/ros2-tf) (ROS 2, NVIDIA CUDA, NVIDIA TensorRT, TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-tf"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-tf"/></a>

<details><summary>Click to expand</summary>

| Tag                                            |      Arch      | Ubuntu  | Python  |  ROS   | ROS Package  |      CMake       |         CUDA         |        cuDNN         |      TensorRT      | Triton | PyTorch |                                                                                                                             TensorFlow                                                                                                                              |
| :--------------------------------------------- | :------------: | :-----: | :-----: | :----: | :----------: | :--------------: | :------------------: | :------------------: | :----------------: | :----: | :-----: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| `humble-ros-core-tf2.16.1`                     | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |                                                                                                                               2.16.1                                                                                                                                |
| `latest`, `humble`, `humble-ros-base-tf2.16.1` | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |                                                                                                                               2.16.1                                                                                                                                |
| `humble-desktop-full-tf2.16.1`                 | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    | 2.16.1<br>/usr/lib/python3/dist-packages/scipy/__init__.py:146: UserWarning: A NumPy version >=1.17.3 and <1.25.0 is required for this version of SciPy (detected version 1.26.4\n  warnings.warn(f"A NumPy version >={np_minversion} and <{np_maxversion}"\n2.16.1 |
| `iron-ros-core-tf2.16.1`                       | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |                                                                                                                               2.16.1                                                                                                                                |
| `iron`, `iron-ros-base-tf2.16.1`               | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    |                                                                                                                               2.16.1                                                                                                                                |
| `iron-desktop-full-tf2.16.1`                   | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    | 2.16.1<br>/usr/lib/python3/dist-packages/scipy/__init__.py:146: UserWarning: A NumPy version >=1.17.3 and <1.25.0 is required for this version of SciPy (detected version 1.26.4\n  warnings.warn(f"A NumPy version >={np_minversion} and <{np_maxversion}"\n2.16.1 |
| `jazzy-desktop-full-tf2.16.1`                  | amd64<br>arm64 | 22.04.3 | 3.10.12 | jazzy  |      -       | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |    -    | 2.16.1<br>/usr/lib/python3/dist-packages/scipy/__init__.py:146: UserWarning: A NumPy version >=1.17.3 and <1.25.0 is required for this version of SciPy (detected version 1.26.4\n  warnings.warn(f"A NumPy version >={np_minversion} and <{np_maxversion}"\n2.16.1 |

</details>
</blockquote>

#### [`rwthika/ros2-ml`](https://hub.docker.com/r/rwthika/ros2-ml) (ROS 2, NVIDIA CUDA, NVIDIA TensorRT, PyTorch, TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-ml"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-ml"/></a>

<details><summary>Click to expand</summary>

| Tag                                                       |      Arch      | Ubuntu  | Python  |  ROS   | ROS Package  |      CMake       |         CUDA         |        cuDNN         |      TensorRT      | Triton | PyTorch |                                                                                                                             TensorFlow                                                                                                                              |
| :-------------------------------------------------------- | :------------: | :-----: | :-----: | :----: | :----------: | :--------------: | :------------------: | :------------------: | :----------------: | :----: | :-----: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| `humble-ros-core-tf2.16.1-torch2.3.0`                     | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |                                                                                                                               2.16.1                                                                                                                                |
| `latest`, `humble`, `humble-ros-base-tf2.16.1-torch2.3.0` | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |                                                                                                                               2.16.1                                                                                                                                |
| `humble-desktop-full-tf2.16.1-torch2.3.0`                 | amd64<br>arm64 | 22.04.3 | 3.10.12 | humble | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  | 2.16.1<br>/usr/lib/python3/dist-packages/scipy/__init__.py:146: UserWarning: A NumPy version >=1.17.3 and <1.25.0 is required for this version of SciPy (detected version 1.26.4\n  warnings.warn(f"A NumPy version >={np_minversion} and <{np_maxversion}"\n2.16.1 |
| `iron-ros-core-tf2.16.1-torch2.3.0`                       | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-core   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |                                                                                                                               2.16.1                                                                                                                                |
| `iron`, `iron-ros-base-tf2.16.1-torch2.3.0`               | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  |   ros-base   | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  |                                                                                                                               2.16.1                                                                                                                                |
| `iron-desktop-full-tf2.16.1-torch2.3.0`                   | amd64<br>arm64 | 22.04.3 | 3.10.12 |  iron  | desktop-full | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  | 2.16.1<br>/usr/lib/python3/dist-packages/scipy/__init__.py:146: UserWarning: A NumPy version >=1.17.3 and <1.25.0 is required for this version of SciPy (detected version 1.26.4\n  warnings.warn(f"A NumPy version >={np_minversion} and <{np_maxversion}"\n2.16.1 |
| `jazzy-desktop-full-tf2.16.1-torch2.3.0`                  | amd64<br>arm64 | 22.04.3 | 3.10.12 | jazzy  |      -       | 3.24.0<br>3.22.1 | 12.2.128<br>12.2.140 | 8.9.5.27<br>8.9.4.25 | 8.6.1.6<br>8.6.2.3 |   -    |  2.3.0  | 2.16.1<br>/usr/lib/python3/dist-packages/scipy/__init__.py:146: UserWarning: A NumPy version >=1.17.3 and <1.25.0 is required for this version of SciPy (detected version 1.26.4\n  warnings.warn(f"A NumPy version >={np_minversion} and <{np_maxversion}"\n2.16.1 |

</details>
</blockquote>

### ROS

#### [`rwthika/ros`](https://hub.docker.com/r/rwthika/ros) (ROS)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros"><img src="https://img.shields.io/docker/pulls/rwthika/ros"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      | Ubuntu  | Python |  ROS   | ROS Package  | CMake  | CUDA  | cuDNN | TensorRT | Triton | PyTorch | TensorFlow |
| :------------------------------------ | :------------: | :-----: | :----: | :----: | :----------: | :----: | :---: | :---: | :------: | :----: | :-----: | :--------: |
| `noetic-ros-core`                     | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.16.3 |   -   |   -   |    -     |   -    |    -    |     -      |
| `latest`, `noetic`, `noetic-ros-base` | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.16.3 |   -   |   -   |    -     |   -    |    -    |     -      |
| `noetic-desktop-full`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.16.3 |   -   |   -   |    -     |   -    |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros-cuda`](https://hub.docker.com/r/rwthika/ros-cuda) (ROS, NVIDIA CUDA)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-cuda"><img src="https://img.shields.io/docker/pulls/rwthika/ros-cuda"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      | Ubuntu  | Python |  ROS   | ROS Package  | CMake  |         CUDA         | cuDNN | TensorRT | Triton | PyTorch | TensorFlow |
| :------------------------------------ | :------------: | :-----: | :----: | :----: | :----------: | :----: | :------------------: | :---: | :------: | :----: | :-----: | :--------: |
| `noetic-ros-core`                     | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.16.3 | 11.4.148<br>11.4.298 |   -   |    -     |   -    |    -    |     -      |
| `latest`, `noetic`, `noetic-ros-base` | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.16.3 | 11.4.148<br>11.4.298 |   -   |    -     |   -    |    -    |     -      |
| `noetic-desktop-full`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.16.3 | 11.4.148<br>11.4.298 |   -   |    -     |   -    |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros-tensorrt`](https://hub.docker.com/r/rwthika/ros-tensorrt) (ROS, NVIDIA CUDA, NVIDIA TensorRT)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-tensorrt"><img src="https://img.shields.io/docker/pulls/rwthika/ros-tensorrt"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      |       Ubuntu       | Python |  ROS   | ROS Package  |      CMake       |         CUDA         |         cuDNN         |    TensorRT    | Triton | PyTorch | TensorFlow |
| :------------------------------------ | :------------: | :----------------: | :----: | :----: | :----------: | :--------------: | :------------------: | :-------------------: | :------------: | :----: | :-----: | :--------: |
| `noetic-ros-core`                     | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-core   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    |    -    |     -      |
| `latest`, `noetic`, `noetic-ros-base` | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-base   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    |    -    |     -      |
| `noetic-desktop-full`                 | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic | desktop-full | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros-triton`](https://hub.docker.com/r/rwthika/ros-triton) (ROS, NVIDIA CUDA, NVIDIA Triton Client)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-triton"><img src="https://img.shields.io/docker/pulls/rwthika/ros-triton"/></a>

<details><summary>Click to expand</summary>

| Tag                                                |      Arch      | Ubuntu  | Python |  ROS   | ROS Package  | CMake  |         CUDA         | cuDNN | TensorRT | Triton | PyTorch | TensorFlow |
| :------------------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :------------------: | :---: | :------: | :----: | :-----: | :--------: |
| `noetic-ros-core-triton2.48.0`                     | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.16.3 | 11.4.148<br>11.4.298 |   -   |    -     | 2.48.0 |    -    |     -      |
| `latest`, `noetic`, `noetic-ros-base-triton2.48.0` | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.16.3 | 11.4.148<br>11.4.298 |   -   |    -     | 2.48.0 |    -    |     -      |
| `noetic-desktop-full-triton2.48.0`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.16.3 | 11.4.148<br>11.4.298 |   -   |    -     | 2.48.0 |    -    |     -      |

</details>
</blockquote>

#### [`rwthika/ros-torch`](https://hub.docker.com/r/rwthika/ros-torch) (ROS, NVIDIA CUDA, NVIDIA TensorRT, PyTorch)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-torch"><img src="https://img.shields.io/docker/pulls/rwthika/ros-torch"/></a>

<details><summary>Click to expand</summary>

| Tag                                              |      Arch      |       Ubuntu       | Python |  ROS   | ROS Package  |      CMake       |         CUDA         |         cuDNN         |    TensorRT    | Triton |     PyTorch      | TensorFlow |
| :----------------------------------------------- | :------------: | :----------------: | :----: | :----: | :----------: | :--------------: | :------------------: | :-------------------: | :------------: | :----: | :--------------: | :--------: |
| `noetic-ros-core-torch2.1.0`                     | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-core   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    | 2.1.0<br>2.1.0a0 |     -      |
| `latest`, `noetic`, `noetic-ros-base-torch2.1.0` | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-base   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    | 2.1.0<br>2.1.0a0 |     -      |
| `noetic-desktop-full-torch2.1.0`                 | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic | desktop-full | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    | 2.1.0<br>2.1.0a0 |     -      |

</details>
</blockquote>

#### [`rwthika/ros-tf`](https://hub.docker.com/r/rwthika/ros-tf) (ROS, NVIDIA CUDA, NVIDIA TensorRT, TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-tf"><img src="https://img.shields.io/docker/pulls/rwthika/ros-tf"/></a>

<details><summary>Click to expand</summary>

| Tag                                            |      Arch      |       Ubuntu       | Python |  ROS   | ROS Package  |      CMake       |         CUDA         |         cuDNN         |    TensorRT    | Triton | PyTorch |                                                                  TensorFlow                                                                   |
| :--------------------------------------------- | :------------: | :----------------: | :----: | :----: | :----------: | :--------------: | :------------------: | :-------------------: | :------------: | :----: | :-----: | :-------------------------------------------------------------------------------------------------------------------------------------------: |
| `noetic-ros-core-tf2.12.0`                     | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-core   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    |    -    | 2.12.0<br>2024-11-12 17:54:22.293083: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT\n2.12.0 |
| `latest`, `noetic`, `noetic-ros-base-tf2.12.0` | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-base   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    |    -    | 2.12.0<br>2024-11-12 17:54:41.047701: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT\n2.12.0 |
| `noetic-desktop-full-tf2.12.0`                 | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic | desktop-full | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    |    -    | 2.12.0<br>2024-11-12 17:55:01.798148: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT\n2.12.0 |

</details>
</blockquote>

#### [`rwthika/ros-ml`](https://hub.docker.com/r/rwthika/ros-ml) (ROS, NVIDIA CUDA, NVIDIA TensorRT, PyTorch, TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-ml"><img src="https://img.shields.io/docker/pulls/rwthika/ros-ml"/></a>

<details><summary>Click to expand</summary>

| Tag                                                       |      Arch      |       Ubuntu       | Python |  ROS   | ROS Package  |      CMake       |         CUDA         |         cuDNN         |    TensorRT    | Triton |     PyTorch      |                                                                  TensorFlow                                                                   |
| :-------------------------------------------------------- | :------------: | :----------------: | :----: | :----: | :----------: | :--------------: | :------------------: | :-------------------: | :------------: | :----: | :--------------: | :-------------------------------------------------------------------------------------------------------------------------------------------: |
| `noetic-ros-core-tf2.12.0-torch2.1.0`                     | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-core   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    | 2.1.0<br>2.1.0a0 | 2.12.0<br>2024-11-12 17:55:23.414420: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT\n2.12.0 |
| `latest`, `noetic`, `noetic-ros-base-tf2.12.0-torch2.1.0` | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic |   ros-base   | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    | 2.1.0<br>2.1.0a0 | 2.12.0<br>2024-11-12 17:55:44.103993: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT\n2.12.0 |
| `noetic-desktop-full-tf2.12.0-torch2.1.0`                 | amd64<br>arm64 | 20.04.2<br>20.04.6 | 3.8.10 | noetic | desktop-full | 3.14.4<br>3.16.3 | 11.4.108<br>11.4.298 | 8.2.2.26<br>8.6.0.166 | 8.0.1<br>8.5.2 |   -    | 2.1.0<br>2.1.0a0 | 2.12.0<br>2024-11-12 17:56:07.501218: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT\n2.12.0 |

</details>
</blockquote>


## Manual Build

```
docker buildx build \
  --pull \
  --platform $PLATFORM \
  --build-arg BASE_IMAGE_TYPE=$BASE_IMAGE_TYPE \
  --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
  --build-arg ROS_VERSION=$ROS_VERSION \
  --build-arg ROS_DISTRO=$ROS_DISTRO \
  --build-arg ROS_PACKAGE=$ROS_PACKAGE \
  --build-arg ROS_BUILD_FROM_SRC=$ROS_BUILD_FROM_SRC \
  --build-arg TORCH_VERSION=$TORCH_VERSION \
  --build-arg TF_VERSION=$TF_VERSION \
  --build-arg TRITON_VERSION=$TRITON_VERSION \
  --tag $IMAGE .
```
