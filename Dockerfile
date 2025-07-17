FROM tarantool/tarantool:latest

RUN apt update
RUN apt install -y git gcc build-essential

RUN tt rocks install http

COPY kvs/ /opt/tarantool
