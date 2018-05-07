#! /bin/bash
###############################################################################
#
#   ****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
###############################################################################
###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/bin/XMLConverter/XMLConverter.sh,v $
# $Revision: 1.8 $
# $Date: 2010-10-05 14:18:26 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################


# Setup SA_VPN_SP variables relative to ServiceActivator variables
if [ ! -e ../../config/setenv.crmportal ]; then
  HERE=`pwd`
  cd ../../config
  ./generate_setenv.sh
  cd $HERE
fi
. ../../config/setenv.crmportal


# Determine OS
case `uname -rs` in
    CYGWIN*) OSTYPE=WINDOWS;;
    *)       OSTYPE=UNIX;;
esac

# Use ; for Windows and : for Unix
if [ "$OSTYPE" = "WINDOWS" ]; then
  export CLASSPATH="."
else
  export CLASSPATH="."
fi

if [ ! $# -eq 1 ]
then
  echo
  echo "usage: XMLConverter.sh <input.xml>"
  echo "  where <input.xml> normally is portal.xml"
  exit 
fi  

$JAVA_HOME/bin/java com.hp.ov.activator.vpn.XMLConverter.XMLConverter "$1"
