zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

# fpath=(~/.zsh/completion $fpath)

# Set up the prompt

setopt autocd

# set up git prompt
autoload -Uz add-zsh-hook vcs_info

source ~/git-downloads/git-prompt.sh

function precmd () {
  add-zsh-hook precmd vcs_info
}

zstyle ':vcs_info:git*' formats "%b %m"
setopt PROMPT_SUBST

RPROMPT=%F{242}\$vcs_info_msg_0_
PROMPT="%F{33}%n@%m %F{99}%2~%F{white}"$'\n'"%# "
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'


setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Add update fpath
fpath+=~/.zfunc

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"

if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#   alias ls='ls --color'
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi

# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

alias bat=batcat
alias ls="ls --color=auto"
alias l="ls -al"
alias tmux="tmux -2"

source $HOME/git-downloads/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export LANG=en_GB.UTF-8
export PATH=$HOME/.local/bin:$HOME/git-downloads/git-fuzzy/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f $HOME/.fzf.zsh ] && source ~/.fzf.zsh

[ ! -d $HOME/.zfunc ] && mkdir $HOME/.zfunc 
[ ! -f $HOME/.zfunc/_rustup ] && rustup completions zsh > $HOME/.zfunc/_rustup 
[ ! -f $HOME/.zfunc/_cargo ] && rustup completions zsh cargo > $HOME/.zfunc/_cargo

[ -s $HOME/git-downloads/forgit/forgit.plugin.zsh ] && source $HOME/git-downloads/forgit/forgit.plugin.zsh

# Powerline configuration
if [ -f /usr/share/powerline/bindings/zsh/powerline.zsh ]; then
  echo "Running powerline!"
  . /usr/share/powerline/bindings/zsh/powerline.zsh
fi

