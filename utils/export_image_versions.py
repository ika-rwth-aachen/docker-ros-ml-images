#!/usr/bin/env python3

import argparse
import os
import subprocess
import tqdm
import csv

VERSION_GETTER_COMMANDS = {
    "Arch": "dpkg --print-architecture",
    "Ubuntu": "lsb_release -d | awk '{print \\$3}'",
    "Python": "python --version | awk '{print \\$2}'",
    "ROS": "echo \\$ROS_DISTRO",
    "ROS Package": "(dpkg -l | grep ros-\\$ROS_DISTRO-desktop-full || dpkg -l | grep ros-\\$ROS_DISTRO-ros-base || dpkg -l | grep ros-\\$ROS_DISTRO-ros-core) | awk '{print \\$2}' | cut -d- -f3-",
    "CMake": "cmake --version | grep version | awk '{print \\$3}'",
    "CUDA": "dpkg -l 2> /dev/null | grep -E 'cuda-cudart-[0-9]' | awk '{ print \\$3 }' | cut -d+ -f1 | cut -d- -f1",
    "cuDNN": "dpkg -l 2> /dev/null | grep -E 'libcudnn[0-9] ' | awk '{ print \\$3 }' | cut -d+ -f1 | cut -d- -f1",
    "TensorRT": "dpkg -l 2> /dev/null | grep -E 'libnvinfer[0-9] ' | awk '{ print \\$3 }' | cut -d+ -f1 | cut -d- -f1",
    "Triton": "echo \\$TRITON_VERSION",
    "PyTorch": "python -c 'exec(\\\"try:\\n  import torch; print(torch.__version__);\\n\\rexcept ImportError:\\n  pass\\\")' | cut -d+ -f1 | cut -d- -f1",
    "TensorFlow": "export TF_CPP_MIN_LOG_LEVEL='1' && python -c 'exec(\\\"try:\\n  import os; import tensorflow as tf; print(tf.__version__);\\n\\rexcept ImportError:\\n  pass\\\")' | cut -d+ -f1 | cut -d- -f1",
}

SCRIPT_PATH = os.path.dirname(os.path.abspath(__file__))

def parse_arguments():
    parser = argparse.ArgumentParser(description="Prints tool versions for docker-ros-ml-images")
    parser.add_argument("images", help="File listing Docker images")
    parser.add_argument("--arch", help="Architecture to filter images", choices=["amd64", "arm64"], required=True)
    return parser.parse_args()

def get_image_list(file_path, arch):
    with open(file_path, "r") as file:
        return [line.strip() for line in file if line.strip().endswith(f"-{arch}")]

def get_tool_versions(image_name, arch):
    result = {}
    for tool, command in VERSION_GETTER_COMMANDS.items():
        try:
            gpu_flag = "--runtime nvidia" if arch == "arm64" else ""
            output = subprocess.check_output(
                f"docker run --rm {gpu_flag} {image_name} bash -c \"{command}\"",
                shell=True,
                stderr=subprocess.STDOUT
            )
            single_line_output = "\\n".join(output.decode("utf-8").strip().splitlines())
            if single_line_output:
                result[tool] = single_line_output
        except subprocess.CalledProcessError as e:
            result[tool] = f"Error: {e.output.decode('utf-8').strip()}"
    return result

def export_to_csv(data, file_path, arch):
    with open(file_path, 'w') as csvfile:
        field_names = ["Tag"] + list(VERSION_GETTER_COMMANDS.keys())
        writer = csv.DictWriter(csvfile, fieldnames = field_names)
        writer.writeheader()
        for image in data:
            image_tag = "`" + image.split("/")[-1].replace(f"-{arch}", "") + "`"
            writer.writerow({"Tag": image_tag, **data[image]})

def main():
    args = parse_arguments()
    image_list_file = args.images
    if not os.path.exists(image_list_file):
        print(f"Error: File {image_list_file} not found.")
        return
    images = get_image_list(image_list_file, args.arch)
    all_versions = {}
    with tqdm.tqdm(images, desc="Getting info") as pbar:
        for image in pbar:
            pbar.set_postfix(image=image)
            all_versions[image] = get_tool_versions(image, args.arch)
    export_to_csv(all_versions, os.path.join(SCRIPT_PATH, f"image_versions-{args.arch}.csv"), args.arch)

if __name__ == "__main__":
    main()
