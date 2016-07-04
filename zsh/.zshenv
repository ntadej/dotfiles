# Mac OS X uses path_helper and /etc/paths.d to preload PATH, clear it out first, and prefer /usr/local
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
    PATH='/usr/local/bin:'$PATH
fi
