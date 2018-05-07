<?xml version="1.0" encoding="utf-8"?>
<!--
######################################################################
#
#   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#######################################################################
#######################################################################
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/xsl/ActivationErrorDialog.xsl,v $
# $Revision: 1.9 $
# $Date: 2010-10-05 15:17:50 $
# $Author: shiva $
######################################################################
-->
<xsl:stylesheet      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"      
version="1.0"        xmlns:java="http://xml.apache.org/xalan/java"     exclude-result-prefixes="java">
    <xsl:output method="html" encoding="UTF-8" />
    <xsl:param name="service_type" />
    <xsl:param name="Command_Symbol" select="'--&gt;'" />
    <xsl:param name="Response_Symbol" select="'&lt;--'" />
    <xsl:param name="Other_Symbol" select="''" />
    <xsl:param name="date_format" select="'E MMM d yyyy HH:mm:ss:SSS'" />
    <xsl:template match="/">
        <style>
.row0 {background-color: #E6E6E6;
       font-family: Verdana, Helvetica, Arial, Sans-serif;
       font-size: 8pt; 
       vertical-align: middle;}
.row1 {background-color: #CCCCCC;
       font-family: Verdana, Helvetica, Arial, Sans-serif;
       font-size: 8pt; 
       vertical-align: middle;}
.heading {
        background: #336699;
        font-family: Verdana, Helvetica, Arial, Sans-serif;
        font-size: 8pt;
        color: white;
        text-align: left;
        vertical-align: middle;
        border: 1px solid white;
}
.error {background-color: red;
       font-family: Verdana, Helvetica, Arial, Sans-serif;
       font-size: 8pt; }
.warning{background-color: yellow;
       font-family: Verdana, Helvetica, Arial, Sans-serif;
       font-size: 8pt; }
</style>
        <html>
            <head>
                <title>Device dialog for the activation attempt</title>
            </head>
            <body>
                <table width="100%">
                    <tr>
                        <td class="heading" width="30%" alt="test">
                     <span title="Time Stamp for the log action">Time</span>
                  </td>
                        <td class="heading" width="3%">
                     <span title=" --&gt;denotes command send to the equipment and &lt;--denotes the response">Tx/Rx</span>
                  </td>
                        <td class="heading" width="30%">
                     <span title="Message">Message</span>
                  </td>
                        <td class="heading" width="40%">
                     <span title="Description for the Resmgr log entry">Description</span>
                  </td>
                    </tr>
                    <xsl:apply-templates select="/Interaction/Output/Connect/Exception"/>
                    <xsl:apply-templates select="/Interaction/Output/Connect/Command"/>
                    <xsl:apply-templates select="/Interaction/Output/Activate/Do/Command"/>
                    <xsl:apply-templates select="/Interaction/Output/Activate/Undo/Command"/>
                    <xsl:apply-templates select="/Interaction/Output/Disconnect/Command"/>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="/Interaction/Output/Connect/Command">
        <xsl:call-template name="PrintRecord" />
    </xsl:template>
    <xsl:template match="/Interaction/Output/Activate/Do/Command">
        <xsl:call-template name="PrintRecord" />
    </xsl:template>
    <xsl:template match="/Interaction/Output/Activate/Undo/Command">
        <xsl:call-template name="PrintRecord" />
    </xsl:template>
    <xsl:template match="/Interaction/Output/Disconnect/Command">
        <xsl:call-template name="PrintRecord" />
    </xsl:template>
    <xsl:template match="//Interaction/Output/Connect/Exception">
        <xsl:call-template name="PrintException" />
    </xsl:template>
    <!-- End of main Template-->
    <!--
 This Template Displays the Time and 
 -->
    <xsl:template name="PrintRecord">
        <xsl:call-template name="PrintRequest" />
        <xsl:call-template name="PrintResponse" />
    </xsl:template>
    <xsl:template name="PrintRequest">
        <xsl:choose>
            <xsl:when test="@error = 'true'">
                <tr class="error">
                    <xsl:call-template name="PrintRequestRow" />
                </tr>
            </xsl:when>
            <xsl:when test="@error = 'false'">
                <tr class="row{position() mod 2 }">
                    <xsl:call-template name="PrintRequestRow" />
                </tr>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="PrintResponse">
        <xsl:choose>
            <xsl:when test="@error = 'true'">
                <tr class="error">
                    <xsl:call-template name="PrintResponseRow" />
                </tr>
            </xsl:when>
            <xsl:when test="@error = 'false'">
                <tr class="row{position() mod 2 }">
                    <xsl:call-template name="PrintResponseRow" />
                </tr>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="PrintRequestRow">
        <xsl:variable name="millisecs" select="Request/@time"/>
        <xsl:variable name="formatter" select="java:java.text.SimpleDateFormat.new($date_format)"/>
        <xsl:variable name='date' select="java:java.util.Date.new(number($millisecs))"/>
        <td>
  <xsl:value-of select="java:format($formatter, $date)"/>
      </td>
        <td valign="center">
         <xsl:value-of select="$Command_Symbol" />
      </td>
        <td>
         <xsl:value-of select="Request" />
      </td>
        <td>
         <xsl:value-of select="RequestDescription" />
      </td>
    </xsl:template>
    <xsl:template name="PrintResponseRow">
        <xsl:variable name="millisecs" select="Response/@time"/>
        <xsl:variable name="formatter" select="java:java.text.SimpleDateFormat.new($date_format)"/>
        <xsl:variable name='date' select="java:java.util.Date.new(number($millisecs))"/>
        <td>
  <xsl:value-of select="java:format($formatter, $date)"/>
      </td>
        <td valign="center">
         <xsl:value-of select="$Response_Symbol" />
      </td>
        <td>
         <xsl:value-of select="Response" />
      </td>
        <td>
         <xsl:value-of select="RequestDescription" />
      </td>
    </xsl:template>
    <xsl:template name="PrintException">
        <xsl:variable name="millisecs" select="/Interaction/Output/Connect/@startTime"/>
        <xsl:variable name="formatter" select="java:java.text.SimpleDateFormat.new($date_format)"/>
        <xsl:variable name='date' select="java:java.util.Date.new(number($millisecs))"/>
        <tr class="error">
            <td>
         <xsl:value-of select="java:format($formatter, $date)"/>
      </td>
            <td valign="center">
         <xsl:value-of select="$Response_Symbol" />
      </td>
            <td>
         <xsl:value-of select="Reason" />
      </td>
            <td>Exception From Plug-in</td>
        </tr>
    </xsl:template>
</xsl:stylesheet>

