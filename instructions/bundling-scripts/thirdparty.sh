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

  thirdparty=( openssl heimdal aspell aspell-ca libmilter libxml2 clamav apr apr-util libevent curl  cyrus-sasl jetty-distribution httpd memcached openjdk perl-carp-clan perl-compress-raw-bzip2 perl-compress-raw-zlib perl-io-compress perl-exporter-tiny perl-list-moreutils  perl-digest-sha1  perl-digest-hmac perl-html-parser perl-crypt-openssl-rsa perl-socket perl-io-socket-inet6 perl-net-dns perl-timedate perl-mailtools perl-mail-dkim perl-netaddr-ip perl-error perl-net-dns-resolver-programmable perl-mail-spf perl-encode-detect perl-net-cidr-lite perl-mail-spamassassin perl-net-server php )
  for currentScript in ${thirdparty[@]}
  do
    echo "Building RPM ${currentScript} ..."
    cd ${repoDir}/packages/thirdparty/${currentScript}
    make all
    find ${repoDir}/packages/thirdparty/${currentScript} -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;
    cd ${repoDir}/zm-build/${arch} && createrepo  --update .
    sudo yum clean all --disablerepo=C6.10-base,C6.10-extras,C6.10-updates,epel
  done


}
############################################################################
main "$@"