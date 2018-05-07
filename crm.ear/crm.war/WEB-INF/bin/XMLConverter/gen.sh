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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/bin/XMLConverter/gen.sh,v $
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
  export CLASSPATH="$SOLUTION/bin/XMLConverter"
else
  export CLASSPATH="$SOLUTION/bin/XMLConverter"
fi

DTD_LOC=$ACTIVATOR_OPT/3rd-party/inventory


cd $CRM_HOME/WEB-INF/src/inventory/
cp -f $DTD_LOC/bean.dtd .

$JAVA_HOME/bin/java com.hp.ov.activator.vpn.XMLConverter.GenDTD $PORTAL_BIN/XMLConverter/dtdConfig portal.dtd
cd ../../bin/XMLConverter

mv ../../src/inventory/*ctl .
mv ../../src/inventory/portal.dtd .
mv ../../src/inventory/export.xml export.input
rm -f ../../src/inventory/bean.dtd

cat export.start export.input export.end >export.xml

