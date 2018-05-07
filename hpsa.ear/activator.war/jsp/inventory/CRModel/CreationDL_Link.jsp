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

                                 java.text.SimpleDateFormat sdfNNMi_LastUpdateData = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
            String sdfNNMi_LastUpdateDataDesc = "Format: [" + sdfNNMi_LastUpdateData.toPattern() + "]. Example: [" + sdfNNMi_LastUpdateData.format(new Date()) + "]";
    
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(DL_LinkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitDL_LinkAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "nnmi_id";
                                                                  }
%>

<html>
  <head>
    <title><bean:message bundle="DL_LinkApplicationResources" key="<%= DL_LinkConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.DL_LinkForm.action = '/activator<%=moduleConfig%>/CreationFormDL_LinkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.DL_LinkForm.submit();
    }
    function performCommit()
    {
      window.document.DL_LinkForm.action = '/activator<%=moduleConfig%>/CreationCommitDL_LinkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.DL_LinkForm.submit();
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

com.hp.ov.activator.nnmi.dl.inventory.DL_Link beanDL_Link = (com.hp.ov.activator.nnmi.dl.inventory.DL_Link) request.getAttribute(DL_LinkConstants.DL_LINK_BEAN);

      String NNMi_Id = beanDL_Link.getNnmi_id();
                String Name = beanDL_Link.getName();
                String NE1_NNMi_Id = beanDL_Link.getNe1_nnmi_id();
                String TP1_NNMi_Id = beanDL_Link.getTp1_nnmi_id();
                String NE2_NNMi_Id = beanDL_Link.getNe2_nnmi_id();
                String TP2_NNMi_Id = beanDL_Link.getTp2_nnmi_id();
                String Type = beanDL_Link.getType();
                String NNMi_UUId = beanDL_Link.getNnmi_uuid();
                String NNMi_LastUpdateData = (beanDL_Link.getNnmi_lastupdatedata() == null) ? "" : beanDL_Link.getNnmi_lastupdatedata();
                String StateName = beanDL_Link.getStatename();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_LinkApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="DL_LinkApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="DL_LinkApplicationResources" property="Name"/>
        <html:errors bundle="DL_LinkApplicationResources" property="NE1_NNMi_Id"/>
        <html:errors bundle="DL_LinkApplicationResources" property="TP1_NNMi_Id"/>
        <html:errors bundle="DL_LinkApplicationResources" property="NE2_NNMi_Id"/>
        <html:errors bundle="DL_LinkApplicationResources" property="TP2_NNMi_Id"/>
        <html:errors bundle="DL_LinkApplicationResources" property="Type"/>
        <html:errors bundle="DL_LinkApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="DL_LinkApplicationResources" property="NNMi_LastUpdateData"/>
        <html:errors bundle="DL_LinkApplicationResources" property="StateName"/>
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
                <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.name.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.ne1_nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ne1_nnmi_id" size="24" value="<%= NE1_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.ne1_nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.tp1_nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="tp1_nnmi_id" size="24" value="<%= TP1_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.tp1_nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.ne2_nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ne2_nnmi_id" size="24" value="<%= NE2_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.ne2_nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.tp2_nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="tp2_nnmi_id" size="24" value="<%= TP2_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.tp2_nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Type==null||Type.trim().equals("")) {
                          selValue="ASBRLink";
                        } else {
                          selValue=Type.toString();
                        }    
                    %>

                    <html:select  property="type" value="<%= selValue %>" >
                                            <html:option value="ASBRLink" >ASBRLink</html:option>
                                            <html:option value="AggregationTrunk" >AggregationTrunk</html:option>
                                            <html:option value="AccessTrunk" >AccessTrunk</html:option>
                                            <html:option value="AccessLink" >AccessLink</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_uuid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_uuid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_lastupdatedata.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="nnmi_lastupdatedata" size="24" value="<%= NNMi_LastUpdateData %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_lastupdatedata.description"/>
                <%=sdfNNMi_LastUpdateDataDesc%>              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_LinkApplicationResources" key="field.statename.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="statename" size="24" value="<%= StateName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_LinkApplicationResources" key="field.statename.description"/>
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
