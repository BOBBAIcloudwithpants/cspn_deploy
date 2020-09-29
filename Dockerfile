FROM nvidia/cuda:9.0-cudnn7-devel

RUN rm /etc/apt/sources.list 

COPY sources.list /etc/apt/

RUN apt-get update; exit 0
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y apt-transport-https && \  
  echo 'deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /' > /etc/apt/sources.list.d/cuda.list && \
  apt-get install -y libhdf5-serial-dev hdf5-tools
  
RUN apt-get install -y python3-pip && mkdir ~/.pip

COPY pip.conf ~/.pip/

RUN pip3 install --index-url https://pypi.douban.com/simple --upgrade pip && \
    pip3 install --index-url https://pypi.douban.com/simple h5py pandas matplotlib imageio scikit-image opencv-python

RUN pip install torch==1.2.0+cu92 torchvision==0.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html

CMD [ "/bin/bash" ]


