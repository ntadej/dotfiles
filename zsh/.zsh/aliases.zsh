# -------------------------------------------------------------------
# directory movement
# -------------------------------------------------------------------
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias 'bk=cd $OLDPWD'

# directory shortcuts
alias projects='~/Workspace/Projects/'

# -------------------------------------------------------------------
# directory information
# -------------------------------------------------------------------
if [[ $IS_MAC -eq 1 ]]; then
	alias lh='ls -d .*' # show hidden files/directories only
	alias l='ls -Al'
	alias la='ls -A'
	alias ls='ls -GFh' # Colorize output, add file type indicator, and put sizes in human readable format
	alias ll='ls -GFhl' # Same as above, but in long listing format
fi
if [[ $IS_LINUX -eq 1 ]]; then
	alias lh='ls -d .* --color' # show hidden files/directories only
	alias l='ls -Al --color'
	alias la='ls -A --color'
	alias ls='ls -Fh --color' # Colorize output, add file type indicator, and put sizes in human readable format
	alias ll='ls -Fhl --color' # Same as above, but in long listing format
fi

alias lsd="ls -ld *" # show directories
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias 'dirdus=du -sckx * | sort -nr' #directories sorted by size
alias 'dus=du -kx | sort -nr | less' #files sorted by size

alias 'filecount=find . -type f | wc -l' # number of files (not directories)

alias root='root -l' # load ROOT without splash screen

# these require zsh
alias ltd='ls *(m0)' # files & directories modified in last day
alias lt='ls *(.m0)' # files (no directories) modified in last day
alias lnew='ls *(.om[1,3])' # list three newest

# -------------------------------------------------------------------
# Mac only
# -------------------------------------------------------------------
if [[ $IS_MAC -eq 1 ]]; then
	alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look

	# Useful Mac aliases
	alias flushdns="sudo discoveryutil mdnsflushcache;sudo discoveryutil udnsflushcaches;say DNS cache flushed"
	alias deletedownloadcache="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
	alias clearprefcache="killall -u tadej cfprefsd"

	alias inkscape=/Applications/InkscapeConsole.app/Contents/Resources/bin/inkscape
fi

# -------------------------------------------------------------------
# Linux only
# -------------------------------------------------------------------
if [[ $IS_LINUX -eq 1 ]]; then
	alias ls="ls --color=auto"
	alias grep="grep --color=auto"
	alias fgrep="fgrep --color=auto"
	alias egrep="egrep --color=auto"
fi
