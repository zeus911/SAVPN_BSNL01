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


#
# NOTE !
#
# On a Windows platform, this script _must_ be executed from the
# directory where it is located
#

# Determine OS
case `uname -rs` in
    HP-UX*)  OSTYPE=HPUX
             AWK=awk
      ;;
    SunOS*)  OSTYPE=SOLARIS
             AWK=/usr/xpg4/bin/awk
      ;;
    CYGWIN*) OSTYPE=WINDOWS
             AWK=awk
      ;;
    Linux*)  OSTYPE=SOLARIS
             AWK=awk
      ;;
    *)       echo Unable to install the product on this Operating System.
             echo Please refer to the Installation Manual for supported
             echo OS version.
             exit 1
esac


# Find or generate script for setting up ServiceActivator variables
if [ "$OSTYPE" = "WINDOWS" ]; then
  SETUP_ENV_FILE=../../../../../../../OpenView/ServiceActivator/bin/setenv.bat
else
  SETUP_ENV_FILE=/opt/OV/ServiceActivator/bin/setenv
fi

# Flag to check if SAVPN is co-located with HPSA.
isCoLocated=true

if [ ! -e $SETUP_ENV_FILE ]
then
	isCoLocated=false

	if [ ! -z $ACTIVATOR_OPT ]
	then
		SETUP_ENV_FILE=$ACTIVATOR_OPT/bin/setenv.bat
		
	fi
fi


while [ ! -e $SETUP_ENV_FILE ]; do
  echo "Could not find Service Activator setup environment script ($SETUP_ENV_FILE)"
  echo "Enter alternative file:"
  read seval
  if [ ! -z $seval ]; then
     SETUP_ENV_FILE=$seval
  else
    echo "No setup environment script given"
    exit 1
  fi
done

# Assume that on a windows system, setup file is a .bat file
# that needs manipulation
if [ "$OSTYPE" = "WINDOWS" ]; then
  cat $SETUP_ENV_FILE |
    dos2unix |
    grep '^set' |
    cut -d' ' -f2 |
    sed 's/\%\(.*\)\%/\$\1/g' |
    sed "s;\\\\;/;g" > ./env.tmp
  echo "export ACTIVATOR_OPT ACTIVATOR_ETC ACTIVATOR_VAR ACTIVATOR_LIB ACTIVATOR_DB_VENDOR ACTIVATOR_THIRD_PARTY_LIB ACTIVATOR_THIRD_PARTY_CLASSES ACTIVATOR_ETC_CONFIG ACTIVATOR_VAR_LOG JBOSS_HOME JBOSS_SERVER_JARS JBOSS_CLIENT_JARS JAVA_HOME" >> ./env.tmp
  SETUP_ENV_FILE=./env.tmp
fi


# Setup CRM Portal variables relative to ServiceActivator variables
. $SETUP_ENV_FILE

# Convert '\' to '/' in $PROJECTROOT for sed to work correctly during file generation.
SLASH_PROJECTROOT=`echo $PROJECTROOT | sed -e 's/\\\\/\//g'`

# Platform indenpendent settings
ACTIVATOR_WEB_XML_DIR=$JBOSS_SAR_DEPLOY/activator.war/WEB-INF/
ACTIVATOR_WEB_XML=$JBOSS_SAR_DEPLOY/activator.war/WEB-INF/web.xml
CRM_HOME=$JBOSS_HOME/standalone/deployments/crm.ear/crm.war
PORTAL_WEB_XML_TEMPLATE=$JBOSS_HOME/standalone/deployments/crm.ear/crm.war/WEB-INF/config/web.xml.template
PORTAL_WEB_XML=$JBOSS_HOME/standalone/deployments/crm.ear/crm.war/WEB-INF/web.xml
ACTIVATOR_VAR_TMP=$ACTIVATOR_VAR/tmp
PORTAL_BIN=$JBOSS_HOME/standalone/deployments/crm.ear/crm.war/WEB-INF/bin
PORTAL_CONFIG=$JBOSS_HOME/standalone/deployments/crm.ear/crm.war/WEB-INF/config
#DB_CONFIG_FILE=$JBOSS_HOME/server/default/deploy/hpovact-oracle-ds.xml
DB_CONFIG_FILE=$JBOSS_HOME/standalone/configuration/standalone.xml

# Check where SAVPN is installed - should work for both build and kit install.
if [ "$isCoLocated" = "true" ]
then
	SOLUTION=$ACTIVATOR_OPT/solutions/SAVPN
else
	SOLUTION=$SLASH_PROJECTROOT/OpenView/ServiceActivator/solutions/SAVPN
fi

#JBOSS_LOGIN_CONFIG_FILE=$JBOSS_HOME/server/default/conf/login-config.xml
JBOSS_LOGIN_CONFIG_FILE=$JBOSS_HOME/standalone/configuration/standalone.xml
JBOSS_EAR_LIB=$JBOSS_EAR_LIB
if [ "$OSTYPE" = "WINDOWS" ]; then
    JBOSS_STANDALONE_CONF=$JBOSS_HOME/bin/standalone.conf.bat
else
    JBOSS_STANDALONE_CONF=$JBOSS_HOME/bin/standalone.conf
fi
JBOSS_DEPLOY=$JBOSS_DEPLOY

#20040311 GKA&RTA : Added new variable to load DB connection parameters 
#from SA dbConnect.cfg file by the default

MWFM_XML=$ACTIVATOR_ETC_CONFIG/mwfm.xml


# Use template to generate script to setup CRM Portal environment
ENV_FILE=./setenv.crmportal
if [ -e $ENV_FILE ]; then
  rm $ENV_FILE
fi

echo "# **************************************************************" >> $ENV_FILE
echo "# Variables specifying locations for CRM Portal"                  >> $ENV_FILE
echo "# **************************************************************" >> $ENV_FILE
echo "# "                                                               >> $ENV_FILE
echo "# "                                                               >> $ENV_FILE

cat setenv.crmportal.template |
  sed s%##AWK_VAL##%${AWK}% |
  sed s%##ACTIVATOR_OPT##%${ACTIVATOR_OPT}% |
  sed s%##ACTIVATOR_VAR_LOG_VAL##%${ACTIVATOR_VAR_LOG}% |
  sed s%##ACTIVATOR_VAR_TMP_VAL##%${ACTIVATOR_VAR_TMP}% |
  sed s%##ACTIVATOR_WEB_XML_DIR_VAL##%${ACTIVATOR_WEB_XML_DIR}% |
  sed s%##ACTIVATOR_WEB_XML_VAL##%${ACTIVATOR_WEB_XML}% |
  sed s%##CRM_HOME##%${CRM_HOME}% |
  sed s%##PORTAL_WEB_XML_TEMPLATE_VAL##%${PORTAL_WEB_XML_TEMPLATE}% |
  sed s%##PORTAL_WEB_XML_VAL##%${PORTAL_WEB_XML}% |
  sed s%##JBOSS_HOME_VAL##%${JBOSS_HOME}% |
  sed s%##MWFM_XML_VAL##%${MWFM_XML}% |	
  sed s%##DB_CONFIG_FILE_VAL##%${DB_CONFIG_FILE}% |
  sed s%##JBOSS_LOGIN_CONFIG_FILE_VAL##%${JBOSS_LOGIN_CONFIG_FILE}% |
  sed s%##PORTAL_BIN_VAL##%${PORTAL_BIN}% |
  sed s%##PORTAL_CONFIG_VAL##%${PORTAL_CONFIG}% |
  sed s%##JAVA_HOME_VAL##%${JAVA_HOME}% |
  sed s%##JBOSS_EAR_LIB_VAL##%${JBOSS_EAR_LIB}% |
  sed s%##JBOSS_STANDALONE_CONF_VAL##%${JBOSS_STANDALONE_CONF}% |
  sed s%##JBOSS_DEPLOY_VAL##%${JBOSS_DEPLOY}% |
  sed s%##ACTIVATOR_DB_VENDOR_VAL##%${ACTIVATOR_DB_VENDOR}% |
  sed s%##SOLUTION_VAL##%${SOLUTION}% >>$ENV_FILE

  
if [ "$OSTYPE" = "WINDOWS" ]; then
  rm ./env.tmp
fi

exit 0;

