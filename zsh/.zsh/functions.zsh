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
	sshold -Y lxplus$1.cern.ch -o gssapitrustdns=yes -o UserKnownHostsFile=~/.ssh/known_lxplus
}

function f9()
{
	ssh f9pc$1.ijs.si -o UserKnownHostsFile=~/.ssh/known_f9
}
