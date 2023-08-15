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
