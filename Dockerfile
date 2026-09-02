FROM ghcr.io/xtls/xray-core:26.7.28

WORKDIR /etc/xray

COPY config.json /etc/xray/config.json

ENV PORT=8080

EXPOSE 8080

CMD ["/usr/local/bin/xray", "run", "-config", "/etc/xray/config.json"]
