#!/bin/bash
if [ -z $SENTRY_TOKEN ]
then
	echo "Please Set the SENTRY_TOKEN enviroment variable"
	exit -1
fi
if [ ! -f /usr/local/bin/sentry-cli ]; then
	apt-get update
	apt-get install -y curl
	ARCH=`uname -m`
	if [ "$ARCH" == "aarch64" ]; then
		echo "Installing sentry-cli for arm64"
 		curl http://bamboo.my-ho.st/bamboo/browse/INFRA-SCL/latest/artifact/shared/sentry-cli-arm64/sentry-cli -o /usr/local/bin/sentry-cli
		chmod +x /usr/local/bin/sentry-cli
	elif [ "$ARCH" == "armv7l" ]; then
		echo "Installing sentry-cli for armhf"
		curl http://bamboo.my-ho.st/bamboo/browse/INFRA-SCL/latest/artifact/shared/sentry-cli-armhf/sentry-cli -o /usr/local/bin/sentry-cli
		chmod +x /usr/local/bin/sentry-cli
	else
		echo "Installing sentry-cli for $ARCH"
		curl -sL https://sentry.io/get-cli/ | bash
	fi
fi
mkdir -p /opt/temp/
tar -xvf /opt/debugfiles.tar.xz -C /opt/temp/ --strip-components 4
LIBS+=`ls /opt/temp/*.debug /opt/qt/*/lib/*.so`
echo $LIBS
sentry-cli --auth-token $SENTRY_TOKEN upload-dif -o openzwave -p qt-openzwave $LIBS --wait

