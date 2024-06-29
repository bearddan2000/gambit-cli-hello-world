FROM ubuntu:22.04

ENV PATH /workspace/gabit/bin:$PATH

WORKDIR /workspace

RUN apt update && apt install -y git make clang

RUN git clone https://github.com/gambit/gambit.git

WORKDIR /workspace/gambit

RUN ./configure --enable-single-host

WORKDIR /workspace/gambit/bin

RUN make

WORKDIR /workspace/gambit

RUN make clean
RUN make -j$(nproc)
RUN make check
RUN make install

WORKDIR /code

COPY bin .

# 
# CMD "./run.sh"