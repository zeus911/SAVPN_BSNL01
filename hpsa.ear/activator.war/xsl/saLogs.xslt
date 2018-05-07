<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--  We want to produce output for a HTML browser  -->
<xsl:output method="html"/>
<xsl:preserve-space elements="*"/>

<xsl:template match="LogRoot">
<html>
  <head>
      <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
      <script>
            function reload (){ 
                var reload_rate = top.leftFrame.getJobRefreshRate();
		var logFileSelected = top.leftFrame.logFileSelected;
		if(logFileSelected.indexOf('active')!=-1 ){
                   setTimeout("go_now()",reload_rate); 
		}

            }
            function go_now (){
                if (window.top.refresh==null || window.top.refresh != "OFF") 
                {
                  if(window.top.logFile.indexOf('_active') != -1  )
                  {
                    window.location.href = window.location.href;
                  }else 
                  {
                     if(window.top.logFile.indexOf('.stderr') != -1  )
                     {
                       window.location.href = window.location.href;
                     }else 
                      { 
                        if(window.top.logFile.indexOf('.stdout') != -1  )
                        {
                          window.location.href = window.location.href;
                        }
                      } 
                   } 
                    
                }
            }
            window.onload = function() {
                top.leftFrame.restoreLogPos(document.body.scrollHeight,document.getElementById('logTable').rows.length);
                reload ();
                return true;
            }
            
            window.onscroll = function() {
                savePosition();
            }

            if (document.layers) {
                document.captureEvents(Event.MOUSEMOVE);
                document.onmousemove = savePosition;
            }

            function savePosition(){
                var valueX = 0;
                var valueY = 0;
                var height=0;
                var numRows=0;
                var ie = document.all;
                //get the height of the log page
                height=document.body.scrollHeight;
                //get the number of rows in the table which displays the logs
                numRows=document.getElementById('logTable').rows.length;
                if(ie){
                    valueX = document.body.scrollLeft;
                    
                    //get the number of rows for the scrolled height((current height/total height)* total number of rows in the page)
                    var tmp = document.body.scrollTop/height;
                    valueY=tmp*numRows;
                }else{
                    valueX = window.pageXOffset;
                    //get the number of rows for the scrolled height((current height/total height)* total number of rows in the page)
                    var tmp = window.pageYOffset/height;
                    valueY=tmp*numRows;
                }
                top.leftFrame.saveLogPos(valueX, valueY,numRows);
                return true;
            }
        </script>
  </head>
  <style>
html {
  font-family: Verdana, Helvetica, Arial, Sans-serif;
}
body,.row0,.row1,.heading,.error,.warning {
  font-size: 8pt;
}
.row0 {
  background-color: /*c:ltgy*/#e5e8e8;
}
.row1 {
  background-color: /*c:gy20*/#cccccc;
}
.heading {
  background: /*c:sabl*/#0096d6;
  color: /*c:whit*/#ffffff;
  text-align: left;
  vertical-align: middle;
  border: 1px solid /*c:whit*/#ffffff;
}
.error {
  background-color: /*c:red*/#ff0000;
}
.warning {
  background-color: /*c:yllw*/#ffff44;
}
</style>
  <body onmousemove="logoutTimerReset();"
    onkeydown="logoutTimerReset();">
    <table id="logTable" width="100%">
      <tr>
        <td class="heading">Hostname</td>
        <td class="heading">Time</td>
        <td class="heading">Component</td>
        
        <td class="heading" >Message</td>
        <!-- If the JobId element is not in file do not display the column -->
         <xsl:if test="//ID">
            <td class="heading">Id</td>
         </xsl:if>
         <!-- If the ServiceId element is not in file do not display the column -->
	          <xsl:if test="//ServiceId">
	             <td class="heading">Service Id</td>
         </xsl:if>
        <td class="heading">Part</td>
        <td class="heading">Topic</td>
        <td class="heading">Thread</td>
      </tr>

      <xsl:for-each select="LogEntry">

        <xsl:choose>
           <xsl:when test="@level = 'ERROR'">
              <tr class="error">
              <xsl:if test="@no">
                 <xsl:attribute name="id"><xsl:value-of select="concat('_log_entry_no_', @no, '_')"/></xsl:attribute>
              </xsl:if>
              <xsl:call-template name="showdata" />
              </tr>
           </xsl:when>
           <xsl:when test="@level = 'WARNING'">
              <tr class="warning">
              <xsl:if test="@no">
                 <xsl:attribute name="id"><xsl:value-of select="concat('_log_entry_no_', @no, '_')"/></xsl:attribute>
              </xsl:if>
              <xsl:call-template name="showdata" />
              </tr>
           </xsl:when>
           <xsl:otherwise>
              <tr class="row{position() mod 2 }">
              <xsl:if test="@no">
                 <xsl:attribute name="id"><xsl:value-of select="concat('_log_entry_no_', @no, '_')"/></xsl:attribute>
              </xsl:if>
              <xsl:call-template name="showdata" />
              </tr>
           </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>
    </table>
  </body>
</html>
</xsl:template>

<xsl:template name="showdata">

          <td nowrap=""><xsl:value-of select="HostName"/></td>
	  <td><xsl:value-of select="Time"/></td>
          <td><xsl:value-of select="Component"/></td>
          
          <td><xsl:value-of select="Message" disable-output-escaping="no"/></td>

          <!-- if JobId is available -->
          <xsl:if test="//ID">
          <xsl:choose>
             <xsl:when test="./ID">
               <td><xsl:value-of select="ID"/></td>
             </xsl:when>
             <xsl:otherwise>
               <td></td>
             </xsl:otherwise>
          </xsl:choose>
          </xsl:if>
          
          <!-- if ServiceId is available -->
	            <xsl:if test="//ServiceId">
	            <xsl:choose>
	               <xsl:when test="./ServiceId">
	                 <td><xsl:value-of select="ServiceId"/></td>
	               </xsl:when>
	               <xsl:otherwise>
	                 <td></td>
	               </xsl:otherwise>
	            </xsl:choose>
          </xsl:if>
          <td><xsl:value-of select="Part"/></td>
          <td><xsl:value-of select="Topic"/></td>
          <td><xsl:value-of select="Thread"/></td>
          

</xsl:template>

</xsl:stylesheet>
<!-- (c) Copyright 2014 Hewlett-Packard Development Company, L.P. -->

