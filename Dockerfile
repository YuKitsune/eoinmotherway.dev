# Build the theme
FROM node:16-bullseye-slim as build

COPY ["./themes/kitsune", "./theme"]
WORKDIR /theme

RUN npm install
RUN npm run build

# Serve the site
FROM klakegg/hugo:0.92.2-ext-alpine

ARG BASE_URL
ENV BASE_URL_ENV=${BASE_URL}

COPY . /site
COPY --from=build /theme /site/themes/kitsune
WORKDIR /site

ENTRYPOINT hugo serve --baseURL $BASE_URL_ENV --port 80 --appendPort=false --minify