FROM fedora:25 AS builder

MAINTAINER Justin Hammond <justin@dynam.ac>

WORKDIR /opt
RUN dnf update -y && \
	dnf groupinstall 'Development Tools' -y && \
	dnf install wget mc joe xz which gcc-c++ gperf bison flex openssl-devel mesa-libGL-devel libXrender-devel libxkbcommon-devel libXcomposite-devel libXcursor-devel libXi-devel libinput-devel freetype-devel fontconfig-devel -y && \
	wget http://download.qt.io/official_releases/qt/5.12/5.12.3/single/qt-everywhere-src-5.12.3.tar.xz && \
	tar -xJf qt-everywhere-src-5.12.3.tar.xz && \
	mkdir qt-build && \
	cd qt-build && \
	../qt-everywhere-src-5.12.3/configure --prefix=/opt/Qt/5.12.3/ --opensource -confirm-license -release -static -optimize-size -syslog -no-use-gold-linker -nomake examples -nomake tests -openssl-runtime -qt-xcb -qt-zlib -qt-libjpeg -qt-libpng -system-freetype -qt-pcre -qt-harfbuzz -fontconfig && \
	cd /opt/qt-build && \
	make -j28 && \
	make install
	
FROM fedora:25

MAINTAINER Justin Hammond <justin@dynam.ac>

RUN dnf update -y && \
	dnf groupinstall 'Development Tools' -y && \
	dnf install wget mc joe xz which gcc-c++ gperf bison flex openssl-devel mesa-libGL-devel libXrender-devel libxkbcommon-devel libXcomposite-devel libXcursor-devel libXi-devel libinput-devel freetype-devel fontconfig-devel -y
WORKDIR /opt
COPY --from=builder /opt/Qt /opt/Qt
RUN echo "PATH=$PATH:/opt/Qt/5.12.3/bin" > /etc/profile.d/qt.sh && echo "export PATH" >> /etc/profile.d/qt.sh
	
	