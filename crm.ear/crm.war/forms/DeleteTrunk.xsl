<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<!--
###############################################################################
#
# 2017
#
###############################################################################
-->

	<xsl:output method="xml" indent="yes" xalan:indent-amount="2" encoding="UTF-8" xmlns:xalan="http://xml.apache.org/xslt"/>
	<xsl:param name="messageid"/>
	<xsl:param name="skip_activation"/>
	<xsl:param name="request_synchronisation"/>
	<xsl:param name="serviceid"/>
	<xsl:param name="customerid"/>
	<xsl:param name="Customer_name"/>
	<xsl:param name="Contact_person"/>
	<xsl:param name="Customer_email"/>
	<xsl:param name="presname"/>
	<xsl:param name="trunk_id"/>
	<xsl:param name="operator"/>
	<xsl:template match="/">
		<msg msg_id="{$messageid}">
			<header>
				<Service_request Response="{$request_synchronisation}" Mode="{$skip_activation}" Operator="{$operator}">
					<Service_id>
						<xsl:value-of select="$serviceid"/>
					</Service_id>
					<Activation_name>delete</Activation_name>
					<Service_name>Trunk</Service_name>
				</Service_request>
			</header>
			<body>
				<Service Service_id="{$serviceid}">
					<IGWIGWPE IGWIGWPE_type="Trunk">  
						<Trunk_id>
							<xsl:value-of select="$trunk_id"/>
						</Trunk_id> 
						<Customer_id>
							<xsl:value-of select="$customerid"/>
						</Customer_id>
					</IGWIGWPE>
				</Service>
			</body>
		</msg>
	</xsl:template>
</xsl:stylesheet>
