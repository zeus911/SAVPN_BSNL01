<?xml version="1.0" encoding="utf-8"?>
<!--
######################################################################
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#######################################################################
#######################################################################
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/xsl/ExecutiveSummary.xsl,v $
# $Revision: 1.6 $
# $Date: 2010-10-05 15:18:21 $
# $Author: shiva $
######################################################################
-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="/activator/css/report.css"/>
            </head>
            <body>
                <br/>
                <h2 align="center">Executive Summary Report</h2>
                <br/>
                <xsl:apply-templates/>
                <table align="right" cellpadding='1' cellspacing='10' border='0' >
                    <tr>
                        <td width="50%"  class="mainHeading" align = "left">
						  <a  href="javascript:window.print();"><center>Print</center></a>
					  </td>
                        <td width="50%"  class="mainHeading" align = "left">
						  <a  href="saveReport.jsp?reportType=ExecutiveSummaryReport">
						  <center>Save</center></a>
					  </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="time">
        <table align="center" width="70%" cellpadding='0' border='1' cellspacing='0'>
            <tr>
                <xsl:choose>
                    <xsl:when test="timeFrame/months &gt; 0">
                        <td class="tableCell" align="left" >
							<b>
								Time-Frame: <xsl:value-of select="timeFrame/months"/> months
							</b>
						</td>
                    </xsl:when>
                    <xsl:when test="timeFrame/years &lt; 0">
                        <td class="tableCell" align="left" >
							<b>
								Time-Frame: <xsl:value-of select="timeFrame/years"/> years
							</b>
						</td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td class="tableCell" align="left" >
							<b>
								Time-Frame: All
							</b>
						</td>
                    </xsl:otherwise>
                </xsl:choose>
                <td class="tableCell" align="right" >
					<b>
						<xsl:value-of select="timeStamp"/>
					</b>
				</td>
            </tr>
        </table>
    </xsl:template>
    <xsl:template match="Customers">
        <table align="center" width="70%" cellpadding='0' border='1' cellspacing='0'>
            <tr>
                <td colspan="7" class="mainHeading" align="center" ><b>Customers</b></td>
            </tr>
            <tr>
                <td align="center"  class="mainHeading" >Added</td>
                <td align="center"  class="mainHeading" >Deleted</td>
                <td align="center"  class="mainHeading" >Active</td>
            </tr>
            <tr class="row{position() mod 2 }">
                <td class="tableCell" width="33%" align="center"><xsl:apply-templates select="NumOfCustomersAdded"/></td>
                <td class="tableCell" width="33%" align="center"><xsl:apply-templates select="NumOfCustomersDeleted"/></td>
                <td class="tableCell" width="33%" align="center"><xsl:value-of select="TotalNumOfCustomersActive"/></td>
            </tr>
        </table>
        <br/>
        <br/>
        <br/>
        <br/>
    </xsl:template>
    <xsl:template match="SiteTypes">
        <table align="center" width="70%" cellpadding='0' border='1' cellspacing='0'>
            <tr>
                <td colspan="7" class="mainHeading" align="center" ><b>Services</b></td>
            </tr>
            <tr>
                <td align="center"  class="mainHeading" >Type</td>
                <td align="center"  class="mainHeading" >Added</td>
                <td align="center"  class="mainHeading" >Modified</td>
                <td align="center"  class="mainHeading" >Total</td>
            </tr>
            <tr>
            </tr>
            <xsl:for-each select="SiteType">
                <tr class="row{position() mod 2 }">
                    <td class="tableCell" width="25%" align="left"><xsl:value-of select="@TypeOfService" /></td>
                    <td class="tableCell" width="25%" align="center"><xsl:value-of select="NumSitesAdded"/></td>
                    <td class="tableCell" width="25%" align="center"><xsl:value-of select="NumSitesModified"/></td>
                    <td class="tableCell" width="25%" align="center"><xsl:value-of select="NumSitesTotal"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>

