FROM ubuntu:24.04

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get install -y \
    sudo \
    nano \
    wget \
    curl \
    git \
    sudo \
    nano \
    wget \
    curl \
    git \
    build-essential \
    gcc \
    openjdk-21-jdk \
    mono-complete \
    python3 \
    strace \
    valgrind


RUN useradd -G sudo -m -d /home/martin -s /bin/bash -p "$(openssl passwd -1 123)" martin

USER martin
WORKDIR /home/martin

RUN mkdir hacking \
    && ls -la \
    && cd hacking \
    && curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh -o pawned.sh \
    && chmod 764 pawned.sh \
    && ls -la \
    && cd ..

RUN git config --global user.email "martingoberg@gmail.com" \
    && git config --global user.name "mgoberg" \
    && git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
    && mkdir -p github.com/mgoberg/sem02v24

USER root
RUN curl -SL https://golang.org/dl/go1.17.1.linux-amd64.tar.gz -o go.tar.gz \
    && tar xvzf go.tar.gz -C /usr/local \
    && rm go.tar.gz

USER martin
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/martin/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf \
| sh -s -- -y
ENV PATH="${PATH}:${HOME}/.cargo/bin"
