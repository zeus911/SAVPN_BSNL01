#! /bin/bash
###############################################################################
#
#    (c) Copyright 2003-2009 Hewlett-Packard Development Company, L.P.
#
###############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/src/inventory/BuildAndDeployBeans.sh,v $
# $Revision: 1.22 $
# $Date: 2011-03-29 06:12:15 $
# $Author: saraswat $
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

if [ "$OSTYPE" = "WINDOWS" ]; then
. $PROJECTROOT/etc/windows.conf
fi

if [ "$OSTYPE" = "UNIX" ]; then
  . /opt/OV/ServiceActivator/bin/setenv
  CRM_HOME=/opt/HP/jboss/standalone/deployments/crm.ear/crm.war/
fi

# -- Building environment --
LOC=$CRM_HOME/WEB-INF/src/inventory
DTD_LOC=$ACTIVATOR_ETC/config
CLASS_INSTALL_PATH="$CRM_HOME/WEB-INF"
JSQL_INSTALL_PTAH="$CRM_HOME/WEB-INF/classes"

RESOURCE_DEF_FILE_WITH_SQL="state.xml customer.xml message.xml servicetype.xml service.xml serviceparameter.xml statemappings.xml VPNMembership.xml StaticRoute.xml"
RESOURCE_DEF_FILE_WITHOUT_SQL="L3Parameters.xml RL.xml car.xml cos.xml location.xml region.xml Profile.xml EXPMapping.xml IPAddrPool.xml PolicyMapping.xml VlanRange.xml DLCIRange.xml IPNet.xml"

if [ "$OSTYPE" = "WINDOWS" ]; then
  BUILDER=$ACTIVATOR_OPT/bin/inventoryBuilder.bat
else
  BUILDER=$ACTIVATOR_OPT/bin/InventoryBuilder
fi

# if the sql directory does exist then remove it.
if [ -d sql ]
then
  rm -rf sql
fi

# if the classes directory does exist then remove it.
if [ -d classes ]
then
  rm -rf classes
fi

echo Building and deploying Beans
echo

# -- Copy bean.dtd --
#cp $DTD_LOC/bean.dtd  $LOC/bean.dtd
#echo copied bean.dtd
echo `pwd`
mkdir struts_classes

echo Building inventory CRM native
echo
$BUILDER -noJSP $RESOURCE_DEF_FILE_WITH_SQL
$BUILDER -compile -beanjar inventory_CRM.jar

#Assign the permissions
chmod -Rf 777 *
chmod -Rf 777 *.*
chmod -Rf 777  ../../*
chmod -Rf 777  ../../*.*

echo "Copying (CRM) classes dir to $CLASS_INSTALL_PATH"
echo
cp -r classes $CLASS_INSTALL_PATH
#cp -r jsql $JSQL_INSTALL_PTAH

if [ -d classes ]
then
  rm -rf classes
fi

echo Building inventory for HPSA access
echo
$BUILDER -noJSP -noSQL $RESOURCE_DEF_FILE_WITHOUT_SQL
$BUILDER -compile -beanjar inventory_CRM.jar

#Assign the permissions
chmod -Rf 777 *
chmod -Rf 777 *.*
chmod -Rf 777  ../../*
chmod -Rf 777  ../../*.*

echo "Copying (HPSA) classes dir to $CLASS_INSTALL_PATH"
echo
cp -r classes $CLASS_INSTALL_PATH
#cp -r jsql $JSQL_INSTALL_PTAH

echo Building done
echo

echo Cleaning up
rm -f $LOC/bean.dtd

echo Building Done

if test -z $1
then
  echo
  echo
  echo Press enter to continue
  read
fi
echo
