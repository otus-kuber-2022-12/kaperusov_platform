FROM klakegg/hugo:0.101.0-busybox

WORKDIR /web

COPY . .

ENTRYPOINT hugo serve --bind 0.0.0.0 --port 8000
EXPOSE 8000
