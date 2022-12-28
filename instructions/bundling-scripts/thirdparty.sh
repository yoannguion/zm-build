#!/bin/bash

# Shell script to create zimbra jetty-distribution package


#-------------------- Configuration ---------------------------

#-------------------- Build Package ---------------------------
main()
{
    CreatePackage "${os}"
}

#-------------------- Util Functions ---------------------------

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/utils.sh"

CreateDebianPackage()
{
    echo "not supported";
    exit 3;

}

CreateRhelPackage()
{

  echo "mkdir -p ${repoDir}/zm-build/${arch}"
  mkdir -p ${repoDir}/zm-build/${arch}

  thirdparty=( aspell aspell-ca clamav cyrus-sasl jetty-distribution httpd memcached openjdk openssl perl-carp-clan perl-compress-raw-bzip2 perl-compress-raw-zlib perl-io-compress perl-list-moreutils perl-mail-spamassassin perl-net-server php )
  for currentScript in ${thirdparty[@]}
  do
    echo "Building RPM ${currentScript} ..."
    cd ${repoDir}/packages/thirdparty/${currentScript}
    make all
  done
  find ${repoDir}/packages/thirdparty/ -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;

}
############################################################################
main "$@"