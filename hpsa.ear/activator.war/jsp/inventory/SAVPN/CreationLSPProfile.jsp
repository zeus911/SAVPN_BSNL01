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
String datasource = (String) request.getParameter(LSPProfileConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitLSPProfileAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "lspprofilename";
                                                      }
%>

<html>
  <head>
    <title><bean:message bundle="LSPProfileApplicationResources" key="<%= LSPProfileConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.LSPProfileForm.action = '/activator<%=moduleConfig%>/CreationFormLSPProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.LSPProfileForm.submit();
    }
    function performCommit()
    {
      window.document.LSPProfileForm.action = '/activator<%=moduleConfig%>/CreationCommitLSPProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.LSPProfileForm.submit();
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

com.hp.ov.activator.vpn.inventory.LSPProfile beanLSPProfile = (com.hp.ov.activator.vpn.inventory.LSPProfile) request.getAttribute(LSPProfileConstants.LSPPROFILE_BEAN);

      String LSPProfileName = beanLSPProfile.getLspprofilename();
                String Type = beanLSPProfile.getType();
                String CT = beanLSPProfile.getCt();
                String bwAllocation = beanLSPProfile.getBwallocation();
                String bwAlgorithm = beanLSPProfile.getBwalgorithm();
                String CoS = beanLSPProfile.getCos();
                String LSPFilter = beanLSPProfile.getLspfilter();
                String LSPProfileVersion = beanLSPProfile.getLspprofileversion();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPProfileApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="LSPProfileApplicationResources" property="LSPProfileName"/>
        <html:errors bundle="LSPProfileApplicationResources" property="Type"/>
        <html:errors bundle="LSPProfileApplicationResources" property="CT"/>
        <html:errors bundle="LSPProfileApplicationResources" property="bwAllocation"/>
        <html:errors bundle="LSPProfileApplicationResources" property="bwAlgorithm"/>
        <html:errors bundle="LSPProfileApplicationResources" property="CoS"/>
        <html:errors bundle="LSPProfileApplicationResources" property="LSPFilter"/>
        <html:errors bundle="LSPProfileApplicationResources" property="LSPProfileVersion"/>
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
function doOnLoad()
{
  // hide field
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
                <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofilename.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="lspprofilename" size="24" value="<%= LSPProfileName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofilename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPProfileApplicationResources" key="field.type.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Type==null||Type.trim().equals("")) {
                          selValue="VPN";
                        } else {
                          selValue=Type.toString();
                        }    
                    %>

                    <html:select  property="type" value="<%= selValue %>" >
                                            <html:option value="VPN" >VPN</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPProfileApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPProfileApplicationResources" key="field.ct.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(CT==null||CT.trim().equals("")) {
                          selValue="ct0";
                        } else {
                          selValue=CT.toString();
                        }    
                    %>

                    <html:select  property="ct" value="<%= selValue %>" >
                                            <html:option value="ct0" >ct0</html:option>
                                            <html:option value="ct1" >ct1</html:option>
                                            <html:option value="ct2" >ct2</html:option>
                                            <html:option value="ct3" >ct3</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPProfileApplicationResources" key="field.ct.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(bwAllocation==null||bwAllocation.trim().equals("")) {
                          selValue="manual";
                        } else {
                          selValue=bwAllocation.toString();
                        }    
                    %>

                    <html:select  property="bwallocation" value="<%= selValue %>" >
                                            <html:option value="manual" >manual</html:option>
                                            <html:option value="auto" >auto</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPProfileApplicationResources" key="field.bwalgorithm.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(bwAlgorithm==null||bwAlgorithm.trim().equals("")) {
                          selValue="Sum";
                        } else {
                          selValue=bwAlgorithm.toString();
                        }    
                    %>

                    <html:select  property="bwalgorithm" value="<%= selValue %>" >
                                            <html:option value="Sum" >Sum</html:option>
                                            <html:option value="manual" >manual</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPProfileApplicationResources" key="field.bwalgorithm.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPProfileApplicationResources" key="field.cos.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="cos" size="24" value="<%= CoS %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPProfileApplicationResources" key="field.cos.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="lspfilter" size="24" value="<%= LSPFilter %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="lspprofileversion" value="<%= LSPProfileVersion %>"/>            
                                          
      
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
