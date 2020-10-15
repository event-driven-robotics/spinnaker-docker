FROM eventdrivenrobotics/yarp:focal_v3.4.0

RUN apt update

RUN apt install -y \
	openssh-client \
	gcc-arm-none-eabi \
	python3-tk \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY gitClone8.sh /
RUN ./gitClone8.sh /usr/local/src/spinnvenv

COPY .spynnaker.cfg /root/

# CMD source /usr/local/src/spinnvenv/bin/activate
