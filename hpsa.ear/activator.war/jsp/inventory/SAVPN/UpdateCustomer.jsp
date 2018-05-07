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
String datasource = (String) request.getParameter(CustomerConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitCustomerAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("customerid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                  }

%>

<html>
  <head>
    <title><bean:message bundle="CustomerApplicationResources" key="<%= CustomerConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.CustomerForm.action = '/activator<%=moduleConfig%>/UpdateFormCustomerAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.CustomerForm.submit();
    }
    function performCommit()
    {
      window.document.CustomerForm.action = '/activator<%=moduleConfig%>/UpdateCommitCustomerAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.CustomerForm.submit();
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
com.hp.ov.activator.vpn.inventory.Customer beanCustomer = (com.hp.ov.activator.vpn.inventory.Customer) request.getAttribute(CustomerConstants.CUSTOMER_BEAN);
if(beanCustomer==null)
   beanCustomer = (com.hp.ov.activator.vpn.inventory.Customer) request.getSession().getAttribute(CustomerConstants.CUSTOMER_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
CustomerForm form = (CustomerForm) request.getAttribute("CustomerForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String CustomerId = beanCustomer.getCustomerid();
        
            
                            
            
                
                String CustomerName = beanCustomer.getCustomername();
        
            
                            
            
                
                String CustomerNameId = beanCustomer.getCustomernameid();
        
            
                            
            
                
                String CustomerContact = beanCustomer.getCustomercontact();
        
            
                            
            
                
                String CustomerEmail = beanCustomer.getCustomeremail();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="CustomerApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="CustomerApplicationResources" property="CustomerId"/>
        <html:errors bundle="CustomerApplicationResources" property="CustomerName"/>
        <html:errors bundle="CustomerApplicationResources" property="CustomerNameId"/>
        <html:errors bundle="CustomerApplicationResources" property="CustomerContact"/>
        <html:errors bundle="CustomerApplicationResources" property="CustomerEmail"/>
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
                <bean:message bundle="CustomerApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customerid" value="<%= CustomerId %>"/>
                                                        <html:text disabled="true" property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CustomerApplicationResources" key="field.customerid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CustomerApplicationResources" key="field.customername.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customername" value="<%= CustomerName %>"/>
                                                        <html:text disabled="true" property="customername" size="24" value="<%= CustomerName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CustomerApplicationResources" key="field.customername.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="customernameid" value="<%= CustomerNameId %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CustomerApplicationResources" key="field.customercontact.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customercontact" value="<%= CustomerContact %>"/>
                                                        <html:text disabled="true" property="customercontact" size="24" value="<%= CustomerContact %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CustomerApplicationResources" key="field.customercontact.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CustomerApplicationResources" key="field.customeremail.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customeremail" value="<%= CustomerEmail %>"/>
                                                        <html:text disabled="true" property="customeremail" size="24" value="<%= CustomerEmail %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CustomerApplicationResources" key="field.customeremail.description"/>
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
