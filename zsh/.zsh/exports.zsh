# Based on http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# Currently this path is appended to dynamically when picking a ruby version
# zshenv has already started PATH with rbenv so append only here
#export PATH=$PATH~/bin:/usr/local/bin:/usr/local/sbin:~/bin

# remove duplicate entries
typeset -U PATH

# Add fpath
if [[ $IS_MAC -eq 1 ]]; then
	fpath=('/usr/local/share/zsh/site-functions' $fpath)
fi

# Setup terminal, and turn on colors
export TERM=xterm-256color

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
if [[ $IS_MAC -eq 1 ]]; then
    export EDITOR='atom'

	export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi

export LOCAL_ROOT_DIR=/opt/root/current
