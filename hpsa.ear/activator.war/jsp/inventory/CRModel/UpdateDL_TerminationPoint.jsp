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
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(DL_TerminationPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_TerminationPointAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("nnmi_id") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "name";
                                    }

%>

<html>
  <head>
    <title><bean:message bundle="DL_TerminationPointApplicationResources" key="<%= DL_TerminationPointConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.DL_TerminationPointForm.action = '/activator<%=moduleConfig%>/UpdateFormDL_TerminationPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.DL_TerminationPointForm.submit();
    }
    function performCommit()
    {
      window.document.DL_TerminationPointForm.action = '/activator<%=moduleConfig%>/UpdateCommitDL_TerminationPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.DL_TerminationPointForm.submit();
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
      var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alert.setBounds(400, 120);
      alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alert.show();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">

<%
com.hp.ov.activator.nnmi.dl.inventory.DL_TerminationPoint beanDL_TerminationPoint = (com.hp.ov.activator.nnmi.dl.inventory.DL_TerminationPoint) request.getAttribute(DL_TerminationPointConstants.DL_TERMINATIONPOINT_BEAN);
if(beanDL_TerminationPoint==null)
   beanDL_TerminationPoint = (com.hp.ov.activator.nnmi.dl.inventory.DL_TerminationPoint) request.getSession().getAttribute(DL_TerminationPointConstants.DL_TERMINATIONPOINT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_TerminationPointForm form = (DL_TerminationPointForm) request.getAttribute("DL_TerminationPointForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String NNMi_Id = beanDL_TerminationPoint.getNnmi_id();
        
            
                            
            
                
                String Name = beanDL_TerminationPoint.getName();
        
            
                            
            
                
                String NE_NNMi_Id = beanDL_TerminationPoint.getNe_nnmi_id();
        
            
                            
            
                
                String EC_NNMi_Id = beanDL_TerminationPoint.getEc_nnmi_id();
        
            
                            
            
                
                String State = beanDL_TerminationPoint.getState();
        
            
                            
            
                
                String StateName = beanDL_TerminationPoint.getStatename();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_TerminationPointApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="DL_TerminationPointApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="Name"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="NE_NNMi_Id"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="EC_NNMi_Id"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="State"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="StateName"/>
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
<input type="hidden" name="_update_commit_" value="true"/> 
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
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.name.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ne_nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ne_nnmi_id" value="<%= NE_NNMi_Id %>"/>
                                                        <html:text disabled="true" property="ne_nnmi_id" size="24" value="<%= NE_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ne_nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ec_nnmi_id.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ec_nnmi_id" value="<%= EC_NNMi_Id %>"/>
                                                        <html:text disabled="true" property="ec_nnmi_id" size="24" value="<%= EC_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ec_nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(State==null||State.trim().equals(""))
                           selValue="Up";
                        else
                        selValue=State.toString();    
                          %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_TerminationPointApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="statename" value="<%= StateName %>"/>            
				                                            
                    
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
      
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
