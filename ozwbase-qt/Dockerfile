FROM debian:buster-slim as builder

RUN apt -y update && apt upgrade && apt -y install joe mc build-essential \
	distcc wget debhelper autotools-dev libdbus-1-dev libxcb1-dev \
	libx11-xcb-dev libxrender-dev libssl-dev libudev-dev \
	libxkbcommon-dev libfontconfig1-dev libgl1-mesa-dev libgles2-mesa-dev \
	libglib2.0-dev libglu1-mesa-dev libicu-dev pkg-config libatspi2.0-dev \
	libcups2-dev libgtk-3-dev libmtdev-dev unixodbc-dev freetds-dev \
	libmariadb-dev libxkbfile-dev libsqlite3-dev libharfbuzz-dev \
	libxkbcommon-x11-dev libasound2-dev \
	libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev libpulse-dev \
	libproxy-dev libxss-dev libsnappy-dev libsrtp2-dev libflac++-dev \
	libopus-dev libspeex-dev libjsoncpp-dev libvpx-dev re2c \
	libevent-dev libopenal-dev libpq-dev libxcb-xinerama0-dev \
	libmariadbclient-dev libinput-dev gperf bison flex libnss3-dev python
RUN mkdir /opt/source/ 
WORKDIR /opt/source/
RUN wget https://download.qt.io/official_releases/qt/5.12/5.12.9/single/qt-everywhere-src-5.12.9.tar.xz \
	&& tar -xf qt-everywhere-src-5.12.9.tar.xz
ARG distcchosts=''
ENV DISTCC_HOSTS=$distcchosts
RUN cd /usr/local/bin && ln /usr/bin/distcc gcc && ln /usr/bin/distcc g++
RUN cd /opt/source/qt-everywhere-src-5.12.9 \
	&& mkdir build \
	&& cd build \
	&& ../configure \
	-recheck-all \
	-opensource \
	-confirm-license \
	-optimize-size \
	-force-debug-info \
	-no-pch \
	--prefix=/opt/qt/5.12.9/ \
	-nomake examples \
	-nomake tests 

RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtbase -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qttools -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtdeclarative -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtimageformats -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtmultimedia -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtscript -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtsensors -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qt3d -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtconnectivity -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtgamepad -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtlocation -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtquickcontrols2 -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtscxml -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtserialbus -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtwayland -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtxmlpatterns -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make module-qtwebengine -j 12
RUN cd /opt/source/qt-everywhere-src-5.12.9/build/ \
	&& make -j 12

RUN cd /opt/source/qt-everywhere-src-5.12.9/build \
	&& make install
RUN apt -y install git
RUN git clone https://github.com/qt/qtmqtt.git \
	&& cd qtmqtt \
	&& git checkout 5.12.9 \
	&& /opt/qt/5.12.9/bin/qmake QT_BUILD_PARTS="libs tools" CONFIG+=release\
	&& make \
	&& make install	
RUN strip --remove-section=.note.ABI-tag /opt/qt/*/lib/libQt5Core.so.5

FROM debian:buster-slim

LABEL maintainer="justin@dynam.ac"
WORKDIR /opt

RUN apt update && \
	apt -y install joe mc git build-essential \
        distcc wget libgl1 libpng16-16 libharfbuzz0b libxkbcommon0 libxkbcommon-x11-0 libice6 libsm6 libxrender1 libfontconfig1 libinput10 libegl1 libmtdev1 libwayland-cursor0 libwayland-client0 libwayland-egl1 libxcomposite1 libpulse0 libpulse-mainloop-glib0 libopus0 libasound2 libxss1 libxcursor1 libsnappy1v5 libjpeg62-turbo libevent-2.1-6 libnspr4 libnss3 libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 libgdk-pixbuf2.0-0 libcairo-gobject2 libatk1.0-0 libpango-1.0-0 libpangocairo-1.0-0 libgtk-3-0 libsybdb5 libpq5 libodbc1        
        
        

COPY --from=builder /opt/qt/* /opt/qt/

