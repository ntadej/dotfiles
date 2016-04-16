# Mac OS X uses path_helper and /etc/paths.d to preload PATH, clear it out first, and prefer /usr/local
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
    PATH='/usr/local/bin:'$PATH
fi

# Add RVM to PATH for scripting, if rvm is present
if which rvm-prompt &> /dev/null; then
    export PATH=$HOME/.rvm/bin:$PATH
fi

# Homebrew command-not-found
if brew command command-not-found-init > /dev/null; then
    eval "$(brew command-not-found-init)";
fi
