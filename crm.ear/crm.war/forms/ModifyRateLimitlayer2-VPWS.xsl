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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/ModifyRateLimitlayer2-VPWS.xsl,v $
# $Revision: 1.7 $
# $Date: 2010-10-05 14:19:31 $
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
	<xsl:param name="service_response"/>
	<xsl:param name="Region"/>
	<xsl:param name="StartTime"/>
	<xsl:param name="EndTime"/>
	<xsl:param name="CAR"/>
	<xsl:param name="Site_Attachment_ID_zEnd"/>
	<xsl:param name="Site_Attachment_ID_aEnd"/>
	<xsl:param name="Period"/>
	<xsl:param name="request_synchronisation"/>
	<xsl:param name="Duration"/>
	<xsl:param name="RL"/>
	<xsl:param name="operator"/>
	<xsl:template match="/">
		<msg msg_id="{$messageid}">
			<header>
				<Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
					<Service_id>
						<xsl:value-of select="$Site_Attachment_ID_aEnd"/>
					</Service_id>
					<Activation_name>modify_QoS</Activation_name>
					<Service_name>L2VPWSSiteAttachment</Service_name>
				</Service_request>
				<Service_schedule>
					<StartTime>
						<xsl:value-of select="$StartTime"/>
					</StartTime>
					<EndTime>
						<xsl:value-of select="$EndTime"/>
					</EndTime>
					<Recurrency Repeat="{$Period}" Until="{$Duration}"/>
				</Service_schedule>
			</header>
			<body>
				<Service Action="modify_QoS" Service_id="{$Site_Attachment_ID_aEnd}">
					<SiteAttachment Attachment_type="L2VPWS">
						<QoS>
							<Rate_limit>
								<xsl:value-of select="$RL"/>
							</Rate_limit>
						</QoS>
					</SiteAttachment>
				</Service>
				<Service Action="modify_QoS" Service_id="{$Site_Attachment_ID_zEnd}">
					<SiteAttachment Attachment_type="L2VPWS">
						<QoS>
							<Rate_limit>
								<xsl:value-of select="$RL"/>
							</Rate_limit>
						</QoS>
					</SiteAttachment>
				</Service>
			</body>
		</msg>
	</xsl:template>
</xsl:stylesheet>
