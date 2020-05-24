FROM python:3.7-slim-buster
# Update Debian
RUN apt-get update -y \
	&& apt-get upgrade \
	&& mkdir mystuff

# OpenCV support
RUN pip install opencv-contrib-python

#SSh Support
RUN apt-get install -y openssh-server \
	&& mkdir -p /var/run/sshd \
	&& echo 'root:docker' | chpasswd \
	&& sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get autoclean && apt-get autoremove
EXPOSE 22

CMD /etc/init.d/ssh start && tail -f /dev/null
