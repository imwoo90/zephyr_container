FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

# Search for branch https://github.com/zephyrproject-rtos/zephyr
ARG ZEPHYR_BRANCH=v3.4.0
ENV ZEPHYR_SDK_VER 0.16.1

ARG USERNAME=zephyr
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
ENV USER $USERNAME
ENV GID $USER_GID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -ms /bin/bash $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************
RUN apt install -y tzdata vim wget


# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

WORKDIR /home/${USERNAME}
RUN wget https://apt.kitware.com/kitware-archive.sh
RUN sudo bash kitware-archive.sh
RUN sudo apt install -y --no-install-recommends git cmake ninja-build gperf \
  ccache dfu-util device-tree-compiler wget \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
  make libsdl2-dev libmagic1

RUN pip3 install --upgrade pip
RUN pip3 install --user -U west
RUN echo 'export PATH=~/.local/bin:"$PATH"' >> ~/.bashrc
RUN mkdir ~/zephyrproject
WORKDIR /home/${USERNAME}/zephyrproject
RUN /home/${USERNAME}/.local/bin/west init --mr ${ZEPHYR_BRANCH}
RUN /home/${USERNAME}/.local/bin/west update
RUN /home/${USERNAME}/.local/bin/west zephyr-export
RUN sudo apt install -y python3-progress python3-psutil python3-cbor python3-capstone python3-intervaltree python3-future gcc g++
# RUN pip3 install --user clang-format==15.0.0
RUN pip3 install --user -r ~/zephyrproject/zephyr/scripts/requirements.txt

WORKDIR /home/${USERNAME}
RUN wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_SDK_VER}/zephyr-sdk-${ZEPHYR_SDK_VER}_linux-$(arch)_minimal.tar.xz
RUN tar xvf zephyr-sdk-${ZEPHYR_SDK_VER}_linux-$(arch)_minimal.tar.xz
RUN bash ./zephyr-sdk-${ZEPHYR_SDK_VER}/setup.sh -h -c -t arm-zephyr-eabi

RUN echo . ${HOME}/zephyrproject/zephyr/zephyr-env.sh >> ~/.bashrc
RUN echo . ${HOME}/zephyr-sdk-${ZEPHYR_SDK_VER}/environment-setup-$(arch)-pokysdk-linux >> ~/.bashrc