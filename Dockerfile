# Build the theme
FROM node:16-bullseye-slim as build-theme

COPY ["./themes/kitsune", "./theme"]
WORKDIR /theme

RUN npm install
RUN npm run build

# Serve the site
FROM klakegg/hugo:0.92.2-ext-alpine

ENV BASE_URL=localhost

COPY . /site
COPY --from=build-theme /theme /site/themes/kitsune
WORKDIR /site

ENTRYPOINT hugo serve --baseURL $BASE_URL --port 80 --appendPort=false --minify --gc --disableLiveReload