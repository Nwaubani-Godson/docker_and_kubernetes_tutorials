FROM node:22-alpine

WORKDIR /app

COPY package*.json /app

RUN npm ci

COPY . /app

ENV PORT=5000

EXPOSE 5000

CMD ["node", "src/index.js"]