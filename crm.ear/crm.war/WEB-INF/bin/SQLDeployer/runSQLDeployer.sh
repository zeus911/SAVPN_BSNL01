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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/bin/SQLDeployer/runSQLDeployer.sh,v $
# $Revision: 1.9 $
# $Date: 2010-10-05 14:18:24 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################
# Determine OS
case `uname -rs` in
    CYGWIN*) OSTYPE=WINDOWS;;
    *)       OSTYPE=UNIX;;
esac

# Use ; for Windows and : for Unix
if [ "$OSTYPE" = "WINDOWS" ]; then
  export CLASSPATH="$CRM_HOME/WEB-INF/bin/SQLDeployer;$JBOSS_HOME/modules/com/hp/ov/activator/oracle/main/oracle_jdbc.jar;$JBOSS_HOME/modules/com/hp/ov/activator/edb/main/edb_jdbc.jar;$JBOSS_HOME/modules/com/hp/ov/activator/postgresql/main/postgresql_jdbc.jar;$JBOSS_EAR_LIB/savpn_dbconfig.jar"
else
  export CLASSPATH="$CRM_HOME/WEB-INF/bin/SQLDeployer:$JBOSS_HOME/modules/com/hp/ov/activator/oracle/main/oracle_jdbc.jar:$JBOSS_HOME/modules/com/hp/ov/activator/edb/main/edb_jdbc.jar:$JBOSS_HOME/modules/com/hp/ov/activator/postgresql/main/postgresql_jdbc.jar:$JBOSS_EAR_LIB/savpn_dbconfig.jar"
fi

$JAVA_HOME/bin/java -DSQLPATH=$SQLPATH -DDBCONFIG=$DB_CONFIG_FILE -DACTIVATORDBVENDOR=$ACTIVATOR_DB_VENDOR com.hp.ov.activator.vpn.SQLDeployer.SQLDeployer $1 $2 $3
