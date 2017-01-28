FROM ubuntu:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget

RUN wget "https://github.com/spf13/hugo/releases/download/v0.18.1/hugo_0.18.1-64bit.deb" -O hugo_0.18.1-64bit.deb && dpkg -i hugo_0.18.1-64bit.deb

RUN mkdir -p /var/local/hugo

CMD ["hugo", "serve", "-wDs", "/var/local/hugo/", "--bind=0.0.0.0"]
