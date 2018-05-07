<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<!--
###############################################################################
#
# 2017
#
###############################################################################
-->

<xsl:output method="xml" indent="yes" xalan:indent-amount="2" encoding="UTF-8" xmlns:xalan="http://xml.apache.org/xslt"/>
<xsl:param name="messageid"/>
<xsl:param name="serviceid"/>
<xsl:param name="skip_activation"/>
<xsl:param name="request_synchronisation"/>
<xsl:param name="Trunk_Type"/>
<xsl:param name="Site_Service_ID_aEnd"/>
<xsl:param name="Site_Service_ID_zEnd"/>
<xsl:param name="EndA_name"/>
<xsl:param name="EndZ_name"/>
<xsl:param name="PW_aEnd_region"/>
<xsl:param name="PW_zEnd_region"/>
<xsl:param name="PW_aEnd_location"/>
<xsl:param name="PW_zEnd_location"/>
<xsl:param name="PERouter_aEnd"/>
<xsl:param name="PERouter_zEnd"/>
<xsl:param name="AddressPool_aEnd"/>
<xsl:param name="AddressPool_zEnd"/>
<xsl:param name="trunk_ipaddress_aEnd"/>
<xsl:param name="trunk_ipaddress_zEnd"/>
<xsl:param name="ip_submask_aEnd"/>
<xsl:param name="ip_submask_zEnd"/>
<xsl:param name="trunk_policy_aside"/>
<xsl:param name="trunk_policy_zside"/>
<xsl:param name="ip_networkIP_aEnd"/>
<xsl:param name="ip_networkIP_zEnd"/>
<xsl:param name="wildcard_aEnd"/>
<xsl:param name="wildcard_zEnd"/>
<xsl:param name="Traffic_policy_io_aend"/>
<xsl:param name="Traffic_policy_io_zend"/>
<xsl:param name="IPv6_family_aEnd"/>
<xsl:param name="IPv6_family_zEnd"/>
<xsl:param name="IPv6_Pool_aEnd"/>
<xsl:param name="IPv6_Pool_zEnd"/>
<xsl:param name="IPv6_Address_aEnd"/>
<xsl:param name="IPv6_Address_zEnd"/>
<xsl:param name="trunk_aside_processid"/>
<xsl:param name="trunk_zside_processid"/>
<xsl:param name="area_number_aside"/>
<xsl:param name="area_number_zside"/>
<xsl:param name="lnk_Protocol_aside"/>
<xsl:param name="lnk_Protocol_zside"/>
<xsl:param name="pim_name_aside"/>
<xsl:param name="pim_name_zside"/>
<xsl:param name="network_type_aside"/>
<xsl:param name="network_type_zside"/>
<xsl:param name="trunk_negotiation_aside"/>
<xsl:param name="trunk_negotiation_zside"/>
<xsl:param name="ospf_aside"/>
<xsl:param name="ospf_zside"/>
<xsl:param name="Sub_ospf_aside"/>
<xsl:param name="Sub_ospf_zside"/>
<xsl:param name="trunk_ipbinding_aside"/>
<xsl:param name="trunk_ipbinding_zside"/>
<xsl:param name="trunk_aside_ospf_password"/>
<xsl:param name="trunk_zside_ospf_password"/>
<xsl:param name="trunk_aside_toend_router_ip"/>
<xsl:param name="trunk_zside_toend_router_ip"/>
<xsl:param name="trunk_aside_ospf_cost"/>
<xsl:param name="trunk_zside_ospf_cost"/>
<xsl:param name="trunk_aside_mtu"/>
<xsl:param name="trunk_zside_mtu"/>
<xsl:param name="trunk_ldp_aside"/>
<xsl:param name="trunk_ldp_zside"/>
<xsl:param name="trunk_description_aEnd"/>
<xsl:param name="trunk_description_zEnd"/>
<xsl:param name="PEInterface_aEnd"/>
<xsl:param name="PEInterface_zEnd"/>
<xsl:param name="Interface_description_aEnd"/>
<xsl:param name="Interface_description_zEnd"/>
<xsl:param name="Trunk_bandwidth_aEnd"/>
<xsl:param name="Trunk_bandwidth_zEnd"/>
<xsl:param name="Trunk_rsvp_bandwidth_aEnd"/>
<xsl:param name="Trunk_rsvp_bandwidth_zEnd"/>
<xsl:param name="link_type"/>
<xsl:param name="area_number_aEnd"/>
<xsl:param name="area_number_zEnd"/>
<xsl:param name="trunk_aIPbinding"/>
<xsl:param name="trunk_zIPbinding"/>
<xsl:param name="OSPF_aPassword"/>
<xsl:param name="OSPF_zPassword"/>
<xsl:param name="LDP_aPassword"/>
<xsl:param name="LDP_zPassword"/>

<xsl:param name="SubInterfaceName"/>
<xsl:param name="ParentInterface_aEnd"/>
<xsl:param name="ParentInterface_zEnd"/>
<xsl:param name="SubAddressPool_aEnd"/>
<xsl:param name="SubAddressPool_zEnd"/>
<xsl:param name="Sub_ipaddress_aEnd"/>
<xsl:param name="Sub_ipaddress_zEnd"/>
<xsl:param name="Sub_ip_submask_aEnd"/>
<xsl:param name="Sub_ip_submask_zEnd"/>
<xsl:param name="Subtrunk_policy_aside"/>
<xsl:param name="Subtrunk_policy_zside"/>
<xsl:param name="Sub_ip_networkIP_aEnd"/>
<xsl:param name="Sub_ip_networkIP_zEnd"/>
<xsl:param name="Sub_wildcard_aEnd"/>
<xsl:param name="Sub_wildcard_zEnd"/>
<xsl:param name="Sub_IPv6_family_aEnd"/>
<xsl:param name="Sub_IPv6_family_zEnd"/>
<xsl:param name="Sub_IPv6_Pool_aEnd"/>
<xsl:param name="Sub_IPv6_Pool_zEnd"/>
<xsl:param name="Sub_IPv6_Address_aEnd"/>
<xsl:param name="Sub_IPv6_Address_zEnd"/>
<xsl:param name="Subtrunk_processid_aEnd"/>
<xsl:param name="Subtrunk_processid_zEnd"/>
<xsl:param name="SubArea_number_aEnd"/>
<xsl:param name="SubArea_number_zEnd"/>
<xsl:param name="lnk_Protocol_aside"/>
<xsl:param name="lnk_Protocol_zside"/>
<xsl:param name="Sub_pim_name_aside"/>
<xsl:param name="Sub_pim_name_zside"/>
<xsl:param name="Sub_network_type_aside"/>
<xsl:param name="Sub_network_type_zside"/>
<xsl:param name="SubNegotiation_aend"/>
<xsl:param name="SubNegotiation_zend"/>
<xsl:param name="Sub_IPv6_encap_aEnd"/>
<xsl:param name="Sub_IPv6_encap_zEnd"/>
<xsl:param name="Sub_IPv6_binding_aEnd"/>
<xsl:param name="Sub_IPv6_binding_zEnd"/>
<xsl:param name="SubOSPF_aPassword"/>
<xsl:param name="SubOSPF_zPassword"/>
<xsl:param name="SubLDP_aPassword"/>
<xsl:param name="SubLDP_zPassword"/>
<xsl:param name="Subtrunk_ospf_cost_aend"/>
<xsl:param name="Subtrunk_ospf_cost_zend"/>
<xsl:param name="Subtrunk_mtu_aend"/>
<xsl:param name="Subtrunk_mtu_zend"/>
<xsl:param name="Subldp_aend"/>
<xsl:param name="Subldp_zend"/>
<xsl:param name="SubInt_description_aEnd"/>
<xsl:param name="SubInt_description_zEnd"/>

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

<xsl:template name="TrunkSub_Name_split">
	<xsl:param name="SubInterfaceName"/>
	<xsl:param name="ParentInterface_aEnd"/>
	<xsl:param name="ParentInterface_zEnd"/>
	<xsl:param name="SubAddressPool_aEnd"/>
	<xsl:param name="SubAddressPool_zEnd"/>
	<xsl:param name="Sub_ipaddress_aEnd"/>
	<xsl:param name="Sub_ipaddress_zEnd"/>
	<xsl:param name="Sub_ip_submask_aEnd"/>
	<xsl:param name="Sub_ip_submask_zEnd"/>
	<xsl:param name="Subtrunk_policy_aside"/>
	<xsl:param name="Subtrunk_policy_zside"/>
	<xsl:param name="Sub_ip_networkIP_aEnd"/>
	<xsl:param name="Sub_ip_networkIP_zEnd"/>
	<xsl:param name="Sub_wildcard_aEnd"/>
	<xsl:param name="Sub_wildcard_zEnd"/>
	<xsl:param name="Sub_IPv6_family_aEnd"/>
	<xsl:param name="Sub_IPv6_family_zEnd"/>
	<xsl:param name="Sub_IPv6_Pool_aEnd"/>
	<xsl:param name="Sub_IPv6_Pool_zEnd"/>
	<xsl:param name="Sub_IPv6_Address_aEnd"/>
	<xsl:param name="Sub_IPv6_Address_zEnd"/>
	<xsl:param name="Subtrunk_processid_aEnd"/>
	<xsl:param name="Subtrunk_processid_zEnd"/>
	<xsl:param name="SubArea_number_aEnd"/>
	<xsl:param name="SubArea_number_zEnd"/>
	<xsl:param name="lnk_Protocol_aside"/>
	<xsl:param name="lnk_Protocol_zside"/>
	<xsl:param name="Sub_pim_name_aside"/>
	<xsl:param name="Sub_pim_name_zside"/>
	<xsl:param name="Sub_network_type_aside"/>
	<xsl:param name="Sub_network_type_zside"/>
	<xsl:param name="SubNegotiation_aend"/>
	<xsl:param name="SubNegotiation_zend"/>
	
	<xsl:param name="Sub_IPv6_encap_aEnd"/>
	<xsl:param name="Sub_IPv6_encap_zEnd"/>
	
	<xsl:param name="Sub_IPv6_binding_aEnd"/>
	<xsl:param name="Sub_IPv6_binding_zEnd"/>
	<xsl:param name="SubOSPF_aPassword"/>
	<xsl:param name="SubOSPF_zPassword"/>
	<xsl:param name="SubLDP_aPassword"/>
	<xsl:param name="SubLDP_zPassword"/>
	<xsl:param name="Subtrunk_ospf_cost_aend"/>
	<xsl:param name="Subtrunk_ospf_cost_zend"/>
	<xsl:param name="Subtrunk_mtu_aend"/>
	<xsl:param name="Subtrunk_mtu_zend"/>
	<xsl:param name="Subldp_aend"/>
	<xsl:param name="Subldp_zend"/>
	<xsl:param name="SubInt_description_aEnd"/>
	<xsl:param name="SubInt_description_zEnd"/>
	<xsl:choose>
		<xsl:when test="contains($SubInterfaceName,',')">
			<TRUNKSUB>
				<xsl:element name="TrunkSub_Name"><xsl:value-of select="substring-before($SubInterfaceName,',')"/></xsl:element>
				<xsl:element name="TrunkParent_InterfaceEndA"><xsl:value-of select="substring-before($ParentInterface_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkParent_InterfaceEndZ"><xsl:value-of select="substring-before($ParentInterface_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Pool"><xsl:value-of select="substring-before($SubAddressPool_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Pool"><xsl:value-of select="substring-before($SubAddressPool_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Address"><xsl:value-of select="substring-before($Sub_ipaddress_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Address"><xsl:value-of select="substring-before($Sub_ipaddress_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Submask"><xsl:value-of select="substring-before($Sub_ip_submask_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Submask"><xsl:value-of select="substring-before($Sub_ip_submask_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Policy"><xsl:value-of select="substring-before($Subtrunk_policy_aside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Policy"><xsl:value-of select="substring-before($Subtrunk_policy_zside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_NetworkIP"><xsl:value-of select="substring-before($Sub_ip_networkIP_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_NetworkIP"><xsl:value-of select="substring-before($Sub_ip_networkIP_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Wildcard"><xsl:value-of select="substring-before($Sub_wildcard_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Wildcard"><xsl:value-of select="substring-before($Sub_wildcard_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_IPv6_family"><xsl:value-of select="substring-before($Sub_IPv6_family_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_IPv6_family"><xsl:value-of select="substring-before($Sub_IPv6_family_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_IPv6_Pool"><xsl:value-of select="substring-before($Sub_IPv6_Pool_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_IPv6_Pool"><xsl:value-of select="substring-before($Sub_IPv6_Pool_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_IPv6_Address"><xsl:value-of select="substring-before($Sub_IPv6_Address_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_IPv6_Address"><xsl:value-of select="substring-before($Sub_IPv6_Address_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ProcessID"><xsl:value-of select="substring-before($Subtrunk_processid_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ProcessID"><xsl:value-of select="substring-before($Subtrunk_processid_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Area"><xsl:value-of select="substring-before($SubArea_number_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Area"><xsl:value-of select="substring-before($SubArea_number_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Protocol"><xsl:value-of select="substring-before($lnk_Protocol_aside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Protocol"><xsl:value-of select="substring-before($lnk_Protocol_zside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Pim"><xsl:value-of select="substring-before($Sub_pim_name_aside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Pim"><xsl:value-of select="substring-before($Sub_pim_name_zside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_NetworkType"><xsl:value-of select="substring-before($Sub_network_type_aside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_NetworkType"><xsl:value-of select="substring-before($Sub_network_type_zside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_negotiation"><xsl:value-of select="substring-before($SubNegotiation_aend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_negotiation"><xsl:value-of select="substring-before($SubNegotiation_zend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_encap"><xsl:value-of select="substring-before($Sub_IPv6_encap_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_encap"><xsl:value-of select="substring-before($Sub_IPv6_encap_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ipbinding"><xsl:value-of select="substring-before($Sub_IPv6_binding_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ipbinding"><xsl:value-of select="substring-before($Sub_IPv6_binding_zEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ospf"><xsl:value-of select="substring-before($Sub_ospf_aside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ospf"><xsl:value-of select="substring-before($Sub_ospf_zside,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ospf_cost"><xsl:value-of select="substring-before($Subtrunk_ospf_cost_aend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ospf_cost"><xsl:value-of select="substring-before($Subtrunk_ospf_cost_zend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ospf_password"><xsl:value-of select="substring-before($SubOSPF_aPassword,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ospf_password"><xsl:value-of select="substring-before($SubOSPF_zPassword,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_mtu"><xsl:value-of select="substring-before($Subtrunk_mtu_aend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_mtu"><xsl:value-of select="substring-before($Subtrunk_mtu_zend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_LDP"><xsl:value-of select="substring-before($Subldp_aend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_LDP"><xsl:value-of select="substring-before($Subldp_zend,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ldp_password"><xsl:value-of select="substring-before($SubLDP_aPassword,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ldp_password"><xsl:value-of select="substring-before($SubLDP_zPassword,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Description"><xsl:value-of select="substring-before($SubInt_description_aEnd,',')"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Description"><xsl:value-of select="substring-before($SubInt_description_zEnd,',')"/></xsl:element>
			</TRUNKSUB>
			<xsl:call-template name="TrunkSub_Name_split">
				<xsl:with-param name="SubInterfaceName" select="substring-after($SubInterfaceName,',')"/>
				<xsl:with-param name="ParentInterface_aEnd" select="substring-after($ParentInterface_aEnd,',')"/>
				<xsl:with-param name="ParentInterface_zEnd" select="substring-after($ParentInterface_zEnd,',')"/>
				<xsl:with-param name="SubAddressPool_aEnd" select="substring-after($SubAddressPool_aEnd,',')"/>
				<xsl:with-param name="SubAddressPool_zEnd" select="substring-after($SubAddressPool_zEnd,',')"/>
				<xsl:with-param name="Sub_ipaddress_aEnd" select="substring-after($Sub_ipaddress_aEnd,',')"/>
				<xsl:with-param name="Sub_ipaddress_zEnd" select="substring-after($Sub_ipaddress_zEnd,',')"/>
				<xsl:with-param name="Sub_ip_submask_aEnd" select="substring-after($Sub_ip_submask_aEnd,',')"/>
				<xsl:with-param name="Sub_ip_submask_zEnd" select="substring-after($Sub_ip_submask_zEnd,',')"/>
				<xsl:with-param name="Subtrunk_policy_aside" select="substring-after($Subtrunk_policy_aside,',')"/>
				<xsl:with-param name="Subtrunk_policy_zside" select="substring-after($Subtrunk_policy_zside,',')"/>
				<xsl:with-param name="Sub_ip_networkIP_aEnd" select="substring-after($Sub_ip_networkIP_aEnd,',')"/>
				<xsl:with-param name="Sub_ip_networkIP_zEnd" select="substring-after($Sub_ip_networkIP_zEnd,',')"/>
				<xsl:with-param name="Sub_wildcard_aEnd" select="substring-after($Sub_wildcard_aEnd,',')"/>
				<xsl:with-param name="Sub_wildcard_zEnd" select="substring-after($Sub_wildcard_zEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_family_aEnd" select="substring-after($Sub_IPv6_family_aEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_family_zEnd" select="substring-after($Sub_IPv6_family_zEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_Pool_aEnd" select="substring-after($Sub_IPv6_Pool_aEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_Pool_zEnd" select="substring-after($Sub_IPv6_Pool_zEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_Address_aEnd" select="substring-after($Sub_IPv6_Address_aEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_Address_zEnd" select="substring-after($Sub_IPv6_Address_zEnd,',')"/>
				<xsl:with-param name="Subtrunk_processid_aEnd" select="substring-after($Subtrunk_processid_aEnd,',')"/>
				<xsl:with-param name="Subtrunk_processid_zEnd" select="substring-after($Subtrunk_processid_zEnd,',')"/>
				<xsl:with-param name="SubArea_number_aEnd" select="substring-after($SubArea_number_aEnd,',')"/>
				<xsl:with-param name="SubArea_number_zEnd" select="substring-after($SubArea_number_zEnd,',')"/>
				<xsl:with-param name="lnk_Protocol_aside" select="substring-after($lnk_Protocol_aside,',')"/>
				<xsl:with-param name="lnk_Protocol_zside" select="substring-after($lnk_Protocol_zside,',')"/>
				<xsl:with-param name="Sub_pim_name_aside" select="substring-after($Sub_pim_name_aside,',')"/>
				<xsl:with-param name="Sub_pim_name_zside" select="substring-after($Sub_pim_name_zside,',')"/>
				<xsl:with-param name="Sub_network_type_aside" select="substring-after($Sub_network_type_aside,',')"/>
				<xsl:with-param name="Sub_network_type_zside" select="substring-after($Sub_network_type_zside,',')"/>
				<xsl:with-param name="SubNegotiation_aend" select="substring-after($SubNegotiation_aend,',')"/>
				<xsl:with-param name="SubNegotiation_zend" select="substring-after($SubNegotiation_zend,',')"/>
				<xsl:with-param name="Sub_IPv6_encap_aEnd" select="substring-after($Sub_IPv6_encap_aEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_encap_zEnd" select="substring-after($Sub_IPv6_encap_zEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_binding_aEnd" select="substring-after($Sub_IPv6_binding_aEnd,',')"/>
				<xsl:with-param name="Sub_IPv6_binding_zEnd" select="substring-after($Sub_IPv6_binding_zEnd,',')"/>
				<xsl:with-param name="Sub_ospf_aside" select="substring-after($Sub_ospf_aside,',')"/>
				<xsl:with-param name="Sub_ospf_zside" select="substring-after($Sub_ospf_zside,',')"/>
				<xsl:with-param name="Subtrunk_ospf_cost_aend" select="substring-after($Subtrunk_ospf_cost_aend,',')"/>
				<xsl:with-param name="Subtrunk_ospf_cost_zend" select="substring-after($Subtrunk_ospf_cost_zend,',')"/>
				<xsl:with-param name="SubOSPF_aPassword" select="substring-after($SubOSPF_aPassword,',')"/>
				<xsl:with-param name="SubOSPF_zPassword" select="substring-after($SubOSPF_zPassword,',')"/>
				<xsl:with-param name="Subtrunk_mtu_aend" select="substring-after($Subtrunk_mtu_aend,',')"/>
				<xsl:with-param name="Subtrunk_mtu_zend" select="substring-after($Subtrunk_mtu_zend,',')"/>
				<xsl:with-param name="Subldp_aend" select="substring-after($Subldp_aend,',')"/>
				<xsl:with-param name="Subldp_zend" select="substring-after($Subldp_zend,',')"/>
				<xsl:with-param name="SubLDP_aPassword" select="substring-after($SubLDP_aPassword,',')"/>
				<xsl:with-param name="SubLDP_zPassword" select="substring-after($SubLDP_zPassword,',')"/>
				<xsl:with-param name="SubInt_description_aEnd" select="substring-after($SubInt_description_aEnd,',')"/>
				<xsl:with-param name="SubInt_description_zEnd" select="substring-after($SubInt_description_zEnd,',')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<TRUNKSUB>
				<xsl:element name="TrunkSub_Name"><xsl:value-of select="$SubInterfaceName"/></xsl:element>
				<xsl:element name="TrunkParent_InterfaceEndA"><xsl:value-of select="$ParentInterface_aEnd"/></xsl:element>
				<xsl:element name="TrunkParent_InterfaceEndZ"><xsl:value-of select="$ParentInterface_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Pool"><xsl:value-of select="$SubAddressPool_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Pool"><xsl:value-of select="$SubAddressPool_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Address"><xsl:value-of select="$Sub_ipaddress_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Address"><xsl:value-of select="$Sub_ipaddress_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Submask"><xsl:value-of select="$Sub_ip_submask_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Submask"><xsl:value-of select="$Sub_ip_submask_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Policy"><xsl:value-of select="$Subtrunk_policy_aside"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Policy"><xsl:value-of select="$Subtrunk_policy_zside"/></xsl:element>
				<xsl:element name="TrunkSubEndA_NetworkIP"><xsl:value-of select="$Sub_ip_networkIP_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_NetworkIP"><xsl:value-of select="$Sub_ip_networkIP_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Wildcard"><xsl:value-of select="$Sub_wildcard_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Wildcard"><xsl:value-of select="$Sub_wildcard_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_IPv6_family"><xsl:value-of select="$Sub_IPv6_family_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_IPv6_family"><xsl:value-of select="$Sub_IPv6_family_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_IPv6_Pool"><xsl:value-of select="$Sub_IPv6_Pool_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_IPv6_Pool"><xsl:value-of select="$Sub_IPv6_Pool_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_IPv6_Address"><xsl:value-of select="$Sub_IPv6_Address_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_IPv6_Address"><xsl:value-of select="$Sub_IPv6_Address_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ProcessID"><xsl:value-of select="$Subtrunk_processid_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ProcessID"><xsl:value-of select="$Subtrunk_processid_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Area"><xsl:value-of select="$SubArea_number_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Area"><xsl:value-of select="$SubArea_number_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Protocol"><xsl:value-of select="$lnk_Protocol_aside"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Protocol"><xsl:value-of select="$lnk_Protocol_zside"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Pim"><xsl:value-of select="$Sub_pim_name_aside"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Pim"><xsl:value-of select="$Sub_pim_name_zside"/></xsl:element>
				<xsl:element name="TrunkSubEndA_NetworkType"><xsl:value-of select="$Sub_network_type_aside"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_NetworkType"><xsl:value-of select="$Sub_network_type_zside"/></xsl:element>
				<xsl:element name="TrunkSubEndA_negotiation"><xsl:value-of select="$SubNegotiation_aend"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_negotiation"><xsl:value-of select="$SubNegotiation_zend"/></xsl:element>
				<xsl:element name="TrunkSubEndA_encap"><xsl:value-of select="$Sub_IPv6_encap_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_encap"><xsl:value-of select="$Sub_IPv6_encap_zEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ipbinding"><xsl:value-of select="$Sub_IPv6_binding_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ipbinding"><xsl:value-of select="$Sub_IPv6_binding_zEnd"/></xsl:element>				
				<xsl:element name="TrunkSubEndA_ospf"><xsl:value-of select="$Sub_ospf_aside"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ospf"><xsl:value-of select="$Sub_ospf_zside"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ospf_cost"><xsl:value-of select="$Subtrunk_ospf_cost_aend"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ospf_cost"><xsl:value-of select="$Subtrunk_ospf_cost_zend"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ospf_password"><xsl:value-of select="$SubOSPF_aPassword"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ospf_password"><xsl:value-of select="$SubOSPF_zPassword"/></xsl:element>
				<xsl:element name="TrunkSubEndA_mtu"><xsl:value-of select="$Subtrunk_mtu_aend"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_mtu"><xsl:value-of select="$Subtrunk_mtu_zend"/></xsl:element>
				<xsl:element name="TrunkSubEndA_LDP"><xsl:value-of select="$Subldp_aend"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_LDP"><xsl:value-of select="$Subldp_zend"/></xsl:element>
				<xsl:element name="TrunkSubEndA_ldp_password"><xsl:value-of select="$SubLDP_aPassword"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_ldp_password"><xsl:value-of select="$SubLDP_zPassword"/></xsl:element>
				<xsl:element name="TrunkSubEndA_Description"><xsl:value-of select="$SubInt_description_aEnd"/></xsl:element>
				<xsl:element name="TrunkSubEndZ_Description"><xsl:value-of select="$SubInt_description_zEnd"/></xsl:element>
			</TRUNKSUB>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="/">
<msg msg_id="{$messageid}">
	<header>
	<Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
		<Service_id><xsl:value-of select="$serviceid"/></Service_id>
		<Activation_name>create</Activation_name>
		<Service_name>Trunk</Service_name>
	</Service_request>
	<Service_schedule>
		<StartTime><xsl:value-of select="$StartTime"/></StartTime>
		<EndTime><xsl:value-of select="$EndTime"/></EndTime>
	</Service_schedule>
	</header>
	<body>
		<Service  Service_id="{$serviceid}">
			<IGWIGWPE IGWIGWPE_type="Trunk">
				<Trunk_name><xsl:value-of select="$presname"/></Trunk_name>
				<TrunkType_name><xsl:value-of select="$Trunk_Type"/></TrunkType_name>
				<TrunkLink_type><xsl:value-of select="$link_type"/></TrunkLink_type>
				<TrunkEndA_Serviceid><xsl:value-of select="$Site_Service_ID_aEnd"/></TrunkEndA_Serviceid>
				<TrunkEndZ_Serviceid><xsl:value-of select="$Site_Service_ID_zEnd"/></TrunkEndZ_Serviceid>
				<TrunkEndA_Name><xsl:value-of select="$EndA_name"/></TrunkEndA_Name>
				<TrunkEndZ_Name><xsl:value-of select="$EndZ_name"/></TrunkEndZ_Name>
				<TrunkEndA_Region><xsl:value-of select="$PW_aEnd_region"/></TrunkEndA_Region>
				<TrunkEndZ_Region><xsl:value-of select="$PW_zEnd_region"/></TrunkEndZ_Region>
				<TrunkEndA_Location><xsl:value-of select="$PW_aEnd_location"/></TrunkEndA_Location>
				<TrunkEndZ_Location><xsl:value-of select="$PW_zEnd_location"/></TrunkEndZ_Location>
				<TrunkEndA_PERouter><xsl:value-of select="$PERouter_aEnd"/></TrunkEndA_PERouter>
				<TrunkEndZ_PERouter><xsl:value-of select="$PERouter_zEnd"/></TrunkEndZ_PERouter>
				<TrunkEndA_Pool><xsl:value-of select="$AddressPool_aEnd"/></TrunkEndA_Pool>
				<TrunkEndZ_Pool><xsl:value-of select="$AddressPool_zEnd"/></TrunkEndZ_Pool>
				<TrunkEndA_Address><xsl:value-of select="$trunk_ipaddress_aEnd"/></TrunkEndA_Address>
				<TrunkEndZ_Address><xsl:value-of select="$trunk_ipaddress_zEnd"/></TrunkEndZ_Address>
				<TrunkEndA_Submask><xsl:value-of select="$ip_submask_aEnd"/></TrunkEndA_Submask>
				<TrunkEndZ_Submask><xsl:value-of select="$ip_submask_zEnd"/></TrunkEndZ_Submask>
				<TrunkEndA_Policy><xsl:value-of select="$trunk_policy_aside"/></TrunkEndA_Policy>
				<TrunkEndZ_Policy><xsl:value-of select="$trunk_policy_zside"/></TrunkEndZ_Policy>
				<TrunkEndA_NetworkIP><xsl:value-of select="$ip_networkIP_aEnd"/></TrunkEndA_NetworkIP>
				<TrunkEndZ_NetworkIP><xsl:value-of select="$ip_networkIP_zEnd"/></TrunkEndZ_NetworkIP>
				<TrunkEndA_Wildcard><xsl:value-of select="$wildcard_aEnd"/></TrunkEndA_Wildcard>
				<TrunkEndZ_Wildcard><xsl:value-of select="$wildcard_zEnd"/></TrunkEndZ_Wildcard>
				<TrunkEndA_TrafficIO><xsl:value-of select="$Traffic_policy_io_aend"/></TrunkEndA_TrafficIO>
				<TrunkEndZ_TrafficIO><xsl:value-of select="$Traffic_policy_io_zend"/></TrunkEndZ_TrafficIO>
				<TrunkEndA_IPv6_family_aEnd><xsl:value-of select="$IPv6_family_aEnd"/></TrunkEndA_IPv6_family_aEnd>
				<TrunkEndA_IPv6_family_zEnd><xsl:value-of select="$IPv6_family_zEnd"/></TrunkEndA_IPv6_family_zEnd>
				<TrunkEndA_IPv6_Pool><xsl:value-of select="$IPv6_Pool_aEnd"/></TrunkEndA_IPv6_Pool>
				<TrunkEndZ_IPv6_Pool><xsl:value-of select="$IPv6_Pool_zEnd"/></TrunkEndZ_IPv6_Pool>
				<TrunkEndA_IPv6_Address><xsl:value-of select="$IPv6_Address_aEnd"/></TrunkEndA_IPv6_Address>
				<TrunkEndZ_IPv6_Address><xsl:value-of select="$IPv6_Address_zEnd"/></TrunkEndZ_IPv6_Address>
				<TrunkEndA_ProcessID><xsl:value-of select="$trunk_aside_processid"/></TrunkEndA_ProcessID>
				<TrunkEndZ_ProcessID><xsl:value-of select="$trunk_zside_processid"/></TrunkEndZ_ProcessID>
				<TrunkEndA_Area><xsl:value-of select="$area_number_aEnd"/></TrunkEndA_Area>
				<TrunkEndZ_Area><xsl:value-of select="$area_number_zEnd"/></TrunkEndZ_Area>
				<TrunkEndA_Protocol><xsl:value-of select="$lnk_Protocol_aside"/></TrunkEndA_Protocol>
				<TrunkEndZ_Protocol><xsl:value-of select="$lnk_Protocol_zside"/></TrunkEndZ_Protocol>
				<TrunkEndA_Pim><xsl:value-of select="$pim_name_aside"/></TrunkEndA_Pim>
				<TrunkEndZ_Pim><xsl:value-of select="$pim_name_zside"/></TrunkEndZ_Pim>
				<TrunkEndA_NetworkType><xsl:value-of select="$network_type_aside"/></TrunkEndA_NetworkType>
				<TrunkEndZ_NetworkType><xsl:value-of select="$network_type_zside"/></TrunkEndZ_NetworkType>
				<TrunkEndA_negotiation><xsl:value-of select="$trunk_negotiation_aside"/></TrunkEndA_negotiation>
				<TrunkEndZ_negotiation><xsl:value-of select="$trunk_negotiation_zside"/></TrunkEndZ_negotiation>
				<TrunkEndA_ospf><xsl:value-of select="$ospf_aside"/></TrunkEndA_ospf>
				<TrunkEndZ_ospf><xsl:value-of select="$ospf_zside"/></TrunkEndZ_ospf>
				<TrunkEndA_ipbinding><xsl:value-of select="$trunk_aIPbinding"/></TrunkEndA_ipbinding>
				<TrunkEndZ_ipbinding><xsl:value-of select="$trunk_zIPbinding"/></TrunkEndZ_ipbinding>
				<TrunkEndA_ospf_password><xsl:value-of select="$OSPF_aPassword"/></TrunkEndA_ospf_password>
				<TrunkEndZ_ospf_password><xsl:value-of select="$OSPF_zPassword"/></TrunkEndZ_ospf_password>
				<TrunkEndA_toend_router_ip><xsl:value-of select="$trunk_aside_toend_router_ip"/></TrunkEndA_toend_router_ip>
				<TrunkEndZ_toend_router_ip><xsl:value-of select="$trunk_zside_toend_router_ip"/></TrunkEndZ_toend_router_ip>
				<TrunkEndA_ospf_cost><xsl:value-of select="$trunk_aside_ospf_cost"/></TrunkEndA_ospf_cost>
				<TrunkEndZ_ospf_cost><xsl:value-of select="$trunk_zside_ospf_cost"/></TrunkEndZ_ospf_cost>
				<TrunkEndA_mtu><xsl:value-of select="$trunk_aside_mtu"/></TrunkEndA_mtu>
				<TrunkEndZ_mtu><xsl:value-of select="$trunk_zside_mtu"/></TrunkEndZ_mtu>
				<TrunkEndA_LDP><xsl:value-of select="$trunk_ldp_aside"/></TrunkEndA_LDP>
				<TrunkEndZ_LDP><xsl:value-of select="$trunk_ldp_zside"/></TrunkEndZ_LDP>
				<TrunkEndA_ldp_password><xsl:value-of select="$LDP_aPassword"/></TrunkEndA_ldp_password>
				<TrunkEndZ_ldp_password><xsl:value-of select="$LDP_zPassword"/></TrunkEndZ_ldp_password>
				<TrunkEndA_Description><xsl:value-of select="$trunk_description_aEnd"/></TrunkEndA_Description>
				<TrunkEndZ_Description><xsl:value-of select="$trunk_description_zEnd"/></TrunkEndZ_Description>
				<TrunkEndA_PEInterface><xsl:value-of select="$PEInterface_aEnd"/></TrunkEndA_PEInterface>
				<TrunkEndZ_PEInterface><xsl:value-of select="$PEInterface_zEnd"/></TrunkEndZ_PEInterface>
				<TrunkEndA_IntDescription><xsl:value-of select="$Interface_description_aEnd"/></TrunkEndA_IntDescription>
				<TrunkEndZ_IntDescription><xsl:value-of select="$Interface_description_zEnd"/></TrunkEndZ_IntDescription>
				<TrunkEndA_TrunkBandwidth><xsl:value-of select="$Trunk_bandwidth_aEnd"/></TrunkEndA_TrunkBandwidth>
				<TrunkEndZ_TrunkBandwidth><xsl:value-of select="$Trunk_bandwidth_zEnd"/></TrunkEndZ_TrunkBandwidth>
				<TrunkEndA_TrunkRSVPBandwidth><xsl:value-of select="$Trunk_rsvp_bandwidth_aEnd"/></TrunkEndA_TrunkRSVPBandwidth>
				<TrunkEndZ_TrunkRSVPBandwidth><xsl:value-of select="$Trunk_rsvp_bandwidth_zEnd"/></TrunkEndZ_TrunkRSVPBandwidth>
				<xsl:if test="$SubInterfaceName != ''">
					<xsl:call-template name="TrunkSub_Name_split">
						<xsl:with-param name="SubInterfaceName" select="$SubInterfaceName"/>
						<xsl:with-param name="ParentInterface_aEnd" select="$ParentInterface_aEnd"/>
						<xsl:with-param name="ParentInterface_zEnd" select="$ParentInterface_zEnd"/>
						<xsl:with-param name="SubAddressPool_aEnd" select="$SubAddressPool_aEnd"/>
						<xsl:with-param name="SubAddressPool_zEnd" select="$SubAddressPool_zEnd"/>
						<xsl:with-param name="Sub_ipaddress_aEnd" select="$Sub_ipaddress_aEnd"/>
						<xsl:with-param name="Sub_ipaddress_zEnd" select="$Sub_ipaddress_zEnd"/>
						<xsl:with-param name="Sub_ip_submask_aEnd" select="$Sub_ip_submask_aEnd"/>
						<xsl:with-param name="Sub_ip_submask_zEnd" select="$Sub_ip_submask_zEnd"/>
						<xsl:with-param name="Subtrunk_policy_aside" select="$Subtrunk_policy_aside"/>
						<xsl:with-param name="Subtrunk_policy_zside" select="$Subtrunk_policy_zside"/>
						<xsl:with-param name="Sub_ip_networkIP_aEnd" select="$Sub_ip_networkIP_aEnd"/>
						<xsl:with-param name="Sub_ip_networkIP_zEnd" select="$Sub_ip_networkIP_zEnd"/>
						<xsl:with-param name="Sub_wildcard_aEnd" select="$Sub_wildcard_aEnd"/>
						<xsl:with-param name="Sub_wildcard_zEnd" select="$Sub_wildcard_zEnd"/>
						<xsl:with-param name="Sub_IPv6_family_aEnd" select="$Sub_IPv6_family_aEnd"/>
						<xsl:with-param name="Sub_IPv6_family_zEnd" select="$Sub_IPv6_family_zEnd"/>
						<xsl:with-param name="Sub_IPv6_Pool_aEnd" select="$Sub_IPv6_Pool_aEnd"/>
						<xsl:with-param name="Sub_IPv6_Pool_zEnd" select="$Sub_IPv6_Pool_zEnd"/>
						<xsl:with-param name="Sub_IPv6_Address_aEnd" select="$Sub_IPv6_Address_aEnd"/>
						<xsl:with-param name="Sub_IPv6_Address_zEnd" select="$Sub_IPv6_Address_zEnd"/>
						<xsl:with-param name="Subtrunk_processid_aEnd" select="$Subtrunk_processid_aEnd"/>
						<xsl:with-param name="Subtrunk_processid_zEnd" select="$Subtrunk_processid_zEnd"/>
						<xsl:with-param name="SubArea_number_aEnd" select="$SubArea_number_aEnd"/>
						<xsl:with-param name="SubArea_number_zEnd" select="$SubArea_number_zEnd"/>
						<xsl:with-param name="lnk_Protocol_aside" select="$lnk_Protocol_aside"/>
						<xsl:with-param name="lnk_Protocol_zside" select="$lnk_Protocol_zside"/>
						<xsl:with-param name="Sub_pim_name_aside" select="$Sub_pim_name_aside"/>
						<xsl:with-param name="Sub_pim_name_zside" select="$Sub_pim_name_zside"/>
						<xsl:with-param name="Sub_network_type_aside" select="$Sub_network_type_aside"/>
						<xsl:with-param name="Sub_network_type_zside" select="$Sub_network_type_zside"/>
						<xsl:with-param name="SubNegotiation_aend" select="$SubNegotiation_aend"/>
						<xsl:with-param name="SubNegotiation_zend" select="$SubNegotiation_zend"/>
						<xsl:with-param name="Sub_IPv6_encap_aEnd" select="$Sub_IPv6_encap_aEnd"/>
						<xsl:with-param name="Sub_IPv6_encap_zEnd" select="$Sub_IPv6_encap_zEnd"/>
						<xsl:with-param name="Sub_IPv6_binding_aEnd" select="$Sub_IPv6_binding_aEnd"/>
						<xsl:with-param name="Sub_IPv6_binding_zEnd" select="$Sub_IPv6_binding_zEnd"/>						
						<xsl:with-param name="Sub_ospf_aside" select="$Sub_ospf_aside"/>
						<xsl:with-param name="Sub_ospf_zside" select="$Sub_ospf_zside"/>
						<xsl:with-param name="Subtrunk_ospf_cost_aend" select="$Subtrunk_ospf_cost_aend"/>
						<xsl:with-param name="Subtrunk_ospf_cost_zend" select="$Subtrunk_ospf_cost_zend"/>
						<xsl:with-param name="SubOSPF_aPassword" select="$SubOSPF_aPassword"/>
						<xsl:with-param name="SubOSPF_zPassword" select="$SubOSPF_zPassword"/>
						<xsl:with-param name="Subtrunk_mtu_aend" select="$Subtrunk_mtu_aend"/>
						<xsl:with-param name="Subtrunk_mtu_zend" select="$Subtrunk_mtu_zend"/>
						<xsl:with-param name="Subldp_aend" select="$Subldp_aend"/>
						<xsl:with-param name="Subldp_zend" select="$Subldp_zend"/>
						<xsl:with-param name="SubLDP_aPassword" select="$SubLDP_aPassword"/>
						<xsl:with-param name="SubLDP_zPassword" select="$SubLDP_zPassword"/>
						<xsl:with-param name="SubInt_description_aEnd" select="$SubInt_description_aEnd"/>
						<xsl:with-param name="SubInt_description_zEnd" select="$SubInt_description_zEnd"/>
					</xsl:call-template>
				</xsl:if>
				<Customer_id><xsl:value-of select="$customerid"/></Customer_id>
				<Customer_name><xsl:value-of select="$Customer_name"/></Customer_name>
				<Customer_contact><xsl:value-of select="$Contact_person"/></Customer_contact>
				<Customer_email><xsl:value-of select="$Customer_email"/></Customer_email>
				<Defaults>
					<QoS>
						<QoSProfile><xsl:value-of select="$QOS_PROFILE"/></QoSProfile>
					</QoS>
				</Defaults>
			</IGWIGWPE>
		</Service>
	</body>
</msg>
</xsl:template>
</xsl:stylesheet>

