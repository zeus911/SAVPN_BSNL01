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
String datasource = (String) request.getParameter(IPNetConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitIPNetAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("ipnetaddr") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "pe1_ipaddr";
                                                                                    }

%>

<html>
  <head>
    <title><bean:message bundle="IPNetApplicationResources" key="<%= IPNetConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.IPNetForm.action = '/activator<%=moduleConfig%>/UpdateFormIPNetAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.IPNetForm.submit();
    }
    function performCommit()
    {
      window.document.IPNetForm.action = '/activator<%=moduleConfig%>/UpdateCommitIPNetAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.IPNetForm.submit();
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
com.hp.ov.activator.vpn.inventory.IPNet beanIPNet = (com.hp.ov.activator.vpn.inventory.IPNet) request.getAttribute(IPNetConstants.IPNET_BEAN);
if(beanIPNet==null)
   beanIPNet = (com.hp.ov.activator.vpn.inventory.IPNet) request.getSession().getAttribute(IPNetConstants.IPNET_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
IPNetForm form = (IPNetForm) request.getAttribute("IPNetForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String IPNetAddr = beanIPNet.getIpnetaddr();
        
            
                            
            
                
                String PE1_IPAddr = beanIPNet.getPe1_ipaddr();
        
            
                            
            
                
                String CE1_IPAddr = beanIPNet.getCe1_ipaddr();
        
            
                            
            
                
                String PE2_IPAddr = beanIPNet.getPe2_ipaddr();
        
            
                            
            
                
                String CE2_IPAddr = beanIPNet.getCe2_ipaddr();
        
            
                            
            
                
                String Netmask = beanIPNet.getNetmask();
        
            
                            
            
                
                String Hostmask = beanIPNet.getHostmask();
        
            
                            
            
                
                String PoolName = beanIPNet.getPoolname();
        
            
                            
            
                
                String IPNetAddrStr = beanIPNet.getIpnetaddrstr();
        
            
                            
            
                
                String ParentIPNetAddr = beanIPNet.getParentipnetaddr();
        
            
                            
            
                
                String StartAddress = beanIPNet.getStartaddress();
        
            
                            
            
                
                String NumberOfEntries = beanIPNet.getNumberofentries();
        
            
                            
            
                
                String AddressFamily = beanIPNet.getAddressfamily();
        
            
                            
            
                
              String __count = "" + beanIPNet.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanIPNet.get__count()) : "";
          
            
            if( beanIPNet.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPNetApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="IPNetApplicationResources" property="IPNetAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="PE1_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="CE1_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="PE2_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="CE2_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="Netmask"/>
        <html:errors bundle="IPNetApplicationResources" property="Hostmask"/>
        <html:errors bundle="IPNetApplicationResources" property="PoolName"/>
        <html:errors bundle="IPNetApplicationResources" property="IPNetAddrStr"/>
        <html:errors bundle="IPNetApplicationResources" property="ParentIPNetAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="StartAddress"/>
        <html:errors bundle="IPNetApplicationResources" property="NumberOfEntries"/>
        <html:errors bundle="IPNetApplicationResources" property="AddressFamily"/>
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
                <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddr.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ipnetaddr" value="<%= IPNetAddr %>"/>
                                                        <html:text disabled="true" property="ipnetaddr" size="24" value="<%= IPNetAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.pe1_ipaddr.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="pe1_ipaddr" size="24" value="<%= PE1_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.pe1_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.ce1_ipaddr.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce1_ipaddr" size="24" value="<%= CE1_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.ce1_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.pe2_ipaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="pe2_ipaddr" size="24" value="<%= PE2_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.pe2_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.ce2_ipaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce2_ipaddr" size="24" value="<%= CE2_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.ce2_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.netmask.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="netmask" size="24" value="<%= Netmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.netmask.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.hostmask.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="hostmask" size="24" value="<%= Hostmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.hostmask.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.poolname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="poolname" size="24" value="<%= PoolName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.poolname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="ipnetaddrstr" value="<%= IPNetAddrStr %>"/>            
				                                            
                                                    <html:hidden property="parentipnetaddr" value="<%= ParentIPNetAddr %>"/>            
				                                            
                                                    <html:hidden property="startaddress" value="<%= StartAddress %>"/> 
													<html:hidden property="EditValue" value="1"/> 													
				                                            
                                                    <html:hidden property="numberofentries" value="<%= NumberOfEntries %>"/>            
				                                            
                                                    <html:hidden property="addressfamily" value="<%= AddressFamily %>"/>            
				                                            
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.__count.description"/>
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
