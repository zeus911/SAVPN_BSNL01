<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<!--
###############################################################################
#
#		****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
###############################################################################
###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/ModifyMulticastlayer3-VPN.xsl,v $
# $Revision: 1.7 $
# $Date: 2010-10-05 14:19:30 $
# $Author: shiva $
#
###############################################################################
#
# <Description> 
#
###############################################################################
-->

<xsl:output method="xml" indent="yes" xalan:indent-amount="2" encoding="UTF-8" xmlns:xalan="http://xml.apache.org/xslt"/>
<xsl:param name="messageid"/>
<xsl:param name="skip_activation"/>
<xsl:param name="request_synchronisation"/>
<xsl:param name="serviceid"/>
<xsl:param name="MulticastStatus"/>
<xsl:param name="MulticastVPNId"/>
<xsl:param name="MulticastMode"/>
<xsl:param name="operator"/>
<xsl:template match="/">
<msg msg_id="{$messageid}">
  <header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
      <Service_id><xsl:value-of select="$serviceid"/></Service_id>
      <Activation_name>modify_Multicast</Activation_name>
      <Service_name>L3VPN</Service_name>
    </Service_request>
  </header>
  <body>
  <Service Service_id="{$serviceid}">
    <VPN VPN_type="L3VPN">
	<Multicast Multicast_state="{$MulticastStatus}">
	  <MulticastVPN_id><xsl:value-of select="$MulticastVPNId"/></MulticastVPN_id>
	  <Multicast_mode><xsl:value-of select="$MulticastMode"/></Multicast_mode>
	</Multicast>
    </VPN>
    </Service>
  </body>
</msg>
</xsl:template>
</xsl:stylesheet>
