FROM ubuntu:lunar

RUN apt-get update

RUN apt-get install \
    bat git zsh curl tmux \
    -y 
ARG USERNAME=developer

RUN adduser ${USERNAME}

RUN chsh -s $(which zsh)

USER ${USERNAME}

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y

RUN mkdir /home/${USERNAME}/git-downloads

RUN cd /home/${USERNAME}/git-downloads && \
    curl -LO https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz && \
    tar xzvf nvim-linux64.tar.gz

RUN git clone https://github.com/marlonrichert/zsh-autocomplete.git /home/${USERNAME}/git-downloads/zsh-autocomplete

RUN mkdir -p /home/${USERNAME}/.local/bin && \
    mkdir -p /home/${USERNAME}/.config/nvim

COPY .zshrc /home/${USERNAME}/.zshrc
COPY git-prompt.sh /home/${USERNAME}/git-prompt.sh
COPY .tmux.conf /home/${USERNAME}/.tmux.conf
COPY neovim/init.lua /home/${USERNAME}/.config/nvim/init.lua

RUN ln -s /home/${USERNAME}/git-downloads/nvim-linux64/bin/nvim /home/${USERNAME}/.local/bin/nvim

WORKDIR /home/${USERNAME}
