FROM ubuntu:latest

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y hugo

RUN mkdir -p /var/local/hugo \
	&& mkdir -p /var/local/public
