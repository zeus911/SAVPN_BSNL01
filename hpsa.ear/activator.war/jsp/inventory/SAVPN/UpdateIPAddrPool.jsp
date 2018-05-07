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
String datasource = (String) request.getParameter(IPAddrPoolConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitIPAddrPoolAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("name") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                _location_ = "ipnetaddress";
                              }

%>

<html>
  <head>
    <title><bean:message bundle="IPAddrPoolApplicationResources" key="<%= IPAddrPoolConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.IPAddrPoolForm.action = '/activator<%=moduleConfig%>/UpdateFormIPAddrPoolAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.IPAddrPoolForm.submit();
    }
    function performCommit()
    {
      window.document.IPAddrPoolForm.action = '/activator<%=moduleConfig%>/UpdateCommitIPAddrPoolAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.IPAddrPoolForm.submit();
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
com.hp.ov.activator.vpn.inventory.IPAddrPool beanIPAddrPool = (com.hp.ov.activator.vpn.inventory.IPAddrPool) request.getAttribute(IPAddrPoolConstants.IPADDRPOOL_BEAN);
if(beanIPAddrPool==null)
   beanIPAddrPool = (com.hp.ov.activator.vpn.inventory.IPAddrPool) request.getSession().getAttribute(IPAddrPoolConstants.IPADDRPOOL_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
IPAddrPoolForm form = (IPAddrPoolForm) request.getAttribute("IPAddrPoolForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String Name = beanIPAddrPool.getName();
        
            
                            
            
                
                String IPNet = beanIPAddrPool.getIpnet();
        
            
                            
            
                
                String Mask = beanIPAddrPool.getMask();
        
            
                            
            
                
                String IPNetAddress = beanIPAddrPool.getIpnetaddress();
        
            
                            
            
                
                String Type = beanIPAddrPool.getType();
        
            
                            
            
                
                String AddressFamily = beanIPAddrPool.getAddressfamily();
        
            
                            
            
                
              boolean isDynamic = new Boolean(beanIPAddrPool.getIsdynamic()).booleanValue();
    
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="IPAddrPoolApplicationResources" property="Name"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="IPNet"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="Mask"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="IPNetAddress"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="Type"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="AddressFamily"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="isDynamic"/>
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
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="name" value="<%= Name %>"/>
                                                        <html:text disabled="true" property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="ipnet" value="<%= IPNet %>"/>            
				                                            
                                                    <html:hidden property="mask" value="<%= Mask %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnetaddress.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnetaddress" size="24" value="<%= IPNetAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnetaddress.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.type.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="type" value="<%= Type %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(Type==null||Type.trim().equals(""))
                           selValue="LSP";
                        else
                        selValue=Type.toString();    
                          %>

                    <html:select disabled="true" property="type" value="<%= selValue %>" >
                                            <html:option value="LSP" >LSP</html:option>
                                            <html:option value="IPNet" >IPNet</html:option>
                                            <html:option value="IPHost" >IPHost</html:option>
                                            <html:option value="MDT Default" >MDT Default</html:option>
                                            <html:option value="MDT Data" >MDT Data</html:option>
                                            <html:option value="Multicast loopback" >Multicast loopback</html:option>
											<html:option value="Multicast Source" >Multicast Source</html:option>
											<html:option value="Multicast Group" >Multicast Group</html:option>
											<html:option value="Multicast RP" >Multicast RP</html:option>
											<html:option value="Multicast MSDP" >Multicast MSDP</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.addressfamily.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(AddressFamily==null||AddressFamily.trim().equals(""))
                           selValue="IPv4";
                        else
                        selValue=AddressFamily.toString();    
                          %>

                    <html:select  property="addressfamily" value="<%= selValue %>" >
                                            <html:option value="IPv4" >IPv4</html:option>
                                            <html:option value="IPv6" >IPv6</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.addressfamily.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <input type="hidden" name="isdynamic" value="<%= isDynamic %>"/>  
                                            
                    
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
