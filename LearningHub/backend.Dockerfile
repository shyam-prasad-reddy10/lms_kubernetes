# Stage 1: Build the app
FROM eclipse-temurin:21-jdk AS builder

# Install Maven inside the builder
RUN apt-get update && apt-get install -y maven

WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml ./
COPY src ./src

# Build the JAR
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 9050

ENTRYPOINT ["java", "-jar", "app.jar"]
