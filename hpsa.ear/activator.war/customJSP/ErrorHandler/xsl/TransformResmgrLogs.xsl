<?xml version="1.0" encoding="utf-8"?>
<!--
######################################################################
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#######################################################################
#######################################################################
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/xsl/TransformResmgrLogs.xsl,v $
# $Revision: 1.6 $
# $Date: 2010-10-05 15:17:50 $
# $Author: shiva $
######################################################################
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:key name="list" match="LogEntry" use="ID"/>
    <xsl:param   name="service_type" />
    <xsl:param name="GTRID"/>
    <xsl:param name="Command_Pattern" select="'Sending'"/>
    <xsl:param name="Response_Pattern" select="'Found'"/>
    <xsl:param name="Command_Symbol" select="'--&gt;'"/>
    <xsl:param name="Response_Symbol" select="'&lt;--'"/>
    <xsl:param name="Other_Symbol" select="''"/>
    <xsl:template   match="/">
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
                <title>Resmgr Log for the activation attempt</title>
            </head>
            <body>
                <table width="100%">
                    <tr>
                        <td class="heading"  width="30%" alt="test"><span title="Time Stamp for the log action">Time</span></td>
                        <td class="heading"  width="3%"><span title=" --&gt;denotes command send to the equipment and &lt;--denotes the response">Tx/Rx</span></td>
                        <td class="heading"  width="30%"> <span title="Message">Message</span> </td>
                        <td class="heading"  width="40%">  <span title="Description for the Resmgr log entry">Description</span> </td>
                    </tr>
                    <!-- getting only log entries for the 
 log levels : error, informative and warning from the 
 compoenents : GLOBAL.GenericCLI , ResMgr.runService  
 -->
                    <xsl:for-each select="key('list', $GTRID)[ (./@level='ERROR' or ./@level='INFORMATIVE' or ./@level='WARNING') and (Component='GLOBAL.GenericCLI' or Component='ResMgr.runService')]">
                        <xsl:choose>
                            <xsl:when test="@level = 'ERROR'">
                                <tr class="error">
                                    <xsl:call-template name="PrintRow" />
                                </tr>
                            </xsl:when>
                            <xsl:when test="@level = 'WARNING'">
                                <tr class="warning">
                                    <xsl:call-template name="PrintRow" />
                                </tr>
                            </xsl:when>
                            <xsl:when test="@level = 'INFORMATIVE'">
                                <tr class="row{position() mod 2 }">
                                    <xsl:call-template name="PrintRow" />
                                </tr>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    <!-- End of main Template-->
    <!--
 This Template Displays the Time and 
 -->
    <xsl:template name="PrintRow">
        <td><xsl:call-template name="showdataTime" /></td>
        <xsl:choose>
            <xsl:when test="contains(Message,$Command_Pattern)">
                <!-- Towards the equipments contains the string "Sending"-->
                <td valign="center"> <xsl:value-of select="$Command_Symbol"/></td>
                <td><pre><xsl:call-template name="PrintMessage"/></pre></td>
                <xsl:call-template name="get-description"/>
            </xsl:when>
            <xsl:when test="contains(Message,$Response_Pattern)">
                <!-- response from the equipments contains the string "Found"-->
                <td valign="center"> <xsl:value-of select="$Response_Symbol"/></td>
                <td><pre><xsl:call-template name="PrintMessage" /></pre></td>
                <xsl:call-template name="get-description"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- TTY Error messages and local error messages-->
                <xsl:choose>
                    <xsl:when test="./@level='ERROR' and contains(Message,'TTY:')">
                        <!--Errors from equipments -->
                        <td valign="center"> <xsl:value-of select="$Response_Symbol"/></td>
                        <td><xsl:call-template name="showERROR"/></td>
                        <td><xsl:call-template name="get-error-description"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <!--Other Errors and logs-->
                        <td valign="center"> <xsl:value-of select="$Other_Symbol"/></td>
                        <td><xsl:call-template name="showOther" /></td>
                        <td><xsl:call-template name="get-error-description"/></td>
                    </xsl:otherwise>
                </xsl:choose>
                <!--end of inner choose-->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="showdataTime">
        <xsl:value-of select="Time"/>
    </xsl:template>
    <xsl:template name="showERROR">
        <xsl:choose>
            <xsl:when test="contains(Message,'/') and contains(Message,'TTY')">
                <xsl:value-of select="substring-after(Message,'/')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="Message"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="showOther">
        <xsl:call-template name="showERROR"/>
    </xsl:template>
    <!-- 
 This template do all the formatting of the 
  log message -->
    <xsl:template name="PrintMessage">
        <!-- get the log string between the '' -->
        <xsl:variable name="new_message1">
	<xsl:call-template name="getMessage">
	<xsl:with-param name="string" select="Message"/>
	</xsl:call-template>
</xsl:variable>
        <xsl:variable name="new_message2">
	<xsl:call-template name="string-replace">
	<xsl:with-param name="string" select="$new_message1"/>
	<xsl:with-param name="from" select="'&amp;gt;'"/>
	<xsl:with-param name="to" select="'&gt;'"/>
	</xsl:call-template>
</xsl:variable>
        <xsl:variable name="new_message3">
	<xsl:call-template name="string-replace">
	<xsl:with-param name="string" select="$new_message2"/>
	<xsl:with-param name="from" select="'!BS!'"/>
	<xsl:with-param name="to" select="''"/>
	</xsl:call-template>
</xsl:variable>
        <xsl:variable name="new_message4">
	<xsl:call-template name="string-replace">
	<xsl:with-param name="string" select="$new_message3"/>
	<xsl:with-param name="from" select="'!CR!'"/>
	<xsl:with-param name="to" select="''"/>
	</xsl:call-template>
</xsl:variable>
        <!-- Relace the !LF! with new lines -->
        <xsl:variable name="new_message5">
	<xsl:call-template name="string-replaceLF">
	<xsl:with-param name="string" select="$new_message4"/>
	<xsl:with-param name="from" select="'!LF!'"/>
	</xsl:call-template>
</xsl:variable>
        <!-- Print the final String -->
        <xsl:value-of select="$new_message5"/>
    </xsl:template>
    <!-- Replaces a string with new line character -->
    <xsl:template name="string-replaceLF" >
        <xsl:param name="string"/>
        <xsl:param name="from"/>
        <!-- don't chaange the format of the below section -->
        <xsl:variable name="test1"><xsl:text>
</xsl:text></xsl:variable>
        <!-- don't chaange the format of the above section -->
        <xsl:choose>
            <xsl:when test="contains($string,$from)">
                <xsl:value-of select="substring-before($string,$from)"/>
                <xsl:value-of select="$test1"/>
                <xsl:call-template name="string-replaceLF">
                    <xsl:with-param name="string" select="substring-after($string,$from)"/>
                    <xsl:with-param name="from" select="$from"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- This template replaces all the occurances of 'from' with 'to' in a string -->
    <xsl:template name="string-replace" >
        <xsl:param name="string"/>
        <xsl:param name="from"/>
        <xsl:param name="to"/>
        <xsl:choose>
            <xsl:when test="contains($string,$from)">
                <xsl:value-of select="substring-before($string,$from)"/>
                <xsl:value-of select="$to"/>
                <xsl:call-template name="string-replace">
                    <xsl:with-param name="string" select="substring-after($string,$from)"/>
                    <xsl:with-param name="from" select="$from"/>
                    <xsl:with-param name="to" select="$to"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- cuts decription portion from the log entry and returns the rest of the log string 
 i.e. the string in between [ and ] 
-->
    <xsl:template name="cut-description" >
        <xsl:param name="Message"/>
        <xsl:choose>
            <xsl:when test="contains(Message,'[') and contains(Message,']')">
                <xsl:value-of select="substring-after(Message,']')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="Message"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--returns decription portion from the log entry  
 i.e. the string in between [ and ] 
-->
    <xsl:template name="get-description" >
        <xsl:choose>
            <xsl:when test="contains(Message,'[') and contains(Message,']')">
                <xsl:variable name="test1"><xsl:value-of select="substring-before(Message,']')"/></xsl:variable>
                <td><xsl:value-of select="substring-after($test1,'[')"/></td>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- returns decription portion from the error log entry  
 i.e. description and response are separated by '/' 
-->
    <xsl:template name="get-error-description" >
        <xsl:choose>
            <xsl:when test="contains(Message,'/') and contains(Message,'TTY')">
                <xsl:variable name="test1"><xsl:value-of select="substring-after(Message,'TTY:')"/> </xsl:variable>
                <xsl:value-of select="substring-before($test1,'/')"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- This return the actual command and the response in the log entry 
  i.e. it returns the string between single qoutes in the log 
  -->
    <xsl:template name="getMessage" >
        <xsl:param name="string"/>
        <xsl:variable name="quot">'</xsl:variable>
        <xsl:choose>
            <xsl:when test="contains($string,$quot)">
                <xsl:variable name="substring" select="substring-after($string,$quot)"/>
                <xsl:value-of select="substring-before($substring,$quot)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
