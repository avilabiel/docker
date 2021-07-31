FROM node:14 as base

WORKDIR /usr/src/app

COPY ./package*.json ./

RUN npm install

COPY . .

FROM base as jobserver
CMD [ "npm", "run", "start-jobserver" ]

