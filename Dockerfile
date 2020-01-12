FROM node:10-alpine

RUN apk update \
    && apk add \
    build-base \
    libtool \
    autoconf \
    automake \
    pkgconfig \
    nasm \
    libpng-dev libjpeg-turbo-dev giflib-dev tiff-dev \
    zlib-dev \
    && rm -rf /var/cache/apk/*

WORKDIR /usr/src/api
VOLUME /usr/src/api

RUN echo "unsafe-perm = true" >> ~/.npmrc


RUN npm install pm2@latest -g
RUN npm install strapi -g


COPY ./strapi .

RUN npm install
RUN strapi build

EXPOSE 1337
ENV HOST 127.0.0.1

CMD ["pm2-runtime", "server.js"]