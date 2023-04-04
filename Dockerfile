FROM debian:latest

# load data 
COPY ./umt /umt
COPY ./data /umt/data

# install deps
RUN apt-get update
RUN apt-get install -y apt-file
RUN apt-file update
RUN apt-get install -y vim \
  git \
  curl \
  gpgv \
  pkg-config \
  make build-essential \
  libssl-dev \
  zlib1g-dev  \
  libbz2-dev  \
  libreadline-dev  \
  libsqlite3-dev  \
  wget  \
  llvm \
  libncurses5-dev  \
  libncursesw5-dev  \
  tk-dev  \
  libffi-dev  \
  liblzma-dev \
  libhdf5-103

# install pyenv so we can get python 3.7 bc tensorflow is a PITA
RUN curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN pyenv install 3.7
RUN pyenv global 3.7

# install python deps
ENV PATH="/root/.pyenv/shims:${PATH}"
RUN pip install --upgrade pip
RUN pip install -r umt/requirements.txt

# install tensorflow
RUN bash /umt/install_tensorflow.sh
RUN pip install --no-deps "deep_sort @ https://github.com/proof-by-accident/deep_sort_den/archive/master.zip#egg=deep_sort-1.2.0"
