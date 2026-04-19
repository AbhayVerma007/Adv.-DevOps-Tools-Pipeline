# Stage 1: Runtime
FROM eclipse-temurin:21-jre-jammy

# 1. Create a security group and a non-root user
# This prevents an attacker from gaining root access to your host if the app is compromised.
RUN useradd -m -u 1001 appuser

# 2. Set the working directory
WORKDIR /app

# 3. Add the compiled JAR from the staging directory
# Note: Maven deploy creates this specific nested path based on your GroupID and ArtifactID.
ADD jarstaging/com/satish/demo-workshop/2.1.2/demo-workshop-2.1.2.jar sample_app.jar

# 4. Grant the non-root user ownership of the application file
RUN chown appuser:appuser sample_app.jar

# 5. Switch to the non-root user
USER appuser

# 6. Execute the application
# We use the exec form of ENTRYPOINT for better signal handling (Ctrl+C, etc.)
ENTRYPOINT ["java", "-jar", "sample_app.jar"]
