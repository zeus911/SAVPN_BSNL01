<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<!--
###############################################################################
#
#		****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. 
#
###############################################################################
###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/AddL2VPWS-Attachment.xsl,v $
# $Revision: 1.0 $
# $Date: 2011-07-24 $
# $Author: Ramesh $
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
<xsl:param name="Comment"/>
<xsl:param name="RL"/>
<xsl:param name="QOS_PROFILE"/>
<xsl:param name="StartTime"/>
<xsl:param name="EndTime"/>
<xsl:param name="PW_aEnd"/>
<xsl:param name="Site_Service_ID_aEnd"/>
<xsl:param name="Site_Attachment_ID_aEnd"/>
<xsl:param name="PW_aEnd_location"/>
<xsl:param name="UNIType_aEnd"/>
<xsl:param name="VLANIdaEnd"/>
<xsl:param name="DLCIaEnd"/>
<xsl:param name="PW_zEnd"/>
<xsl:param name="Site_Service_ID_zEnd"/>
<xsl:param name="Site_Attachment_ID_zEnd"/>
<xsl:param name="PW_zEnd_location"/>
<xsl:param name="UNIType_zEnd"/>
<xsl:param name="VLANIdzEnd"/>
<xsl:param name="DLCIzEnd"/>
<xsl:param name="vpn_id"/>
<xsl:param name="operator"/>
<xsl:param name="lspusagemode"/>
<xsl:param name="Vlan_Flag_aEnd"/>
<xsl:param name="Vlan_Flag_zEnd"/>

<xsl:template match="/">
<msg msg_id="{$messageid}">
   <header>
    <Service_request Mode="{$skip_activation}" Response="{$request_synchronisation}" Operator="{$operator}">
         <Service_id><xsl:value-of select="$Site_Attachment_ID_aEnd"/></Service_id>
         <Activation_name>add</Activation_name>
         <Service_name>L2VPWSSiteAttachment</Service_name>
      </Service_request>
      <Service_schedule>
         <StartTime><xsl:value-of select="$StartTime"/></StartTime>
         <EndTime><xsl:value-of select="$EndTime"/></EndTime>
      </Service_schedule>
   </header>
   <body>
      <Service Action="add" Service_id="{$Site_Attachment_ID_aEnd}">
            <SiteAttachment Attachment_type="L2VPWS"  Attachment_role="initial">
                <Attachment_name><xsl:value-of select="$PW_aEnd"/>-L2VPWSAttachment</Attachment_name>
                <Attachment_location><xsl:value-of select="$PW_aEnd_location"/></Attachment_location>
                <Attachment_comment><xsl:value-of select="$Comment"/></Attachment_comment>
                <Activation_scope Managed_CE="false">PE_only</Activation_scope>
                <Connectivity Type="p2p"/>
                <VPN_id><xsl:value-of select="$vpn_id"/></VPN_id>
                <Site_id><xsl:value-of select="$Site_Service_ID_aEnd"/></Site_id>
                <L2Resources>
                   <UNI_type><xsl:value-of select="$UNIType_aEnd"/></UNI_type>
                    <UNI_flag><xsl:value-of select="$Vlan_Flag_aEnd"/></UNI_flag>
                   <DLCI><xsl:value-of select="$DLCIaEnd"/></DLCI>
                   <VLAN_id>
                        <xsl:choose>
                            <xsl:when test="$VLANIdaEnd=''">0</xsl:when>
                            <xsl:otherwise><xsl:value-of select="$VLANIdaEnd"/></xsl:otherwise>
                        </xsl:choose>
                   </VLAN_id>
                </L2Resources>
                <QoS>
                    <Rate_limit><xsl:value-of select="$RL"/></Rate_limit>
                    <QoSProfile><xsl:value-of select="$QOS_PROFILE"/></QoSProfile>
                </QoS>
				<LSP>
					<UsageMode>
						<xsl:value-of select="$lspusagemode"/>
					</UsageMode>
				</LSP>
            </SiteAttachment>
        </Service>
        <Service Action="add" Service_id="{$Site_Attachment_ID_zEnd}">
            <SiteAttachment Attachment_type="L2VPWS"  Attachment_role="initial">
                <Attachment_name><xsl:value-of select="$PW_zEnd"/>-L2VPWSAttachment</Attachment_name>
                <Attachment_location><xsl:value-of select="$PW_zEnd_location"/></Attachment_location>
                <Attachment_comment><xsl:value-of select="$Comment"/></Attachment_comment>
                <Activation_scope Managed_CE="false">PE_only</Activation_scope>
                <Connectivity Type="p2p"/>
                <VPN_id><xsl:value-of select="$vpn_id"/></VPN_id>
                <Site_id><xsl:value-of select="$Site_Service_ID_zEnd"/></Site_id>
                <L2Resources>
                   <UNI_type><xsl:value-of select="$UNIType_zEnd"/></UNI_type>
                     <UNI_flag><xsl:value-of select="$Vlan_Flag_zEnd"/></UNI_flag>
                   <DLCI><xsl:value-of select="$DLCIzEnd"/></DLCI>
                   <VLAN_id>
                        <xsl:choose>
                            <xsl:when test="$VLANIdzEnd=''">0</xsl:when>
                            <xsl:otherwise><xsl:value-of select="$VLANIdzEnd"/></xsl:otherwise>
                        </xsl:choose>
                   </VLAN_id>
                </L2Resources>
                <QoS>
                    <Rate_limit><xsl:value-of select="$RL"/></Rate_limit>
                    <QoSProfile><xsl:value-of select="$QOS_PROFILE"/></QoSProfile>
                </QoS>
				<LSP>
					<UsageMode>
						<xsl:value-of select="$lspusagemode"/>
					</UsageMode>
				</LSP>
            </SiteAttachment>
      </Service>
   </body>
</msg>
</xsl:template>
</xsl:stylesheet>
