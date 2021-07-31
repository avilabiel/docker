FROM node:14 as base

WORKDIR /usr/src/app

COPY ./package*.json ./

RUN npm install

COPY . .

FROM base as web
EXPOSE 3000
CMD [ "npm", "run", "start" ] 



