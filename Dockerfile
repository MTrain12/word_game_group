#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY ./word_game/src /home/app/src
COPY ./word_game/pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/word_game-0.0.1-SNAPSHOT.jar /usr/local/lib/word_game.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/word_game.jar"]
