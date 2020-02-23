# shellcheck disable=SC1090

# rbenv
[[ -s "$HOME/.rbenv/bin/rbenv" ]] && export PATH="$HOME/.rbenv/bin:$PATH"
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"

# nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# Root
init-root

# lxplus/singularity/ATLAS setup
if [[ $IS_LXPLUS -eq 1 || $IS_SINGULARITY -eq 1 ]]; then
  setupATLAS
fi

# local environment
[[ -f "$HOME/.environment" ]] && source "$HOME/.environment"
