#!/bin/bash
#
#############
# Variables #
#############
LIST_DEFAULT_TAG=10.0.6,10.0.5,10.0.4,10.0.3,10.0.2,10.0.1,10.0.0-GA,10.0.0
PATCHNO=5

#########################################
# DON"T EDIT ANYTHING BELOW THESE LINES #
#########################################

build_zimbra() {
  #ENV_CACHE_CLEAR_FLAG=true
  $(dirname $0)/build.pl --ant-options -DskipTests=true --build-release=NIKOLATESLA --build-release-no=10.0.6 --no-interactive --build-release-candidate=ZZENO --build-type=FOSS --build-thirdparty-server=files.zimbra.com --git-default-tag=$LIST_DEFAULT_TAG --build-no=$PATCHNO`date +'%Y%m%d'`

  # Inform where archive can be found or error message if problem with build
  if [ $? == 0 ]
  then
    echo -e "\nZimbra archive file can be found under  $(realpath $(dirname $0)/../BUILDS)"
    echo -e "You can now unpack this and install/upgrade Zimbra\n"
  else
    echo -e "${YELLOW}\nThere was a problem with the build process, check output above!\n${NORMAL}"
  fi
}

error() {
  echo -e "\nA parameter is required to run this script!"
  echo -e "Use --help for assistance\n"
}

# Colours
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
NORMAL="\e[0m"



build_zimbra
