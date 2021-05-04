FROM public.ecr.aws/ubuntu/ubuntu:18.04_stable

# install github and vim--
 RUN apt-get update &&\
     apt-get install sudo -y
 RUN apt-get install -y vim wget gnupg

# skip any interactive configurations during installation--
 ENV DEBIAN_FRONTEND "noninteractive" 
 RUN apt-get install -yq keyboard-configuration

# install gstreamer--
 RUN sudo apt install -y \
     libssl1.1 \
     libgstreamer1.0-0 \
     gstreamer1.0-tools \
     gstreamer1.0-plugins-good \
     gstreamer1.0-plugins-bad \
     gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
     libgstrtspserver-1.0-0 \
     libjansson4

# install cuda
# let docker could use nvidia drivers: see https://github.com/NVIDIA/nvidia-docker/wiki/Usage#non-cuda-image---
 ENV NVIDIA_VISIBLE_DEVICES all  
 ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,video
#RUN apt-get install -y software-properties-common && \  # ubuntu 1804 could work---
#    add-apt-repository ppa:graphics-drivers && apt-get update && \----
#    apt-get install -y nvidia-driver-435----
 RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin && \
     sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
     wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda-repo-ubuntu1804-11-1-local_11.1.0-455.23.05-1_amd64.deb
 RUN sudo dpkg -i cuda-repo-ubuntu1804-11-1-local_11.1.0-455.23.05-1_amd64.deb && \
     sudo apt-key add /var/cuda-repo-ubuntu1804-11-1-local/7fa2af80.pub && \
     sudo apt-get update && \
     sudo apt-get -y install cuda && \
     rm cuda-repo-ubuntu1804-11-1-local_11.1.0-455.23.05-1_amd64.deb

# install tensorrt--

 COPY nv-tensorrt-repo-ubuntu1804-cuda11.1-trt7.2.3.4-ga-20210226_1-1_amd64.deb /root
 RUN sudo dpkg -i /root/nv-tensorrt-repo-ubuntu1804-cuda11.1-trt7.2.3.4-ga-20210226_1-1_amd64.deb
 RUN sudo apt-key add /var/nv-tensorrt-repo-ubuntu1804-cuda11.1-trt7.2.3.4-ga-20210226/7fa2af80.pub 
 RUN sudo apt-get update 
 RUN sudo apt-get install -y tensorrt
 RUN sudo apt-get install -y uff-converter-tf
 RUN sudo apt-get install -y python-libnvinfer-dev
 RUN rm /root/nv-tensorrt-repo-ubuntu1804-cuda11.1-trt7.2.3.4-ga-20210226_1-1_amd64.deb

# install python opencv--
# python is required for librdkafka--
 RUN sudo apt-get install -y python3.7 python3-pip  
 RUN sudo apt-get install python3-pip
 RUN sudo python -m pip install --upgrade pip
 RUN pip3 install opencv-python numpy 
     #ln -s /usr/bin/python3 /usr/bin/python

# install librdkafka---
 RUN sudo apt-get install -y git
 RUN git clone https://github.com/edenhill/librdkafka.git && cd librdkafka &&\
     git reset --hard 7101c2310341ab3f4675fc565f64f0967e135a6a && \
     ./configure && \
     make && sudo make install &&\
     mkdir -p /opt/nvidia/deepstream/deepstream-5.1/lib && \
     sudo cp /usr/local/lib/librdkafka* /opt/nvidia/deepstream/deepstream-5.1/lib && \
     cd .. && rm -r librdkafka

# install deepstream--
# firt download deepstream from this site: https://developer.nvidia.com/deepstream-download--
 COPY deepstream-5.1_5.1.0-1_amd64.deb /root
 RUN sudo apt-get install -y libgstrtspserver-1.0-0 libgstreamer-plugins-base1.0-dev && \
     sudo apt-get install /root/deepstream-5.1_5.1.0-1_amd64.deb && \
     rm /root/deepstream-5.1_5.1.0-1_amd64.deb

# RUN rm -r /var/nv-tensorrt-repo-cuda11.1-trt7.2.3.4-ga-20210226 /var/cuda-repo-10-1-local-10.1.243-418.87.00--