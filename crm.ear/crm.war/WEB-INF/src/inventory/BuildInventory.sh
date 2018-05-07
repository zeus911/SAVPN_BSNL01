#! /bin/bash
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/src/inventory/BuildInventory.sh,v $
# $Revision: 1.12 $
# $Date: 2010-10-05 14:19:03 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################

#removes command "import com.hp.ov.activator.mwfm.component.AuditEvent;" from all .java files
#in directory ./classes/com/hp/ov/activator/crmportal/bean
#the statement is situated on line 13 in each file
removeImport()
{
  echo "Remove import from *.java files"


if [ "$OSTYPE" = "WINDOWS" ]; then
  p="./classes/com/hp/ov/activator/crmportal/bean"
else
  p="/opt/HP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/src/inventory/classes/com/hp/ov/activator/crmportal/bean"
fi


  files=`ls $p/*.java`

   for i in $files
  do
    echo $i

    awk 'BEGIN{}
         {
             update_index = index($0, "import com.hp.ov.activator.mwfm.component.AuditEvent;");
             if(update_index!=0){
             } else {
               print;
             }
          }' $i > $i.tmp

    rm $i
    
    mv ${i}.tmp $i

  done
}

# Determine OS
case `uname -rs` in
    CYGWIN*) OSTYPE=WINDOWS;;
    *)       OSTYPE=UNIX;;
esac

if [ "$OSTYPE" = "WINDOWS" ]; then
  BUILDER=../../../../../../../../../OpenView/ServiceActivator/bin/InventoryBuilder.bat
else
  BUILDER=/opt/OV/ServiceActivator/bin/InventoryBuilder
fi

echo "Building SQLs and JSPs"

# if directories does exist then remove them and create new ones.
if [ -d sql ]
then
  rm -rf sql
fi
mkdir sql

if [ -d classes ]
then
  rm -rf classes
fi
mkdir classes

if [ -d struts_classes ]
then
  rm -rf struts_classes
fi
mkdir struts_classes

CLASSPATH="../../../WEB-INF/classes"
CLASS_INSTALL_PATH="../../../WEB-INF"

# -- Copy bean.dtd --
if [ "$OSTYPE" = "WINDOWS" ]; then
  cp ../../../../../../../../../OpenView/ServiceActivator/3rd-party/inventory/bean.dtd bean.dtd
else
  cp /opt/OV/ServiceActivator/3rd-party/inventory/bean.dtd bean.dtd
fi

echo "Compiling beans."
$BUILDER -nojsp -app . *.xml

removeImport

$BUILDER -compile -app .

echo "Done"

#./AlterServiceParameterSize.sh

echo Cleaning up
rm -f bean.dtd

# move the sql files to correct location
cp -r classes $CLASS_INSTALL_PATH
rm -rf classes

if test -z $1
then
  echo
  echo
  echo Press enter to continue
  read
fi
echo
