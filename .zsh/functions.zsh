# Singularity
if (( $+commands[singularity] )) && [[ ! $IS_SINGULARITY -eq 1 ]]; then
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
  if [[ $OSTYPE == darwin* ]]; then
		kswitch -p tadej@CERN.CH
	fi

  ssh "lxplus${1}.cern.ch" -o UserKnownHostsFile=~/.ssh/known_lxplus -F ~/.ssh/config_lxplus "${@:2}"
}

function f9()
{
  if [[ $OSTYPE == darwin* ]]; then
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
  if [[ $OSTYPE == darwin* ]]; then
    kswitch -p tadej@DESY.DE
	fi

  if [[ "${1}" == "dev" ]]; then
    ssh -Y "naf-dev" -o UserKnownHostsFile=~/.ssh/known_naf "${@:2}"
  else
    ssh -Y "naf-atlas${1}.desy.de" -o UserKnownHostsFile=~/.ssh/known_naf "${@:2}"
  fi
}

# ATLAS
function setupATLAS()
{
  if [[ -z ${ATLAS_LOCAL_ROOT_BASE+x} ]]; then
	  export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
  fi

  source "${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh"
}
