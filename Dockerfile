FROM klakegg/hugo:0.92.2-ext-alpine

ARG BASE_URL
ENV BASE_URL_ENV=${BASE_URL}

COPY . /site
WORKDIR /site
ENTRYPOINT hugo serve --baseURL $BASE_URL_ENV --port 80