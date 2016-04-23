
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" # This loads nvm
[[ -s "$HOME/server-config/env.sh" ]] && source "$HOME/server-config/env.sh" # This loads server environment variables

# Root
if [[ -s $LOCAL_ROOT_DIR ]]; then
    pushd $LOCAL_ROOT_DIR/bin >/dev/null
    source thisroot.sh
    popd >/dev/null
fi
