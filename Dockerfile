#
# Package stage
#
FROM openjdk:11-jre-slim
COPY ./target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8181


ENTRYPOINT ["java","-jar", "/usr/local/lib/demo.jar"]