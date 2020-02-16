FROM debian:latest

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

COPY config/profile.sh /etc/profile.d/profile.sh
COPY config/profile.sh /root/.bashrc
COPY config/profile.sh /root/.bash_profile

RUN apt-get update &&\
    apt-get install -y --no-install-recommends build-essential \
        sudo \
        curl \
        man \
        vim \
        nano \
        less \
        gdb \
        wget \
        ca-certificates \
        openssh-server \
        file \
        valgrind -y &&\
    apt-get update

COPY config/ssh_config /etc/ssh/ssh_config
COPY config/sshd_config /etc/ssh/sshd_config
COPY config/vimconfig /etc/vim/vimrc.local

COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["user", "1234"];
