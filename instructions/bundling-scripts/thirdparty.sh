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

  thirdparty=( aspell aspell-ca clamav apr apr-util libevent openssl heimdal curl libxml2 cyrus-sasl jetty-distribution httpd memcached openjdk perl-carp-clan perl-compress-raw-bzip2 perl-compress-raw-zlib perl-io-compress perl-exporter-tiny perl-list-moreutils  perl-digest-sha1 perl-html-parser perl-mail-dkim perl-net-dns perl-netaddr-ip perl-mail-spf perl-encode-detect perl-net-cidr-lite perl-mail-spamassassin perl-net-server php )
  for currentScript in ${thirdparty[@]}
  do
    echo "Building RPM ${currentScript} ..."
    cd ${repoDir}/packages/thirdparty/${currentScript}
    make all
    find ${repoDir}/packages/thirdparty/${currentScript} -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;
    cd ${repoDir}/zm-build/${arch} && createrepo  --update .
    yum clean all --disablerepo=C6.10-base,C6.10-extras,C6.10-updates,epel
  done


}
############################################################################
main "$@"