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
ENV HOST 0.0.0.0

CMD ["pm2-runtime", "server.js"]
