FROM nix-docker.registry.twcstorage.ru/ci/build/common-build:1.1.0000@sha256:744b3dc2ed14b0f5433746500130c59907d83dddc09d81c3f374b69c79d6c858

LABEL org.opencontainers.image.authors="wizardy.oni@gmail.com"

USER root

# Install nodejs, npm
ARG NODEJS_MAJOR_VERSION=22
ARG NODEJS_VERSION=22.20.0
RUN curl -kLso nodejs_${NODEJS_MAJOR_VERSION}.sh "https://rpm.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" \
    && chmod +x nodejs_${NODEJS_MAJOR_VERSION}.sh \
    && ./nodejs_${NODEJS_MAJOR_VERSION}.sh \
    && microdnf -y --refresh \
                --setopt=install_weak_deps=0 \
                --setopt=tsflags=nodocs \
                --disablerepo=nodesource-nsolid install nodejs-${NODEJS_VERSION} \
    && node --version \
    && npm --version \
    && microdnf clean all \
    && rm -rf /var/cache/dnf /var/cache/yum

USER jenkins
