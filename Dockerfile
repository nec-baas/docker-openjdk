# 1st stage
FROM openjdk:11.0.5

# create minified JDK with jlink.
RUN jlink --module-path ${JAVA_HOME}/jmods \
        --compress=2 \
        --add-modules java.se,jdk.jdi,jdk.httpserver,jdk.unsupported \
        --no-header-files \
        --no-man-pages \
        --output /opt/jdk-min

# 2nd stage
FROM debian:sid-slim


# Install curl, wget, gettext-base(for envsubst)
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl wget aria2 gettext-base \
    && rm -rf /var/lib/apt/lists/*

COPY --from=0 /opt/jdk-min/ /opt/jdk-min/

ENV JAVA_HOME /opt/jdk-min
ENV PATH ${PATH}:${JAVA_HOME}/bin
