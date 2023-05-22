# *docker-base* - Docker image building pipeline for ML-enabled ROS images

## Available Images

<details open><summary><b>ros1</b></summary>

| Tag                                   |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  | CUDA  | cuDNN | TensorRT | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :---: | :---: | :------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `noetic`, `noetic-ros-core` | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-core   | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `noetic-ros-base`                     | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-base   | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `noetic-robot`                        | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |    robot     | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `noetic-perception`                   | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |  perception  | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `noetic-desktop`                      | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   desktop    | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `noetic-desktop-full`                 | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic | desktop-full | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |

</details>

<details open><summary><b>ros1-cuda</b></summary>

| Tag                                   |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `noetic`, `noetic-ros-core` | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `noetic-ros-base`                     | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `noetic-robot`                        | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |    robot     | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `noetic-perception`                   | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `noetic-desktop`                      | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `noetic-desktop-full`                 | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |

</details>

<details open><summary><b>ros1-torch</b></summary>

| Tag                                                           |      Arch      |    Ubuntu    |   Python    |     ROS     |   ROS Packages    |    CMake    |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------------------------------- | :------------: | :----------: | :---------: | :---------: | :---------------: | :---------: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `noetic-torch1.11.0`, `noetic-ros-core-torch1.11.0` | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |     ros-core      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `noetic-ros-base-torch1.11.0`                                 | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |     ros-base      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `noetic-robot-torch1.11.0`                                    | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |       robot       |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `noetic-perception-torch1.11.0`                               | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |    perception     |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `noetic-desktop-torch1.11.0`                                  | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |      desktop      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `noetic-desktop-full-torch1.11.0`                             | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |   desktop-full    |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `noetic-torch1.11.0-py`, `noetic-ros-core-torch1.11.0-py`     | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |     ros-core      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `noetic-ros-base-torch1.11.0-py`                              | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |     ros-base      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `noetic-robot-torch1.11.0-py`                                 | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |       robot       |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `noetic-perception-torch1.11.0-py`                            | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |    perception     |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `noetic-desktop-torch1.11.0-py`                               | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |      desktop      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `noetic-desktop-full-torch1.11.0-py`                          | amd64<br>arm64 |   20.04.5    |   3.8.10    |   noetic    |   desktop-full    |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `noetic-torch1.11.0-cpp`, `noetic-ros-core-torch1.11.0-cpp`   |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | noetic<br>- |   ros-core<br>-   | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `noetic-ros-base-torch1.11.0-cpp`                             |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | noetic<br>- |   ros-base<br>-   | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `noetic-robot-torch1.11.0-cpp`                                |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | noetic<br>- |    robot<br>-     | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `noetic-perception-torch1.11.0-cpp`                           |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | noetic<br>- |  perception<br>-  | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `noetic-desktop-torch1.11.0-cpp`                              |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | noetic<br>- |   desktop<br>-    | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `noetic-desktop-full-torch1.11.0-cpp`                         |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | noetic<br>- | desktop-full<br>- | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |

</details>

<details open><summary><b>ros1-tf</b></summary>

| Tag                                                   |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ----------------------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `noetic-tf2.9.2`, `noetic-ros-core-tf2.9.2` | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-ros-base-tf2.9.2`                             | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-robot-tf2.9.2`                                | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |    robot     | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-perception-tf2.9.2`                           | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-desktop-tf2.9.2`                              | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-desktop-full-tf2.9.2`                         | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-tf2.9.2-py`, `noetic-ros-core-tf2.9.2-py`     | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `noetic-ros-base-tf2.9.2-py`                          | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `noetic-robot-tf2.9.2-py`                             | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |    robot     | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `noetic-perception-tf2.9.2-py`                        | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `noetic-desktop-tf2.9.2-py`                           | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `noetic-desktop-full-tf2.9.2-py`                      | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `noetic-tf2.9.2-cpp`, `noetic-ros-core-tf2.9.2-cpp`   | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `noetic-ros-base-tf2.9.2-cpp`                         | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `noetic-robot-tf2.9.2-cpp`                            | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |    robot     | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `noetic-perception-tf2.9.2-cpp`                       | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `noetic-desktop-tf2.9.2-cpp`                          | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `noetic-desktop-full-tf2.9.2-cpp`                     | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |

</details>

<details open><summary><b>ros1-ml</b></summary>

| Tag                                                                           |      Arch      | Ubuntu  | Python |  ROS   | ROS Packages | CMake  |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ----------------------------------------------------------------------------- | :------------: | :-----: | :----: | :----: | :----------: | :----: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `noetic-tf2.9.2-torch1.11.0`, `noetic-ros-core-tf2.9.2-torch1.11.0` | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-ros-base-tf2.9.2-torch1.11.0`                                         | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-robot-tf2.9.2-torch1.11.0`                                            | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |    robot     | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-perception-tf2.9.2-torch1.11.0`                                       | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-desktop-tf2.9.2-torch1.11.0`                                          | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `noetic-desktop-full-tf2.9.2-torch1.11.0`                                     | amd64<br>arm64 | 20.04.5 | 3.8.10 | noetic | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |

</details>

<details open><summary><b>ros2</b></summary>

| Tag                                     |      Arch      | Ubuntu  | Python |   ROS   | ROS Packages | CMake  | CUDA  | cuDNN | TensorRT | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| --------------------------------------- | :------------: | :-----: | :----: | :-----: | :----------: | :----: | :---: | :---: | :------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `rolling`, `rolling-ros-core` | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-core   | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `rolling-ros-base`                      | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-base   | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `rolling-perception`                    | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |  perception  | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `rolling-desktop`                       | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   desktop    | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `rolling-desktop-full`                  | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling | desktop-full | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `humble`, `humble-ros-core`             | amd64<br>arm64 | 22.04.1 | 3.10.6 | humble  |   ros-core   | 3.22.1 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `humble-ros-base`                       | amd64<br>arm64 | 22.04.1 | 3.10.6 | humble  |   ros-base   | 3.22.1 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `humble-perception`                     | amd64<br>arm64 | 22.04.1 | 3.10.6 | humble  |  perception  | 3.22.1 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `humble-desktop`                        | amd64<br>arm64 | 22.04.1 | 3.10.6 | humble  |   desktop    | 3.22.1 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `humble-desktop-full`                   | amd64<br>arm64 | 22.04.1 | 3.10.6 | humble  | desktop-full | 3.22.1 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `foxy`, `foxy-ros-core`                 | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-core   | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `foxy-ros-base`                         | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-base   | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |
| `foxy-desktop`                          | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   desktop    | 3.16.3 |   -   |   -   |    -     |       -        |      -      |         -         |       -        |

</details>

<details open><summary><b>ros2-cuda</b></summary>

| Tag                                     |      Arch      | Ubuntu  | Python |   ROS   | ROS Packages | CMake  |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| --------------------------------------- | :------------: | :-----: | :----: | :-----: | :----------: | :----: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `rolling`, `rolling-ros-core` | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `rolling-ros-base`                      | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `rolling-perception`                    | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `rolling-desktop`                       | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `rolling-desktop-full`                  | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `foxy`, `foxy-ros-core`                 | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `foxy-ros-base`                         | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |
| `foxy-desktop`                          | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |       -        |

</details>

<details open><summary><b>ros2-torch</b></summary>

| Tag                                                             |      Arch      |    Ubuntu    |   Python    |     ROS      |   ROS Packages    |    CMake    |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| --------------------------------------------------------------- | :------------: | :----------: | :---------: | :----------: | :---------------: | :---------: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `rolling-torch1.11.0`, `rolling-ros-core-torch1.11.0` | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |     ros-core      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `rolling-ros-base-torch1.11.0`                                  | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |     ros-base      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `rolling-perception-torch1.11.0`                                | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |    perception     |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `rolling-desktop-torch1.11.0`                                   | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |      desktop      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `rolling-desktop-full-torch1.11.0`                              | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |   desktop-full    |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `rolling-torch1.11.0-py`, `rolling-ros-core-torch1.11.0-py`     | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |     ros-core      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `rolling-ros-base-torch1.11.0-py`                               | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |     ros-base      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `rolling-perception-torch1.11.0-py`                             | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |    perception     |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `rolling-desktop-torch1.11.0-py`                                | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |      desktop      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `rolling-desktop-full-torch1.11.0-py`                           | amd64<br>arm64 |   20.04.5    |   3.8.10    |   rolling    |   desktop-full    |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `rolling-torch1.11.0-cpp`, `rolling-ros-core-torch1.11.0-cpp`   |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | rolling<br>- |   ros-core<br>-   | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `rolling-ros-base-torch1.11.0-cpp`                              |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | rolling<br>- |   ros-base<br>-   | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `rolling-perception-torch1.11.0-cpp`                            |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | rolling<br>- |  perception<br>-  | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `rolling-desktop-torch1.11.0-cpp`                               |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | rolling<br>- |   desktop<br>-    | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `rolling-desktop-full-torch1.11.0-cpp`                          |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- | rolling<br>- | desktop-full<br>- | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `foxy-torch1.11.0`, `foxy-ros-core-torch1.11.0`                 | amd64<br>arm64 |   20.04.5    |   3.8.10    |     foxy     |     ros-core      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `foxy-ros-base-torch1.11.0`                                     | amd64<br>arm64 |   20.04.5    |   3.8.10    |     foxy     |     ros-base      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `foxy-desktop-torch1.11.0`                                      | amd64<br>arm64 |   20.04.5    |   3.8.10    |     foxy     |      desktop      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |    -<br>2.9.1     |       -        |
| `foxy-torch1.11.0-py`, `foxy-ros-core-torch1.11.0-py`           | amd64<br>arm64 |   20.04.5    |   3.8.10    |     foxy     |     ros-core      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `foxy-ros-base-torch1.11.0-py`                                  | amd64<br>arm64 |   20.04.5    |   3.8.10    |     foxy     |     ros-base      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `foxy-desktop-torch1.11.0-py`                                   | amd64<br>arm64 |   20.04.5    |   3.8.10    |     foxy     |      desktop      |   3.16.3    | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     |      -      |    -<br>2.9.1     |       -        |
| `foxy-torch1.11.0-cpp`, `foxy-ros-core-torch1.11.0-cpp`         |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- |  foxy<br>-   |   ros-core<br>-   | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `foxy-ros-base-torch1.11.0-cpp`                                 |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- |  foxy<br>-   |   ros-base<br>-   | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |
| `foxy-desktop-torch1.11.0-cpp`                                  |   amd64<br>-   | 20.04.5<br>- | 3.8.10<br>- |  foxy<br>-   |   desktop<br>-    | 3.16.3<br>- |    11.3.109<br>-     |   8.2.1<br>-   |   7.2.3<br>-   |       -        | 1.11.0<br>- |         -         |       -        |

</details>

<details open><summary><b>ros2-tf</b></summary>

| Tag                                                     |      Arch      | Ubuntu  | Python |   ROS   | ROS Packages | CMake  |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------------------------- | :------------: | :-----: | :----: | :-----: | :----------: | :----: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `rolling-tf2.9.2`, `rolling-ros-core-tf2.9.2` | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-ros-base-tf2.9.2`                              | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-perception-tf2.9.2`                            | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-desktop-tf2.9.2`                               | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-desktop-full-tf2.9.2`                          | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-tf2.9.2-py`, `rolling-ros-core-tf2.9.2-py`     | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `rolling-ros-base-tf2.9.2-py`                           | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `rolling-perception-tf2.9.2-py`                         | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `rolling-desktop-tf2.9.2-py`                            | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `rolling-desktop-full-tf2.9.2-py`                       | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `rolling-tf2.9.2-cpp`, `rolling-ros-core-tf2.9.2-cpp`   | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `rolling-ros-base-tf2.9.2-cpp`                          | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `rolling-perception-tf2.9.2-cpp`                        | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `rolling-desktop-tf2.9.2-cpp`                           | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `rolling-desktop-full-tf2.9.2-cpp`                      | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `foxy-tf2.9.2`, `foxy-ros-core-tf2.9.2`                 | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `foxy-ros-base-tf2.9.2`                                 | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `foxy-desktop-tf2.9.2`                                  | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |     2.9.2      |
| `foxy-tf2.9.2-py`, `foxy-ros-core-tf2.9.2-py`           | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `foxy-ros-base-tf2.9.2-py`                              | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `foxy-desktop-tf2.9.2-py`                               | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |  2.9.2<br>2.9.1   |       -        |
| `foxy-tf2.9.2-cpp`, `foxy-ros-core-tf2.9.2-cpp`         | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `foxy-ros-base-tf2.9.2-cpp`                             | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |
| `foxy-desktop-tf2.9.2-cpp`                              | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |       -        |      -      |    -<br>2.9.1     |     2.9.2      |

</details>

<details open><summary><b>ros2-ml</b></summary>

| Tag                                                                             |      Arch      | Ubuntu  | Python |   ROS   | ROS Packages | CMake  |         CUDA         |     cuDNN      |    TensorRT    | PyTorch Python | PyTorch C++ | TensorFlow Python | TensorFlow C++ |
| ------------------------------------------------------------------------------- | :------------: | :-----: | :----: | :-----: | :----------: | :----: | :------------------: | :------------: | :------------: | :------------: | :---------: | :---------------: | :------------: |
| `latest`, `rolling-tf2.9.2-torch1.11.0`, `rolling-ros-core-tf2.9.2-torch1.11.0` | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-ros-base-tf2.9.2-torch1.11.0`                                          | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-perception-tf2.9.2-torch1.11.0`                                        | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |  perception  | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-desktop-tf2.9.2-torch1.11.0`                                           | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `rolling-desktop-full-tf2.9.2-torch1.11.0`                                      | amd64<br>arm64 | 20.04.5 | 3.8.10 | rolling | desktop-full | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `foxy-tf2.9.2-torch1.11.0`, `foxy-ros-core-tf2.9.2-torch1.11.0`                 | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-core   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `foxy-ros-base-tf2.9.2-torch1.11.0`                                             | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   ros-base   | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |
| `foxy-desktop-tf2.9.2-torch1.11.0`                                              | amd64<br>arm64 | 20.04.5 | 3.8.10 |  foxy   |   desktop    | 3.16.3 | 11.3.109<br>11.4.239 | 8.2.1<br>8.4.1 | 7.2.3<br>8.4.1 |     1.11.0     | 1.11.0<br>- |  2.9.2<br>2.9.1   |     2.9.2      |

</details>
