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

  zimbra=( apache-components dnscache-components ldap-components mta-components os-requirements perl proxy-components spell-components  )

  for currentScript in ${zimbra[@]}
  do
    echo "Building RPM ${currentScript} ..."
    cd ${repoDir}/packages/zimbra/${currentScript}
    make all
  done
  find ${repoDir}/packages/zimbra/ -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;

}
############################################################################
main "$@"