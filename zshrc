# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="travis"

plugins=(git git-prompt)

source $ZSH/oh-my-zsh.sh

[ -s "$HOME/.credentials" ] && . "$HOME/.credentials"

[ -s "$HOME/.aliases" ] && . "$HOME/.aliases"

[ -s "$HOME/.system-specific-aliases" ] && . "$HOME/.system-specific-aliases"

export NVM_DIR="/home/travis/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# eval "$(rbenv init -)"

export PSQL_EDITOR="/usr/bin/vim"
export GOPATH="$HOME/dev"
export JAVA_HOME="/usr/lib/jvm/default"
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$HOME/dev/bin
