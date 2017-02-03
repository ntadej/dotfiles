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
	sshold -Y lxplus$1.cern.ch -o gssapitrustdns=yes -o UserKnownHostsFile=~/.ssh/known_lxplus -F ~/.ssh/config
}

function f9()
{
	if [[ -z ${1+x} ]]; then
		pc=34
	else
		pc=$1
	fi
	ssh -Y f9pc${pc}.ijs.si -o UserKnownHostsFile=~/.ssh/known_f9
}

# ATLAS
function setupATLAS()
{
	if [[ -z ${ATLAS_LOCAL_ROOT_BASE+x} ]]; then
		export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
	fi
	source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
}
