<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
java.sql.Connection,
java.text.NumberFormat,javax.sql.DataSource,com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
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
String datasource = (String) request.getParameter(LSPParametersConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitLSPParametersAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("idname") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                        }

%>

<html>
  <head>
    <title><bean:message bundle="LSPParametersApplicationResources" key="<%= LSPParametersConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
  function sendthis(focusthis) {
      window.document.LSPParametersForm.action = '/activator<%=moduleConfig%>/UpdateFormLSPParametersAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.LSPParametersForm.submit();
    }
  function performCommit() {
      window.document.LSPParametersForm.action = '/activator<%=moduleConfig%>/UpdateCommitLSPParametersAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.LSPParametersForm.submit();
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
com.hp.ov.activator.vpn.inventory.LSPParameters beanLSPParameters = (com.hp.ov.activator.vpn.inventory.LSPParameters) request.getAttribute(LSPParametersConstants.LSPPARAMETERS_BEAN);
if(beanLSPParameters==null)
   beanLSPParameters = (com.hp.ov.activator.vpn.inventory.LSPParameters) request.getSession().getAttribute(LSPParametersConstants.LSPPARAMETERS_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
LSPParametersForm form = (LSPParametersForm) request.getAttribute("LSPParametersForm");


Connection con = null;
com.hp.ov.activator.vpn.inventory.LSP[] findLSPs = null;
com.hp.ov.activator.vpn.inventory.LSP[] findAggLSPs = null;

try
{
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
	
	if (ds != null)
	{
		con = ds.getConnection();
		findLSPs = (com.hp.ov.activator.vpn.inventory.LSP[]) com.hp.ov.activator.vpn.inventory.LSP.findAll(con);
		findAggLSPs = (com.hp.ov.activator.vpn.inventory.LSP[]) com.hp.ov.activator.vpn.inventory.LSP.findByUsagemode(con,"Aggregated");
	}	
}
catch(Exception e)
{
	System.out.println("Exception finding LSPs in the system"+e);
}
finally
{
	if (con != null)
	{
		try 
		{
			con.close();
		} catch (Exception rollbackex)
		{
			// we don't handle this exception because we think this should be 
			// corrected manually. System cann't handle this problem by itself.
		}
	}
}


String lspResult="";
if (findLSPs!=null) 
	lspResult="WARNING: There are LSPs in this system. Disabling LSP Feature without deleting those LSPs first may lead to inconsistencies.";
	
String aggLspResult="";
if (findAggLSPs!=null) 
	aggLspResult="NOTICE: There are Aggregated LSPs in this system. User won't be able to create/modify/delete Aggregated LSPs if this option is disabled.";


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String IDName = beanLSPParameters.getIdname();
        
            
                            
            
                
              boolean LSPEnabled = new Boolean(beanLSPParameters.getLspenabled()).booleanValue();
    
            
                            
            
                
              boolean LSPTierEnabled = new Boolean(beanLSPParameters.getLsptierenabled()).booleanValue();
    
//Added for PR17889
              boolean MulticastLSPEnabled = new Boolean(beanLSPParameters.getMulticastlspenabled()).booleanValue();
    
            
                            
            
                
              boolean AggregateLSPEnabled = new Boolean(beanLSPParameters.getAggregatelspenabled()).booleanValue();
    
            
                            
            
                
              boolean AggregateLSPTierEnabled = new Boolean(beanLSPParameters.getAggregatelsptierenabled()).booleanValue();
    
            
                            
            
                
  %>

<center> 
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPParametersApplicationResources" key="jsp.update.title"/>
</h2> 
</center>

<H1>
      <html:errors bundle="LSPParametersApplicationResources" property="IDName"/>
        <html:errors bundle="LSPParametersApplicationResources" property="LSPEnabled"/>
        <html:errors bundle="LSPParametersApplicationResources" property="LSPTierEnabled"/>
        <html:errors bundle="LSPParametersApplicationResources" property="MulticastLSPEnabled"/>
        <html:errors bundle="LSPParametersApplicationResources" property="AggregateLSPEnabled"/>
        <html:errors bundle="LSPParametersApplicationResources" property="AggregateLSPTierEnabled"/>
  </H1>
<script type="text/javascript">
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
      
                                                  <html:hidden property="idname" value="<%= IDName %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPParametersApplicationResources" key="field.lspenabled.alias"/>
                                  *
                              </table:cell>
              <table:cell>
<html:checkbox  property="lspenabled" value="true" onclick="sendthis('lspenabled');"/>
                  <html:hidden  property="lspenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="LSPParametersApplicationResources" key="field.lspenabled.description"/>
				
				<% if((LSPEnabled)&&(lspResult!="")) { %> 
					<br><p style="color:red"><img src="/activator/images/warning.gif"><%=lspResult%></p>
				<% } %> 
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPParametersApplicationResources" key="field.lsptierenabled.alias"/>
                                  *
                              </table:cell>
              <table:cell>
<% if (LSPEnabled){%>
                                  <html:checkbox  property="lsptierenabled" value="true" onclick="sendthis('lsptierenabled');"/>
<%}else{%>
<html:checkbox disabled="true" property="lsptierenabled" value="true"/>
<%}%>
                  <html:hidden  property="lsptierenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="LSPParametersApplicationResources" key="field.lsptierenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPParametersApplicationResources" key="field.multicastlspenabled.alias"/>
                                  *
                              </table:cell>
              <table:cell>
<% if (LSPEnabled){%>
                                  <html:checkbox  property="multicastlspenabled" value="true"/>
<%}else{%>
<html:checkbox disabled="true" property="multicastlspenabled" value="true"/>
<%}%>
                  <html:hidden  property="multicastlspenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="LSPParametersApplicationResources" key="field.multicastlspenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPParametersApplicationResources" key="field.aggregatelspenabled.alias"/>
                                  *
                              </table:cell>
              <table:cell>
			  <% if (LSPEnabled){%>
                                  <html:checkbox  property="aggregatelspenabled" value="true" onclick="sendthis('aggregatelspenabled');"/>
				<%}else{%>
					 <html:checkbox  disabled="true" property="aggregatelspenabled" value="true"/>
				<%}%>				
                  <html:hidden  property="aggregatelspenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="LSPParametersApplicationResources" key="field.aggregatelspenabled.description"/>
				
				<% if((AggregateLSPEnabled)&&(aggLspResult!="")) { %> 
					<br><p style="color:blue"><img src="/activator/images/info.gif"><%=aggLspResult%></p>
				<% } %> 
				
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="LSPParametersApplicationResources" key="field.aggregatelsptierenabled.alias"/>
                                  *
                              </table:cell>
              <table:cell>
			  <% if ((LSPEnabled)&&(AggregateLSPEnabled)){%>
                                  <html:checkbox  property="aggregatelsptierenabled" value="true"/>
				<%}else{%>
					 <html:checkbox  disabled="true"  property="aggregatelsptierenabled" value="true"/>
				<%}%>	
                                  
                  <html:hidden  property="aggregatelsptierenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="LSPParametersApplicationResources" key="field.aggregatelsptierenabled.description"/>
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
