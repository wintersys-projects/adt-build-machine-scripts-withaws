#!/bin/sh
#####################################################################################
# Author: Peter Winter
# Date  : 13/07/2021
# Description :  This will record your build client IP in the S3 system which will ensure
# that the firewall grants access to your laptop onto your build machine
#####################################################################################
# License Agreement:
# This file is part of The Agile Deployment Toolkit.
# The Agile Deployment Toolkit is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# The Agile Deployment Toolkit is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with The Agile Deployment Toolkit.  If not, see <http://www.gnu.org/licenses/>.
######################################################################################
######################################################################################
#set -x

BUILD_HOME="`/usr/bin/pwd | /bin/sed 's/\/helperscripts//g'`"

if ( [ "`/bin/grep "^DATASTORETOOL:*" ${BUILD_HOME}/builddescriptors/buildstylesscp.dat | /usr/bin/awk -F':' '{print $NF}'`" = "s3cmd" ] )
then
    /usr/bin/s3cmd mb s3://adt-${BUILD_IDENTIFIER} 2>/dev/null
    /usr/bin/s3cmd ls s3://adt-${BUILD_IDENTIFIER}/  | /usr/bin/awk '{print $4}' | /usr/bin/xargs s3cmd del
    /bin/touch /tmp/${BUILD_CLIENT_IP}
    /usr/bin/s3cmd put /tmp/${BUILD_CLIENT_IP} s3://adt-${BUILD_IDENTIFIER}
fi
