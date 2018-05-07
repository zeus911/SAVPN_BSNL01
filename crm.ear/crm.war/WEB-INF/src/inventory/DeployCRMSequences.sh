#! /bin/bash
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/src/inventory/DeployCRMSequences.sh,v $
# $Revision: 1.9 $
# $Date: 2010-10-05 14:19:04 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################

. ../../config/setenv.crmportal

SQLPATH=$CRM_HOME/WEB-INF/src/inventory/
export SQLPATH

. $CRM_HOME/WEB-INF/bin/SQLDeployer/runSQLDeployer.sh DeployCRMSequences $DB_USER $DB_PASSWORD

if test -z $1
then
  echo Press enter to continue
  read
fi
