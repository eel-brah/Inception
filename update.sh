#!/bin/bash

# Update all Dockerfile to use the penultimate stable version of alpine

# Fetch the latest stable version of Alpine Linux
LATEST_VERSION=$(curl -s https://alpinelinux.org/releases/ | grep -oP 'v\d+\.\d+' | head -n 1)

# Calculate the penultimate version
MAJOR_VERSION=$(echo $LATEST_VERSION | cut -d. -f1 | tr -d 'v')
MINOR_VERSION=$(echo $LATEST_VERSION | cut -d. -f2)
PENULTIMATE_VERSION="${MAJOR_VERSION}.$((MINOR_VERSION - 1))"

# Output the penultimate version
echo "Penultimate stable version: $PENULTIMATE_VERSION"

# Find all Dockerfiles in the current directory and subdirectories
DOCKERFILES=$(find . -type f -name "Dockerfile")

# Update the Alpine version
for DOCKERFILE in $DOCKERFILES; do
  echo "Updating $DOCKERFILE..."
  sed -i -E "s/(FROM alpine:)[0-9]+\.[0-9]+.*/\1$PENULTIMATE_VERSION/" "$DOCKERFILE"
done

echo "All Dockerfiles updated to use Alpine version $PENULTIMATE_VERSION"
