FROM debian:buster-slim

RUN apt-get update
# ignore librevisa libgpib
RUN apt-get install -y git gcc make autoconf automake libtool pkg-config libglib2.0-dev zlib1g-dev libzip-dev libtirpc-dev libserialport-dev libusb-1.0 libhidapi-dev libbluetooth-dev libftdi1 libieee1284-3-dev libglib2.0-dev nettle-dev check doxygen graphviz g++ autoconf-archive python glibmm-2.4-dev cmake libqt5gui5 libglibmm-2.4-dev libsigrokdecode-dev qtbase5-dev qttools5-dev libqt5svg5-dev libboost-dev libboost-filesystem-dev libboost-serialization-dev libboost-test-dev libboost-stacktrace-dev
ADD ./libsigrok /libsigrok
WORKDIR /libsigrok
RUN ./autogen.sh
RUN ./configure
RUN make -j16
# RUN apt-get install -y pulseview
RUN make install
ADD ./pulseview /pulseview
WORKDIR /pulseview
RUN cmake .
RUN make -j16
RUN apt-get install -y libqt5gui5 && \
    rm -rf /var/lib/apt/lists/*
ENV QT_DEBUG_PLUGINS=1
RUN make install
RUN ldconfig
ARG CONTAINER_USER_ID=1000
RUN adduser --disabled-password --gecos "" --uid=${CONTAINER_USER_ID} user
# RUN usermod -a -G dialout ${CONTAINER_USER_ID}
RUN adduser user dialout
RUN apt-get install libcap2-bin