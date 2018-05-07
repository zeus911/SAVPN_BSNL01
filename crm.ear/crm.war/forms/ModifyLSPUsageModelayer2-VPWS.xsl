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
<xsl:param name="lspusagemode"/>
<xsl:param name="operator"/>
<xsl:param name="Site_Attachment_ID_zEnd"/>
<xsl:param name="Site_Attachment_ID_aEnd"/>
<xsl:template match="/">
<msg msg_id="{$messageid}">
  <header>
	<Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
		<Service_id>
			<xsl:value-of select="$Site_Attachment_ID_aEnd"/>
		</Service_id>
		<Activation_name>modify_LSPUsageMode</Activation_name>
		<Service_name>L2VPWSSiteAttachment</Service_name>
	</Service_request>
  </header>
  <body>
	<Service Action="modify_LSPUsageMode" Service_id="{$Site_Attachment_ID_aEnd}">
		<SiteAttachment Attachment_type="L2VPWS">
			<LSP>
				<UsageMode><xsl:value-of select="$lspusagemode"/></UsageMode>
			</LSP>
		</SiteAttachment>
	</Service>
	<Service Action="modify_LSPUsageMode" Service_id="{$Site_Attachment_ID_zEnd}">
		<SiteAttachment Attachment_type="L2VPWS">
			<LSP>
				<UsageMode><xsl:value-of select="$lspusagemode"/></UsageMode>
			</LSP>
		</SiteAttachment>
	</Service>
  </body>
</msg>
</xsl:template>
</xsl:stylesheet>
