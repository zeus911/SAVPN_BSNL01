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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/bin/XMLConverter/updateSequences.sh,v $
# $Revision: 1.6 $
# $Date: 2010-10-05 14:18:27 $
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

SQLPATH=`pwd`/
export SQLPATH


echo -n "Update sequences [y]? "
read answer

if [ ! -z $answer ]; then
    if [ $answer != "y" ]; then
      exit 0
    fi
fi

SQLPATH=$PORTAL_BIN/XMLConverter/
export SQLPATH

. $PORTAL_BIN/SQLDeployer/runSQLDeployer.sh DeploynewSequences $DB_USER $DB_PASSWORD

