FROM openjdk:8-jdk-alpine
VOLUME /tmp
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG WAR_FILE
ADD ${WAR_FILE} target/app.war
ENV JAVA_OPTS=""
EXPOSE 9090
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar target/app.war
