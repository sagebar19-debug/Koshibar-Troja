FROM alpine:3.20

ARG XRAY_VERSION=26.8.3

RUN apk add --no-cache \
    ca-certificates \
    curl \
    unzip \
    bash

WORKDIR /opt/xray

RUN curl -L --fail \
    "https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip" \
    -o /tmp/xray.zip \
    && unzip /tmp/xray.zip -d /opt/xray \
    && chmod +x /opt/xray/xray \
    && rm -f /tmp/xray.zip

COPY config.json /opt/xray/config.json

ENV PORT=8080

EXPOSE 8080

CMD ["/opt/xray/xray", "run", "-config", "/opt/xray/config.json"]
