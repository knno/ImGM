function imgm() {
    local arg1=$1
    shift
    npm run $arg1 -- $*
}

function imgm-debug() {
    imgm $* --debug --log-level DEBUG
}
