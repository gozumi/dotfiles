FROM ubuntu:lunar

RUN apt-get update

RUN apt-get install \
    bat git neovim zsh curl tmux \
    -y 
ARG USERNAME=developer

RUN adduser ${USERNAME}

RUN chsh -s $(which zsh)

USER ${USERNAME}

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y

RUN mkdir /home/${USERNAME}/git-downloads

RUN git clone https://github.com/marlonrichert/zsh-autocomplete.git /home/${USERNAME}/git-downloads/zsh-autocomplete


COPY .zshrc /home/${USERNAME}/.zshrc
COPY git-prompt.sh /home/${USERNAME}/git-prompt.sh
COPY .tmux.conf /home/${USERNAME}/.tmux.conf

WORKDIR /home/${USERNAME}
