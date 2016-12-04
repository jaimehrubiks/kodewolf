FROM ubuntu:latest

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y hugo

RUN mkdir -p /var/local/hugo \
	&& mkdir -p /var/local/public

ENTRYPOINT ["hugo", "serve", "-wDs", "/var/local/hugo/ocean/", "--destination=/var/local/public", "--bind=0.0.0.0"]