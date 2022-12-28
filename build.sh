#!/bin/bash
#
#############
# Variables #
#############
LIST_DEFAULT_TAG=8.8.15.p36,8.8.15.p35,8.8.15.p34,8.8.15.p33,8.8.15.p32,8.8.15.p31,8.8.15.p30,8.8.15.p29,8.8.15.p28,8.8.15.p27,8.8.15.p26,8.8.15.p25,8.8.15.p24.1,8.8.15.p24,8.8.15.p23,8.8.15.p22,8.8.15.p21,8.8.15.p20,8.8.15.p19,8.8.15.p18,8.8.15.p17,8.8.15.p16,8.8.15.p15,8.8.15.p14,8.8.15.p13,8.8.15.p12,8.8.15.p11,8.8.15.p10,8.8.15.p9,8.8.15.p8,8.8.15.p7,8.8.15.p6,8.8.15.p5,8.8.15.p4,8.8.15.p3,8.8.15.p2,8.8.15.p1,8.8.15
PATCHNO=36

#########################################
# DON"T EDIT ANYTHING BELOW THESE LINES #
#########################################

build_zimbra() {
  #ENV_CACHE_CLEAR_FLAG=true
  $(dirname $0)/build.pl --ant-options -DskipTests=true --build-dev-tool-base-dir=/.zm-dev-tools --build-release=JOULE --build-release-no=8.8.15 --build-release-candidate=ZZENO --build-type=FOSS --build-thirdparty-server=files.zimbra.com --git-default-tag=$LIST_DEFAULT_TAG --build-no=$PATCHNO`date +'%Y%m%d'`

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
