ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.1.3

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base
RUN apk add --no-cache \
    git=2.45.2-r0 \
    nginx=1.26.1-r0 \
    nodejs=20.15.1-r0 \
    npm=10.8.0-r0 \
    icu-data-full=74.2-r0

# Copy root filesystem
COPY rootfs /
COPY package.json /

# Install MatterBridge
RUN npm install -g matterbridge@"$(jq -r '.dependencies.matterbridge' < "/package.json")"  matterbridge-zigbee2mqtt@"$(jq -r '.dependencies."matterbridge-zigbee2mqtt"' < "/package.json")" full-icu@1.5.0

RUN chmod -R 775 /var/lib/nginx

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="L2jLiga <l2jliga@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="L2jLiga" \
    org.opencontainers.image.authors="L2jLiga <l2jliga@gmail.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/l2jliga/ha-addons" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

# Healthcheck
ENV HEALTH_PORT="8283" \
    HEALTH_URL=""
HEALTHCHECK \
    --interval=5s \
    --retries=5 \
    --start-period=30s \
    --timeout=25s \
    CMD curl --fail "http://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || exit 1
