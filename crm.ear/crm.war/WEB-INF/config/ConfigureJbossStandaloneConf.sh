#! /bin/bash
###############################################################################
#
#   ****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/etc/config/ConfigureJbossLog4j.sh,v $
# $Revision: 1.6 $
# $Date: 2010-10-05 15:33:40 $
# $Author: shiva $
#
###############################################################################


# To be called like:
#
#   ./ConfigureJbossStandaloneConf.sh
#

# Determine OS
case `uname -rs` in
    CYGWIN*) OSTYPE=WINDOWS;;
    *)       OSTYPE=UNIX;;
esac

if [ ! -e ./setenv.crmportal ]; then
  ./generate_setenv.sh
fi
. ./setenv.crmportal

if test -e $JBOSS_STANDALONE_CONF
then
  cur_time=`date +%m%d%y_%H%M%S`
  cp -p -f $JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.${cur_time}
fi

if [ -e $JBOSS_STANDALONE_CONF.original ]; then
  # Reinstall original (and saved) standalone.conf[.bat] file
  echo "(Using standalone.conf.original as template)"
  cp -p -f $JBOSS_STANDALONE_CONF.original $JBOSS_STANDALONE_CONF
  if [ "$OSTYPE" = "WINDOWS" ]; then
    getfacl $JBOSS_STANDALONE_CONF.original | setfacl -f - $JBOSS_STANDALONE_CONF
    chmod --reference=$JBOSS_STANDALONE_CONF.original $JBOSS_STANDALONE_CONF
    chown --reference=$JBOSS_STANDALONE_CONF.original $JBOSS_STANDALONE_CONF
    chgrp --reference=$JBOSS_STANDALONE_CONF.original $JBOSS_STANDALONE_CONF
  fi
else
  # Save original standalone.conf file
  echo "(Saving standalone.conf for future reconfiguration)"
  cp -p -f $JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.original
  if [ "$OSTYPE" = "WINDOWS" ]; then
    getfacl $JBOSS_STANDALONE_CONF | setfacl -f - $JBOSS_STANDALONE_CONF.original
    chmod --reference=$JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.original
    chown --reference=$JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.original
    chgrp --reference=$JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.original
  fi
fi

$AWK -v jboss_deploy=$JBOSS_DEPLOY -v os_type=$OSTYPE -f ./modify_jboss_standaloneconf.awk $JBOSS_STANDALONE_CONF > $JBOSS_STANDALONE_CONF.tmp
if [ "$OSTYPE" = "WINDOWS" ]; then
  # Restore original JBOSS_STANDALONE_CONF file attributes
  getfacl $JBOSS_STANDALONE_CONF | setfacl -f - $JBOSS_STANDALONE_CONF.tmp
  chmod --reference=$JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.tmp
  chown --reference=$JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.tmp
  chgrp --reference=$JBOSS_STANDALONE_CONF $JBOSS_STANDALONE_CONF.tmp
fi
mv $JBOSS_STANDALONE_CONF.tmp $JBOSS_STANDALONE_CONF

echo "Differences between $JBOSS_STANDALONE_CONF.original and $JBOSS_STANDALONE_CONF" > $ACTIVATOR_VAR_LOG/savpnsp.standalone.conf.diff
echo "======================================================================" >> $ACTIVATOR_VAR_LOG/savpnsp.standalone.conf.diff
diff -w $JBOSS_STANDALONE_CONF.original $JBOSS_STANDALONE_CONF                           >> $ACTIVATOR_VAR_LOG/savpnsp.standalone.conf.diff
