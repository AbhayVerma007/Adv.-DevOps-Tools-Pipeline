FROM eclipse-temurin:21-jre-jammy

# Non-root user for security — never run Java apps as root in containers
RUN useradd -m -u 1001 appuser

WORKDIR /app

# Copy the built JAR
ADD jarstaging/com/satish/demo-workshop/2.1.2/demo-workshop-2.1.2.jar sample_app.jar

# Set ownership
RUN chown appuser:appuser sample_app.jar

USER appuser

ENTRYPOINT ["java", "-jar", "sample_app.jar"]
