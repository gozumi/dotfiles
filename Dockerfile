FROM ubuntu:lunar

ENV TZ="BST"

RUN apt-get update

RUN apt-get install \
    bat git zsh curl tmux gcc cmake make sudo fzf bc fd-find ripgrep powerline \
    -y 

ARG USERNAME=developer

RUN adduser ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chsh -s $(which zsh)

USER ${USERNAME}

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y

RUN mkdir /home/${USERNAME}/git-downloads && \
    mkdir -p /home/${USERNAME}/.local/bin && \
    mkdir -p /home/${USERNAME}/.config/nvim && \
    mkdir -p /home/${USERNAME}/.tmux/plugins

RUN cd /home/${USERNAME}/git-downloads && \
    curl -LO https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz && \
    tar xzvf nvim-linux64.tar.gz

RUN /home/${USERNAME}/.cargo/bin/cargo install git-delta && \
    /home/${USERNAME}/.cargo/bin/cargo install exa

RUN git clone https://github.com/marlonrichert/zsh-autocomplete.git /home/${USERNAME}/git-downloads/zsh-autocomplete
RUN git clone https://github.com/wfxr/forgit.git /home/${USERNAME}/git-downloads/forgit
RUN git clone https://github.com/bigH/git-fuzzy.git /home/${USERNAME}/git-downloads/git-fuzzy
RUN git clone https://github.com/tmux-plugins/tpm /home/${USERNAME}/.tmux/plugins/tpm

COPY --chown=${USERNAME}:${USERNAME} .zshrc /home/${USERNAME}/.zshrc
COPY --chown=${USERNAME}:${USERNAME} git-prompt.sh /home/${USERNAME}/git-downloads/git-prompt.sh
COPY --chown=${USERNAME}:${USERNAME} .tmux.conf /home/${USERNAME}/.tmux.conf
COPY --chown=${USERNAME}:${USERNAME} neovim/init.lua /home/${USERNAME}/.config/nvim/init.lua

RUN ln -s /home/${USERNAME}/git-downloads/nvim-linux64/bin/nvim /home/${USERNAME}/.local/bin/nvim

WORKDIR /home/${USERNAME}
