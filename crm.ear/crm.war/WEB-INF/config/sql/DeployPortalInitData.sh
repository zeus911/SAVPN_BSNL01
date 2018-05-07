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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/config/sql/DeployPortalInitData.sh,v $
# $Revision: 1.8 $
# $Date: 2010-10-05 14:18:31 $
# $Author: shiva $
#
###############################################################################
#
# <Description>
#
###############################################################################

. ../setenv.crmportal


SQLPATH=$PORTAL_CONFIG/sql/DeployScripts/
export SQLPATH
if [ -f DeployScripts/DeployPortalInitDataME ]
then
. $PORTAL_BIN/SQLDeployer/runSQLDeployer.sh DeployScripts/DeployPortalInitDataME $DB_USER $DB_PASSWORD
fi

if [ -f DeployScripts/DeployPortalInitData ]
then
. $PORTAL_BIN/SQLDeployer/runSQLDeployer.sh DeployScripts/DeployPortalInitData $DB_USER $DB_PASSWORD
fi

if test -z $1
then
  echo Press enter to continue
  read
fi
