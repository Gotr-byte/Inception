FROM debian:12
RUN apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y nginx openssl
COPY ./components/nginx.conf /etc/nginx/nginx.conf
RUN openssl req -x509 -nodes -newkey rsa:4096 -days 365 \
		-out /etc/ssl/certs/pbiederm.42.fr.crt \
		-keyout /etc/ssl/private/pbiederm.42.fr.key \
		-subj "/C=DE/ST=wob/L=Germany/O=42/OU=42/CN=pbiederm.42.fr/UID=pbiederm/"
ENTRYPOINT ["nginx", "-g", "daemon off;"]
