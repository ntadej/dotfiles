# Apptainer
if (( $+commands[apptainer] || $+commands[singularity] )) && [[ ! $IS_APPTAINER -eq 1 ]]; then
  function tn_apptainer_zsh()
  {
    if [[ -f ~/.local/bin/zsh ]]; then
      echo ~/.local/bin/zsh
    else
      echo "/bin/zsh"
    fi
  }

  function tn_apptainer_paths()
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

    # to disable (auto)-mounting
    # paths="$paths --no-mount /exa5"

    echo "$paths"
  }

  function tn_apptainer_run()
  {
    local command
    if (( $+commands[apptainer] )); then
      command="apptainer"
    elif (( $+commands[singularity] )); then
      command="singularity"
    else
      return
    fi

    if (( $+commands[zshs] )) && [[ -n ${2+x} ]]; then
      $command exec --pwd "$(pwd)" $(tn_apptainer_paths) "$1" $(which zshs) $2 -l
    else
      $command exec --pwd "$(pwd)" $(tn_apptainer_paths) "$1" $(tn_apptainer_zsh) -l
    fi
  }

  function podman_to_apptainer()
  {
    if [[ -z ${2+x} ]]; then
      echo "Two arguments are required!"
    fi

    podman save --format oci-archive "$1" -o "$2.tar"
    apptainer build "$2.sif" "oci-archive://$2.tar"
  }

  function centos7()
  {
    if [[ -n ${APPTAINER_CENTOS7+x} ]]; then
      tn_apptainer_run "$APPTAINER_CENTOS7" ${1}
    fi
  }

  function centos7extra()
  {
    if [[ -n ${APPTAINER_CENTOS7_EXTRA+x} ]]; then
      tn_apptainer_run "$APPTAINER_CENTOS7_EXTRA" ${1}
    fi
  }

  function centos7batch()
  {
    if [[ -n ${APPTAINER_CENTOS7_BATCH+x} ]]; then
      tn_apptainer_run "$APPTAINER_CENTOS7_BATCH" ${1}
    fi
  }

  function alma9()
  {
    if [[ -n ${APPTAINER_ALMA9+x} ]]; then
      tn_apptainer_run "$APPTAINER_ALMA9" ${1}
    fi
  }

  function alma9extra()
  {
    if [[ -n ${APPTAINER_ALMA9_EXTRA+x} ]]; then
      tn_apptainer_run "$APPTAINER_ALMA9_EXTRA" ${1}
    fi
  }

  function alma9batch()
  {
    if [[ -n ${APPTAINER_ALMA9_BATCH+x} ]]; then
      tn_apptainer_run "$APPTAINER_ALMA9_BATCH" ${1}
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

  ssh "f9pc${pc}.ijs.si" -o UserKnownHostsFile=~/.ssh/known_f9 "${@:2}"
}

function naf()
{
  if [[ $OSTYPE == darwin* ]]; then
    kswitch -p tadej@DESY.DE
  fi

  if [[ "${1}" == "dev" ]]; then
    ssh "naf-dev" -o UserKnownHostsFile=~/.ssh/known_naf "${@:2}"
  else
    ssh "naf-atlas${1}.desy.de" -o UserKnownHostsFile=~/.ssh/known_naf "${@:2}"
  fi
}

function vega()
{
  if [[ $OSTYPE == darwin* ]]; then
    kswitch -p tadej@SLING.SI
  fi

  if [[ -n ${1+x} ]]; then
    ssh "vglogin000${1}.vega.izum.si" "${@:2}"
  else
    ssh "vega" "${@:2}"
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
