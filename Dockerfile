FROM node:14 as base

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

CMD ./wrapper_script.sh



