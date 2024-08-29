# Use the official Jenkins base image with LTS version
FROM jenkins/jenkins:lts

# Switch to root user to install dependencies
USER root

# Install Docker inside the Jenkins container
RUN apt-get update && \
    apt-get install -y docker.io curl unzip && \
    apt-get clean

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws/

# Install tini
RUN curl -sSL https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-amd64 -o /sbin/tini && \
    chmod +x /sbin/tini

# Set AWS CLI configuration
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION
RUN mkdir -p /root/.aws && \
    echo "[default]" > /root/.aws/config && \
    echo "region=${AWS_DEFAULT_REGION}" >> /root/.aws/config && \
    echo "[default]" > /root/.aws/credentials && \
    echo "aws_access_key_id=${AWS_ACCESS_KEY_ID}" >> /root/.aws/credentials && \
    echo "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" >> /root/.aws/credentials

# Set the Jenkins home directory as a volume
VOLUME /var/jenkins_home

# Expose Jenkins port
EXPOSE 8080

# Switch back to Jenkins user
USER jenkins

# Start Jenkins server
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
