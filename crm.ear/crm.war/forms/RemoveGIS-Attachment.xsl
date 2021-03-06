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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/RemoveGIS-Attachment.xsl,v $
# $Revision: 1.8 $
# $Date: 2010-10-05 14:19:29 $
# $Author: Anu D $
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
<xsl:param name="StartTime"/>
<xsl:param name="EndTime"/>
<xsl:param name="parentserviceid"/>
<xsl:param name="vpnserviceid"/>
<xsl:param name="operator"/> 
<xsl:template match="/">
<msg msg_id="{$messageid}">
  <header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
      <Service_id><xsl:value-of select="$serviceid"/></Service_id>
      <Activation_name>remove</Activation_name>
      <Service_name>GISSiteAttachment</Service_name>
    </Service_request>	
   </header>
   <body>
   <Service Service_id="{$serviceid}">
	<SiteAttachment Attachment_type="GISVPN">
	<VPN_id><xsl:value-of select="$vpnserviceid"/></VPN_id>
	<Site_id><xsl:value-of select="$parentserviceid"/></Site_id>
   </SiteAttachment>
 </Service>
</body>
</msg>
</xsl:template>
</xsl:stylesheet>
