FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 9000

ENV NODE_ENV=production
ENV PORT=9000

CMD ["npm", "start"]
