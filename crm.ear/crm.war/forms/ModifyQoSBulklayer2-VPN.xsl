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
<xsl:param name="operator"/>
<xsl:param name="activation_name"/>
<xsl:template match="/">
<msg msg_id="{$messageid}">
  <header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
      <Service_id><xsl:value-of select="$serviceid"/></Service_id>
      <Activation_name><xsl:value-of select="$activation_name"/></Activation_name>
      <Service_name>L2VPN</Service_name>
    </Service_request>
  </header>
  <body>
  <Service Service_id="{$serviceid}">
	 <SiteAttachment Attachment_type="L2VPN">
	  <VPN_id><xsl:value-of select="$serviceid"/></VPN_id>
    </SiteAttachment>
    </Service>
  </body>
</msg>
</xsl:template>
</xsl:stylesheet>
