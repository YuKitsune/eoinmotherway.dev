FROM klakegg/hugo:0.92.2-ext-alpine
COPY . /site
WORKDIR /site
ENTRYPOINT ["hugo", "serve"]