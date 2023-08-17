## Docker Images for CUDA, cuDNN, TensorRT

The Dockerfile in this directory can be used to build Docker images including arbitrary versions of CUDA, cuDNN, and TensorRT, either runtime-only or including dev-libraries. The images are well suited as base images for other Dockerfiles. In this repository, they are used as base images for the machine-learning enabled ROS Docker images.

### Why not use `nvidia/cuda` or `nvcr.io/nvidia/tensorrt`?

NVIDIA releases official CUDA-related Docker images on both DockerHub (e.g., [`nvidia/cuda`](https://hub.docker.com/r/nvidia/cuda)) and their own NGC (e.g., [`nvcr.io/nvidia/tensorrt`](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorrt)). The former offers a variety of different CUDA versions including cuDNN installations, but no support for TensorRT. The latter offers images with CUDA, cuDNN, and TensorRT installed, but uses a monthly update cycle containing only specific versions of those libraries. In contrast, this Dockerfile can be used to build multi-arch combinations of arbitrary CUDA, cuDNN, and TensorRT versions, giving more flexibility.

### Available Images

| Tag                                  |      Arch      | Ubuntu  |  CUDA   | cuDNN | TensorRT |
| ------------------------------------ | :------------: | :-----: | :-----: | :---: | :------: |
| `11.8-cudnn-trt-ubuntu20.04[-devel]` | amd64<br>arm64 | 20.04.6 | 11.8.89 | 8.6.0 |  8.5.3   |
| `11.8-cudnn-trt-ubuntu22.04[-devel]` |     amd64      | 22.04.2 | 11.8.89 | 8.6.0 |  8.5.3   |

### Build

1. Download a cuDNN installer deb-package from [NVIDIA's download page](https://developer.nvidia.com/rdp/cudnn-archive) (login required).
2. Place the cuDNN installer deb-package in this directory and rename it to `cudnn-local-repo-$(dpkg --print-architecture).deb`.
3. Download a TensorRT installer deb-package from [NVIDIA's download page](https://developer.nvidia.com/tensorrt-download) (login required).
4. Place the cuDNN installer deb-package in this directory and rename it to `nv-tensorrt-local-repo-$(dpkg --print-architecture).deb`.
5. Build the Docker image with below command.

```bash
docker buildx build \
    --load \
    --platform $(uname)/$(uname -m) \
    --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
    --build-arg CUDA_VERSION=$CUDA_VERSION \
    --build-arg CUDNN_VERSION=$CUDNN_VERSION \
    --build-arg TENSORRT_VERSION=$TENSORRT_VERSION \
    --build-arg INSTALL_AS_DEV=$INSTALL_AS_DEV \
    --tag rwthika/cuda:$CUDA_VERSION-cudnn-trt-ubuntu$UBUNTU_VERSION \
    .
```
