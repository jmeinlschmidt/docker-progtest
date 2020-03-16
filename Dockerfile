FROM gitlab.fit.cvut.cz:5000/bi-pa2/virtual-machine/pa2vm:latest

USER root

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        file \
        git \
        gdbserver \
        man \
        nano \
        sudo \
        vim

RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.7/cmake-3.15.7.tar.gz -P /tmp &&\
    cd /tmp &&\
    tar -xzvf cmake-3.15.7.tar.gz &&\
    cd /tmp/cmake-3.15.7 &&\
    ./bootstrap &&\
    make &&\
    make install

COPY config/user.sh /tmp/user.sh
RUN chmod a+x /tmp/user.sh && /tmp/user.sh

COPY config/gitconfig /etc/gitconfig
COPY config/ssh_config /etc/ssh/ssh_config
COPY config/sshd_config /etc/ssh/sshd_config
COPY config/vimconfig /etc/vim/vimrc.local

COPY config/profile.sh /root/.bashrc
RUN echo "\"set nolist" >/root/.vimrc

USER progtest

RUN echo "\"set nolist" >/home/progtest/.vimrc
COPY config/profile.sh /home/progtest/.bashrc
