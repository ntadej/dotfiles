# Based on http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# checks (stolen from zshuery)
if [[ $(uname) = 'Linux' ]]; then
	IS_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
	IS_MAC=1
fi

if [[ -n `alias setupATLAS 2> /dev/null` ]]; then
	IS_LXPLUS=1
fi

if [[ ! -z ${SINGULARITY_CONTAINER+x} ]]; then
	IS_SINGULARITY=1
fi

if [[ -x `which brew 2> /dev/null` ]]; then
	HAS_BREW=1
fi

if [[ -x `which apt-get 2> /dev/null` ]]; then
	HAS_APT=1
fi

if [[ -x `which yum 2> /dev/null` ]]; then
	HAS_YUM=1
fi

if [[ -x `which virtualenv 2> /dev/null` ]]; then
	HAS_VIRTUALENV=1
fi
