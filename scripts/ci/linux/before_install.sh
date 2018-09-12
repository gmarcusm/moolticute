#!/bin/bash
set -ev

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPTDIR/../funcs.sh

# Docker
docker pull mooltipass/mc-win-builder
docker pull mooltipass/mc-appimage-builder
docker pull mooltipass/mc-launchpad
docker pull mooltipass/mc-upload

#create certificate from env
echo $CODESIGN_WIN_CERT | base64 -d > $HOME/cert.p12

VERSION=$(get_version)

#setup the source dir for ubuntu deb
rm -fr $HOME/build-debs && mkdir -p $HOME/build-debs
echo $LAUNCHPAD_GPG_PUB | base64 -d > $HOME/build-debs/gpgkey_pub.asc
echo $LAUNCHPAD_GPG_PRIV | base64 -d > $HOME/build-debs/gpgkey_sec.asc
echo $LAUNCHPAD_GPG_PASS | base64 -d > $HOME/build-debs/passphrase.txt

