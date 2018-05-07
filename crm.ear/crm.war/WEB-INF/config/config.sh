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


# Setup CRM Portal variables

rm -f setenv.crmportal

if [ ! -e ./setenv.crmportal ]; then
  ./generate_setenv.sh
  fi

. ./setenv.crmportal


cur_time=`date +%m%d%y_%H%M%S`
LOGFILE=$ACTIVATOR_VAR_LOG/crmportal.install.${cur_time}.log

function log() {
  echo $1
  echo $1 >> $LOGFILE
}

#
# NOTE !
#
# This script _must_ be executed from the directory where
# it is located
#


############################################################
# Main
############################################################
log "Setting up the Service Activator VPN CRM Web Portal..."
log

#
# Generate web.xml file
#
log
log "Configure $PORTAL_WEB_XML..."
log "=============================================="
log


#get db params 

if [ -z $LOCALUSER ] || [ -z  $PASSWORD ] || [ -z $DB_URL ];  then

    CURRENT_DIR=`pwd`
    cd $SOLUTION/etc/config

	if [ "$ACTIVATOR_DB_VENDOR" == "EnterpriseDB" ]; then
		DB_URL=`./PrintDBParams.sh -getURL | cut -d"/" -f3,4`
	else
		DB_URL=`./PrintDBParams.sh -getURL | cut -d'@' -f2`
	fi

    . GetDBParams.sh
    cd $CURRENT_DIR

    LOCALUSER=$DB_USER 
    PASSWORD=$DB_PASSWORD

    if [ ! -z $DB_URL ]; then
        URL_PROMPT_STRING="Enter Database Connection Line [ $DB_URL ] "
    else
        URL_PROMPT_STRING="Enter Database Connection Line "
    fi

    echo $URL_PROMPT_STRING 
    read dbval
    if [ ! -z $dbval ]; then
        DB_URL=$dbval
    fi

    if [ ! -z $LOCALUSER ]; then
        USER_PROMPT_STRING="Enter Database User [ $LOCALUSER ] "
    else
        USER_PROMPT_STRING="Enter Database User "
    fi
	
    echo $USER_PROMPT_STRING
    read userval
    if [ ! -z $userval ]; then
      LOCALUSER=$userval
    fi

    if [ ! -z $PASSWORD ]; then
        PASS_PROMPT_STRING="Enter Database Password [ $PASSWORD ] "
    else
        PASS_PROMPT_STRING="Enter Database Password "
    fi

    echo $PASS_PROMPT_STRING
    read -s pwdval
    if [ ! -z $pwdval ]; then
        PASSWORD=$pwdval
    fi
fi

if [ -z $DB_URL ] || [ -z $LOCALUSER ] || [ -z $PASSWORD ] ; then
	echo "Database connection URL, DB User and DB User Password cannot be empty"
	exit 1;
fi

./ConfigureWebXML.sh 

log
log "File $PORTAL_WEB_XML configured"
log
log

#
# Generate jboss_service.xml file
#
log
log "Configure jboss_service.xml..."
log "=============================================="
log

. ./ConfigureJbossService.sh $DB_URL $LOCALUSER $PASSWORD

log
log "File jboss_service.xml configured"
log
log

log
log "Configure standalone.conf..."
log "=============================================="
log
. ./ConfigureJbossStandaloneConf.sh

log "Done setting up the Service Activator VPN CRM Web Portal..."
log
log "  Log file:"
log "    $LOGFILE"
log
log "Press enter to continue..."
read




