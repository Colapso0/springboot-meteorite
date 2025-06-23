FROM maven:3.8.5-openjdk-17-slim AS build

WORKDIR /app

# Copiar proyecto
COPY ./stackbones/stack/meteorite/meteorite/pom.xml ./pom.xml
COPY ./stackbones/stack/meteorite/meteorite/src ./src
COPY ./stackbones/stack/meteorite/meteorite/mvnw ./mvnw
COPY ./stackbones/stack/meteorite/meteorite/.mvn ./mvn

RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# Etapa final
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
