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
<xsl:param name="Contact_person"/>
<xsl:param name="Comment"/>
<xsl:param name="StartTime"/>
<xsl:param name="EndTime"/>
<xsl:param name="PW_aEnd"/>
<xsl:param name="aEnd_Site_address"/>
<xsl:param name="Site_Service_ID_aEnd"/>
<xsl:param name="PW_aEnd_region"/>
<xsl:param name="PW_zEnd"/>
<xsl:param name="zEnd_Site_address"/>
<xsl:param name="Site_Service_ID_zEnd"/>
<xsl:param name="PW_zEnd_region"/>
<xsl:param name="operator"/>
<xsl:template match="/">
<msg msg_id="{$messageid}">
   <header>
    <Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
         <Service_id><xsl:value-of select="$serviceid"/></Service_id>
         <Activation_name>create</Activation_name>
         <Service_name>Site</Service_name>         
      </Service_request>
      <Service_schedule>
         <StartTime><xsl:value-of select="$StartTime"/></StartTime>
         <EndTime><xsl:value-of select="$EndTime"/></EndTime>
      </Service_schedule>
   </header>
   <body>
      <Service Action="create" Service_id="{$Site_Service_ID_aEnd}">
      <VPNSite>
			  <Site_name><xsl:value-of select="$PW_aEnd"/></Site_name>
               <Site_address><xsl:value-of select="$aEnd_Site_address"/></Site_address>
               <Site_contact><xsl:value-of select="$Contact_person"/></Site_contact> 
               <Site_comment><xsl:value-of select="$Comment"/></Site_comment>
               <Site_region><xsl:value-of select="$PW_aEnd_region"/></Site_region>
            <Customer_id><xsl:value-of select="$customerid"/></Customer_id>
            </VPNSite>
             </Service>
             <Service Action="create" Service_id="{$Site_Service_ID_zEnd}">
             <VPNSite>
           <Site_name><xsl:value-of select="$PW_zEnd"/></Site_name>
               <Site_address><xsl:value-of select="$zEnd_Site_address"/></Site_address>
               <Site_contact><xsl:value-of select="$Contact_person"/></Site_contact> 
               <Site_comment><xsl:value-of select="$Comment"/></Site_comment>
               <Site_region><xsl:value-of select="$PW_zEnd_region"/></Site_region>
            <Customer_id><xsl:value-of select="$customerid"/></Customer_id>            
            </VPNSite>
       </Service>
   </body>
</msg>
</xsl:template>
</xsl:stylesheet>
