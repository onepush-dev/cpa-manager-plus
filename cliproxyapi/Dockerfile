# CLIProxyAPI on Railway: upstream image eceasy/cli-proxy-api v8.0.51 (pinned by digest) + a start wrapper
# that keeps config.yaml, OAuth credentials and logs on the /app/data volume and listens on Railway's PORT.
FROM eceasy/cli-proxy-api:v8.0.51@sha256:15d13889e1a39a688be306dfbf2f6cf9003e99cd913b5070fa463f8ab2aa0031
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod 755 /usr/local/bin/railway-start.sh
ENV CPA_DATA_DIR=/app/data \
    WRITABLE_PATH=/app/data \
    TZ=UTC
WORKDIR /CLIProxyAPI
EXPOSE 8317
ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
