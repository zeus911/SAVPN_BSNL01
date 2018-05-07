<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnmi.dl.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
String datasource = (String) request.getParameter(DL_NetworkAttachmentConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitDL_NetworkAttachmentAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "ne_nnmi_id";
                  }
%>

<html>
  <head>
    <title><bean:message bundle="DL_NetworkAttachmentApplicationResources" key="<%= DL_NetworkAttachmentConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.DL_NetworkAttachmentForm.action = '/activator<%=moduleConfig%>/CreationFormDL_NetworkAttachmentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.DL_NetworkAttachmentForm.submit();
    }
    function performCommit()
    {
      window.document.DL_NetworkAttachmentForm.action = '/activator<%=moduleConfig%>/CreationCommitDL_NetworkAttachmentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.DL_NetworkAttachmentForm.submit();
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

com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkAttachment beanDL_NetworkAttachment = (com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkAttachment) request.getAttribute(DL_NetworkAttachmentConstants.DL_NETWORKATTACHMENT_BEAN);

      String NE_NNMi_Id = beanDL_NetworkAttachment.getNe_nnmi_id();
        String NE_NNMi_IdLabel = (String) request.getAttribute(DL_NetworkAttachmentConstants.NE_NNMI_ID_LABEL);
ArrayList NE_NNMi_IdListOfValues = (ArrayList) request.getAttribute(DL_NetworkAttachmentConstants.NE_NNMI_ID_LIST_OF_VALUES);
            String Network = beanDL_NetworkAttachment.getNetwork();
        String NetworkLabel = (String) request.getAttribute(DL_NetworkAttachmentConstants.NETWORK_LABEL);
ArrayList NetworkListOfValues = (ArrayList) request.getAttribute(DL_NetworkAttachmentConstants.NETWORK_LIST_OF_VALUES);
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_NetworkAttachmentApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="DL_NetworkAttachmentApplicationResources" property="NE_NNMi_Id"/>
        <html:errors bundle="DL_NetworkAttachmentApplicationResources" property="Network"/>
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
                <bean:message bundle="DL_NetworkAttachmentApplicationResources" key="field.ne_nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="ne_nnmi_id" value="<%= NE_NNMi_Id %>" >
                      <html:options collection="NE_NNMi_IdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkAttachmentApplicationResources" key="field.ne_nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkAttachmentApplicationResources" key="field.network.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="network" value="<%= Network %>" >
                      <html:options collection="NetworkListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkAttachmentApplicationResources" key="field.network.description"/>
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
