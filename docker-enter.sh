#!/bin/bash

# Function to print usage
usage() {
    echo "Usage:"
    echo "  $0 <container_name>"
    echo "  $0 -i|--image <image_name>"
    exit 1
}

# Check input arguments
if [[ "$1" == "-i" || "$1" == "--image" ]]; then
    image="${2:?Image name is required}"
    containerId=$(docker ps -qf "ancestor=$image")
    inputType="image"
    inputValue="$image"
elif [[ -n "$1" ]]; then
    name="$1"
    containerId=$(docker ps -qf "name=$name")
    inputType="name"
    inputValue="$name"
else
    usage
fi

# Run command or show error
if [[ -n "$containerId" ]]; then
    docker exec -it "$containerId" bash
else
    echo "No running Docker container found with $inputType: $inputValue"
    exit 2
fi