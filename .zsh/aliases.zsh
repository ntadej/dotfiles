# -------------------------------------------------------------------
# directory information
# -------------------------------------------------------------------
alias ls="${aliases[ls]:-ls} -Fh"   # add file type indicator, and put sizes in human readable format
alias ll="${aliases[ls]:-ls} -l"    # same as above, but in long listing format
alias lh="${aliases[ls]:-ls} -d .*" # same as ls, but show hidden files/directories only
alias la="${aliases[ls]:-ls} -A"    # same as ls, but show all files
alias l="${aliases[la]:-la} -l"     # same as above, but n long listing format

# -------------------------------------------------------------------
# Useful helpers
# -------------------------------------------------------------------
alias clear="printf '\033[2J\033[3J\033[1;1H'"
alias path='echo -e ${PATH//:/\\n}' # Print each PATH entry on a separate line
alias synchist='fc -RI'

# -------------------------------------------------------------------
# Useful Mac aliases
# -------------------------------------------------------------------
if [[ $OSTYPE == darwin* ]]; then
  # OS X Quick Look
  alias ql='qlmanage -p 2>/dev/null'
  # Flush Directory Service cache
  alias flushdns='dscacheutil -flushcache'
  # Clean up LaunchServices to remove duplicates in the “Open With” menu
  alias lscleanup='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
  # Clean up download cache
  alias deletedownloadcache='sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* "delete from LSQuarantineEvent"'
  # Clear preferences cache
  alias clearprefcache="killall -u $USER cfprefsd"
  # macOS has no `md5sum`, so use `md5` as a fallback
  (( $+commands[md5sum] )) || alias md5sum='md5'
  # macOS has no `sha1sum`, so use `shasum` as a fallback
  (( $+commands[sha1sum] )) || alias sha1sum='shasum'
  # Recursively delete `.DS_Store` files
  alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"
fi

# -------------------------------------------------------------------
# Tool aliases
# -------------------------------------------------------------------
(( $+commands[root] )) && alias root='root -l' # load ROOT without splash screen

(( $+commands[uproot-browser] )) && alias ub='uproot-browser browse'
(( $+commands[uproot-browser] )) && alias up='uproot-browser plot --iterm'
(( $+commands[uproot-browser] )) && alias ut='uproot-browser tree'
