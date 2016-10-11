# rbenv
[[ -s "$HOME/.rbenv/bin/rbenv" ]] && export PATH="$HOME/.rbenv/bin:$PATH"
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"

# nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# server environment variables
[[ -s "$HOME/server-config/env.sh" ]] && source "$HOME/server-config/env.sh"

# Root
if [[ -s $LOCAL_ROOT_DIR ]]; then
    pushd $LOCAL_ROOT_DIR/bin >/dev/null
    source thisroot.sh
    popd >/dev/null
fi

# travis gem
[[ -f "$HOME/.travis/travis.sh" ]] && source "$HOME/.travis/travis.sh"

# lxplus/ATLAS setup
if [[ $IS_LXPLUS -eq 1 ]]; then
	setupATLAS
fi
