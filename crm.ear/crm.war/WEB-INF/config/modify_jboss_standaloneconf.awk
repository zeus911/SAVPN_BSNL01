###############################################################################
#
#   ****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
###############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/etc/config/modify_jboss_log4j.awk,v $
# $Revision: 1.5 $
# $Date: 2010-10-05 15:33:40 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################
BEGIN { hpsa_ear_found = 0; hpsa_ear_check_found = 0; }

/set HPSA_EAR_FAILED/   { 
  hpsa_ear_found = 1;
}
/touch/   { 
  hpsa_ear_found = 1;
}

   { print }

/set HPSA_EAR_FAILED/ {
  if (hpsa_ear_found==1) {
	print " "
	printf("set CRM_EAR_DODEPLOY=%s/crm.ear.dodeploy\n",jboss_deploy);
	printf("set CRM_EAR_DEPLOYED=%s/crm.ear.deployed\n",jboss_deploy);
        printf("set CRM_EAR_FAILED=%s/crm.ear.failed\n",jboss_deploy);
	print " "
	hpsa_ear_found = 0;
  }
}
/touch/ {
  if (hpsa_ear_found==1) {
	print " "
	print "rm -f /opt/HP/jboss/standalone/deployments/crm.ear.failed"
	print "rm -f /opt/HP/jboss/standalone/deployments/crm.ear.dodeploy"
	print "rm -f /opt/HP/jboss/standalone/deployments/crm.ear.deployed"
	print "rm -f /opt/HP/jboss/standalone/deployments/crm.ear.deploying"
	print "touch /opt/HP/jboss/standalone/deployments/crm.ear.dodeploy"
	print " "
	hpsa_ear_found = 0;
  }
}

/HPSA_EAR_DEPLOYED/	{
	hpsa_ear_check_found = 1;
}
  
 /echo hpsa >/ {
  if (hpsa_ear_check_found==1) {
      if (os_type == "WINDOWS") {
	  print " "
          print "if exist \"%CRM_EAR_DEPLOYED%\" (";
          print "  del \"%CRM_EAR_DEPLOYED%\"";
          print ")";
	  print " "
          print "if exist \"%CRM_EAR_FAILED%\" (";
          print "  del \"%CRM_EAR_FAILED%\"";
          print ")";
	  print " "
          print "if exist \"%CRM_EAR_DODEPLOY%\" (";
          print "  del \"%CRM_EAR_DODEPLOY%\"";
          print ")";
	  print " "
	  print "echo crm > %CRM_EAR_DODEPLOY%";
      }
	hpsa_ear_check_found = 0;
   }
  }

