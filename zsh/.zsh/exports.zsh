# Based on http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# macOS system python
if [[ $IS_MAC -eq 1 ]]; then
	export PATH=~/Library/Python/2.7/bin:$PATH
fi

# remove duplicate entries
typeset -U PATH

# Add fpath
if [[ $IS_MAC -eq 1 ]]; then
	fpath=('/usr/local/share/zsh/site-functions' $fpath)
fi

# Setup terminal, and turn on colors
export TERM=xterm-256color

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
if [[ $IS_MAC -eq 1 ]]; then
	export EDITOR='atom'
	export HOMEBREW_CASK_OPTS="--appdir=/Applications"

	# Enable color in grep
	export GREP_OPTIONS='--color=auto'
	export GREP_COLOR='3;33'
fi

export NVM_DIR="$HOME/.nvm"

# CERN scripts
if [[ -d "$HOME/Workspace/CERNscripts" ]]; then
	export PATH="$HOME/Workspace/CERNscripts/bin:$PATH"
fi

# lxplus specials
if [[ $IS_LXPLUS -eq 1 ]]; then
	export RUCIO_ACCOUNT=tadej
else
	export LOCAL_ROOT_DIR=/opt/root/current
fi
