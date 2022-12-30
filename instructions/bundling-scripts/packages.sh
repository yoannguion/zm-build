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


  while read p; do
    echo "$p"
  done <${repoDir}/packages/build-order

  for currentScript in ${thirdparty[@]}
  do
    echo "Building RPM ${p} ..."
    cd ${repoDir}/packages/${p}
    make all
    find ${repoDir}/packages/${p} -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;
    cd ${repoDir}/zm-build/${arch} && createrepo  --update .
    sudo yum clean all --disablerepo=C6.10-base,C6.10-extras,C6.10-updates,epel
  done


}
############################################################################
main "$@"