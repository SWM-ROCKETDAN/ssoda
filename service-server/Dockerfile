FROM openjdk:11
ARG JAR_FILE=build/libs/*-SNAPSHOT.jar
COPY ${JAR_FILE} service-server.jar
ENTRYPOINT ["java","-jar","/service-server.jar"]