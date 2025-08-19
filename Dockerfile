# Use docker image with Debian Bookworm Slim as the base
FROM debian:bookworm-slim

# Step 1: Install locales and generate them
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    locales \
    # ... toutes tes autres dépendances existantes
    curl \
    git \
    zsh \
    ca-certificates \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python3-openssl && \
    # locale configuration
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen fr_FR.UTF-8 && \
    # APT cache cleanup
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Step 2 : Set environment variables for locale
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:en
ENV LC_ALL fr_FR.UTF-8

# Install NVM (Node Version Manager)
ENV NVM_DIR="/root/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install 20 && \
    nvm alias default 20 && \
    nvm use default

# Instal Pyenv & pyenv-virtualenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv && \
    export PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init -)" && \
    pyenv install 3.12.0 && \
    pyenv global 3.12.0

# Configure ZSH as the default shell for root user
SHELL ["/usr/bin/zsh", "-l", "-c"]

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Powerlevel10k theme for Oh My Zsh
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy .zshrc configuration file inside the container
COPY .zshrc-config /root/.zshrc

# Copy the Powerlevel10k configuration file inside the container
COPY .p10k-zsh-config /root/.p10k.zsh

# Setup the working directory
WORKDIR /app

# Default command when the container starts (launches a Zsh shell)
CMD ["zsh"]