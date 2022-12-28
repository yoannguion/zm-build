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

  for currentScript in `ls ${repoDir}/packages/thirdparty/`
  do
    cd ${repoDir}/packages/thirdparty/${currentScript}
    make all
  done
  find ${repoDir}/packages/thirdparty/ -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;

}
############################################################################
main "$@"