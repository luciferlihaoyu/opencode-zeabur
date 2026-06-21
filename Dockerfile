FROM node:20-slim AS builder

WORKDIR /app
RUN npm install -g opencode-ai

FROM node:20-slim

WORKDIR /app

COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=builder /usr/local/bin/opencode /usr/local/bin/opencode

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY opencode.json /app/opencode.json

ENV NODE_ENV=production
ENV OPENCODE_SERVER_HOSTNAME=0.0.0.0

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
