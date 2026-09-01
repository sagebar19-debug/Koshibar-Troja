FROM v2fly/v2fly-core:latest

RUN mkdir -p /Koshibar/100%/config \
    /Koshibar/100%/tls

COPY config.json /Koshibar/100%/config/config.json

EXPOSE 443

CMD ["run", "-c", "/Koshibar/100%/config/config.json"]
