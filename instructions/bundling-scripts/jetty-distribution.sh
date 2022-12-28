#!/bin/bash

# Shell script to create zimbra jetty-distribution package


#-------------------- Configuration ---------------------------

    currentScript=`basename $0 | cut -d "." -f 1`                          # jetty-distribution
    currentPackage=`echo ${currentScript}-build`




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
    cd ${repoDir}/packages/thirdparty/${currentScript}
    make all
    find ${repoDir}/packages/thirdparty/${currentScript}/build/ -name "*.${arch}.rpm" -exec mv -v {} ${repoDir}/zm-build/${arch} \;
}


############################################################################
main "$@"