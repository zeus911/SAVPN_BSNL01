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
String datasource = (String) request.getParameter(VlanRangeConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitVlanRangeAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "usage";
                                          }
%>

<html>
  <head>
    <title><bean:message bundle="VlanRangeApplicationResources" key="<%= VlanRangeConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.VlanRangeForm.action = '/activator<%=moduleConfig%>/CreationFormVlanRangeAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.VlanRangeForm.submit();
    }
    function performCommit()
    {
      window.document.VlanRangeForm.action = '/activator<%=moduleConfig%>/CreationCommitVlanRangeAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.VlanRangeForm.submit();
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

com.hp.ov.activator.vpn.inventory.VlanRange beanVlanRange = (com.hp.ov.activator.vpn.inventory.VlanRange) request.getAttribute(VlanRangeConstants.VLANRANGE_BEAN);

      String VlanRangeID = beanVlanRange.getVlanrangeid();
                String Usage = beanVlanRange.getUsage();
                String Allocation = beanVlanRange.getAllocation();
                String StartValue = "" + beanVlanRange.getStartvalue();
                      String EndValue = "" + beanVlanRange.getEndvalue();
                      String Description = beanVlanRange.getDescription();
                String Region = beanVlanRange.getRegion();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="VlanRangeApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="VlanRangeApplicationResources" property="VlanRangeID"/>
        <html:errors bundle="VlanRangeApplicationResources" property="Usage"/>
        <html:errors bundle="VlanRangeApplicationResources" property="Allocation"/>
        <html:errors bundle="VlanRangeApplicationResources" property="StartValue"/>
        <html:errors bundle="VlanRangeApplicationResources" property="EndValue"/>
        <html:errors bundle="VlanRangeApplicationResources" property="Description"/>
        <html:errors bundle="VlanRangeApplicationResources" property="Region"/>
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
      
                                                  <html:hidden property="vlanrangeid" value="<%= VlanRangeID %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="VlanRangeApplicationResources" key="field.usage.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="usage" size="24" value="<%= Usage %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VlanRangeApplicationResources" key="field.usage.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VlanRangeApplicationResources" key="field.allocation.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Allocation==null||Allocation.trim().equals("")) {
                          selValue="Internal";
                        } else {
                          selValue=Allocation.toString();
                        }    
                    %>

                    <html:select  property="allocation" value="<%= selValue %>" >
                                            <html:option value="Internal" >Internal</html:option>
                                            <html:option value="External" >External</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VlanRangeApplicationResources" key="field.allocation.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VlanRangeApplicationResources" key="field.startvalue.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="startvalue" size="24" value="<%= StartValue %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VlanRangeApplicationResources" key="field.startvalue.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VlanRangeApplicationResources" key="field.endvalue.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="endvalue" size="24" value="<%= EndValue %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VlanRangeApplicationResources" key="field.endvalue.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VlanRangeApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VlanRangeApplicationResources" key="field.description.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VlanRangeApplicationResources" key="field.region.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="region" value="<%= Region %>"/>
                                                        <html:text disabled="true" property="region" size="24" value="<%= Region %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VlanRangeApplicationResources" key="field.region.description"/>
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
