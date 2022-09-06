# it is gonna create a build folder in container as /app/build
FROM node:16-alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# putting the second step automatically indicates that the previous block is ended
FROM nginx
# copy from a different phase
COPY --from=builder /app/build /usr/share/nginx/html

# we don't have to start nginx, when the container is up, it is starting nginx automatically
