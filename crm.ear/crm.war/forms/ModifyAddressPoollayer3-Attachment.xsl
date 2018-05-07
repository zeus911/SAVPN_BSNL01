<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<!--
###############################################################################
#
#		****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2014 Hewlett-Packard Development Company, L.P. 
#
###############################################################################
-->

<xsl:output method="xml" indent="yes" xalan:indent-amount="2" encoding="UTF-8" xmlns:xalan="http://xml.apache.org/xslt"/>
<xsl:param name="messageid"/>
<xsl:param name="skip_activation"/>
<xsl:param name="request_synchronisation"/>
<xsl:param name="serviceid"/>
<xsl:param name="operator"/>
<xsl:param name="Activation_Scope"/>
<xsl:param name="Managed_CE_Router"/>
<xsl:param name="AddressPool"/>
<xsl:param name="SecondaryAddressPool"/>
<xsl:param name="AddressFamily"/>
<xsl:param name="parentserviceid"/>
<xsl:param name="vpnserviceid"/>
<xsl:template match="/">
<msg msg_id="{$messageid}">
<header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
      <Service_id><xsl:value-of select="$serviceid"/></Service_id>
      <Activation_name>modify_AddressPool</Activation_name>
      <Service_name>L3SiteAttachment</Service_name>
    </Service_request>
</header>
  <body>
	<Service Service_id="{$serviceid}">
      <SiteAttachment Attachment_type="L3VPN">
		<Activation_scope Managed_CE="{$Managed_CE_Router}">
			<xsl:value-of select="$Activation_Scope"/>
		</Activation_scope>
		<VPN_id>
			<xsl:value-of select="$vpnserviceid"/>
		</VPN_id>
		<Site_id>
			<xsl:value-of select="$parentserviceid"/>
		</Site_id>
		<L3Resources Attachment_Address_family="{$AddressFamily}">
			<AddressPool Pool_name="{$AddressPool}" Address_type="{$AddressFamily}" />
			<xsl:if test="$SecondaryAddressPool!='-none-' and $SecondaryAddressPool!=''">
				<SecondaryAddressPool Pool_name="{$SecondaryAddressPool}" Address_type="{$AddressFamily}" />
			</xsl:if>
		</L3Resources>
	  </SiteAttachment>
    </Service>
  </body>
</msg>
</xsl:template>
</xsl:stylesheet>
