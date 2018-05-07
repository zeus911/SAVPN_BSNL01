<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.cr.inventory.*,
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
String datasource = (String) request.getParameter(TerminationPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitTerminationPointAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "name";
                                    }
%>

<html>
  <head>
    <title><bean:message bundle="TerminationPointApplicationResources" key="<%= TerminationPointConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.TerminationPointForm.action = '/activator<%=moduleConfig%>/CreationFormTerminationPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.TerminationPointForm.submit();
    }
    function performCommit()
    {
      window.document.TerminationPointForm.action = '/activator<%=moduleConfig%>/CreationCommitTerminationPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.TerminationPointForm.submit();
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

com.hp.ov.activator.cr.inventory.TerminationPoint beanTerminationPoint = (com.hp.ov.activator.cr.inventory.TerminationPoint) request.getAttribute(TerminationPointConstants.TERMINATIONPOINT_BEAN);

      String TerminationPointId = beanTerminationPoint.getTerminationpointid();
                String Name = beanTerminationPoint.getName();
                String NE_Id = beanTerminationPoint.getNe_id();
        String NE_IdLabel = (String) request.getAttribute(TerminationPointConstants.NE_ID_LABEL);
ArrayList NE_IdListOfValues = (ArrayList) request.getAttribute(TerminationPointConstants.NE_ID_LIST_OF_VALUES);
            String EC_Id = beanTerminationPoint.getEc_id();
        String EC_IdLabel = (String) request.getAttribute(TerminationPointConstants.EC_ID_LABEL);
ArrayList EC_IdListOfValues = (ArrayList) request.getAttribute(TerminationPointConstants.EC_ID_LIST_OF_VALUES);
            String State = beanTerminationPoint.getState();
            
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="TerminationPointApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="TerminationPointApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="TerminationPointApplicationResources" property="Name"/>
        <html:errors bundle="TerminationPointApplicationResources" property="NE_Id"/>
        <html:errors bundle="TerminationPointApplicationResources" property="EC_Id"/>
        <html:errors bundle="TerminationPointApplicationResources" property="State"/>
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
      
                                                  <html:hidden property="terminationpointid" value="<%= TerminationPointId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="TerminationPointApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="TerminationPointApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="TerminationPointApplicationResources" key="field.ne_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="ne_id" value="<%= NE_Id %>" onchange="sendthis('ne_id');">
                      <html:options collection="NE_IdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="TerminationPointApplicationResources" key="field.ne_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="TerminationPointApplicationResources" key="field.ec_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="ec_id" value="<%= EC_Id %>" >
                      <html:options collection="EC_IdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="TerminationPointApplicationResources" key="field.ec_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="TerminationPointApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(State==null||State.trim().equals("")) {
                          selValue="Up";
                        } else {
                          selValue=State.toString();
                        }    
                    %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="TerminationPointApplicationResources" key="field.state.description"/>
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
