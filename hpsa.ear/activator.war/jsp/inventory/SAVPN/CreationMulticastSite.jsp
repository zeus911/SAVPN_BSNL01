<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
        com.hp.ov.activator.inventory.facilities.StringFacility " %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext()); 
// module name that can be used as solution name               
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<%
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(MulticastSiteConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitMulticastSiteAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "attachmentid";
                                                }
%>

<html>
  <head>
    <title><bean:message bundle="MulticastSiteApplicationResources" key="<%= MulticastSiteConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
    function sendthis(focusthis)
    {
      window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/CreationFormMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.MulticastSiteForm.submit();
    }
    function performCommit()
    {
      window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/CreationCommitMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.MulticastSiteForm.submit();
    }
    function init()
    {
<%
if ( _location_ != null ) {
%>
      var elems = document.getElementsByName("<%=_location_%>");
      var elem = elems == null || elems.length == 0 ? null : elems[0];
      if (elem != null) {
        elem.focus();
      }
<%
}
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }
    </script>
  </head>
  <body style="overflow:auto;" onload="init();">
<%

com.hp.ov.activator.vpn.inventory.MulticastSite beanMulticastSite = (com.hp.ov.activator.vpn.inventory.MulticastSite) request.getAttribute(MulticastSiteConstants.MULTICASTSITE_BEAN);

      String AttachmentId = beanMulticastSite.getAttachmentid();
                String MulticastLoopbackAddress = beanMulticastSite.getMulticastloopbackaddress();
                String VirtualTunnelId = beanMulticastSite.getVirtualtunnelid();
                String RPMode = beanMulticastSite.getRpmode();
                String RPAddress = beanMulticastSite.getRpaddress();
                String MSDPLocalAddress = beanMulticastSite.getMsdplocaladdress();
                String MSDPPeerAddress = beanMulticastSite.getMsdppeeraddress();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="MulticastSiteApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="MulticastSiteApplicationResources" property="AttachmentId"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MulticastLoopbackAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="VirtualTunnelId"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="RPMode"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="RPAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MSDPLocalAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MSDPPeerAddress"/>
  </h1>
<script>
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
    allEvents = allEvents + "checkShowRulesAttachmentId();";//default invoked when loading HTML
    function checkShowRulesAttachmentId(){
          var AttachmentIdPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("attachmentid")[0].value)) {AttachmentIdPass = true;}
                        
      

    var controlTr = document.getElementsByName("attachmentid")[0];
    
          if (true && AttachmentIdPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('attachmentid')[0],'keyup',checkShowRulesAttachmentId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesVirtualTunnelId();";//default invoked when loading HTML
    function checkShowRulesVirtualTunnelId(){
          var VirtualTunnelIdPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("virtualtunnelid")[0].value)) {VirtualTunnelIdPass = true;}
                        
      

    var controlTr = document.getElementsByName("virtualtunnelid")[0];
    
          if (true && VirtualTunnelIdPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('virtualtunnelid')[0],'keyup',checkShowRulesVirtualTunnelId);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                    document.getElementsByName("attachmentid")[0].parentNode.parentNode.style.display="none";
                                    document.getElementsByName("virtualtunnelid")[0].parentNode.parentNode.style.display="none";
                                      // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
    <table:table>
      <table:header>
        <table:cell>
          <bean:message bundle="InventoryResources" key="name.heading"/>
        </table:cell>
        <table:cell>
          <bean:message bundle="InventoryResources" key="value.heading"/>
        </table:cell>
        <table:cell>
          <bean:message bundle="InventoryResources" key="description.heading"/>
        </table:cell>
      </table:header>
      
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="attachmentid" size="24" value="<%= AttachmentId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="multicastloopbackaddress" size="24" value="<%= MulticastLoopbackAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="virtualtunnelid" size="24" value="<%= VirtualTunnelId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(RPMode==null||RPMode.trim().equals("")) {
                          selValue="Disabled";
                        } else {
                          selValue=RPMode.toString();
                        }    
                    %>

                    <html:select  property="rpmode" value="<%= selValue %>" >
                                            <html:option value="Disabled" >Disabled</html:option>
                                            <html:option value="Auto-RP-Announce" >Auto-RP-Announce</html:option>
                                            <html:option value="Auto-RP-Discovery" >Auto-RP-Discovery</html:option>
                                            <html:option value="Auto-RP-Mapping" >Auto-RP-Mapping</html:option>
                                            <html:option value="Remote" >Remote</html:option>
                                            <html:option value="Local" >Local</html:option>
                                            <html:option value="Anycast-non-RP" >Anycast-non-RP</html:option>
                                            <html:option value="Anycast-RP" >Anycast-RP</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rpaddress" size="24" value="<%= RPAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="msdplocaladdress" size="24" value="<%= MSDPLocalAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="msdppeeraddress" size="24" value="<%= MSDPPeerAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.description"/>
                              </table:cell>
            </table:row>
                              
      
      <table:row>
        <table:cell colspan="3" align="center">
        <br>
        </table:cell>
      </table:row>
      <table:row>
        <table:cell colspan="3" align="center">
          <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
          <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>
  </html:form>

  </body>

</html>
