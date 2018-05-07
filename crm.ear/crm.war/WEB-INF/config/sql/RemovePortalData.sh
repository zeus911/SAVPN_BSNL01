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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/config/sql/RemovePortalData.sh,v $
# $Revision: 1.5 $
# $Date: 2010-10-05 14:18:31 $
# $Author: shiva $
#
###############################################################################
#
# <Description>
#
###############################################################################

. ../setenv.crmportal

SQLPATH=$PORTAL_CONFIG/sql/RemoveScripts/
export SQLPATH

. $PORTAL_BIN/SQLDeployer/runSQLDeployer.sh RemoveScripts/RemovePortalData

if test -z $1
then
  echo Press enter to continue
  read
fi
