FROM haskell:8.4.3

ENV DYLD_LIBRARY_PATH=/usr/local/lib

RUN apt-get update && apt-get install -y \
  build-essential autoconf git pkg-config \
  automake libtool curl make g++ unzip \
  && apt-get clean

ENV GRPC_RELEASE_TAG v1.2.0
RUN git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc && \
		cd /var/local/git/grpc && \
    git submodule update --init && \
    echo "--- installing protobuf ---" && \
    cd third_party/protobuf && \
    ./autogen.sh && ./configure --enable-shared && \
    make -j$(nproc) && make -j$(nproc) check && make install && make clean && ldconfig && \
    echo "--- installing grpc ---" && \
    cd /var/local/git/grpc && \
    make -j$(nproc) && make install && make clean && ldconfig
