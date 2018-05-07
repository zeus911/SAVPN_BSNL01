#! /bin/bash
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/src/inventory/RemoveCRMTables.sh,v $
# $Revision: 1.11 $
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

if [ -z $DB_USER ] || [ -z $DB_PASSWORD ] ; then
	echo "Enter Database User"
	read userval
	if [ ! -z $userval ]; then
	  DB_USER=$userval
	fi

	echo "Enter Database Password"
	read -s pwdval
	if [ ! -z $pwdval ]; then
	  DB_PASSWORD=$pwdval
	fi

	if [ -z $DB_USER ] || [ -z $DB_PASSWORD ] ; then
		echo "Database User and User Password cannot be empty"
		exit 1;
	fi
fi

export DB_USER DB_PASSWORD

. $CRM_HOME/WEB-INF/bin/SQLDeployer/runSQLDeployer.sh RemoveCRMTables $DB_USER $DB_PASSWORD

if test -z $1
then
  echo Press enter to continue
  read
fi
echo
