<?xml version="1.0" encoding="utf-8"?>
<!--
######################################################################
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#######################################################################
#######################################################################
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/xsl/ServicesPerPE.xsl,v $
# $Revision: 1.7 $
# $Date: 2010-10-05 15:18:21 $
# $Author: shiva $
######################################################################
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="/activator/css/report.css"/>
            </head>
            <body>
                <br/>
                <h2 align="center">Services per PE Report</h2>
                <br/>
                <xsl:apply-templates/>
                <br/>
                <br/>
                <table align="right" cellpadding='1' cellspacing='10' border='0' >
                    <tr>
                        <td width="50%"  class="mainHeading" align = "left">
						  <a  href="javascript:window.print();"><center>Print</center></a>
					  </td>
                        <td width="50%"  class="mainHeading" align = "left">
						  <a  href="saveReport.jsp?reportType=ServicePerPEReport">
						  <center>Save</center></a>
					  </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="timeStamp">
        <table align="center" width="95%" cellpadding='0' border='1' cellspacing='0'>
            <tr>
                <td class="tableCell" align="right" >
				<b>
					<xsl:value-of select="."/>
				</b>
			</td>
            </tr>
        </table>
    </xsl:template>
    <xsl:template match="PERouterDetails">
        <table align="center" width="95%" cellpadding='0' border='1' cellspacing='0'>
            <tr>
                <td colspan="7" class="mainHeading" align="center" ><b>PE Router Details</b></td>
            </tr>
            <tr>
                <td align="center"  width="33%" class="mainHeading" >PE Router Name</td>
                <td align="center"  width="33%" class="mainHeading" >Network Element Id</td>
                <td align="center"  width="33%" class="mainHeading" >Management IP</td>
            </tr>
            <tr class="tableOddRow">
                <td class="tableCell" align= "center" ><xsl:apply-templates select="peroutername"/></td>
                <td class="tableCell" align= "center" ><xsl:apply-templates select="networkelementid"/></td>
                <td class="tableCell" align= "center" ><xsl:value-of select="managementip"/></td>
            </tr>
        </table>
        <br/>
        <br/>
        <table align="center" width="95%" cellpadding='0' border='0' cellspacing='0'>
            <tr>
                <td colspan="15" class="mainHeading" align="center" ><b>Customer Details Report</b></td>
            </tr>
            <xsl:for-each select="Customers/Customer">
                <tr valign="top">
                    <td width="45%" >
						<table align="left" width="100%" cellpadding='0' border='0' cellspacing='0'>
							<tr>
								<td colspan="5" align="center" width="35%" class="mainHeading" >Customer Name</td>
								<td colspan="5" align="center" width="15%" class="mainHeading" >Id</td>
								<td colspan="5" align="center" width="50%" class="mainHeading" >Contact Person</td>
							</tr>
							<tr class="row0">
								<td colspan="5" class="tableCell" align="center">
									<xsl:choose>
									  <xsl:when test="customerName != 'null'">
											<xsl:value-of select="customerName"/>
									  </xsl:when>
									  <xsl:otherwise>
											-
									  </xsl:otherwise>
									</xsl:choose>
								</td>
								<td colspan="5" class="tableCell" align="center"><xsl:value-of select="customerId"/></td>
								<td colspan="5" class="tableCell" align="center">
									<xsl:choose>
									  <xsl:when test="contactPerson != 'null null'">
											<xsl:value-of select="contactPerson"/>
									  </xsl:when>
									  <xsl:otherwise>
											-
									  </xsl:otherwise>
									</xsl:choose>								
								</td>
							</tr>
						</table>
					</td>
                    <td width="55%" >
							<table align="center" width="100%" cellpadding='0' border='0' cellspacing='0'>
								<tr>
									<td colspan="9" align="center" class="mainHeading" >Service</td>
									<td colspan="6" align="center" class="mainHeading" >VPN</td>
								</tr>
								<tr>
									<td colspan="3" align="center" width="35%" class="mainHeading" >Name</td>
									<td colspan="3" align="center" width="8%" class="mainHeading" >Id</td>
									<td colspan="3" align="center" width="12%" class="mainHeading" >Type</td>
									<td colspan="3" align="center" width="30%" class="mainHeading" >Name</td>
									<td colspan="3" align="center" width="15%" class="mainHeading" >Id</td>
								</tr>

								<xsl:for-each select="Services/Service">
									<tr class="row{position() mod 2 }">
										<td colspan="3" class="tableCell" align= "center" ><xsl:value-of select="serviceName"/></td>
										<td colspan="3" class="tableCell" align= "center" ><xsl:value-of select="serviceId"/></td>
										<td colspan="3" class="tableCell" align= "center" ><xsl:value-of select="serviceType"/></td>
										<td colspan="3" class="tableCell" align= "center" ><xsl:value-of select="vpnName"/></td>
										<td colspan="3" class="tableCell" align= "center" ><xsl:value-of select="vpnId"/></td>
									</tr>
								</xsl:for-each>
						</table>
					</td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>