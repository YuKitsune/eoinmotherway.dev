# Build the CSS
FROM node:16-bullseye-slim as build-css

COPY . /site
WORKDIR /site

RUN npm install
RUN npm run build

# Serve the site
FROM klakegg/hugo:0.92.2-ext-alpine

COPY --from=build-css /site /site

WORKDIR /site

ENV PORT=80
ENV BASE_URL=http://localhost:$PORT

ENTRYPOINT hugo serve --baseURL $BASE_URL --port $PORT --appendPort=false --minify --gc --disableLiveReload