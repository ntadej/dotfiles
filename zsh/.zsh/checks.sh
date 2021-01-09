# shellcheck disable=SC2034
# Based on http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# checks (stolen from zshuery)
if [[ $(uname) = 'Linux' ]]; then
  IS_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
  IS_MAC=1
fi

if [[ $(hostname) = 'lxplus'* ]]; then
  IS_LXPLUS=1
fi

if [[ $(hostname) = 'naf'* ]]; then
  IS_NAF=1
fi

if [[ -n ${SINGULARITY_CONTAINER+x} ]]; then
  IS_SINGULARITY=1
fi

if [[ -x $(command -v brew) ]]; then
  HAS_BREW=1
fi

if [[ -x $(command -v apt-get) ]]; then
  HAS_APT=1
fi

if [[ -x $(command -v yum) ]]; then
  HAS_YUM=1
fi

if [[ -x $(command -v virtualenv) ]]; then
  HAS_VIRTUALENV=1
fi
