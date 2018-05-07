<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
# $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/forms/Createlayer3-Attachment.xsl,v $
# $Revision: 1.11 $
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
	<xsl:param name="skip_activation"/>
	<xsl:param name="request_synchronisation"/>
	<xsl:param name="serviceid"/>
	<xsl:param name="STATIC_Routes"/>
	<xsl:param name="Region"/>
	<xsl:param name="StartTime"/>
	<xsl:param name="EndTime"/>
	<xsl:param name="parentserviceid"/>
	<xsl:param name="vpnserviceid"/>
	<xsl:param name="Location"/>
	<xsl:param name="Comment"/>
	<xsl:param name="presname"/>
	<xsl:param name="Attachmenttype"/>
	<xsl:param name="Activation_Scope"/>
	<xsl:param name="ConnectivityType"/>
	<xsl:param name="RoutingProtocol"/>
	<xsl:param name="OSPF_Area"/>
	<xsl:param name="Customer_ASN"/>
	<xsl:param name="AddressPool"/>
	<xsl:param name="SecondaryAddressPool"/>
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
	<xsl:param name="ServiceMultiplexing"/>
	<xsl:param name="Managed_CE_Router"/>
	<xsl:param name="Max_prefixes"/>
	<xsl:param name="Address_type"/>
	<xsl:param name="AddressFamily"/>
	<xsl:param name="hidden_activate_CE"/>
	<xsl:param name="operator"/> 
	<xsl:param name="lspusagemode"/>
	<xsl:param name="QoSChildEnabled"/>
	<xsl:template name="strsplit">
		<xsl:param name="src"/>
		<xsl:choose>
			<xsl:when test="contains($src,',')">
				<xsl:element name="Static_route">
					<xsl:value-of select="substring-before($src,',')"/>
				</xsl:element>
				<xsl:call-template name="strsplit">
					<xsl:with-param name="src" select="substring-after($src,',')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="Static_route">
					<xsl:value-of select="$src"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="/">
		<msg msg_id="{$messageid}">
			<header>
				<Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
					<Service_id>
						<xsl:value-of select="$serviceid"/>
					</Service_id>
					<Activation_name>add</Activation_name>
					<Service_name>L3SiteAttachment</Service_name>
				</Service_request>
				<Service_schedule>
					<StartTime>
						<xsl:value-of select="$StartTime"/>
					</StartTime>
					<EndTime>
						<xsl:value-of select="$EndTime"/>
					</EndTime>
				</Service_schedule>
			</header>
			<body>
				<Service Service_id="{$serviceid}">
					<xsl:attribute name="Action">
						<xsl:choose>
							<xsl:when test="$hidden_activate_CE= 'true'">
								<xsl:value-of select="'Activate_CE'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'add'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<SiteAttachment Attachment_type="L3VPN" Attachment_role="{$Attachmenttype}">
						<Attachment_name>
							<xsl:value-of select="$presname"/>
						</Attachment_name>
						<Attachment_location>
							<xsl:value-of select="$Location"/>
						</Attachment_location>
						<Attachment_comment>
							<xsl:value-of select="$Comment"/>
						</Attachment_comment>
						<Activation_scope Managed_CE="{$Managed_CE_Router}">
							<xsl:choose>
								<xsl:when test='$hidden_activate_CE="true"'>
									<xsl:value-of select="'CE_ONLY'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$Activation_Scope"/>
								</xsl:otherwise>
							</xsl:choose>
						</Activation_scope>
						<Connectivity Type="{$ConnectivityType}"/>
						<VPN_id>
							<xsl:value-of select="$vpnserviceid"/>
						</VPN_id>
						<Site_id>
							<xsl:value-of select="$parentserviceid"/>
						</Site_id>
						<L3Resources Attachment_Address_family="{$AddressFamily}">
							<Routing Protocol="{$RoutingProtocol}" Address_type="{$AddressFamily}">
								<xsl:choose>
									<xsl:when test="$RoutingProtocol='RIP'">
										<RIP/>
									</xsl:when>
									<xsl:when test="$RoutingProtocol='OSPF'">
										<OSPF Area="{$OSPF_Area}"/>
									</xsl:when>
									<xsl:when test="$RoutingProtocol='BGP'">
										<BGP Customer_ASN="{$Customer_ASN}" Max_prefixes="{$Max_prefixes}"/>
									</xsl:when>
									<xsl:when test="$RoutingProtocol='STATIC'">
										<xsl:value-of select="$STATIC_Routes"/>
									</xsl:when>
								</xsl:choose>
							</Routing>
							<AddressPool Pool_name="{$AddressPool}" Address_type="{$AddressFamily}" />
							<xsl:if test="$SecondaryAddressPool!='-none-' and $SecondaryAddressPool!=''">
								<SecondaryAddressPool Pool_name="{$SecondaryAddressPool}" Address_type="{$AddressFamily}" />
							</xsl:if>
						</L3Resources>
						<QoS>
							<Rate_limit>
								<xsl:value-of select="$CAR"/>
							</Rate_limit>
							<QoSProfile>
								<xsl:value-of select="$QOS_PROFILE"/>
							</QoSProfile>
							<BaseProfile>
								<xsl:value-of select="$QOS_BASE_PROFILE"/>
							</BaseProfile>
							<Percent0>
								<xsl:value-of select="$QOS_CLASS_0_PERCENT"/>
							</Percent0>
							<Percent1>
								<xsl:value-of select="$QOS_CLASS_1_PERCENT"/>
							</Percent1>
							<Percent2>
								<xsl:value-of select="$QOS_CLASS_2_PERCENT"/>
							</Percent2>
							<Percent3>
								<xsl:value-of select="$QOS_CLASS_3_PERCENT"/>
							</Percent3>
							<Percent4>
								<xsl:value-of select="$QOS_CLASS_4_PERCENT"/>
							</Percent4>
							<Percent5>
								<xsl:value-of select="$QOS_CLASS_5_PERCENT"/>
							</Percent5>
							<Percent6>
								<xsl:value-of select="$QOS_CLASS_6_PERCENT"/>
							</Percent6>
							<Percent7>
								<xsl:value-of select="$QOS_CLASS_7_PERCENT"/>
							</Percent7>
							<CE_based_QoS>
								<xsl:value-of select="$CE_based_QoS"/>
							</CE_based_QoS>
							<QoSChildEnabled>
								<xsl:value-of select="$QoSChildEnabled"/>
							</QoSChildEnabled>
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
