FROM debian:latest

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
        openssh-server \
        valgrind -y &&\
    apt-get update

COPY config/ssh_config /etc/ssh/ssh_config
COPY config/sshd_config /etc/ssh/sshd_config

COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["user", "1234"];
