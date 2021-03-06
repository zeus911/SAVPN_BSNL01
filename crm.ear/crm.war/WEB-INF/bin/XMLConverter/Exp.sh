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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/bin/XMLConverter/Exp.sh,v $
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

if [ ! -e ../../config/setenv.savpnsp ]; then
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
  export CLASSPATH=".;$JBOSS_HOME/modules/com/hp/ov/activator/oracle/main/oracle_jdbc.jar;$JBOSS_HOME/modules/com/hp/ov/activator/edb/main/edb_jdbc.jar;$JBOSS_HOME/modules/com/hp/ov/activator/postgresql/main/postgresql_jdbc.jar;$SOLUTION/3rd-party/lib/savpn_dbconfig.jar"
else
  export CLASSPATH=".:$JBOSS_HOME/modules/com/hp/ov/activator/oracle/main/oracle_jdbc.jar:$JBOSS_HOME/modules/com/hp/ov/activator/edb/main/edb_jdbc.jar:$JBOSS_HOME/modules/com/hp/ov/activator/postgresql/main/postgresql_jdbc.jar:$SOLUTION/3rd-party/lib/savpn_dbconfig.jar"
fi



if [ ! $# -eq 2 ]
then
  echo
  echo "usage: Exp.sh <export.xml> <output.xml>"
  echo "  where <export.xml> is the file generated by gen.sh containing a list of the tables to be exported"
  echo "  and  <output.xml> is the file containing the exported data"
  exit 
fi  

$JAVA_HOME/bin/java -DDBCONFIG=$DB_CONFIG_FILE com.hp.ov.activator.vpn.XMLConverter.Export $1 $2 portal.dtd $DB_USER $DB_PASSWORD

