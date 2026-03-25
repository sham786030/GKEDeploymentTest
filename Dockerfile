# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build
COPY . /app2
WORKDIR /app2
RUN mvn clean package -DskipTests

####

# Stage 2: Change the base image here
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app2
# Copy the jar from the build stage
COPY --from=build /app2/target/*.jar app2.jar

# Expose port 8080 for your Spring Boot app
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app2.jar"]