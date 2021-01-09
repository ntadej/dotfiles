# shellcheck disable=SC1090

# poetry
if [[ -s "$HOME/.poetry/bin/poetry" ]]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

# lxplus/singularity/ATLAS setup
if [[ $IS_LXPLUS -eq 1 || $IS_SINGULARITY -eq 1 ]]; then
  setupATLAS
fi

# local environment
if [[ -f "$HOME/.environment" ]]; then
  source "$HOME/.environment"
fi
