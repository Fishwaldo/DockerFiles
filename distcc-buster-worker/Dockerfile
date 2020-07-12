FROM debian:buster-slim

RUN apt -y update && apt -y upgrade && apt -y install joe mc build-essential distcc

ENV HOME=/home/distcc
RUN useradd -s /bin/bash distcc
EXPOSE 3632/tcp 3633/tcp

ENTRYPOINT [\
  "distccd", \
  "--daemon", \
  "--no-detach", \
  "--user", "distcc", \
  "--port", "3632", \
  "--stats", \
  "--stats-port", "3633", \
  "--log-stderr", \
  "--listen", "0.0.0.0"\
]