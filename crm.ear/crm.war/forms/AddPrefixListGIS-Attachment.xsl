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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/AddPrefixListGIS-Attachment.xsl,v $
# $Revision: 1.7 $
# $Date: 2010-10-05 14:19:28 $
# $Author: Anu $
#
###############################################################################
#
# <Description> 
#
###############################################################################
-->

<xsl:output method="xml" indent="yes" xalan:indent-amount="2" encoding="UTF-8" xmlns:xalan="http://xml.apache.org/xslt"/>
<xsl:param name="messageid"/>
<xsl:param name="request_synchronisation"/>
<xsl:param name="serviceid"/>
<xsl:param name="skip_activation"/>
<xsl:param name="PREFIX_Routes"/>
<xsl:param name="AddressFamily" />
<xsl:param name="operator"/>
<xsl:template name="strsplit">
<xsl:param name="src"/>
    <xsl:choose>
        <xsl:when test="contains($src,',')">
            <xsl:element name="Prefix_route">
                <xsl:value-of select="substring-before($src,',')"/>
            </xsl:element>
            <xsl:call-template name="strsplit">
                <xsl:with-param name="src" select="substring-after($src,',')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="Prefix_route">
            <xsl:value-of select="$src"/>
            </xsl:element>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>          
<xsl:template match="/">
<msg msg_id="{$messageid}">
<header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
      <Service_id><xsl:value-of select="$serviceid"/></Service_id>
      <Activation_name>modify_PrefixList</Activation_name>
      <Service_name>GISSiteAttachment</Service_name>
    </Service_request>
</header>
<body>
    <Service Service_id="{$serviceid}">
        <SiteAttachment Attachment_type="GISVPN">
            <L3Resources Attachment_Address_family="{$AddressFamily}">
                <Routing Protocol="BGP" Address_type="{$AddressFamily}">
<xsl:call-template name="strsplit">
       <xsl:with-param name="src" select="$PREFIX_Routes"/>
</xsl:call-template>
                </Routing>
            </L3Resources>
        </SiteAttachment>
    </Service>
</body>
</msg>
</xsl:template>
</xsl:stylesheet>
