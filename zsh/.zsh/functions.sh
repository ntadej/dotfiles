function copy_function()
{
  test -n "$(declare -f "$1")" || return 
  eval "${_/$1/$2}"
}

function rename_function()
{
  copy_function "$@" || return
  unset -f "$1"
}

# Singularity
if [[ ! $IS_SINGULARITY -eq 1 ]]; then
  function centos7()
  {
    # Use singularity
    if [[ -n ${SINGULARITY_CENTOS7+x} ]]; then
      if [[ $IS_NAF -eq 1 ]]; then
        singularity exec --contain --pwd "$(pwd)" --bind /afs:/afs --bind /cvmfs:/cvmfs --bind /nfs:/nfs --bind /pnfs:/pnfs "$SINGULARITY_CENTOS7" /bin/zsh -l
      else
        "$SINGULARITY_CENTOS7" /bin/zsh -l
      fi
    fi
  }
fi

# SSH
function lxplus()
{
  if [[ $IS_MAC -eq 1 ]]; then
		kswitch -p tadej@CERN.CH
	fi

  ssh "lxplus${1}.cern.ch" -o UserKnownHostsFile=~/.ssh/known_lxplus -F ~/.ssh/config_lxplus "${@:2}"
}

function f9()
{
  if [[ $IS_MAC -eq 1 ]]; then
    kswitch -p tadej@F9.IJS.SI
	fi

  if [[ -z ${1+x} ]]; then
	  pc=19
  else
	  pc=$1
  fi

  ssh -Y "f9pc${pc}.ijs.si" -o UserKnownHostsFile=~/.ssh/known_f9 "${@:2}"
}

function naf()
{
  if [[ $IS_MAC -eq 1 ]]; then
    kswitch -p tadej@DESY.DE
	fi

  ssh -Y "naf-atlas${1}.desy.de" -o UserKnownHostsFile=~/.ssh/known_naf "${@:2}"
}

# ATLAS
function setupATLAS()
{
  if [[ -z ${ATLAS_LOCAL_ROOT_BASE+x} ]]; then
	  export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
  fi

  # shellcheck disable=SC1090
  source "${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh"
}
