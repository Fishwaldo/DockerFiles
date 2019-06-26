FROM raspbian/stretch:041518 AS builder

MAINTAINER Justin Hammond <justin@dynam.ac>

WORKDIR /opt
RUN apt-get update && apt-get -y upgrade && apt-get -y install build-essential libfontconfig1-dev libdbus-1-dev libfreetype6-dev libinput-dev libxkbcommon-dev libsqlite3-dev libssl-dev libglib2.0-dev libraspberrypi-dev gperf bison flex libx11-dev libxcb1-dev libxkbcommon-x11-dev libx11-xcb-dev libxext-dev libwayland-dev python2.7 git libxcb-xfixes0-dev && \ 
	wget http://download.qt.io/official_releases/qt/5.12/5.12.4/single/qt-everywhere-src-5.12.4.tar.xz && \
	tar -xJf qt-everywhere-src-5.12.4.tar.xz && \
	mkdir qt-build && \
	cd qt-build 
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 && cd /opt && git clone https://github.com/oniongarlic/qt-raspberrypi-configuration.git && cd qt-raspberrypi-configuration && make install DESTDIR=../qt-everywhere-src-5.12.4 && \
	cd /opt/qt-build && ../qt-everywhere-src-5.12.4/configure -platform linux-rpi-g++ --prefix=/opt/Qt/5.12.4/ --opensource -confirm-license -release -static -optimize-size -syslog -no-use-gold-linker -nomake examples -nomake tests -openssl-runtime -qt-xcb -qt-zlib -qt-libjpeg -qt-libpng -system-freetype -qt-pcre -qt-harfbuzz -fontconfig -qt-xcb -skip qttools
RUN	cd /opt/qt-build/ && make -j6
RUN	cd /opt/qt-build/ && make install
	
FROM raspbian/stretch:041518

MAINTAINER Justin Hammond <justin@dynam.ac>

RUN apt-get update && apt-get -y upgrade && apt-get -y install build-essential git joe mc
	

WORKDIR /opt
COPY --from=builder /opt/Qt /opt/Qt
RUN echo "PATH=$PATH:/opt/Qt/5.12.4/bin" > /etc/profile.d/qt.sh && echo "export PATH" >> /etc/profile.d/qt.sh
	
	