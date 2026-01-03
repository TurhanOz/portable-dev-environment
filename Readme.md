# Side-Car : Work Environment Setup with Docker

This guide provides step-by-step instructions to set up and use a Docker-based development environment (side-car), ensuring a consistent and efficient workflow. 

For a detailed discussion on the benefits and necessity of containerized development environments, check out this [article](https://medium.com/@turhan.oz/productivity-and-serenity-in-2025-the-indispensable-containerized-development-environment-3d023dd95ec6).

---

## 1. Build the Docker Image

Run the following commands to build and tag the Docker image:

```bash
docker build -t side-car:1.0.0 .
docker tag side-car:1.0.0 side-car:latest
```

---

## 2. Run the Docker Container

Start the container with the following command:

```bash
docker run -it --name side-car -v "$(pwd)/app:/app" side-car:latest zsh
```

### Explanation:
- **`$(pwd)/app`**: Refers to the `app` directory in the current working directory on the host machine.
- **`/app`**: The directory inside the container where the `app` directory is mounted.
- This setup allows files in the `app` directory on the host to be accessible and editable inside the container.

---

## 3. Connect to the Docker Container
If your container is already running, you can connect to it : 
```bash
docker exec -it side-car zsh
```

### Explanation:
- **exec**: Instructs Docker to run a new process or command inside an already existing and running container.  
- **-it**: (Interactive + TTY) Essential for interacting with the container; it allows you to type commands and see the output in real-time, just like a standard terminal. 
- **side-car**: This is the specific name we assigned to our container using the --name flag during the initial setup.  
- **zsh**: The specific shell we want to launch (since our Dockerfile is pre-configured with Oh My Zsh).  

---

## 4. Test the Container

Run the following commands inside the container to verify the setup:

```bash
node -v    # Should show v20.x.x
npm -v     # Should display the npm version
python -V  # Should show Python 3.12.0
git --version
gh --version
echo $SHELL # Should display /usr/bin/zsh
```

---

## 5. Stop and Remove the Container

To stop and remove the container, use the following commands:

```bash
docker stop side-car
docker rm side-car
```

---

## 6. Customization
### 🐚 Shell Prompt (Powerlevel10k)
To keep your terminal clean, you can remove or customize the `root@hostname` part in the prompt. Edit your `.p10k.zsh` configuration file and look for the `POWERLEVEL9K_CONTEXT_TEMPLATE` variable.

```bash
# To hide the context completely
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE=''

# To show only a custom icon (e.g., a lightning bolt)
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='⚡'
```

### 🐙 GitHub Authentication & Multi-Account
This container is pre-configured with a **Git Credential Helper** linked to the GitHub CLI (`gh`). 

**How it works:** Git will automatically use the `GITHUB_TOKEN` variable currently present in your environment for all operations (`push`, `pull`, `clone`). You will never have to manually enter your username or Personal Access Token (PAT).

#### A. Manual Testing
To quickly test a specific account or token in your current session:
```bash 
export GITHUB_TOKEN=ghp_your_personal_access_token
gh auth status # verify if the token is active and valid
```

#### B. Per-Project Automation (Recommended)
To manage different identities (e.g., **Work** vs. **Personal**) seamlessly without switching sessions, use a `.envrc` file in your project folders. **direnv** will load the correct credentials automatically when you `cd` into the directory.

**Create a file: `/app/my-project/.envrc`**
```bash 
# 1. Local Git Identity for this specific project
export GIT_AUTHOR_NAME="Your Name"
export GIT_AUTHOR_EMAIL="pro@entreprise.com"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# 2. GitHub Token (used by both 'gh' and 'git' commands)
export GITHUB_TOKEN=ghp_YOUR_PAT_TOKEN_FOR_THIS_ACCOUNT
```

> **Note:** After creating or editing a `.envrc` file, you must run `direnv allow` to authorize the environment loading in that folder.
---

### 🦊 GitLab CLI
Currently disabled to prioritize GitHub multi-account efficiency. The glab binary can be added back via the Dockerfile for a later update

---

## 7. Maintainers

- TurhanOz ([@TurhanOz](https://github.com/TurhanOz))

---

## Notes

- Ensure Docker is installed and running on your machine before starting.
- The `app` directory on the host machine will sync with the `/app` directory inside the container, enabling seamless file sharing.

---

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute this software, provided that the original license is included in all copies or substantial portions of the software.
