FROM debian:latest

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

COPY config/profile.sh /etc/profile.d/profile.sh
COPY config/profile.sh /root/.bashrc
COPY config/profile.sh /root/.bash_profile

RUN apt-get update &&\
    apt-get install -y --no-install-recommends build-essential \
        acl \
        aptitude \
        bc \
        bzip2 \
        ca-certificates \
        clang \
        curl \
        doxygen \
        file \
        gcc \
        git \
        g++ \
        gdb \
        gdbserver \
        hexedit \
        joe \
        less \
        lsof \
        lzma \
        lzop \
        make \
        mc \
        man \
        nano \
        openssl \
        openssh-server \
        openssh-client \
        patch \
        pmccabe \
        psmisc \
        rsync \
        sudo \
        screen \
        splint \
        sqlite3 \
        strace \
        unzip \
        valgrind -y \
        vim \
        wget \
        zip \
        zstd \
        libncurses-dev \
        libsdl2-dev \
        libsdl2-gfx-dev \
        libsdl2-image-dev \
        libsdl2-mixer-dev \
        libsdl2-net-dev \
        libsdl2-ttf-dev \
        libgl-dev  \
        libglu-dev \
        freeglut3-dev \
        libssl-dev \
        zlib1g-dev \
        libmariadbclient-dev \
        libpq-dev \
        libsqlite3-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg-dev \
        libexif-dev \
        libexiv2-dev \
        libmediainfo-dev 

COPY config/ssh_config /etc/ssh/ssh_config
COPY config/sshd_config /etc/ssh/sshd_config
COPY config/vimconfig /etc/vim/vimrc.local

COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["user", "1234"];

RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.7/cmake-3.15.7.tar.gz -P /tmp &&\
    cd /tmp &&\
    tar -xzvf cmake-3.15.7.tar.gz &&\
    cd /tmp/cmake-3.15.7 &&\
    ./bootstrap &&\
    make &&\
    make install
