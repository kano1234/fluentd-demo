FROM adoptopenjdk/openjdk11:slim
WORKDIR /app
COPY build/libs/$JAR_TARGET docker-entrypoint.sh ./
ENTRYPOINT ["./docker-entrypoint.sh"]
