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
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(NetworkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitNetworkAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("networkid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "name";
                                    }

%>

<html>
  <head>
    <title><bean:message bundle="NetworkApplicationResources" key="<%= NetworkConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.NetworkForm.action = '/activator<%=moduleConfig%>/UpdateFormNetworkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.NetworkForm.submit();
    }
    function performCommit()
    {
      window.document.NetworkForm.action = '/activator<%=moduleConfig%>/UpdateCommitNetworkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.NetworkForm.submit();
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
com.hp.ov.activator.cr.inventory.Network beanNetwork = (com.hp.ov.activator.cr.inventory.Network) request.getAttribute(NetworkConstants.NETWORK_BEAN);
if(beanNetwork==null)
   beanNetwork = (com.hp.ov.activator.cr.inventory.Network) request.getSession().getAttribute(NetworkConstants.NETWORK_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
NetworkForm form = (NetworkForm) request.getAttribute("NetworkForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String NetworkId = beanNetwork.getNetworkid();
        
            
                            
            
                
                String Name = beanNetwork.getName();
        
            
                            
            
                
                String Type = beanNetwork.getType();
        
            
                            
            
                
                String ASN = beanNetwork.getAsn();
        
            
                            
            
                
                String Region = beanNetwork.getRegion();
        
          String RegionLabel = (String) request.getAttribute(NetworkConstants.REGION_LABEL);
      ArrayList RegionListOfValues = (ArrayList) request.getAttribute(NetworkConstants.REGION_LIST_OF_VALUES);
            
                            
            
                
                String ParentNetworkId = beanNetwork.getParentnetworkid();
        
          String ParentNetworkIdLabel = (String) request.getAttribute(NetworkConstants.PARENTNETWORKID_LABEL);
      ArrayList ParentNetworkIdListOfValues = (ArrayList) request.getAttribute(NetworkConstants.PARENTNETWORKID_LIST_OF_VALUES);
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="NetworkApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="NetworkApplicationResources" property="NetworkId"/>
        <html:errors bundle="NetworkApplicationResources" property="Name"/>
        <html:errors bundle="NetworkApplicationResources" property="Type"/>
        <html:errors bundle="NetworkApplicationResources" property="ASN"/>
        <html:errors bundle="NetworkApplicationResources" property="Region"/>
        <html:errors bundle="NetworkApplicationResources" property="ParentNetworkId"/>
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
                <bean:message bundle="NetworkApplicationResources" key="field.networkid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="networkid" value="<%= NetworkId %>"/>
                                                        <html:text disabled="true" property="networkid" size="24" value="<%= NetworkId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkApplicationResources" key="field.networkid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(Type==null||Type.trim().equals(""))
                           selValue="Network";
                        else
                        selValue=Type.toString();    
                          %>

                    <html:select  property="type" value="<%= selValue %>" >
                                            <html:option value="Network" >Network</html:option>
                                            <html:option value="AccessNetwork" >AccessNetwork</html:option>
                                            <html:option value="Topology" >Topology</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkApplicationResources" key="field.asn.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="asn" size="24" value="<%= ASN %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkApplicationResources" key="field.asn.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkApplicationResources" key="field.region.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="region" value="<%= Region %>" >
                      <html:options collection="RegionListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkApplicationResources" key="field.region.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkApplicationResources" key="field.parentnetworkid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="parentnetworkid" value="<%= ParentNetworkId %>"/>
                                                        <html:select disabled="true" property="parentnetworkid" value="<%= ParentNetworkId %>" >
                      <html:options collection="ParentNetworkIdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkApplicationResources" key="field.parentnetworkid.description"/>
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
