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
String datasource = (String) request.getParameter(igw_trunkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitigw_trunkAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("trunk_id") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "trunktype_id";
                                    }

%>

<html>
  <head>
    <title><bean:message bundle="igw_trunkApplicationResources" key="<%= igw_trunkConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.igw_trunkForm.action = '/activator<%=moduleConfig%>/UpdateFormigw_trunkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.igw_trunkForm.submit();
    }
    function performCommit()
    {
      window.document.igw_trunkForm.action = '/activator<%=moduleConfig%>/UpdateCommitigw_trunkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.igw_trunkForm.submit();
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
com.hp.ov.activator.vpn.inventory.igw_trunk beanigw_trunk = (com.hp.ov.activator.vpn.inventory.igw_trunk) request.getAttribute(igw_trunkConstants.IGW_TRUNK_BEAN);
if(beanigw_trunk==null)
   beanigw_trunk = (com.hp.ov.activator.vpn.inventory.igw_trunk) request.getSession().getAttribute(igw_trunkConstants.IGW_TRUNK_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
igw_trunkForm form = (igw_trunkForm) request.getAttribute("igw_trunkForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String TRUNK_ID = beanigw_trunk.getTrunk_id();
        
            
                            
            
                
                String TRUNKTYPE_ID = beanigw_trunk.getTrunktype_id();
        
            
                            
            
                
                String NAME = beanigw_trunk.getName();
        
            
                            
            
                
                String LINK_TYPE = beanigw_trunk.getLink_type();
        
            
                            
            
                
                String STATUS = beanigw_trunk.getStatus();
        
            
                            
            
                
                String SUBMIT_DATA = beanigw_trunk.getSubmit_data();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="igw_trunkApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="igw_trunkApplicationResources" property="TRUNK_ID"/>
        <html:errors bundle="igw_trunkApplicationResources" property="TRUNKTYPE_ID"/>
        <html:errors bundle="igw_trunkApplicationResources" property="NAME"/>
        <html:errors bundle="igw_trunkApplicationResources" property="LINK_TYPE"/>
        <html:errors bundle="igw_trunkApplicationResources" property="STATUS"/>
        <html:errors bundle="igw_trunkApplicationResources" property="SUBMIT_DATA"/>
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
                <bean:message bundle="igw_trunkApplicationResources" key="field.trunk_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="trunk_id" value="<%= TRUNK_ID %>"/>
                                                        <html:text disabled="true" property="trunk_id" size="24" value="<%= TRUNK_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkApplicationResources" key="field.trunk_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkApplicationResources" key="field.trunktype_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="trunktype_id" size="24" value="<%= TRUNKTYPE_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkApplicationResources" key="field.trunktype_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= NAME %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkApplicationResources" key="field.link_type.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="link_type" size="24" value="<%= LINK_TYPE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkApplicationResources" key="field.link_type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkApplicationResources" key="field.status.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="status" size="24" value="<%= STATUS %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkApplicationResources" key="field.status.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkApplicationResources" key="field.submit_data.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="submit_data" size="24" value="<%= SUBMIT_DATA %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkApplicationResources" key="field.submit_data.description"/>
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
