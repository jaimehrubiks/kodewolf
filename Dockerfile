FROM nginx:latest

ADD ./source/public/ /usr/share/nginx/html

ADD ./nginx.conf /etc/nginx/nginx.conf