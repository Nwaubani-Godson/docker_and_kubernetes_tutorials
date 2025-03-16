FROM nginx:1.27.0

RUN apt-get update && apt-get install -y vim
RUN apt-get install -y nano && apt-get install -y curl

COPY styles.css /usr/share/nginx/html/styles.css
COPY index.html /usr/share/nginx/html/index.html