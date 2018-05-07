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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/Createlayer2-VPWS.xsl,v $
# $Revision: 1.12 $
# $Date: 2010-10-05 14:19:29 $
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
<xsl:param name="serviceid"/>
<xsl:param name="skip_activation"/>
<xsl:param name="request_synchronisation"/>
<xsl:param name="customerid"/>
<xsl:param name="Customer_name"/>
<xsl:param name="Contact_person"/>
<xsl:param name="Customer_email"/>
<xsl:param name="presname"/>
<xsl:param name="Comment"/>
<xsl:param name="QOS_PROFILE"/>
<xsl:param name="StartTime"/>
<xsl:param name="EndTime"/>
<xsl:param name="operator"/>
<xsl:template match="/">
<msg msg_id="{$messageid}">
   <header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
         <Service_id><xsl:value-of select="$serviceid"/></Service_id>
         <Activation_name>create</Activation_name>
         <Service_name>L2VPWS</Service_name>
      </Service_request>
      <Service_schedule>
         <StartTime><xsl:value-of select="$StartTime"/></StartTime>
         <EndTime><xsl:value-of select="$EndTime"/></EndTime>
      </Service_schedule>
   </header>
   <body>
      <Service  Service_id="{$serviceid}">
        <VPN VPN_type="L2VPWS">
            <VPN_name><xsl:value-of select="$presname"/></VPN_name>
            <VPN_comment><xsl:value-of select="$Comment"/></VPN_comment>
            <VPN_topology>p2p</VPN_topology>
            <Customer_id><xsl:value-of select="$customerid"/></Customer_id>
            <Customer_name><xsl:value-of select="$Customer_name"/></Customer_name>
            <Customer_contact><xsl:value-of select="$Contact_person"/></Customer_contact>
	        <Customer_email><xsl:value-of select="$Customer_email"/></Customer_email>
            <Defaults>
               <QoS>
                  <QoSProfile><xsl:value-of select="$QOS_PROFILE"/></QoSProfile>
               </QoS>
            </Defaults>
         </VPN>
      </Service>
   </body>
</msg>
</xsl:template>
</xsl:stylesheet>

