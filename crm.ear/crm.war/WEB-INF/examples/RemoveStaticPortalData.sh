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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/examples/RemoveStaticPortalData.sh,v $
# $Revision: 1.6 $
# $Date: 2010-10-05 14:18:55 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################


. ../config/setenv.crmportal

SQLPATH=$CRM_HOME/WEB-INF/examples/RemoveScripts/
export SQLPATH

. $PORTAL_BIN/SQLDeployer/runSQLDeployer.sh RemoveScripts/RemoveStaticPortalData

if test -z $1
then
  echo Press enter to continue
  read
fi
