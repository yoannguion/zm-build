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

  zimbra=( base perl perl-base apache-components dnscache-components ldap-components mta-components os-requirements proxy-components spell-components  )

  for currentScript in ${zimbra[@]}
  do
    echo "Building RPM ${currentScript} ..."
    cd ${repoDir}/packages/zimbra/${currentScript}
    make all
  done
  find ${repoDir}/packages/zimbra/ -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;
  cd ${repoDir}/zm-build/${arch} && createrepo .

sudo bash -c 'cat >  /etc/yum.repos.d/zimbra-build.conf << \EOF
[zimbra-build]
  name=Zimbra Build Repository
  baseurl=file://${repoDir}/zm-build/${arch}
  gpgcheck=0
  enabled=1
EOF'

}
############################################################################
main "$@"