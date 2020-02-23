# Based on http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

if [[ $IS_MAC -eq 1 ]]; then
  if [[ -d "/usr/local/opt/ruby/bin" ]]; then
    export RUBY_HOME=/usr/local/opt/ruby/bin
  	export PATH="$RUBY_HOME:$PATH"
  fi
fi

if [[ -d $HOME/.local/bin ]]; then
  export PATH=$HOME/.local/bin:$PATH
fi

# remove duplicate entries
# typeset -U PATH

# Add fpath
if [[ $IS_MAC -eq 1 ]]; then
  # shellcheck disable=SC2206
	fpath=('/usr/local/share/zsh/site-functions' $fpath)
fi

# Setup terminal
export TERM=xterm-256color

# Export hostname
HOSTNAME=$(hostname)
export HOSTNAME

# gnupg
if [[ -S "/run/user/$(id -u)/gnupg/S.gpg-agent" ]]; then
  GNUPG_AGENT_SOCKET="/run/user/$(id -u)/gnupg/S.gpg-agent"
  export GNUPG_AGENT_SOCKET
fi

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
if [[ $IS_MAC -eq 1 ]]; then
  export EDITOR='code'
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  # Enable color in grep
  export GREP_OPTIONS='--color=auto'
  export GREP_COLOR='3;33'
fi

if [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"
fi

# CERN scripts
if [[ -d "$HOME/Workspace/CERNscripts" ]]; then
  export PATH="$HOME/Workspace/CERNscripts/bin:$PATH"
fi

# lxplus/ATLAS specials
if [[ $IS_LXPLUS -eq 1 || $IS_SINGULARITY -eq 1 ]]; then
  export RUCIO_ACCOUNT=tadej
elif [[ $IS_MAC -eq 1 ]]; then
  export LOCAL_ROOT_DIR=/opt/root/current
fi
