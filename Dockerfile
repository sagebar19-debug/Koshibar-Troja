FROM ghcr.io/xtls/xray-core:26.7.28

COPY config.json /usr/local/etc/xray/config.json

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/xray"]
CMD ["run", "-config", "/usr/local/etc/xray/config.json"]
