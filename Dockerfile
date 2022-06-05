# Base Node.js image
FROM node:16-bullseye-slim as base
ENV NODE_ENV=production

FROM base as deps

RUN mkdir /theme
WORKDIR /theme

COPY package.json package-lock.json ./
RUN npm install --production=false

FROM base as production-deps

RUN mkdir /theme
WORKDIR /theme

COPY --from=deps /theme/node_modules /theme/node_modules
COPY package.json package-lock.json ./
RUN npm prune --production

# Build the theme
FROM base as build

RUN mkdir /theme
WORKDIR /theme

COPY --from=deps /theme/node_modules /app/node_modules

COPY . .
RUN npm run build

# Serve the site
FROM klakegg/hugo:0.92.2-ext-alpine

ARG BASE_URL
ENV BASE_URL_ENV=${BASE_URL}

COPY . /site
COPY --from=build /theme /site/themes/kitsune
WORKDIR /site

ENTRYPOINT hugo serve --baseURL $BASE_URL_ENV --port 80 --appendPort=false --minify