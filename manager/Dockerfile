# CPA Manager Plus on Railway: upstream image seakee/cpa-manager-plus v1.14.10 (pinned by digest)
# + a start wrapper that listens on Railway's PORT. Data (SQLite + data.key) lives on the /data volume.
FROM seakee/cpa-manager-plus:1.14.10@sha256:0e803f21d51aceea7b752686417bf57f40678d8068fe102ba23cb2a3afb414e1
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod 755 /usr/local/bin/railway-start.sh
ENV USAGE_DATA_DIR=/data \
    USAGE_DB_PATH=/data/usage.sqlite \
    CPA_MANAGER_DATA_KEY_PATH=/data/data.key \
    USAGE_COLLECTOR_MODE=auto \
    USAGE_RESP_QUEUE=usage \
    USAGE_RESP_POP_SIDE=right \
    USAGE_BATCH_SIZE=100 \
    USAGE_POLL_INTERVAL_MS=500 \
    USAGE_QUERY_LIMIT=50000 \
    TZ=UTC
EXPOSE 18317
ENTRYPOINT ["/usr/local/bin/railway-start.sh"]
