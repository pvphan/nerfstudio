FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-devel

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        curl \
        ffmpeg \
        git \
        libsm6 \
        libxext6 \
        pkg-config \
        tar \
        unzip \
        zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone https://github.com/microsoft/vcpkg \
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh \
    && ./vcpkg install colmap[cuda]:x64-linux \
    && cd .. \
    && rm -r vcpkg

WORKDIR /root/nerfstudio

ARG TCNN_CUDA_ARCHITECTURES=61
RUN pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch
RUN pip install nerfstudio==0.1.9
RUN pip install Pillow==9.3.0

