#! /bin/bash
###############################################################################
#
#   ****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
##############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/config/PrintDBParams.sh,v $
# $Revision: 1.10 $
# $Date: 2010-10-05 14:18:29 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################


if [ ! -e ./setenv.crmportal ]; then
  ./generate_setenv.sh
fi
. ./setenv.crmportal

# Determine OS
case `uname -rs` in
    CYGWIN*) OSTYPE=WINDOWS;;
    *)       OSTYPE=UNIX;;
esac

# Use ; for Windows and : for Unix
if [ "$OSTYPE" = "WINDOWS" ]; then
  export CLASSPATH="$JBOSS_EAR_LIB/activator_utils.jar;$JBOSS_EAR_LIB/savpn_dbconfig.jar;$JBOSS_HOME/modules/com/hp/ov/activator/oracle/main/oracle_jdbc.jar;$JBOSS_HOME/modules/com/hp/ov/activator/edb/main/edb_jdbc.jar;$JBOSS_HOME/modules/com/hp/ov/activator/postgresql/main/postgresql_jdbc.jar;."
else
  export CLASSPATH="$JBOSS_EAR_LIB/activator_utils.jar:$JBOSS_EAR_LIB/savpn_dbconfig.jar:$JBOSS_HOME/modules/com/hp/ov/activator/oracle/main/oracle_jdbc.jar:$JBOSS_HOME/modules/com/hp/ov/activator/edb/main/edb_jdbc.jar:$JBOSS_HOME/modules/com/hp/ov/activator/postgresql/main/postgresql_jdbc.jar:."
fi

op=`$JAVA_HOME/bin/java -DDBCONFIG=$DB_CONFIG_FILE -DJBOSS_HOME=$JBOSS_HOME -DJBOSS_DEPLOY=$JBOSS_HOME/server/default/deploy com.hp.ov.activator.vpn.dbconfig.PrintDBParams "$@"`

echo $op
