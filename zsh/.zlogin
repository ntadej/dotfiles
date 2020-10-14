# shellcheck disable=SC1090

# rbenv
[[ -s "$HOME/.rbenv/bin/rbenv" ]] && export PATH="$HOME/.rbenv/bin:$PATH"
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"

# nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# poetry
[[ -s "$HOME/.poetry/bin/poetry" ]] && export PATH="$HOME/.poetry/bin:$PATH"

# Root
init-root

# lxplus/singularity/ATLAS setup
if [[ $IS_LXPLUS -eq 1 || $IS_SINGULARITY -eq 1 ]]; then
  setupATLAS
fi

# local environment
[[ -f "$HOME/.environment" ]] && source "$HOME/.environment"

# linuxbrew
if [[ -d "$HOMEBREW_PREFIX" ]]; then
  if [[ -s "$HOMEBREW_PREFIX/bin/brew" ]]; then
    eval $("$HOMEBREW_PREFIX/bin/brew" shellenv)
  fi
fi
