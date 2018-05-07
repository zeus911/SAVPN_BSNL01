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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/bin/XMLConverter/generateReport.sh,v $
# $Revision: 1.6 $
# $Date: 2010-10-05 14:18:27 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################


# Setup SA_VPN_SP variables relative to ServiceActivator variables
if [ ! -e ../../config/setenv.crmportal ]; then
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
  export CLASSPATH=".;$JBOSS_HOME/server/default/deploy/hpovact.sar/activator.war/WEB-INF/classes;$ACTIVATOR_OPT/3rd-party/classes;$ACTIVATOR_OPT/lib/mwfm.jar;$ACTIVATOR_OPT/lib/3rd-party/classes12.zip"
else
  export CLASSPATH=".:$JBOSS_HOME/server/default/deploy/hpovact.sar/activator.war/WEB-INF/classes:$ACTIVATOR_OPT/3rd-party/classes:$ACTIVATOR_OPT/lib/mwfm.jar:$ACTIVATOR_OPT/lib/3rd-party/classes12.zip"
fi

$JAVA_HOME/bin/java -DDBCONFIG=$DB_CONFIG_FILE com.hp.ov.activator.vpn.XMLConverter.DoReport 
