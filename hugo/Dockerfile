FROM ubuntu:latest

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y hugo

RUN mkdir -p /var/local/hugo

ENTRYPOINT ["hugo", "serve", "-wDs", "/var/local/hugo/", "--bind=0.0.0.0"]