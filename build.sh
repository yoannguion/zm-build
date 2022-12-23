#!/bin/bash
#
#############
# Variables #
#############
LIST_DEFAULT_TAG=9.0.0.p27,9.0.0.p26,9.0.0.p25,9.0.0.p24.1,9.0.0.p24,9.0.0.p23,9.0.0.p22,9.0.0.p21,9.0.0.p20,9.0.0.p19,9.0.0.p18,9.0.0.p17,9.0.0.p16,9.0.0.p15,9.0.0.p14,9.0.0.p13,9.0.0.p12,9.0.0.p11,9.0.0.p10,9.0.0.p9,9.0.0.p8,9.0.0.p7,9.0.0.p6.1,9.0.0.p6,9.0.0.p5,9.0.0.p4,9.0.0.p3,9.0.0.p2,9.0.0.p1,9.0.0
PATCHNO=27

#########################################
# DON"T EDIT ANYTHING BELOW THESE LINES #
#########################################

build_zimbra() {
  #ENV_CACHE_CLEAR_FLAG=true
  $(dirname $0)/build.pl --ant-options -DskipTests=true --build-release=KEPLER --build-release-no=9.0.0 --build-release-candidate=ZZENO --build-type=FOSS --build-thirdparty-server=files.zimbra.com --git-default-tag=$LIST_DEFAULT_TAG --build-no=$PATCHNO`date +'%Y%m%d'`

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
