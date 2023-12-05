FROM debian:12
RUN apt update &&\
apt install nginx -y
# where do I copy nginx.conf to?
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]