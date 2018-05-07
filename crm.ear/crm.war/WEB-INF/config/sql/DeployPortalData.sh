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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/config/sql/DeployPortalData.sh,v $
# $Revision: 1.6 $
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

. $PORTAL_BIN/SQLDeployer/runSQLDeployer.sh DeployScripts/DeployPortalData $DB_USER $DB_PASSWORD

if test -z $1
then
  echo Press enter to continue
  read
fi
