# Work Environment Setup with Docker

This guide provides step-by-step instructions to set up and use a Docker-based development environment, ensuring a consistent and efficient workflow. 

For a detailed discussion on the benefits and necessity of containerized development environments, check out this [article](https://medium.com/@turhan.oz/productivity-and-serenity-in-2025-the-indispensable-containerized-development-environment-3d023dd95ec6).

---

## 1. Build the Docker Image

Run the following commands to build and tag the Docker image:

```bash
docker build -t my-work-env:1.0.0 .
docker tag my-work-env:1.0.0 my-work-env:latest
```

---

## 2. Create a Dedicated Directory

Create a directory on your host machine to store your application files:

```bash
mkdir -p ~/WorkEnvironment/app
```

---

## 3. Run the Docker Container

Start the container with the following command:

```bash
docker run -it --name my-work-env -v "$(pwd)/app:/app" my-work-env:latest zsh
```

### Explanation:
- **`$(pwd)/app`**: Refers to the `app` directory in the current working directory on the host machine.
- **`/app`**: The directory inside the container where the `app` directory is mounted.
- This setup allows files in the `app` directory on the host to be accessible and editable inside the container.

---

## 4. Test the Container

Run the following commands inside the container to verify the setup:

```bash
node -v    # Should show v20.x.x
npm -v     # Should display the npm version
python -V  # Should show Python 3.12.0
git --version
echo $SHELL # Should display /usr/bin/zsh
```

---

## 5. Stop and Remove the Container

To stop and remove the container, use the following commands:

```bash
docker stop my-work-env
docker rm my-work-env
```

---

## 6. Customization

If you're using the **p10k theme** and want to remove the `root@xxxxx` part from the shell prompt, update your `.p10k.zsh` configuration file. Locate and modify the following line:

```bash
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
```

---

## Notes

- Ensure Docker is installed and running on your machine before starting.
- The `app` directory on the host machine will sync with the `/app` directory inside the container, enabling seamless file sharing.

---

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute this software, provided that the original license is included in all copies or substantial portions of the software.
