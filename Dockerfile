
FROM ubuntu:16.04

MAINTAINER Mark Dessain <mark.dessain@gmail.com>

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    pkg-config \
    libswscale-dev \
    python3-dev \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    python3-pandas \
    python3-nose \
    python3-pip \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libavformat-dev \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN wget https://github.com/Itseez/opencv/archive/3.0.0.zip \
    && unzip 3.0.0.zip \
    && mkdir /opencv-3.0.0/cmake_binary \
    && cd /opencv-3.0.0/cmake_binary \
    && cmake .. \
    && make install \
    && rm /3.0.0.zip \
    && rm -r /opencv-3.0.0

RUN pip3 install jupyter

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

CMD ["sh", "jupyter", "notebook", "--no-browser", "--ip", "*", "--port", "8888"]
