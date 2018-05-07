<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
		java.sql.*,
		java.sql.Connection,
		javax.sql.DataSource,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
		com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
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
String datasource = (String) request.getParameter(MulticastProfileConstants.DATASOURCE);
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitMulticastProfileAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("vpnid") + "||" + request.getParameter("multicastsource") + "||" + request.getParameter("multicastgroup") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                      _location_ = "bandwidth";
                  }

%>

<html>
  <head>
    <title><bean:message bundle="MulticastProfileApplicationResources" key="<%= MulticastProfileConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.MulticastProfileForm.action = '/activator<%=moduleConfig%>/UpdateFormMulticastProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.MulticastProfileForm.submit();
    }
    function performCommit()
    {
      window.document.MulticastProfileForm.action = '/activator<%=moduleConfig%>/UpdateCommitMulticastProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.MulticastProfileForm.submit();
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
com.hp.ov.activator.vpn.inventory.MulticastProfile beanMulticastProfile = (com.hp.ov.activator.vpn.inventory.MulticastProfile) request.getAttribute(MulticastProfileConstants.MULTICASTPROFILE_BEAN);
if(beanMulticastProfile==null)
   beanMulticastProfile = (com.hp.ov.activator.vpn.inventory.MulticastProfile) request.getSession().getAttribute(MulticastProfileConstants.MULTICASTPROFILE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
MulticastProfileForm form = (MulticastProfileForm) request.getAttribute("MulticastProfileForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String MCastProfileId = beanMulticastProfile.getMcastprofileid();
        
            
                            
            
                
                String VPNId = beanMulticastProfile.getVpnid();
        
            
                            
            
                
                String MulticastSource = beanMulticastProfile.getMulticastsource();
        
            
                            
            
                
                String MulticastGroup = beanMulticastProfile.getMulticastgroup();
        
            
                            
            
                
                String Bandwidth = beanMulticastProfile.getBandwidth();
        
          String BandwidthLabel = (String) request.getAttribute(MulticastProfileConstants.BANDWIDTH_LABEL);
      ArrayList BandwidthListOfValues = (ArrayList) request.getAttribute(MulticastProfileConstants.BANDWIDTH_LIST_OF_VALUES);
            
                            
            
                
                String CoS = beanMulticastProfile.getCos();
        
            
EXPMapping[] expMappings = null;
RateLimit[] rlList = null;
                            
Connection con = null;                            
                            
try
{
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
            
	if (ds != null)
	{
		con = ds.getConnection();
		
		expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
		rlList = com.hp.ov.activator.vpn.inventory.RateLimit.findAll(con);
	}             
}
catch(Exception e)
{
	System.out.println("Exception getting Multicast Pools info from database: "+e);
}
finally
{
	if (con != null)
	{
		try 
		{
			con.close();
		}
		catch (Exception rollbackex)
		{
			// Ignore
		}
	}
}
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="MulticastProfileApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="MulticastProfileApplicationResources" property="MCastProfileId"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="VPNId"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="MulticastSource"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="MulticastGroup"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="Bandwidth"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="CoS"/>
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
                <bean:message bundle="MulticastProfileApplicationResources" key="field.mcastprofileid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="mcastprofileid" value="<%= MCastProfileId %>"/>
                                                        <html:text disabled="true" property="mcastprofileid" size="24" value="<%= MCastProfileId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.mcastprofileid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="vpnid" value="<%= VPNId %>"/>
                                                        <html:text disabled="true" property="vpnid" size="24" value="<%= VPNId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="multicastsource" value="<%= MulticastSource %>"/>
                                                        <html:text disabled="true" property="multicastsource" size="24" value="<%= MulticastSource %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgroup.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="multicastgroup" value="<%= MulticastGroup %>"/>
                                                        <html:text disabled="true" property="multicastgroup" size="24" value="<%= MulticastGroup %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgroup.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.bandwidth.alias"/>
                                  *
                              </table:cell>
              <table:cell>
						<select name="cmbSelectRateLimit" style="width:130px">
							<% rlList = rlList != null ? rlList : new RateLimit[0];

							for (int i = 0; i < rlList.length; i++) 
							{
								RateLimit rateLimit = rlList[i];
								
								if ("Unknown".equals(rateLimit.getRatelimitname())) continue;
								
								if ((rateLimit.getRatelimitname()).equals(Bandwidth)) { %>
									<option value="<%=rateLimit.getRatelimitname()%>" selected><%=rateLimit.getRatelimitname()%></option> 
								<% } else { %>
									<option value="<%=rateLimit.getRatelimitname()%>"><%=rateLimit.getRatelimitname()%></option> 
								<% } %>
							<% } %>
						</select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.bandwidth.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.cos.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                       <select name="cmbSelectQoSClass" style="width:130px">
							<% expMappings = expMappings != null ? expMappings : new EXPMapping[0];

							for (int i = 0; i < expMappings.length; i++) 
							{
								EXPMapping expMapping = expMappings[i];
								
								if ((expMapping.getExpvalue()).equals(CoS)) { %>
									<option value="<%=expMapping.getExpvalue()%>" selected><%=expMapping.getClassname()%>
								<%} else { %>
									<option value="<%=expMapping.getExpvalue()%>"><%=expMapping.getClassname()%></option> 
								<% } %>
							<% } %>
						</select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.cos.description"/>
                                                                        </table:cell>
            </table:row>
                                
                    
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
      <html:hidden property="bandwidth" value="1" />
	  <html:hidden property="cos" value="1"/>
      
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
