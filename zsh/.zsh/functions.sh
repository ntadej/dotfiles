# Root
function init-root()
{
 if [[ -s $LOCAL_ROOT_DIR ]]; then
   pushd "$LOCAL_ROOT_DIR/bin" > /dev/null || exit
   # shellcheck disable=SC1091
   source thisroot.sh
   popd > /dev/null || exit
 fi
}

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

  ssh "f9pc${pc}.ijs.si" -o UserKnownHostsFile=~/.ssh/known_f9 "${@:2}"
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