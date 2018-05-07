<?xml version="1.0" encoding="utf-8"?>
<!--
######################################################################
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#######################################################################
#######################################################################
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/xsl/ListCLICommands.xsl,v $
# $Revision: 1.8 $
# $Date: 2010-10-05 15:17:50 $
# $Author: shiva $
######################################################################
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output doctype-system="CLIv4.dtd" indent="yes"/>
    <xsl:param name="activation_name"/>
    <xsl:param name="equipment_name"/>
    <xsl:param name="element_type"/>
    <xsl:param name="vendor"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Activation Dialog </title>
                <style>
.pageHead{    font-family: Verdana, Helvetica, Arial, Sans-serif;
        font-size: 10pt;
        color: #08396B;
		font-weight: bold;
		
   }
 .pageText{    font-family: Verdana, Helvetica, Arial, Sans-serif;
        font-size: 10pt;
        color: #08396B;
			
   }
 .pageField{    font-family: Verdana, Helvetica, Arial, Sans-serif;
        font-size: 10pt;
        color: #08396B;
  }

   .pageValue{    font-family: Verdana, Helvetica, Arial, Sans-serif;
        font-size: 10pt;
        color: #08396B;
   }

h2 {
        font-family: Tahoma, Arial, Helvetica, Sans-serif;
        font-size: 12pt;
        color: #08396B;
   }

h3 {
        font-family: Tahoma, Arial, Helvetica, Sans-serif;
        font-size: 10pt;
        color: #08396B;
   }

h6 {
        font-family: Tahoma, Arial, Helvetica, Sans-serif;
        font-size: 7pt;
        color: #08396B;
   }
.heading {
        background: #336699;
        font-family: Verdana, Helvetica, Arial, Sans-serif;
        font-size: 8pt;
        color: white;
        text-align: left;
        vertical-align: middle;
        border: 1px solid white;
}
.pageHead {
        font-family: Verdana, Helvetica, Arial, Sans-serif;
        font-size: 12pt;
        color: #336699;
        text-align: left;
        vertical-align: middle;
        border: 1px solid white;
}

.row0 {background-color: #E6E6E6;
       font-family: Verdana, Helvetica, Arial, Sans-serif;
       font-size: 8pt; }
.row1 {background-color: #CCCCCC;
       font-family: Verdana, Helvetica, Arial, Sans-serif;
       font-size: 8pt; }
	
</style>
            </head>
            <body>
                <script>
	 window.focus();
	</script>
                <xsl:if test="$activation_name!='null' and $activation_name!=''">
                    <h3>Command set for the service: <xsl:value-of select="$activation_name"/></h3>
                </xsl:if>
                <xsl:if test="$equipment_name!='null' and $equipment_name!=''">
                    <span class="pageField">Equipment name: </span>
                    <span class="pageValue">
                        <xsl:value-of select="$equipment_name"/>
                    </span>
                    <span class="pagefield">,  Element Type: </span>
                    <span class="pageValue">
                        <xsl:value-of select="$element_type"/>
                    </span>
                    <span class="pageField">,  Vendor: </span>
                    <span class="pageValue">
                        <xsl:value-of select="$vendor"/>
                    </span>
                </xsl:if>
                <table width="100%">
                    <tr class="heading">
                        <td width="30%">Description</td>
                        <td width="40%">Activation commands</td>
                        <td width="30%">Rollback commands</td>
                    </tr>
                    <!-- Displaying the Connenct Do commands  Commands -->
                    <xsl:apply-templates select="CLI/Connect/Do"/>
                    <!-- Displaying the Activate Do  and undo Commands  Commands -->
                    <xsl:for-each select="CLI/Activate/Action">
                        <tr class="row0">
                            <td><xsl:value-of select="./@description"/></td>
                            <td><xsl:value-of select="Do/Command"/></td>
                            <td><xsl:value-of select="Undo/Command"/></td>
                        </tr>
                    </xsl:for-each>
                    <!-- Displaying the DisConnect do commands  Commands -->
                    <xsl:apply-templates select="CLI/Disconnect/Do"/>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="CLI/Connect/Do">
        <xsl:apply-templates select="Command"/>
        <xsl:apply-templates select="Confirm/Command"/>
    </xsl:template>
    <xsl:template match="CLI/Disconnect/Do">
        <xsl:apply-templates select="Command"/>
        <xsl:apply-templates select="Confirm/Command"/>
    </xsl:template>
    <xsl:template match="Command">
        <xsl:if test=".!=null or .!=''">
            <tr class="row0">
                <td><xsl:value-of select="../@description"/></td>
                <td><xsl:value-of select="."/></td>
                <td></td>
            </tr>
        </xsl:if>
    </xsl:template>
    <xsl:template match="Confirm/Command">
        <xsl:if test=".!=null or .!=''">
            <tr class="row0">
                <td><xsl:value-of select="../../@description"/></td>
                <td><xsl:value-of select="."/></td>
                <td></td>
            </tr>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>



