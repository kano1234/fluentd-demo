FROM adoptopenjdk/openjdk11:slim
WORKDIR /app
COPY build/libs/$JAR_TARGET docker-entrypoint.sh fluentd/config/fluent.conf ./

RUN apt -y update
RUN apt -y install sudo less systemctl gnupg
RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh

ENTRYPOINT ["./docker-entrypoint.sh"]
