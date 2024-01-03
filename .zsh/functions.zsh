# Singularity
if (( $+commands[singularity] )) && [[ ! $IS_SINGULARITY -eq 1 ]]; then
  function tn_singularity_zsh()
  {
    if [[ -f ~/.local/bin/zsh ]]; then
      echo ~/.local/bin/zsh
    else
      echo "/bin/zsh"
    fi
  }

  function tn_singularity_paths()
  {
    local paths=""
    if [[ -d /afs ]]; then
      paths="$paths --bind /afs:/afs"
    fi
    if [[ -d /cvmfs ]]; then
      paths="$paths --bind /cvmfs:/cvmfs"
    fi
    if [[ -d /data ]]; then
      paths="$paths --bind /data:/data"
    fi
    if [[ -d /nfs ]]; then
      paths="$paths --bind /nfs:/nfs"
    fi
    if [[ -d /pnfs ]]; then
      paths="$paths --bind /pnfs:/pnfs"
    fi
    if [[ -d /var/data ]]; then
      paths="$paths --bind /var/data:/var/data"
    fi
    if [[ -d /var/tmp ]]; then
      paths="$paths --bind /var/tmp:/var/tmp"
    fi
    if [[ -d /tmp ]]; then
      paths="$paths --bind /tmp:/tmp"
    fi
    if [[ -S /var/run/.heim_org.h5l.kcm-socket ]]; then
      paths="$paths --bind /var/run/.heim_org.h5l.kcm-socket:/var/run/.heim_org.h5l.kcm-socket"
    fi
    if [[ -d "/run/user/$(id -u $USER)" ]]; then
      paths="$paths --bind /run/user/$(id -u $USER):/run/user/$(id -u $USER)"
    fi
    if [[ -d /etc/condor ]]; then
      paths="$paths --bind /etc/condor:/etc/condor"
    fi
    if [[ -d /var/lib/condor/util ]]; then
      paths="$paths --bind /var/lib/condor/util:/var/lib/condor/util"
    fi

    echo "$paths"
  }

  function centos7()
  {
    # Use singularity
    if [[ -n ${SINGULARITY_CENTOS7+x} ]]; then
      singularity exec --pwd "$(pwd)" $(tn_singularity_paths) "$SINGULARITY_CENTOS7" $(tn_singularity_zsh) -l
    fi
  }

  function centos7extra()
  {
    # Use singularity
    if [[ -n ${SINGULARITY_CENTOS7_EXTRA+x} ]]; then
      singularity exec --pwd "$(pwd)" $(tn_singularity_paths) "$SINGULARITY_CENTOS7_EXTRA" $(tn_singularity_zsh) -l
    fi
  }

  function centos7batch()
  {
    # Use singularity
    if [[ -n ${SINGULARITY_CENTOS7_BATCH+x} ]]; then
      singularity exec --pwd "$(pwd)" $(tn_singularity_paths) "$SINGULARITY_CENTOS7_BATCH" $(tn_singularity_zsh) -l
    fi
  }

  function alma9()
  {
    # Use singularity
    if [[ -n ${SINGULARITY_ALMA9+x} ]]; then
      singularity exec --pwd "$(pwd)" $(tn_singularity_paths) "$SINGULARITY_ALMA9" $(tn_singularity_zsh) -l
    fi
  }

  function alma9extra()
  {
    # Use singularity
    if [[ -n ${SINGULARITY_ALMA9_EXTRA+x} ]]; then
      singularity exec --pwd "$(pwd)" $(tn_singularity_paths) "$SINGULARITY_ALMA9_EXTRA" $(tn_singularity_zsh) -l
    fi
  }

  function alma9batch()
  {
    # Use singularity
    if [[ -n ${SINGULARITY_ALMA9_BATCH+x} ]]; then
      singularity exec --pwd "$(pwd)" $(tn_singularity_paths) "$SINGULARITY_ALMA9_BATCH" $(tn_singularity_zsh) -l
    fi
  }
fi

# SSH
function lxplus()
{
  if [[ $OSTYPE == darwin* ]]; then
    kswitch -p tadej@CERN.CH
  fi

  if [[ "${1}" == "dev" ]]; then
    ssh "lxplus-dev" -o UserKnownHostsFile=~/.ssh/known_lxplus "${@:2}"
  else
    ssh "lxplus${1}.cern.ch" -o UserKnownHostsFile=~/.ssh/known_lxplus "${@:2}"
  fi
}

function f9()
{
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

  source "${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh" "${@}"
}
