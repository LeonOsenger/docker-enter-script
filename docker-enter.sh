#!/bin/bash

# Function to print usage
usage() {
    echo "Usage:"
    echo "  $0                    # Interactive mode - select from running containers"
    echo "  $0 <container_name>   # Connect directly to named container"
    echo "  $0 -i|--image <image_name>  # Connect to container by image name"
    exit 1
}

# Function to list containers and let user select
interactive_mode() {
    echo "Fetching running Docker containers..."
    
    # Get running containers with custom format
    containers=$(docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}")
    
    # Check if any containers are running
    container_count=$(docker ps -q | wc -l | awk '{print $1}')
    if [[ $container_count -eq 0 ]]; then
        echo "No running Docker containers found."
        exit 1
    fi
    
    echo
    echo "Running Docker containers:"
    echo "---------------------------"
    
    # Display containers with numbers 1-N
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | column -t -s $'\t' | awk 'NR==1{print "  #  "$0; next} {printf "  %d  %s\n", NR-1, $0}'
    
    echo
    echo -n "Enter the number of the container you want to connect to (1-${container_count}): "
    read -r selection
    
    # Validate input
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [[ $selection -lt 1 ]] || [[ $selection -gt $container_count ]]; then
        echo "Invalid selection. Please enter a number between 1 and ${container_count}."
        exit 2
    fi
    
    # Get the container name at the selected index
    container_name=$(docker ps --format "{{.Names}}" | sed -n "${selection}p")
    
    echo "Connecting to container: $container_name"
    docker exec -it "$container_name" bash
}

# Check input arguments
if [[ $# -eq 0 ]]; then
    # No arguments - run interactive mode
    interactive_mode
elif [[ "$1" == "-i" || "$1" == "--image" ]]; then
    image="${2:?Image name is required}"
    containerId=$(docker ps -qf "ancestor=$image")
    inputType="image"
    inputValue="$image"
elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
elif [[ -n "$1" ]]; then
    name="$1"
    containerId=$(docker ps -qf "name=$name")
    inputType="name"
    inputValue="$name"
else
    usage
fi

# Run command or show error (for non-interactive modes)
if [[ -n "$containerId" ]]; then
    docker exec -it "$containerId" bash
elif [[ $# -gt 0 ]]; then
    echo "No running Docker container found with $inputType: $inputValue"
    exit 2
fi
