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


# To be called like:
#
#   ConfigureWebXML.sh <db_url> <db_user> <db_pwd>
#
#  eg.
#
#   ConfigureWebXML.sh dbhost:1521:crminstance crmuser hest
#

if [ ! -e ./setenv.crmportal ]; then
  ./generate_setenv.sh
fi
. ./setenv.crmportal

#DB_URL=$1
#LOCALUSER=$2
#PASSWORD=$3

SOCKETLISTENER_HOST="localhost"
SOCKETLISTENER_PORT="3099"
SYNCSOCKETLISTENER_PORT="4099"
REQUEST_SYNCHRONISATION="true"


echo "Enter Service Activator Host [" $SOCKETLISTENER_HOST "] "
read hostval
if [ ! -z $hostval ]; then
  SOCKETLISTENER_HOST=$hostval
fi

echo "Enter Service Activator Port [" $SOCKETLISTENER_PORT "] "
read portval
if [ ! -z $portval ]; then
  SOCKETLISTENER_PORT=$portval
fi

echo "Enter Portal synchronisation Socket Listener Port [" $SYNCSOCKETLISTENER_PORT "] "
read syncportval
if [ ! -z $syncportval ]; then
  SYNCSOCKETLISTENER_PORT=$syncportval
fi


# echo "Request activation synchronisation [" $REQUEST_SYNCHRONISATION "] "
# read sync
# if [ ! -z $sync ]; then
#   REQUEST_SYNCHRONISATION=$sync
# fi
REQUEST_SYNCHRONISATION=true


if test -e $PORTAL_WEB_XML
then
  cur_time=`date +%m%d%y_%H%M%S`
  mv $PORTAL_WEB_XML $PORTAL_WEB_XML.${cur_time}
fi
cat $PORTAL_WEB_XML_TEMPLATE |
  sed s%##ACTIVATOR_LOG##%${ACTIVATOR_VAR_LOG}% |
  sed s%##ACTIVATOR_TMP##%${ACTIVATOR_VAR_TMP}% |
  sed s%##JBOSS##%${JBOSS_HOME}% |
  sed s%##SOCKETLISTENER_HOST##%${SOCKETLISTENER_HOST}% |
  sed s%##SOCKETLISTENER_PORT##%${SOCKETLISTENER_PORT}% |
  sed s%##SYNCSOCKETLISTENER_PORT##%${SYNCSOCKETLISTENER_PORT}% |
  sed s%##REQUEST_SYNCHRONISATION##%${REQUEST_SYNCHRONISATION}% > $PORTAL_WEB_XML

