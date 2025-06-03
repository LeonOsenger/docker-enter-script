# docker-enter-script
A small script that helps you quickly open a shell (`bash`) inside a running Docker container, either by specifying the container **name** or its **image**.

# Usage
Make the script executable:
```bash
chmod +x docker-shell.sh
```
Then run it like this:
By Container Name
```bash
./docker-shell.sh my-container-name
```

By Image Name
```bash
./docker-shell.sh --image my-image-name
# or shorthand
./docker-shell.sh -i my-image-name
```

# Notes
- If multiple containers match (e.g., multiple containers from the same image), the first one found by docker ps is used.
- The script uses docker exec -it ... bash, so the container must have Bash installed.

