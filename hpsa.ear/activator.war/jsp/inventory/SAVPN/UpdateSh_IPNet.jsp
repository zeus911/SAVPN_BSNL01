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
String datasource = (String) request.getParameter(Sh_IPNetConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSh_IPNetAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
                          _location_ = "ce1_ipaddr";
                                                                        }

%>

<html>
  <head>
    <title><bean:message bundle="Sh_IPNetApplicationResources" key="<%= Sh_IPNetConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_IPNetForm.action = '/activator<%=moduleConfig%>/UpdateFormSh_IPNetAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.Sh_IPNetForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_IPNetForm.action = '/activator<%=moduleConfig%>/UpdateCommitSh_IPNetAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.Sh_IPNetForm.submit();
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
com.hp.ov.activator.vpn.inventory.Sh_IPNet beanSh_IPNet = (com.hp.ov.activator.vpn.inventory.Sh_IPNet) request.getAttribute(Sh_IPNetConstants.SH_IPNET_BEAN);
if(beanSh_IPNet==null)
   beanSh_IPNet = (com.hp.ov.activator.vpn.inventory.Sh_IPNet) request.getSession().getAttribute(Sh_IPNetConstants.SH_IPNET_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
Sh_IPNetForm form = (Sh_IPNetForm) request.getAttribute("Sh_IPNetForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String IPNetAddr = beanSh_IPNet.getIpnetaddr();
        
            
                            
            
                
                String PE1_IPAddr = beanSh_IPNet.getPe1_ipaddr();
        
            
                            
            
                
                String CE1_IPAddr = beanSh_IPNet.getCe1_ipaddr();
        
            
                            
            
                
                String PE2_IPAddr = beanSh_IPNet.getPe2_ipaddr();
        
            
                            
            
                
                String CE2_IPAddr = beanSh_IPNet.getCe2_ipaddr();
        
            
                            
            
                
                String Netmask = beanSh_IPNet.getNetmask();
        
            
                            
            
                
                String Hostmask = beanSh_IPNet.getHostmask();
        
            
                            
            
                
                String PoolName = beanSh_IPNet.getPoolname();
        
            
                            
            
                
                String IPNetAddrStr = beanSh_IPNet.getIpnetaddrstr();
        
            
                            
            
                
                String Marker = beanSh_IPNet.getMarker();
        
            
                            
            
                
                String UploadStatus = beanSh_IPNet.getUploadstatus();
        
            
                            
            
                
                String DBPrimaryKey = beanSh_IPNet.getDbprimarykey();
        
            
                            
            
                
              String __count = "" + beanSh_IPNet.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_IPNet.get__count()) : "";
          
            
            if( beanSh_IPNet.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_IPNetApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_IPNetApplicationResources" property="IPNetAddr"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="PE1_IPAddr"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="CE1_IPAddr"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="PE2_IPAddr"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="CE2_IPAddr"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="Netmask"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="Hostmask"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="PoolName"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="IPNetAddrStr"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_IPNetApplicationResources" property="DBPrimaryKey"/>
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
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.ipnetaddr.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ipnetaddr" value="<%= IPNetAddr %>"/>
                                                        <html:text disabled="true" property="ipnetaddr" size="24" value="<%= IPNetAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.ipnetaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe1_ipaddr.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="pe1_ipaddr" value="<%= PE1_IPAddr %>"/>
                                                        <html:text disabled="true" property="pe1_ipaddr" size="24" value="<%= PE1_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe1_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce1_ipaddr.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce1_ipaddr" size="24" value="<%= CE1_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce1_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe2_ipaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="pe2_ipaddr" value="<%= PE2_IPAddr %>"/>
                                                        <html:text disabled="true" property="pe2_ipaddr" size="24" value="<%= PE2_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe2_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce2_ipaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce2_ipaddr" size="24" value="<%= CE2_IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce2_ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.netmask.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="netmask" value="<%= Netmask %>"/>
                                                        <html:text disabled="true" property="netmask" size="24" value="<%= Netmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.netmask.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.hostmask.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="hostmask" value="<%= Hostmask %>"/>
                                                        <html:text disabled="true" property="hostmask" size="24" value="<%= Hostmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.hostmask.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.poolname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="poolname" value="<%= PoolName %>"/>
                                                        <html:text disabled="true" property="poolname" size="24" value="<%= PoolName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.poolname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="ipnetaddrstr" value="<%= IPNetAddrStr %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="marker" value="<%= Marker %>"/>
                                                        <html:text disabled="true" property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.marker.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="uploadstatus" value="<%= UploadStatus %>"/>
                                                        <html:text disabled="true" property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.uploadstatus.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="dbprimarykey" value="<%= DBPrimaryKey %>"/>
                                                        <html:text disabled="true" property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.dbprimarykey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_IPNetApplicationResources" key="field.__count.description"/>
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
