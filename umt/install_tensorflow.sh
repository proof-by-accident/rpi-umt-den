#!/bin/bash

ARCH=$(uname -m)
echo $ARCH
if [ $ARCH = "x86_64" ]
then
  echo 'pip install'
  pip install tensorflow==2.4.0 --no-deps
else
  echo 'other branch'
  wget https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.4.0/tensorflow-2.4.0-cp37-none-linux_aarch64.whl
  pip install ./tensorflow-2.4.0-cp37-none-linux_aarch64.whl --no-deps
fi
