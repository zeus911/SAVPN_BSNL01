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
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(ActionTemplatesConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitActionTemplatesAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("elementtype") + "||" + request.getParameter("osversion") + "||" + request.getParameter("role") + "||" + request.getParameter("activationname") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                      _location_ = "clitemplate";
            }

%>

<html>
  <head>
    <title><bean:message bundle="ActionTemplatesApplicationResources" key="<%= ActionTemplatesConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.ActionTemplatesForm.action = '/activator<%=moduleConfig%>/UpdateFormActionTemplatesAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.ActionTemplatesForm.submit();
    }
    function performCommit()
    {
      window.document.ActionTemplatesForm.action = '/activator<%=moduleConfig%>/UpdateCommitActionTemplatesAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.ActionTemplatesForm.submit();
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
com.hp.ov.activator.vpn.inventory.ActionTemplates beanActionTemplates = (com.hp.ov.activator.vpn.inventory.ActionTemplates) request.getAttribute(ActionTemplatesConstants.ACTIONTEMPLATES_BEAN);
if(beanActionTemplates==null)
   beanActionTemplates = (com.hp.ov.activator.vpn.inventory.ActionTemplates) request.getSession().getAttribute(ActionTemplatesConstants.ACTIONTEMPLATES_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
ActionTemplatesForm form = (ActionTemplatesForm) request.getAttribute("ActionTemplatesForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ElementType = beanActionTemplates.getElementtype();
        
          String ElementTypeLabel = (String) request.getAttribute(ActionTemplatesConstants.ELEMENTTYPE_LABEL);
      ArrayList ElementTypeListOfValues = (ArrayList) request.getAttribute(ActionTemplatesConstants.ELEMENTTYPE_LIST_OF_VALUES);
            
                            
            
                
                String OSversion = beanActionTemplates.getOsversion();
        
          String OSversionLabel = (String) request.getAttribute(ActionTemplatesConstants.OSVERSION_LABEL);
      ArrayList OSversionListOfValues = (ArrayList) request.getAttribute(ActionTemplatesConstants.OSVERSION_LIST_OF_VALUES);
            
                            
            
                
                String Role = beanActionTemplates.getRole();
        
            
                            
            
                
                String ActivationName = beanActionTemplates.getActivationname();
        
            
                            
            
                
                String CLITemplate = beanActionTemplates.getClitemplate();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ActionTemplatesApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="ActionTemplatesApplicationResources" property="ElementType"/>
        <html:errors bundle="ActionTemplatesApplicationResources" property="OSversion"/>
        <html:errors bundle="ActionTemplatesApplicationResources" property="Role"/>
        <html:errors bundle="ActionTemplatesApplicationResources" property="ActivationName"/>
        <html:errors bundle="ActionTemplatesApplicationResources" property="CLITemplate"/>
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
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.elementtype.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="elementtype" value="<%= ElementType %>"/>
                                                        <html:select disabled="true" property="elementtype" value="<%= ElementType %>" onchange="sendthis('elementtype');">
                      <html:options collection="ElementTypeListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.elementtype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.osversion.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="osversion" value="<%= OSversion %>"/>
                                                        <html:select disabled="true" property="osversion" value="<%= OSversion %>" >
                      <html:options collection="OSversionListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.osversion.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.role.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="role" value="<%= Role %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(Role==null||Role.trim().equals(""))
                           selValue="PE";
                        else
                        selValue=Role.toString();    
                          %>

                    <html:select disabled="true" property="role" value="<%= selValue %>" >
                                            <html:option value="PE" >PE</html:option>
                                            <html:option value="CE" >CE</html:option>
                                            <html:option value="P" >P</html:option>
                                            <html:option value="AggregationSwitch" >AggregationSwitch</html:option>
                                            <html:option value="AccessSwitch" >AccessSwitch</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.role.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.activationname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="activationname" value="<%= ActivationName %>"/>
                                                        <html:text disabled="true" property="activationname" size="24" value="<%= ActivationName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.activationname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.clitemplate.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="clitemplate" size="24" value="<%= CLITemplate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ActionTemplatesApplicationResources" key="field.clitemplate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                    
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
