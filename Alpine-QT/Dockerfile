FROM alpine:latest AS builder

MAINTAINER Justin Hammond <justin@dynam.ac>

WORKDIR /opt
RUN apk add --update alpine-sdk openssl-dev mesa-dev libxkbcommon-static libxkbcommon-dev libxcomposite-dev libxcursor-dev libxi-dev libinput-dev freetype-static freetype-dev fontconfig-static fontconfig-dev linux-headers openssl-libs-static && \
	wget http://download.qt.io/official_releases/qt/5.12/5.12.4/single/qt-everywhere-src-5.12.4.tar.xz && \
	tar -xJf qt-everywhere-src-5.12.4.tar.xz && \
	mkdir qt-build && \
	cd qt-build
RUN apk add --update libxkbcommon-static gperf bison flex python2
RUN cd qt-build && ../qt-everywhere-src-5.12.4/configure --prefix=/opt/Qt/5.12.4/ --opensource -confirm-license -release -static -optimize-size -syslog -no-use-gold-linker -nomake examples -nomake tests -openssl-runtime -qt-xcb -qt-zlib -qt-libjpeg -qt-libpng -system-freetype -qt-pcre -qt-harfbuzz -fontconfig
RUN cd qt-everywhere-src-5.12.4/qtlocation/ && wget https://git.alpinelinux.org/aports/plain/community/qt5-qtlocation/fix-build.patch && patch -p1 < fix-build.patch
RUN cd qt-build && make -j20
RUN cd qt-build && make install
	
FROM alpine:latest

MAINTAINER Justin Hammond <justin@dynam.ac>

RUN apk add --update alpine-sdk joe mc

WORKDIR /opt
COPY --from=builder /opt/Qt /opt/Qt
RUN echo "PATH=$PATH:/opt/Qt/5.12.4/bin" > /etc/profile.d/qt.sh && echo "export $PATH" >> /etc/profile.d/qt.sh
	
	