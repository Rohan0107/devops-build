#!/bin/bash
echo "Stopping existing container..."
docker stop devops-build-container 2>/dev/null || true
docker rm devops-build-container 2>/dev/null || true

echo "Deploying new container..."
docker run -d --name devops-build-container -p 80:80 devops-build
echo "Deployment complete! App running on port 80"