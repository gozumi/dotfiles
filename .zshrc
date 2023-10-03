autoload -Uz compinit
compinit

alias bat=batcat
alias ls="ls --color=auto"
alias l="ls -al"
alias tmux="tmux -2"

source $HOME/git-downloads/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export LANG=en_GB.UTF-8
export PATH=$HOME/.local/bin:$HOME/git-downloads/git-fuzzy/bin:$HOME/.docker/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export PICO_SDK_PATH=$HOME/pico/pico-sdk
export GOPATH=$HOME/go

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f $HOME/.fzf.zsh ] && source ~/.fzf.zsh

[ ! -d $HOME/.zfunc ] && mkdir $HOME/.zfunc 
[ ! -f $HOME/.zfunc/_rustup ] && rustup completions zsh > $HOME/.zfunc/_rustup 
[ ! -f $HOME/.zfunc/_cargo ] && rustup completions zsh cargo > $HOME/.zfunc/_cargo

[ -s $HOME/git-downloads/forgit/forgit.plugin.zsh ] && source $HOME/git-downloads/forgit/forgit.plugin.zsh

