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
<xsl:template match="/">
<msg msg_id="{$messageid}">
  <header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
      <Service_id><xsl:value-of select="$serviceid"/></Service_id>
      <Activation_name>modify_LSPUsageMode</Activation_name>
      <Service_name>L3SiteAttachment</Service_name>
    </Service_request>
  </header>
  <body>
    <Service Service_id="{$serviceid}">
      <SiteAttachment Attachment_type="L3VPN">
      <LSP>
        <UsageMode><xsl:value-of select="$lspusagemode"/></UsageMode>
      </LSP>
    </SiteAttachment>
    </Service>
  </body>
</msg>
</xsl:template>
</xsl:stylesheet>
