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
# <Description> 
#
###############################################################################
# Determine OS
case `uname -rs` in
    CYGWIN*) OSTYPE=WINDOWS;;
    *)       OSTYPE=UNIX;;
esac

if [ ! -e ./setenv.crmportal ]; then
  ./generate_setenv.sh
fi
. ./setenv.crmportal

DB_URL=$1
LOCALUSER=$2
PASSWORD=$3

JBOSS_SERVICE_TEMPLATE="jboss-service.template"
JBOSS_SERVICE="../../../META-INF/jboss-service.xml"
JBOSS_DEPLOYMENT_STRUCTURE_TEMPLATE="jboss-deployment-structure.template"
JBOSS_DEPLOYMENT_STRUCTURE="../../../META-INF/jboss-deployment-structure.xml"
JBOSS_DATASOURCE_TEMPLATE="crmportal-oracle-ds.xml.template"
JBOSS_DATASOURCE_XML="../../../../crmportal-oracle-ds.xml"
JBOSS_LOG4J_TEMPLATE="log4j.xml.template"
JBOSS_LOG4J_XML="../classes/log4j.xml"

# Determine OS
case `uname -rs` in
    CYGWIN*)  CODEPATH="../../../OpenView/ServiceActivator/lib/3rd-party";;
    *)        CODEPATH="$ACTIVATOR_OPT/lib/3rd-party";;
esac

cat $JBOSS_SERVICE_TEMPLATE |
  sed s%##CODEPATH##%${CODEPATH}% > $JBOSS_SERVICE

#place jboss-deployment-structure.xml in same location as jboss-service.xml
cat $JBOSS_DEPLOYMENT_STRUCTURE_TEMPLATE > $JBOSS_DEPLOYMENT_STRUCTURE

#place log4j.xml in $CRM_HOME/WEB-INF/classes
cat $JBOSS_LOG4J_TEMPLATE > $JBOSS_LOG4J_XML

# Configure datasource
#cat $JBOSS_DATASOURCE_TEMPLATE |
  #sed s%##DB_URL##%${DB_URL}% |
  #sed s%##PASSWORD##%${PASSWORD}% |
  #sed s%##USERNAME##%${LOCALUSER}% > $JBOSS_DATASOURCE_XML

if [ -e $JBOSS_LOGIN_CONFIG_FILE.original ]; then
   
   tmp=`grep -c "CRMPortalDSEncryptDBPassword" $JBOSS_LOGIN_CONFIG_FILE`
   if [ "$tmp" = "0" ];then
     echo "standalone.xml has been re-configured, use new standalone.xml as template"
     cp -p -f $JBOSS_LOGIN_CONFIG_FILE $JBOSS_LOGIN_CONFIG_FILE.original 
   fi

  # Reinstall original (and saved) standalone.xml file
  echo "(Using standalone.xml.original as template)"
  cp -p -f $JBOSS_LOGIN_CONFIG_FILE.original $JBOSS_LOGIN_CONFIG_FILE
  if [ "$OSTYPE" = "WINDOWS" ]; then
    getfacl $JBOSS_LOGIN_CONFIG_FILE.original | setfacl -f - $JBOSS_LOGIN_CONFIG_FILE
    chmod 755 $JBOSS_LOGIN_CONFIG_FILE
  fi
else
  # Save original standalone.xml file
  echo "(Saving standalone.xml for future reconfiguration)"
  cp -p -f $JBOSS_LOGIN_CONFIG_FILE $JBOSS_LOGIN_CONFIG_FILE.original
  if [ "$OSTYPE" = "WINDOWS" ]; then
    getfacl $JBOSS_LOGIN_CONFIG_FILE | setfacl -f - $JBOSS_LOGIN_CONFIG_FILE.original
    chmod 755 $JBOSS_LOGIN_CONFIG_FILE.original
  fi
fi
if [ "$OSTYPE" = "WINDOWS" ]; then
    TEMP_ENCRYPTED_PASSWORD=`$ACTIVATOR_OPT/bin/generateEncryptedPassword.bat -password $PASSWORD`
else
    TEMP_ENCRYPTED_PASSWORD=`$ACTIVATOR_OPT/bin/generateEncryptedPassword -password $PASSWORD`
fi

ENCRYPTED_PASSWORD=`echo $TEMP_ENCRYPTED_PASSWORD | sed -e 's/Encoded password: //g'` 

$AWK -v crm_user=$LOCALUSER -v crm_password=$ENCRYPTED_PASSWORD -v crm_db_url=$DB_URL -f ./modify_login-config.awk $JBOSS_LOGIN_CONFIG_FILE > $JBOSS_LOGIN_CONFIG_FILE.tmp

if [ "$OSTYPE" = "WINDOWS" ]; then
    # Restore original JBOSS_LOGIN_CONFIG_FILE file attributes
    getfacl $JBOSS_LOGIN_CONFIG_FILE | setfacl -f - $JBOSS_LOGIN_CONFIG_FILE.tmp
    chmod --reference=$JBOSS_LOGIN_CONFIG_FILE $JBOSS_LOGIN_CONFIG_FILE.tmp
    chown --reference=$JBOSS_LOGIN_CONFIG_FILE $JBOSS_LOGIN_CONFIG_FILE.tmp
    chgrp --reference=$JBOSS_LOGIN_CONFIG_FILE $JBOSS_LOGIN_CONFIG_FILE.tmp
    chmod 755 $JBOSS_LOGIN_CONFIG_FILE.tmp
  fi

  mv -f $JBOSS_LOGIN_CONFIG_FILE.tmp $JBOSS_LOGIN_CONFIG_FILE

