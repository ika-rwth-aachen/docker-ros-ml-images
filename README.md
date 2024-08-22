# *docker-ros-ml-images* – Machine Learning-Enabled ROS Docker Images

# TODO: add information for ROS 2 Jazzy

<p align="center">
  <img src="https://img.shields.io/github/v/release/ika-rwth-aachen/docker-ros-ml-images"/></a>
  <img src="https://img.shields.io/github/license/ika-rwth-aachen/docker-ros-ml-images"/>
  <img src="https://img.shields.io/badge/ROS-noetic-blueviolet"/>
  <img src="https://img.shields.io/badge/ROS 2-humble|iron|jazzy|rolling-blueviolet"/>
  <img src="https://img.shields.io/badge/PyTorch-2.0-red"/>
  <img src="https://img.shields.io/badge/TensorFlow-2.11-orange"/>
</p>

*docker-ros-ml-images* provides machine learning-enabled ROS Docker images.

> [!IMPORTANT]  
> This repository is open-sourced and maintained by the [**Institute for Automotive Engineering (ika) at RWTH Aachen University**](https://www.ika.rwth-aachen.de/).  
> **DevOps, Containerization and Orchestration of Software-Defined Vehicles** are some of many research topics within our [*Vehicle Intelligence & Automated Driving*](https://www.ika.rwth-aachen.de/en/competences/fields-of-research/vehicle-intelligence-automated-driving.html) domain.  
> If you would like to learn more about how we can support your advanced driver assistance and automated driving efforts, feel free to reach out to us!  
> :email: ***opensource@ika.rwth-aachen.de***

We recommend to use *docker-ros-ml-images* in combination with our other tools for Docker and ROS.
- [*docker-ros*](https://github.com/ika-rwth-aachen/docker-ros) automatically builds minimal container images of ROS applications <a href="https://github.com/ika-rwth-aachen/docker-ros"><img src="https://img.shields.io/github/stars/ika-rwth-aachen/docker-ros?style=social"/></a>
- [*docker-run*](https://github.com/ika-rwth-aachen/docker-run) is a CLI tool for simplified interaction with Docker images <a href="https://github.com/ika-rwth-aachen/docker-run"><img src="https://img.shields.io/github/stars/ika-rwth-aachen/docker-run?style=social"/></a>


## Quick Start

```bash
docker run --rm rwthika/ros2-ml:humble \
  python -c 'import os; import tensorflow as tf; import torch; e="ROS_DISTRO"; print(f"Hello from ROS {os.environ[e]}, PyTorch {torch.__version__}, and TensorFlow {tf.__version__}!")'
```


## Variations

With *docker-ros-ml-images*, we provide a variety of lightweight multi-arch machine learning-enabled ROS Docker images. Each of the provided Docker images includes support for popular machine learning frameworks in addition to a ROS distribution. Currently, the supported machine learning frameworks are [*PyTorch*](https://pytorch.org/) and [*TensorFlow*](https://www.tensorflow.org/). Since robotic applications are often implemented in C++ instead of Python for performance reasons, we also offer the C++ APIs of both frameworks. Combining the components listed the table below, we have built more than 100 multi-arch images and make them publicly available on [DockerHub](https://hub.docker.com/u/rwthika). In addition to the provided images, we also publish the [generic Dockerfile](./Dockerfile) used to flexibly build images combining the different components.

| Component        | Variations                                                           |
| ---------------- | -------------------------------------------------------------------- |
| ROS Distribution | noetic, humble, iron, jazzy, rolling                                 |
| ROS Components   | core, base, desktop-full                                             |
| ML Framework     | CUDA, PyTorch Python, PyTorch C++, TensorFlow Python, TensorFlow C++ |
| Architecture     | amd64, arm64                                                         |


## Image Configuration

### User Setup

Containers of the provided images start with `root` user by default. If the two environment variables `DOCKER_UID` and `DOCKER_GID` are passed, a new user with the corresponding UID/GID is created on the fly. Most importantly, this features allows to mount and edit files of the host user in the container without having to deal with permission issues.

```bash
docker run --rm -it -e DOCKER_UID=$(id -u) -e DOCKER_GID=$(id -g) -e DOCKER_USER=$(id -un) rwthika/ros:latest
```

The password of the custom user is set to its username (`dockeruser:dockeruser` by default).


## Available Images

### ROS

#### [`rwthika/ros`](https://hub.docker.com/r/rwthika/ros) (ROS)


<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros"><img src="https://img.shields.io/docker/pulls/rwthika/ros"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  | CUDA  | cuDNN | TensorRT | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :---: | :---: | :------: | :------------: | :---------: | :---------------: | :------------: |
| `noetic-ros-core`                     | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `latest`, `noetic`, `noetic-ros-base` | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `noetic-desktop-full`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |

</details>
</blockquote>

#### [`rwthika/ros-cuda-trt`](https://hub.docker.com/r/rwthika/ros-cuda-trt) (ROS + CUDA + TensorRT)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-cuda-trt"><img src="https://img.shields.io/docker/pulls/rwthika/ros-cuda-trt"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  |  CUDA   | cuDNN | TensorRT | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :-----: | :---: | :------: | :------------: | :---------: | :---------------: | :------------: |
| `noetic-ros-core`                     | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |         -         |       -        |
| `latest`, `noetic`, `noetic-ros-base` | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |         -         |       -        |
| `noetic-desktop-full`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |         -         |       -        |

</details>
</blockquote>

#### [`rwthika/ros-torch`](https://hub.docker.com/r/rwthika/ros-torch) (ROS + PyTorch)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-torch"><img src="https://img.shields.io/docker/pulls/rwthika/ros-torch"/></a>

<details><summary>Click to expand</summary>

| Tag                                              |      Arch      |    Ubuntu    |   Python    |     ROS     |   ROS Packages    |    CMake    |     CUDA     |   cuDNN    |  TensorRT  | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------------------ | :------------: | :----------: | :---------: | :---------: | :---------------: | :---------: | :----------: | :--------: | :--------: | :------------: | :---------: | :---------------: | :------------: |
| `noetic-ros-core-torch2.0.1`                     | amd64<br>arm64 |   20.04.6    |   3.8.10    |   noetic    |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |         -         |       -        |
| `latest`, `noetic`, `noetic-ros-base-torch2.0.1` | amd64<br>arm64 |   20.04.6    |   3.8.10    |   noetic    |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |         -         |       -        |
| `noetic-desktop-full-torch2.0.1`                 | amd64<br>arm64 |   20.04.6    |   3.8.10    |   noetic    |   desktop-full    |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |         -         |       -        |
| `noetic-ros-core-torch2.0.1-py`                  | amd64<br>arm64 |   20.04.6    |   3.8.10    |   noetic    |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 |      -      |         -         |       -        |
| `noetic-ros-base-torch2.0.1-py`                  | amd64<br>arm64 |   20.04.6    |   3.8.10    |   noetic    |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 |      -      |         -         |       -        |
| `noetic-desktop-full-torch2.0.1-py`              | amd64<br>arm64 |   20.04.6    |   3.8.10    |   noetic    |   desktop-full    |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 |      -      |         -         |       -        |
| `noetic-ros-core-torch2.0.1-cpp`                 |   amd64<br>-   | 20.04.6<br>- | 3.8.10<br>- | noetic<br>- |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `noetic-ros-base-torch2.0.1-cpp`                 |   amd64<br>-   | 20.04.6<br>- | 3.8.10<br>- | noetic<br>- |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `noetic-desktop-full-torch2.0.1-cpp`             |   amd64<br>-   | 20.04.6<br>- | 3.8.10<br>- | noetic<br>- | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |

</details>
</blockquote>

#### [`rwthika/ros-tf`](https://hub.docker.com/r/rwthika/ros-tf) (ROS + TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-tf"><img src="https://img.shields.io/docker/pulls/rwthika/ros-tf"/></a>

<details><summary>Click to expand</summary>

| Tag                                            |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  |  CUDA   | cuDNN | TensorRT | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ---------------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :-----: | :---: | :------: | :------------: | :---------: | :---------------: | :------------: |
| `noetic-ros-core-tf2.11.0`                     | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |      2.11.0       |     2.11.0     |
| `latest`, `noetic`, `noetic-ros-base-tf2.11.0` | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |      2.11.0       |     2.11.0     |
| `noetic-desktop-full-tf2.11.0`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |      2.11.0       |     2.11.0     |
| `noetic-ros-core-tf2.11.0-py`                  | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |      2.11.0       |       -        |
| `noetic-ros-base-tf2.11.0-py`                  | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |      2.11.0       |       -        |
| `noetic-desktop-full-tf2.11.0-py`              | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |      2.11.0       |       -        |
| `noetic-ros-core-tf2.11.0-cpp`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |         -         |     2.11.0     |
| `noetic-ros-base-tf2.11.0-cpp`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |         -         |     2.11.0     |
| `noetic-desktop-full-tf2.11.0-cpp`             | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   |       -        |      -      |         -         |     2.11.0     |

</details>
</blockquote>

#### [`rwthika/ros-ml`](https://hub.docker.com/r/rwthika/ros-ml) (ROS + PyTorch + TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros-ml"><img src="https://img.shields.io/docker/pulls/rwthika/ros-ml"/></a>

<details><summary>Click to expand</summary>

| Tag                                                       |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  |  CUDA   | cuDNN | TensorRT | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| --------------------------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :-----: | :---: | :------: | :------------: | :---------: | :---------------: | :------------: |
| `noetic-ros-core-tf2.11.0-torch2.0.1`                     | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-core   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   | 2.0.1<br>2.0.0 | 2.0.1<br>-  |      2.11.0       |     2.11.0     |
| `latest`, `noetic`, `noetic-ros-base-tf2.11.0-torch2.0.1` | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic |   ros-base   | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   | 2.0.1<br>2.0.0 | 2.0.1<br>-  |      2.11.0       |     2.11.0     |
| `noetic-desktop-full-tf2.11.0-torch2.0.1`                 | amd64<br>arm64 | 20.04.6 | 3.8.10 | noetic | desktop-full | 3.27.2 | 11.8.89 | 8.6.0 |  8.5.3   | 2.0.1<br>2.0.0 | 2.0.1<br>-  |      2.11.0       |     2.11.0     |

</details>
</blockquote>

### ROS 2

#### [`rwthika/ros2`](https://hub.docker.com/r/rwthika/ros2) (ROS 2)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2"><img src="https://img.shields.io/docker/pulls/rwthika/ros2"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      | Ubuntu  | Python  |   ROS   | ROS Packages | CMake  | CUDA  | cuDNN | TensorRT | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------- | :------------: | :-----: | :-----: | :-----: | :----------: | :----: | :---: | :---: | :------: | :------------: | :---------: | :---------------: | :------------: |
| `rolling-ros-core`                    | amd64<br>arm64 | 20.04.6 | 3.8.10  | rolling |   ros-core   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `rolling`, `rolling-ros-base`         | amd64<br>arm64 | 20.04.6 | 3.8.10  | rolling |   ros-base   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `rolling-desktop`                     | amd64<br>arm64 | 20.04.6 | 3.8.10  | rolling |   desktop    | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `iron-ros-core`                       | amd64<br>arm64 | 22.04.2 | 3.10.12 |  iron   |   ros-core   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `iron`, `iron-ros-base`               | amd64<br>arm64 | 22.04.2 | 3.10.12 |  iron   |   ros-base   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `iron-desktop-full`                   | amd64<br>arm64 | 22.04.2 | 3.10.12 |  iron   | desktop-full | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `humble-ros-core`                     | amd64<br>arm64 | 22.04.2 | 3.10.12 | humble  |   ros-core   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `latest`, `humble`, `humble-ros-base` | amd64<br>arm64 | 22.04.2 | 3.10.12 | humble  |   ros-base   | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `humble-desktop-full`                 | amd64<br>arm64 | 22.04.2 | 3.10.12 | humble  | desktop-full | 3.27.2 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `jazzy-ros-core`                      | amd64<br>arm64 | 24.04   | 3.12.3  | jazzy   |   ros-core   | 3.28.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `jazzy`, `jazzy-ros-base`             | amd64<br>arm64 | 24.04   | 3.12.3  | jazzy   |   ros-base   | 3.28.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `jazzy-desktop-full`                  | amd64<br>arm64 | 24.04   | 3.12.3  | jazzy   | desktop-full | 3.28.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |

</details>
</blockquote>

#### [`rwthika/ros2-cuda-trt`](https://hub.docker.com/r/rwthika/ros2-cuda-trt) (ROS 2 + CUDA + TensorRT)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-cuda-trt"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-cuda-trt"/></a>

<details><summary>Click to expand</summary>

| Tag                                   |      Arch      |    Ubuntu    |    Python    |     ROS     |   ROS Packages    |    CMake    |     CUDA     |   cuDNN    |  TensorRT  | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------- | :------------: | :----------: | :----------: | :---------: | :---------------: | :---------: | :----------: | :--------: | :--------: | :------------: | :---------: | :---------------: | :------------: |
| `rolling-ros-core`                    | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |         -         |       -        |
| `rolling`, `rolling-ros-base`         | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |         -         |       -        |
| `rolling-desktop`                     | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |      desktop      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |         -         |       -        |
| `iron-ros-core`                       |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |       -        |
| `iron`, `iron-ros-base`               |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |       -        |
| `iron-desktop-full`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |       -        |
| `humble-ros-core`                     |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |       -        |
| `latest`, `humble`, `humble-ros-base` |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |       -        |
| `humble-desktop-full`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |       -        |

</details>
</blockquote>

#### [`rwthika/ros2-torch`](https://hub.docker.com/r/rwthika/ros2-torch) (ROS 2 + PyTorch)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-torch"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-torch"/></a>

<details><summary>Click to expand</summary>

| Tag                                              |      Arch      |    Ubuntu    |    Python    |     ROS      |   ROS Packages    |    CMake    |     CUDA     |   cuDNN    |  TensorRT  | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------------------ | :------------: | :----------: | :----------: | :----------: | :---------------: | :---------: | :----------: | :--------: | :--------: | :------------: | :---------: | :---------------: | :------------: |
| `rolling-ros-core-torch2.0.1`                    | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling    |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |         -         |       -        |
| `rolling`, `rolling-ros-base-torch2.0.1`         | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling    |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |         -         |       -        |
| `rolling-desktop-torch2.0.1`                     | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling    |      desktop      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |         -         |       -        |
| `rolling-ros-core-torch2.0.1-py`                 | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling    |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 |      -      |         -         |       -        |
| `rolling-ros-base-torch2.0.1-py`                 | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling    |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 |      -      |         -         |       -        |
| `rolling-desktop-torch2.0.1-py`                  | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling    |      desktop      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 |      -      |         -         |       -        |
| `rolling-ros-core-torch2.0.1-cpp`                |   amd64<br>-   | 20.04.6<br>- | 3.8.10<br>-  | rolling<br>- |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `rolling-ros-base-torch2.0.1-cpp`                |   amd64<br>-   | 20.04.6<br>- | 3.8.10<br>-  | rolling<br>- |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `rolling-desktop-torch2.0.1-cpp`                 |   amd64<br>-   | 20.04.6<br>- | 3.8.10<br>-  | rolling<br>- |   desktop<br>-    | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `iron-ros-core-torch2.0.1`                       |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |         -         |       -        |
| `iron`, `iron-ros-base-torch2.0.1`               |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |         -         |       -        |
| `iron-desktop-full-torch2.0.1`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |         -         |       -        |
| `iron-ros-core-torch2.0.1-py`                    |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   |      -      |         -         |       -        |
| `iron-ros-base-torch2.0.1-py`                    |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   |      -      |         -         |       -        |
| `iron-desktop-full-torch2.0.1-py`                |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   |      -      |         -         |       -        |
| `iron-ros-core-torch2.0.1-cpp`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `iron-ros-base-torch2.0.1-cpp`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `iron-desktop-full-torch2.0.1-cpp`               |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-   | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `humble-ros-core-torch2.0.1`                     |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |         -         |       -        |
| `latest`, `humble`, `humble-ros-base-torch2.0.1` |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |         -         |       -        |
| `humble-desktop-full-torch2.0.1`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |         -         |       -        |
| `humble-ros-core-torch2.0.1-py`                  |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   |      -      |         -         |       -        |
| `humble-ros-base-torch2.0.1-py`                  |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   |      -      |         -         |       -        |
| `humble-desktop-full-torch2.0.1-py`              |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   |      -      |         -         |       -        |
| `humble-ros-core-torch2.0.1-cpp`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `humble-ros-base-torch2.0.1-cpp`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |
| `humble-desktop-full-torch2.0.1-cpp`             |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        | 2.0.1<br>-  |         -         |       -        |

</details>
</blockquote>

#### [`rwthika/ros2-tf`](https://hub.docker.com/r/rwthika/ros2-tf) (ROS 2 + TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-tf"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-tf"/></a>

<details><summary>Click to expand</summary>

| Tag                                            |      Arch      |    Ubuntu    |    Python    |     ROS     |   ROS Packages    |    CMake    |     CUDA     |   cuDNN    |  TensorRT  | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ---------------------------------------------- | :------------: | :----------: | :----------: | :---------: | :---------------: | :---------: | :----------: | :--------: | :--------: | :------------: | :---------: | :---------------: | :------------: |
| `rolling-ros-core-tf2.11.0`                    | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |      2.11.0       |     2.11.0     |
| `rolling`, `rolling-ros-base-tf2.11.0`         | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |      2.11.0       |     2.11.0     |
| `rolling-desktop-tf2.11.0`                     | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |      desktop      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |      2.11.0       |     2.11.0     |
| `rolling-ros-core-tf2.11.0-py`                 | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |      2.11.0       |       -        |
| `rolling-ros-base-tf2.11.0-py`                 | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |      2.11.0       |       -        |
| `rolling-desktop-tf2.11.0-py`                  | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |      desktop      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |      2.11.0       |       -        |
| `rolling-ros-core-tf2.11.0-cpp`                | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |         -         |     2.11.0     |
| `rolling-ros-base-tf2.11.0-cpp`                | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |         -         |     2.11.0     |
| `rolling-desktop-tf2.11.0-cpp`                 | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |      desktop      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    |       -        |      -      |         -         |     2.11.0     |
| `iron-ros-core-tf2.11.0`                       |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |  2.11.0<br>-   |
| `iron`, `iron-ros-base-tf2.11.0`               |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |  2.11.0<br>-   |
| `iron-desktop-full-tf2.11.0`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |  2.11.0<br>-   |
| `iron-ros-core-tf2.11.0-py`                    |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |       -        |
| `iron-ros-base-tf2.11.0-py`                    |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |       -        |
| `iron-desktop-full-tf2.11.0-py`                |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |       -        |
| `iron-ros-core-tf2.11.0-cpp`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |  2.11.0<br>-   |
| `iron-ros-base-tf2.11.0-cpp`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |  2.11.0<br>-   |
| `iron-desktop-full-tf2.11.0-cpp`               |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |  2.11.0<br>-   |
| `humble-ros-core-tf2.11.0`                     |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |  2.11.0<br>-   |
| `latest`, `humble`, `humble-ros-base-tf2.11.0` |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |  2.11.0<br>-   |
| `humble-desktop-full-tf2.11.0`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |  2.11.0<br>-   |
| `humble-ros-core-tf2.11.0-py`                  |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |       -        |
| `humble-ros-base-tf2.11.0-py`                  |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |       -        |
| `humble-desktop-full-tf2.11.0-py`              |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |    2.11.0<br>-    |       -        |
| `humble-ros-core-tf2.11.0-cpp`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |  2.11.0<br>-   |
| `humble-ros-base-tf2.11.0-cpp`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |  2.11.0<br>-   |
| `humble-desktop-full-tf2.11.0-cpp`             |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |       -        |      -      |         -         |  2.11.0<br>-   |

</details>
</blockquote>

#### [`rwthika/ros2-ml`](https://hub.docker.com/r/rwthika/ros2-ml) (ROS 2 + PyTorch + TensorFlow)

<blockquote>

<a href="https://hub.docker.com/r/rwthika/ros2-ml"><img src="https://img.shields.io/docker/pulls/rwthika/ros2-ml"/></a>

<details><summary>Click to expand</summary>

| Tag                                                       |      Arch      |    Ubuntu    |    Python    |     ROS     |   ROS Packages    |    CMake    |     CUDA     |   cuDNN    |  TensorRT  | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| --------------------------------------------------------- | :------------: | :----------: | :----------: | :---------: | :---------------: | :---------: | :----------: | :--------: | :--------: | :------------: | :---------: | :---------------: | :------------: |
| `rolling-ros-core-tf2.11.0-torch2.0.1`                    | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-core      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |      2.11.0       |     2.11.0     |
| `rolling`, `rolling-ros-base-tf2.11.0-torch2.0.1`         | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |     ros-base      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |      2.11.0       |     2.11.0     |
| `rolling-desktop-tf2.11.0-torch2.0.1`                     | amd64<br>arm64 |   20.04.6    |    3.8.10    |   rolling   |      desktop      |   3.27.2    |   11.8.89    |   8.6.0    |   8.5.3    | 2.0.1<br>2.0.0 | 2.0.1<br>-  |      2.11.0       |     2.11.0     |
| `iron-ros-core-tf2.11.0-torch2.0.1`                       |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |    2.11.0<br>-    |  2.11.0<br>-   |
| `iron`, `iron-ros-base-tf2.11.0-torch2.0.1`               |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |    2.11.0<br>-    |  2.11.0<br>-   |
| `iron-desktop-full-tf2.11.0-torch2.0.1`                   |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- |  iron<br>-  | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |    2.11.0<br>-    |  2.11.0<br>-   |
| `humble-ros-core-tf2.11.0-torch2.0.1`                     |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-core<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |    2.11.0<br>-    |  2.11.0<br>-   |
| `latest`, `humble`, `humble-ros-base-tf2.11.0-torch2.0.1` |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- |   ros-base<br>-   | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |    2.11.0<br>-    |  2.11.0<br>-   |
| `humble-desktop-full-tf2.11.0-torch2.0.1`                 |   amd64<br>-   | 22.04.2<br>- | 3.10.12<br>- | humble<br>- | desktop-full<br>- | 3.27.2<br>- | 11.8.89<br>- | 8.6.0<br>- | 8.5.3<br>- |   2.0.1<br>-   | 2.0.1<br>-  |    2.11.0<br>-    |  2.11.0<br>-   |

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
  --build-arg TORCH_VERSION=$TORCH_VERSION \
  --build-arg TF_VERSION=$TF_VERSION \
  --tag $IMAGE .
```
