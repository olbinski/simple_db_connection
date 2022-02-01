#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY app /home/app

RUN mvn -f /home/app/pom.xml package
#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY app /home/app

RUN mvn -f /home/app/pom.xml package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build ./target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8181


ENTRYPOINT ["java","-jar", "/usr/local/lib/demo.jar"]