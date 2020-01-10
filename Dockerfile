FROM mhart/alpine-node:12

RUN npm install pm2@latest -g && \
	npm install strapi -g

WORKDIR /srv/app

VOLUME /srv/app

RUN ls

COPY ./strapi .

RUN npm install && \
	strapi build

ENV PORT 1337
ENV HOST 127.0.0.1


# RUN curl -I 127.0.0.1:1337/admin


CMD NODE_ENV=development pm2 start server.js --no-autorestart
