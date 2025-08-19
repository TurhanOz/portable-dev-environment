# Build the Docker image
```
docker build -t my-work-env:1.0.0 .
docker tag my-work-env:1.0.0 my-work-env:latest
```
# Create a dedicated directory
```
mkdir -p ~/WorkEnvironment/app
```

# run the docker container
```
docker run -it --name my-work-env -v "$(pwd)/app:/app" my-work-env:latest zsh
```

This command starts the container and mounts the app directory from the current working directory on the host to the app directory inside the container, enabling file access and edits between the host and container.

# test the container
```
node -v (should show v20.x.x)
npm -v
python -V (should show Python 3.12.0)
git --version
echo $SHELL (should /usr/bin/zsh)
```

# end the container
```
docker stop my-work-env
docker rm my-work-env
```

# customization
To remove the root@xxxxx part from the end of your shell prompt when using the p10k theme, you need to locate the following line in your .p10k-zsh-config file:
```
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
```