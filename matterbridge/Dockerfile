ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.7
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy root filesystem
COPY rootfs /

# Setup base
RUN apk add --no-cache \
    git=2.43.0-r0 \
    nodejs=20.12.1-r0 \
    npm=10.2.5-r0 \
	icu-data-full=74.1-r0

# Install MatterBridge
RUN npm install -g matterbridge@1.2.5 full-icu@1.5.0

# Install MatterBridge Zigbee2MQTT plugin
RUN mkdir /root/MatterBridge
WORKDIR /root/MatterBridge

# hadolint ignore=DL3003
RUN git clone https://github.com/Luligu/matterbridge-zigbee2mqtt.git && \
    cd matterbridge-zigbee2mqtt && \
    git reset --hard 000e7287d70d0a922bf4007992454649130d95f4

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

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
ENV HEALTH_PORT="3000" \
    HEALTH_URL=""
HEALTHCHECK \
    --interval=5s \
    --retries=5 \
    --start-period=30s \
    --timeout=25s \
    CMD curl --fail "http://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || exit 1
