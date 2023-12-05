FROM debian:12
RUN apt update &&\
apt install nginx -y
# where do I copy nginx.conf to?
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/pbiederm.42.fr.crt /etc/nginx/ssl/
COPY ./tools/pbiederm.42.fr.key /etc/nginx/ssl/
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]