#!/bin/bash
#
# ***** BEGIN LICENSE BLOCK *****
# Zimbra Collaboration Suite Server
# Copyright (C) 2009, 2010, 2011, 2013, 2014, 2015, 2016 Synacor, Inc.
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software Foundation,
# version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.
# ***** END LICENSE BLOCK *****

# Shell script to create zimbra logger package


#-------------------- Configuration ---------------------------

    currentScript=`basename $0 | cut -d "." -f 1`                          # zimbra-logger
    currentPackage=`echo ${currentScript}build | cut -d "-" -f 2` # loggerbuild


#-------------------- Build Package ---------------------------
main()
{
    echo -e "\tCreate package directories..." >> ${buildLogFile}
    mkdir -p ${repoDir}/zm-build/${currentPackage}/opt/zimbra/logger/db/data

    CreatePackage "${os}"
}

#-------------------- Util Functions ---------------------------

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/utils.sh"

CreateDebianPackage()
{
    mkdir -p ${repoDir}/zm-build/${currentPackage}/DEBIAN
    echo -e "\tCopy package files..." >> ${buildLogFile}
    cat ${repoDir}/zm-build/rpmconf/Spec/Scripts/${currentScript}.post >> ${repoDir}/zm-build/${currentPackage}/DEBIAN/postinst
    chmod 555 ${repoDir}/zm-build/${currentPackage}/DEBIAN/*

    echo -e "\tCreate debian package..." >> ${buildLogFile}
    cat ${repoDir}/zm-build/rpmconf/Spec/${currentScript}.deb | sed -e "s/@@VERSION@@/${release}.${buildNo}.${os/_/.}/" -e "s/@@branch@@/${buildTimeStamp}/" -e "s/@@ARCH@@/${arch}/" \
        > ${repoDir}/zm-build/${currentPackage}/DEBIAN/control
    (cd ${repoDir}/zm-build/${currentPackage}; dpkg -b ${repoDir}/zm-build/${currentPackage} ${repoDir}/zm-build/${arch})

}

CreateRhelPackage()
{
    cp ${repoDir}/zm-build/rpmconf/Spec/Scripts/${currentScript}.post ${repoDir}/zm-build/
    cat ${repoDir}/zm-build/rpmconf/Spec/${currentScript}.spec | \
    	sed -e "s/@@VERSION@@/${release}.${buildNo}.${os}/" \
            	-e "s/@@RELEASE@@/${buildTimeStamp}/" \
            	-e "s/^Copyright:/Copyright:/" \
            	-e "/^%post$/ r ${currentScript}.post" > ${repoDir}/zm-build/${currentScript}.spec
    rm -f ${repoDir}/zm-build/${currentScript}.post
    echo "%attr(755, zimbra, zimbra) /opt/zimbra/logger" >> \
    	${repoDir}/zm-build/${currentScript}.spec
    echo "%attr(755, zimbra, zimbra) /opt/zimbra/logger/db" >> \
    	${repoDir}/zm-build/${currentScript}.spec
    echo "%attr(755, zimbra, zimbra) /opt/zimbra/logger/db/data" >> \
    	${repoDir}/zm-build/${currentScript}.spec
    echo "" >> ${repoDir}/zm-build/${currentScript}.spec
    echo "%clean" >> ${repoDir}/zm-build/${currentScript}.spec
    (cd ${repoDir}/zm-build/${currentPackage}; \
    	rpmbuild --target ${arch} --define '_rpmdir ../' --buildroot=${repoDir}/zm-build/${currentPackage} -bb ${repoDir}/zm-build/${currentScript}.spec )
}

############################################################################
main "$@"