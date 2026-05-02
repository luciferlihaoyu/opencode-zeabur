FROM ghcr.io/anomalyco/opencode:latest AS opencode

FROM alpine:3.20

RUN apk add --no-cache \
    libgcc libstdc++ ripgrep \
    curl bash git ca-certificates

# 安装 ttyd
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then TTYD_ARCH="x86_64"; \
    elif [ "$ARCH" = "aarch64" ]; then TTYD_ARCH="aarch64"; fi && \
    curl -fsSL -o /usr/local/bin/ttyd \
      "https://github.com/nicm/ttyd/releases/download/1.7.7/ttyd.${TTYD_ARCH}" && \
    chmod +x /usr/local/bin/ttyd

# 从官方镜像拷贝 opencode 二进制
COPY --from=opencode /usr/local/bin/opencode /usr/local/bin/opencode

RUN opencode --version

WORKDIR /workspace

EXPOSE 7681

CMD ["ttyd", "--writable", "--once", "opencode"]
