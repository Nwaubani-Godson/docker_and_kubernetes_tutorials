FROM node:22

WORKDIR /app

COPY package.json /app
COPY package-lock.json /app

RUN npm ci

COPY index.js /app

EXPOSE 3000

CMD ["npm", "start"]