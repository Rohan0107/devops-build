#!/bin/bash
echo "Building Docker image..."
docker build -t devops-build .
echo "Build complete!"