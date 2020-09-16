#
# jdownloader-2 Dockerfile
#
# https://github.com/daniel0076/docker-jdownloader-2
# Forked from https://github.com/jlesage/docker-jdownloader-2
# Supports aarch64 and tested on Raspberry Pi 4

# Pull base image.
# NOTE: ubuntu has glibc for 7-Zip-JBinding, and better aarch64 package support.
FROM daniel0076/baseimage-gui:ubuntu-20.04-aarch64-v0.1

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=unknown

# Define software download URLs.
ARG JDOWNLOADER_URL=http://installer.jdownloader.org/JDownloader.jar

# Define working directory.
WORKDIR /tmp

# Add 7-Zip-JBinding for aarch64
COPY ./arm64/*.jar /defaults/lib/

# Download JDownloader 2.
RUN \
    add-pkg --virtual build-dependencies wget && \
    mkdir -p /defaults && \
    wget ${JDOWNLOADER_URL} -O /defaults/JDownloader.jar && \
    del-pkg build-dependencies

# Install dependencies.
RUN \
    add-pkg \
        openjdk-8-jre \
        ttf-dejavu \
        # For ffmpeg and ffprobe tools.
        ffmpeg \
        # For rtmpdump tool.
        rtmpdump \
        libasound2

# Maximize only the main/initial window.
RUN \
    sed-patch 's/<application type="normal">/<application type="normal" title="JDownloader 2">/' \
        /etc/xdg/openbox/rc.xml

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/jdownloader-2-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /

# Set environment variables.
ENV APP_NAME="JDownloader 2" \
    S6_KILL_GRACETIME=8000

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/output"]

# Expose ports.
#   - 3129: For MyJDownloader in Direct Connection mode.
EXPOSE 3129

# Metadata.
LABEL \
      org.label-schema.name="jdownloader-2" \
      org.label-schema.description="Docker container for JDownloader 2" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/daniel0076/docker-jdownloader-2" \
      org.label-schema.schema-version="1.0"
