# Root
function init-root()
{
	if [[ -s $LOCAL_ROOT_DIR ]]; then
		pushd $LOCAL_ROOT_DIR/bin >/dev/null
		source thisroot.sh
		popd >/dev/null
	fi
}

# SSH
function lxplus()
{
	if [[ $IS_MAC ]]; then
		kswitch -p tadej@CERN.CH
	fi

	ssh lxplus$1.cern.ch -o UserKnownHostsFile=~/.ssh/known_lxplus -F ~/.ssh/config_lxplus ${@:2}
}

function lxplus7()
{
	if [[ $IS_MAC ]]; then
		kswitch -p tadej@CERN.CH
	fi

	ssh lxplus7.cern.ch -o UserKnownHostsFile=~/.ssh/known_lxplus -F ~/.ssh/config_lxplus ${@:1}
}

function f9()
{
	if [[ $IS_MAC ]]; then
		kswitch -p tadej@F9.IJS.SI
	fi

	if [[ -z ${1+x} ]]; then
		pc=19
	else
		pc=$1
	fi
	ssh f9pc${pc}.ijs.si -o UserKnownHostsFile=~/.ssh/known_f9 ${@:2}
}

# ATLAS
function setupATLAS()
{
	if [[ -z ${ATLAS_LOCAL_ROOT_BASE+x} ]]; then
		export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
	fi
	source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
}
