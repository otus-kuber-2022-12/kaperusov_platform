FROM klakegg/hugo:0.101.0-debian

RUN \
    groupadd appuser && \
    useradd -r -u 1001 -g appuser appuser && \
    mkdir /web

WORKDIR /web

COPY . .
RUN chown -R appuser:appuser /web
USER appuser

ENTRYPOINT hugo serve --bind 0.0.0.0 --port 8000
EXPOSE 8000
