# Root
function init-root()
{
    if [[ -s $LOCAL_ROOT_DIR ]]; then
        pushd $LOCAL_ROOT_DIR/bin >/dev/null
        source thisroot.sh
        popd >/dev/null
    fi
}
