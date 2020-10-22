FROM openjdk:8-jdk-alpine

ADD target/homes-0.0.1-SNAPSHOT.war app.war

EXPOSE 9012

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.war"]
