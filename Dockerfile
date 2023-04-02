# set base image
#FROM i386/debian:bullseye-20230320-slim
FROM debian:latest

COPY ./umt /umt
COPY ./data /umt/data

RUN alias umt="python /umt/umt_main.py"
RUN alias python="python3"
RUN alias pip="pip3"

RUN apt-get update 
RUN apt-get install -y vim git curl gnupg python3-pip python3-dev python3-setuptools pkg-config


RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update 
RUN apt-get install -y python3-pycoral python3-scipy python3-opencv python3-skimage

RUN pip install --upgrade pip
RUN pip install -r umt/requirements.txt

