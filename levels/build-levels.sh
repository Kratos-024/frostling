#!/bin/bash
# build_levels.sh
# Build Docker images from level directories (level0, level1, ...)

for dir in level*/; do
    # Find Dockerfile case-insensitively
    dockerfilePath=""
    if [[ -f "$dir/Dockerfile" ]]; then
        dockerfilePath="$dir/Dockerfile"
    elif [[ -f "$dir/dockerfile" ]]; then
        dockerfilePath="$dir/dockerfile"
    fi

    if [[ -n "$dockerfilePath" ]]; then
        imageName="child-${dir%/}-image"
        echo "Building Docker image: $imageName from $dockerfilePath"
        docker build -t "$imageName" -f "$dockerfilePath" "$dir"
    else
        echo "No Dockerfile found in $dir, skipping..."
    fi
done
