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
String datasource = (String) request.getParameter(Sh_QoSProfileConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSh_QoSProfileAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "qosprofilename";
                                                                              }
%>

<html>
  <head>
    <title><bean:message bundle="Sh_QoSProfileApplicationResources" key="<%= Sh_QoSProfileConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_QoSProfileForm.action = '/activator<%=moduleConfig%>/CreationFormSh_QoSProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.Sh_QoSProfileForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_QoSProfileForm.action = '/activator<%=moduleConfig%>/CreationCommitSh_QoSProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_QoSProfileForm.submit();
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

com.hp.ov.activator.vpn.inventory.Sh_QoSProfile beanSh_QoSProfile = (com.hp.ov.activator.vpn.inventory.Sh_QoSProfile) request.getAttribute(Sh_QoSProfileConstants.SH_QOSPROFILE_BEAN);

      String QoSProfileName = beanSh_QoSProfile.getQosprofilename();
                String CustomerId = beanSh_QoSProfile.getCustomerid();
                String Prefix = beanSh_QoSProfile.getPrefix();
                String Layer = beanSh_QoSProfile.getLayer();
                String Description = beanSh_QoSProfile.getDescription();
                String PEQoSProfileName = beanSh_QoSProfile.getPeqosprofilename();
                String Profilename_in = beanSh_QoSProfile.getProfilename_in();
                String Profilename_out = beanSh_QoSProfile.getProfilename_out();
                String UploadStatus = beanSh_QoSProfile.getUploadstatus();
                String DBPrimaryKey = beanSh_QoSProfile.getDbprimarykey();
                String Marker = beanSh_QoSProfile.getMarker();
                String Compliant = beanSh_QoSProfile.getCompliant();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_QoSProfileApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_QoSProfileApplicationResources" property="QoSProfileName"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="CustomerId"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Prefix"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Layer"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Description"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="PEQoSProfileName"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Profilename_in"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Profilename_out"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Compliant"/>
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
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.qosprofilename.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofilename" size="24" value="<%= QoSProfileName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.qosprofilename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.customerid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.customerid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.prefix.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="prefix" size="24" value="<%= Prefix %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.prefix.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.layer.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Layer==null||Layer.trim().equals("")) {
                          selValue="layer 3";
                        } else {
                          selValue=Layer.toString();
                        }    
                    %>

                    <html:select  property="layer" value="<%= selValue %>" >
                                            <html:option value="layer 3" >layer 3</html:option>
                                            <html:option value="layer 2" >layer 2</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.layer.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.description.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.peqosprofilename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="peqosprofilename" size="24" value="<%= PEQoSProfileName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.peqosprofilename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="profilename_in" size="24" value="<%= Profilename_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_in.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="profilename_out" size="24" value="<%= Profilename_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_out.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.uploadstatus.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.dbprimarykey.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.marker.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.compliant.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Compliant==null||Compliant.trim().equals("")) {
                          selValue="compliant";
                        } else {
                          selValue=Compliant.toString();
                        }    
                    %>

                    <html:select  property="compliant" value="<%= selValue %>" >
                                            <html:option value="compliant" >compliant</html:option>
                                            <html:option value="partial compliant" >partial compliant</html:option>
                                            <html:option value="non compliant" >non compliant</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.compliant.description"/>
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
