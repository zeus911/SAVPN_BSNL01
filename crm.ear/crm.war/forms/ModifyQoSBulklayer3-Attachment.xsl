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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/ModifyQoSProfilelayer3-Attachment.xsl,v $
# $Revision: 1.8 $
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
<xsl:param name="Region"/>
<xsl:param name="StartTime"/>
<xsl:param name="EndTime"/>
<xsl:param name="CAR"/>
<xsl:param name="QOS_PROFILE"/>
<xsl:param name="QOS_BASE_PROFILE"/>
<xsl:param name="QOS_CLASS_0_PERCENT"/>
<xsl:param name="QOS_CLASS_1_PERCENT"/>
<xsl:param name="QOS_CLASS_2_PERCENT"/>
<xsl:param name="QOS_CLASS_3_PERCENT"/>
<xsl:param name="QOS_CLASS_4_PERCENT"/>
<xsl:param name="QOS_CLASS_5_PERCENT"/>
<xsl:param name="QOS_CLASS_6_PERCENT"/>
<xsl:param name="QOS_CLASS_7_PERCENT"/>
<xsl:param name="CE_based_QoS"/>
<xsl:param name="Period"/>
<xsl:param name="Duration"/>
<xsl:param name="operator"/>
<xsl:param name="QoSChildEnabled"/>
<xsl:template match="/">
<msg msg_id="{$messageid}">
<header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
      <Service_id><xsl:value-of select="$serviceid"/></Service_id>
      <Activation_name>modify_QoS</Activation_name>
      <Service_name>L3SiteAttachment</Service_name>
    </Service_request>
    <Service_schedule>
      <StartTime><xsl:value-of select="$StartTime"/></StartTime>
      <EndTime><xsl:value-of select="$EndTime"/></EndTime>
      <Recurrency Repeat="{$Period}" Until="{$Duration}"/>
    </Service_schedule>
</header>
  <body>
  <Service Service_id="{$serviceid}">
    <SiteAttachment Attachment_type="L3VPN">
      <QoS>
        <Rate_limit><xsl:value-of select="$CAR"/></Rate_limit>
        <QoSProfile><xsl:value-of select="$QOS_PROFILE"/></QoSProfile>
        <BaseProfile><xsl:value-of select="$QOS_BASE_PROFILE"/></BaseProfile>
        <Percent0><xsl:value-of select="$QOS_CLASS_0_PERCENT"/></Percent0>
        <Percent1><xsl:value-of select="$QOS_CLASS_1_PERCENT"/></Percent1>
        <Percent2><xsl:value-of select="$QOS_CLASS_2_PERCENT"/></Percent2>
        <Percent3><xsl:value-of select="$QOS_CLASS_3_PERCENT"/></Percent3>
        <Percent4><xsl:value-of select="$QOS_CLASS_4_PERCENT"/></Percent4>
        <Percent5><xsl:value-of select="$QOS_CLASS_5_PERCENT"/></Percent5>
        <Percent6><xsl:value-of select="$QOS_CLASS_6_PERCENT"/></Percent6>
        <Percent7><xsl:value-of select="$QOS_CLASS_7_PERCENT"/></Percent7>
        <CE_based_QoS><xsl:value-of select="$CE_based_QoS"/></CE_based_QoS>
		<QoSChildEnabled><xsl:value-of select="$QoSChildEnabled"/></QoSChildEnabled>
      </QoS>
    </SiteAttachment>
    </Service>   
  </body>
</msg>
</xsl:template>
</xsl:stylesheet>
