# 🐳 docker-enter-script
A small and handy script that helps you quickly open a Bash shell inside a running Docker container.
You can connect by:

- **Container name**
- **Image name**
- **Interactive selection** from a list of running containers

# 📦 Requirements
- **Bash shell**
- **Docker installed and running**

# 🚀 Usage
### Make the script executable:
```bash
chmod +x docker-shell.sh
```

### Run the script
_Interactive Mode (no arguments)_ \
Choose a container from a numbered list of all running containers:
``` bash
./docker-shell.sh
```

_By Container Name_ \
Connect directly by specifying the container name:
```bash
./docker-shell.sh my-container-name
```

_By Image Name_ \
Connect to the first running container that was created from the given image:
```bash
./docker-shell.sh --image my-image-name
# or shorthand
./docker-shell.sh -i my-image-name
```

_Help_ \
To see usage instructions:
``` bash
./docker-shell.sh -h
# or shorthand
./docker-shell.sh --help
```

# 📝 Notes
- The script connects using:
`docker exec -it <container> bash`
So the container must have **Bash installed**.
- If multiple containers match (by image or name), the **first** one listed by `docker` ps is used.
- In **interactive mode**, you’ll see a numbered list with container name, image, and status to choose from.

# ✅ Example
```bash
# List running containers and choose one
./docker-shell.sh

# Directly connect to a container named "my_api"
./docker-shell.sh my_api

# Connect to a container from the "nginx" image
./docker-shell.sh -i nginx
```
