# -------------------------------------------------------------------
# directory movement
# -------------------------------------------------------------------
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias 'bk=cd $OLDPWD'

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

alias lsd='ls -ld *' # show directories
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias dirdus='du -sckx * | sort -nr' # directories sorted by size
alias dus='du -kx | sort -nr | less' # files sorted by size

alias filecount='find . -type f | wc -l' # number of files (not directories)

alias clear="printf '\033[2J\033[3J\033[1;1H'"
alias synchist='fc -RI'

alias root='root -l' # load ROOT without splash screen

# these require zsh
alias ltd='ls *(m0)' # files & directories modified in last day
alias lt='ls *(.m0)' # files (no directories) modified in last day
alias lnew='ls *(.om[1,3])' # list three newest

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# -------------------------------------------------------------------
# Mac only
# -------------------------------------------------------------------
if [[ $IS_MAC -eq 1 ]]; then
  alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look

  # Useful Mac aliases
  # Flush Directory Service cache
  alias flushdns='dscacheutil -flushcache && killall -HUP mDNSResponder'

  # Clean up LaunchServices to remove duplicates in the “Open With” menu
  alias lscleanup='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'

  # Clean up download cache
  alias deletedownloadcache='sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* "delete from LSQuarantineEvent"'

  # Clear preferences cache
  alias clearprefcache='killall -u tadej cfprefsd'

  # macOS has no `md5sum`, so use `md5` as a fallback
  command -v md5sum > /dev/null || alias md5sum='md5'

  # macOS has no `sha1sum`, so use `shasum` as a fallback
  command -v sha1sum > /dev/null || alias sha1sum='shasum'

  # Recursively delete `.DS_Store` files
  alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"
fi

# -------------------------------------------------------------------
# Linux only
# -------------------------------------------------------------------
if [[ $IS_LINUX -eq 1 ]]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
