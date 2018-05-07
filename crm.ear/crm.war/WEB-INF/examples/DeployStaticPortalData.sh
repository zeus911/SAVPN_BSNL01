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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/examples/DeployStaticPortalData.sh,v $
# $Revision: 1.7 $
# $Date: 2010-10-05 14:18:54 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################


. ../config/setenv.crmportal

SQLPATH=$CRM_HOME/WEB-INF/examples/DeployScripts/
export SQLPATH

. $CRM_HOME/WEB-INF/bin/SQLDeployer/runSQLDeployer.sh DeployScripts/DeployStaticPortalData $DB_USER $DB_PASSWORD

if test -z $1
then
  echo Press enter to continue
  read
fi
