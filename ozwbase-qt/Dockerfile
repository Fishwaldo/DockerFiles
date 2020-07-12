FROM debian:buster-slim

RUN apt -y update && apt upgrade && apt -y install joe mc build-essential distcc wget
RUN mkdir /opt/source/ 
WORKDIR /opt/source/
RUN wget https://download.qt.io/official_releases/qt/5.12/5.12.9/single/qt-everywhere-src-5.12.9.tar.xz && tar -xf qt-everywhere-src-5.12.9.tar.xz
RUN apt -y install debhelper autotools-dev libdbus-1-dev libxcb1-dev libx11-xcb-dev libxrender-dev libssl-dev libudev-dev libxkbcommon-dev libfontconfig1-dev libgl1-mesa-dev libgles2-mesa-dev libglib2.0-dev libglu1-mesa-dev libicu-dev pkg-config libatspi2.0-dev libcups2-dev libgtk-3-dev libmtdev-dev unixodbc-dev freetds-dev libmariadb-dev libxkbfile-dev libsqlite3-dev libharfbuzz-dev libxkbcommon-x11-dev libasound2-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev libpulse-dev libproxy-dev libxss-dev libsnappy-dev libsrtp2-dev libflac++-dev libopus-dev libspeex-dev libjsoncpp-dev libvpx-dev re2c libevent-dev libopenal-dev libpq-dev libxcb-xinerama0-dev
RUN apt -y install libmariadbclient-dev libinput-dev gperf bison flex libnss3-dev python
RUN cd /opt/source/qt-everywhere-src-5.12.9 && ./configure -recheck-all -opensource -confirm-license -optimize-size -force-debug-info -no-pch --prefix=/opt/qt/5.12.9/ -nomake examples -nomake tests 
ENV DISTCC_HOSTS='--randomize arm64-1.dmz.dynam.ac arm64-2.dmz.dynam.ac arm64-3.dmz.dynam.ac arm64-4.dmz.dynam.ac arm64-5.dmz.dynam.ac arm64-6.dmz.dynam.ac'
RUN cd /opt/source/qt-everywhere-src-5.12.9 && make CC=distcc CXX=distcc -j 6