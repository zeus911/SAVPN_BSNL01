<?xml version="1.0" encoding="utf-8"?>
<!--
######################################################################
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#######################################################################
#######################################################################
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/xsl/BandwidthAccounting.xsl,v $
# $Revision: 1.7 $
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
                <h2 align="center">Bandwidth Accounting Report</h2>
                <br/>
                <xsl:apply-templates/>
                <table align="right" cellpadding='1' cellspacing='10' border='0' >
                    <tr>
                        <td width="50%"  class="mainHeading" align = "left">
						  <a  href="javascript:window.print();"><center>Print</center></a>
					  </td>
                        <td width="50%"  class="mainHeading" align = "left">
						  <a  href="saveReport.jsp?reportType=BandwidthAccountingReport">
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
    <xsl:template match="PEDetails">
        <table align="center" width="95%" cellpadding='0' border='1' cellspacing='0'>
            <tr>
                <td colspan="7" class="mainHeading" align="center" ><b>NE Details</b></td>
            </tr>
            <tr>
                <td align="center" rowspan="2" class="mainHeading" >Router Name</td>
                <td align="center" rowspan="2" class="mainHeading" >NE Id</td>
                <td align="center" rowspan="2" class="mainHeading" >Management IP</td>
                <td align="center" rowspan="2" class="mainHeading" >Committed Bandwidth</td>
                <td align="center" rowspan="1" colspan="3" class="mainHeading" >Physical-Bandwidth</td>
            </tr>
            <tr>
                <td align="center"  class="mainHeading" >Customer-Facing</td>
                <td align="center"  class="mainHeading" >Core-Facing</td>
                <td align="center"  class="mainHeading" >Available</td>
            </tr>
            <tr class="tableOddRow">
                <td class="tableCell" width="12%" align= "left" ><xsl:apply-templates select="routerName"/></td>
                <td class="tableCell" width="16%" align= "center" ><xsl:apply-templates select="networkElementId"/></td>
                <td class="tableCell" width="24%" align= "center" ><xsl:value-of select="managementIp"/></td>
                <td class="tableCell" width="12%" align= "right" ><xsl:value-of select="totalCommittedBandwidth"/></td>
                <td class="tableCell" width="12%" align= "right" ><xsl:value-of select="totalCustomerFacingPhysicalBandwidth"/></td>
                <td class="tableCell" width="12%" align= "right" ><xsl:value-of select="totalCoreFacingPhysicalBandwidth"/></td>
                <td class="tableCell" width="12%" align= "right" ><xsl:value-of select="totalAvailablePhysicalBandwidth"/></td>
            </tr>
        </table>
        <br/>
    </xsl:template>
    <xsl:template match="typeOfInterfaces">
        <table align="center" width="95%" cellpadding='0' border='0' cellspacing='0'>
            <tr>
                <td colspan="9" class="tableCell" align="right" >
					<b>Unit of Bandwidth: kbps</b>
				</td>
            </tr>
            <tr>
                <td colspan="9" class="mainHeading" align="center" ><b>Interface Level Bandwidth-Summary Report</b></td>
            </tr>
            <tr>
                <td rowspan="2" align="center"  class="mainHeading" >Interface Type</td>
                <td rowspan="1" colspan="4" align="center"  class="mainHeading" >Number</td>
                <td rowspan="2" align="center"  class="mainHeading" >Committed Bandwidth</td>
                <td rowspan="1" colspan="3" align="center"  class="mainHeading" >Physical-Bandwidth</td>
            </tr>
            <tr>
                <td align="center"  class="mainHeading" >Total</td>
                <td align="center"  class="mainHeading" >Provisioned</td>
                <td align="center"  class="mainHeading" >Reserved</td>
                <td align="center"  class="mainHeading" >Available</td>
                <td align="center"  class="mainHeading" >Customer-Facing</td>
                <td align="center"  class="mainHeading" >Core-Facing</td>
                <td align="center"  class="mainHeading" >Available</td>
            </tr>
            <xsl:for-each select="typeOfInterface[noOfInterfacesTotal &gt; 0]">
                <tr class="row{position() mod 2 }">
                    <td class="tableCell" width="12%" align= "left" ><xsl:value-of select="interfaceType"/></td>
                    <td class="tableCell" width="10%" align="center"><xsl:value-of select="noOfInterfacesTotal"/></td>
                    <td class="tableCell" width="10%" align="center"><xsl:value-of select="noOfInterfacesProvisioned"/></td>
                    <td class="tableCell" width="10%" align="center"><xsl:value-of select="noOfInterfacesReserved"/></td>
                    <td class="tableCell" width="10%" align="center"><xsl:value-of select="noOfInterfacesAvailable"/></td>
                    <td class="tableCell" width="12%" align= "right"><xsl:value-of select="totalCommittedBandwidth"/></td>
                    <td class="tableCell" width="12%" align= "right"><xsl:value-of select="totalCustomerFacingPhysicalBandwidth"/></td>
                    <td class="tableCell" width="12%" align= "right"><xsl:value-of select="totalCoreFacingPhysicalBandwidth"/></td>
                    <td class="tableCell" width="12%" align= "right"><xsl:value-of select="totalAvailablePhysicalBandwidth"/></td>
                </tr>
            </xsl:for-each>
        </table>
        <br/>
        <br/>
        <br/>
        <br/>
    </xsl:template>
</xsl:stylesheet>
