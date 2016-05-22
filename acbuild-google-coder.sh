#!/bin/bash
set -e -E -o pipefail

real_acbuild=$(type -p acbuild)
function acbuild {
    sudo $real_acbuild "$@"
}

# In the event of the script exiting, end the build
trap "{ export EXT=$?; acbuild --debug end && exit $EXT; }" EXIT

acbuild begin
acbuild set-name quay.io/schlomo/google-coder
acbuild dependency add quay.io/coreos/alpine-sh
acbuild port add http tcp 8080
acbuild port add https tcp 8081
acbuild run -- apk update
acbuild run -- apk upgrade
acbuild run -- apk add openssl
acbuild run -- apk add nodejs
(
    rm -Rf work    
    mkdir -p work
    cd work
    curl -o coder-master.zip https://codeload.github.com/googlecreativelab/coder/zip/master
    unzip coder-master
    cd coder-master
    sed -i -e 's/util.print/console.log/g' coder-base/server.js
    cd coder-apps
    ./install_common.sh ../coder-base
)
acbuild copy-to-dir work/coder-master/coder-base/* config.js /coder
acbuild run -- /bin/sh -c "cd /coder && npm install"
acbuild set-working-dir /coder
acbuild set-exec -- /usr/bin/node /coder/server.js
acbuild write --overwrite google-coder-latest.aci

