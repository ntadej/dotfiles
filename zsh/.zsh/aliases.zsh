alias st="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

if [[ $IS_MAC -eq 1 ]]; then
	eval "$(hub alias -s)"

	alias ll="ls -lh"
	alias la="ls -A"
	alias l="ls -C"
fi

if [[ $IS_LINUX -eq 1 ]]; then
    alias ls="ls --color=auto"
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"

	alias ll="ls -lh"
	alias la="ls -A"
	alias l="ls -C"
fi
