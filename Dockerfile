FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

#COPY ./sources.list /etc/apt/

RUN apt-get update && apt-get upgrade -y && apt-get -y install apt-utils automake bc bison bsdmainutils build-essential bzip2 ccache chrpath cpio curl debianutils diffstat dosfstools dpkg-dev efitools flex gawk gcc-multilib gettext git git-core g++-multilib gperf locales iputils-ping libbz2-1.0 libbz2-dev libelf-dev libffi-dev libghc-bzlib-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2-utils lzop make maven mtools openjdk-8-jdk optipng pngcrush python python-pip python3 python3-pexpect python3-pip python-mako python-networkx python-lxml sbsigntool schedtool socat squashfs-tools texinfo unzip wget xz-utils zip zlib1g-dev xterm
RUN apt-get -y install openjdk-8-jdk git ccache automake \
       lzop bison gperf build-essential zip curl \
       zlib1g-dev g++-multilib python-networkx \
       libxml2-utils bzip2 libbz2-dev libbz2-1.0 \
       libghc-bzlib-dev squashfs-tools pngcrush \
       schedtool dpkg-dev liblz4-tool make optipng maven \
       libssl-dev bc bsdmainutils gettext python-mako \
       libelf-dev sbsigntool dosfstools mtools
RUN pip install --upgrade pip
RUN pip install pycrypto

RUN ["locale-gen", "en_US.UTF-8"]
RUN ["dpkg-reconfigure", "locales"]

RUN useradd --create-home -s /bin/bash user
WORKDIR /home/user
USER user
RUN mkdir -p ~/bin && curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo
COPY bashrc /home/user/.bashrc

CMD ["/bin/bash"]
