#! /bin/bash
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/src/inventory/AlterServiceParameterSize.sh,v $
# $Revision: 1.7 $
# $Date: 2010-10-05 14:19:03 $
# $Author: shiva $
#
###############################################################################
#
# <Description>
#
###############################################################################

#. ../../../setenv.savpnsp


echo "Changing size of 'Value' field on ServiceParameter object from VARCHAR(200) to VARCHAR(4000) "
cd sql
sed s/Value\ varchar2\(200\)/Value\ varchar2\(4000\)/ ServiceParameter.sql > ServiceParameter.sql.new

mv ServiceParameter.sql.new ServiceParameter.sql


cd ..