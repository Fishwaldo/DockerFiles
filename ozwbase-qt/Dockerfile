FROM debian:buster-slim as builder

ARG distcchosts=''
ARG qtversion="5.12.9"
ARG concurrency="12"

ENV DISTCC_HOSTS=$distcchosts

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
	libmariadbclient-dev libinput-dev gperf bison flex libnss3-dev python git

RUN mkdir /opt/source/ 
WORKDIR /opt/source/

RUN wget https://download.qt.io/official_releases/qt/$(echo $qtversion | awk -F. '{ print $1"."$2 }')/$qtversion/single/qt-everywhere-src-$qtversion.tar.xz \
	&& tar -xf qt-everywhere-src-$qtversion.tar.xz

RUN cd /usr/local/bin && ln /usr/bin/distcc gcc && ln /usr/bin/distcc g++

RUN cd /opt/source/qt-everywhere-src-$qtversion \
	&& mkdir build \
	&& cd build \
	&& ../configure \
	-recheck-all \
	-opensource \
	-confirm-license \
	-optimize-size \
	-no-pch \
	--prefix=/opt/qt/$qtversion/ \
	-nomake examples \
	-nomake tests \
	-force-debug-info \
	-separate-debug-info \
	-strip \
	-silent
	

RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtbase -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qttools -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtdeclarative -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtimageformats -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtmultimedia -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtscript -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtsensors -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qt3d -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtconnectivity -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtgamepad -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtlocation -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtquickcontrols2 -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtscxml -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtserialbus -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtwayland -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtxmlpatterns -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make module-qtwebengine -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build/ \
	&& make -j $concurrency
RUN cd /opt/source/qt-everywhere-src-$qtversion/build \
	&& make install
RUN git clone https://github.com/qt/qtmqtt.git \
	&& cd qtmqtt \
	&& git checkout $qtversion \
	&& /opt/qt/$qtversion/bin/qmake QT_BUILD_PARTS="libs tools" CONFIG+=release\
	&& make -j $concurrency \
	&& make install

RUN tar -cJvf debugfiles.tar.xz /opt/qt/$qtversion/**/*debug \
	&& find /opt/qt/$qtversion/ -name "*.debug" -type f -delete \
	&& strip --remove-section=.note.ABI-tag /opt/qt/$qtversion/lib/libQt5Core.so.5

FROM debian:buster-slim

LABEL maintainer="justin@dynam.ac"
WORKDIR /opt

ARG distcchosts=''
ARG qtversion="5.12.9"
ARG concurrency="12"

RUN apt update && \
	apt -y install joe mc git build-essential distcc wget libgl1 libpng16-16 \
	libharfbuzz0b libxkbcommon0 libxkbcommon-x11-0 libice6 libsm6 libxrender1 \
	libfontconfig1 libinput10 libegl1 libmtdev1 libwayland-cursor0 \
	libwayland-client0 libwayland-egl1 libxcomposite1 libpulse0 \
	libpulse-mainloop-glib0 libopus0 libasound2 libxss1 libxcursor1 \
	libsnappy1v5 libjpeg62-turbo libevent-2.1-6 libnspr4 libnss3 \
	libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 libgdk-pixbuf2.0-0 \
	libcairo-gobject2 libatk1.0-0 libpango-1.0-0 \
	libpangocairo-1.0-0 libgtk-3-0 libsybdb5 libpq5 libodbc1 \
	&& echo "/opt/qt/$qtversion/lib" > /etc/ld.so.conf.d/qt.conf \
	&& echo "/opt/lib/" > /etc/ld.so.conf.d/opt.conf \
	&& ldconfig -v

RUN echo "hello $qtversion"
	       
        
COPY --from=builder /opt/qt/$qtversion /opt/qt/$qtversion
COPY --from=builder /opt/source/debugfiles.tar.xz /opt/
ENV PATH "$PATH:/opt/qt/$qtversion/bin"

