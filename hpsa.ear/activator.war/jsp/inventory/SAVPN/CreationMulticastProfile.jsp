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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

            
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(MulticastProfileConstants.DATASOURCE);
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitMulticastProfileAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "vpnid";
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
      window.document.MulticastProfileForm.action = '/activator<%=moduleConfig%>/CreationFormMulticastProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.MulticastProfileForm.submit();
    }
    function performCommit()
    {
      window.document.MulticastProfileForm.action = '/activator<%=moduleConfig%>/CreationCommitMulticastProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.MulticastProfileForm.submit();
    }
	function reload()
	{
	  window.document.MulticastProfileForm.action = '/activator<%=moduleConfig%>/CreationFormMulticastProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>'; 
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
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }
    </script>
  </head>
  <body style="overflow:auto;" onload="init();">
<%

com.hp.ov.activator.vpn.inventory.MulticastProfile beanMulticastProfile = (com.hp.ov.activator.vpn.inventory.MulticastProfile) request.getAttribute(MulticastProfileConstants.MULTICASTPROFILE_BEAN);

      String MCastProfileId = beanMulticastProfile.getMcastprofileid();
                String VPNId = beanMulticastProfile.getVpnid();
                String MulticastSource = beanMulticastProfile.getMulticastsource();
                String MulticastGroup = beanMulticastProfile.getMulticastgroup();
                String Bandwidth = beanMulticastProfile.getBandwidth();
        String BandwidthLabel = (String) request.getAttribute(MulticastProfileConstants.BANDWIDTH_LABEL);
ArrayList BandwidthListOfValues = (ArrayList) request.getAttribute(MulticastProfileConstants.BANDWIDTH_LIST_OF_VALUES);
            String CoS = beanMulticastProfile.getCos();
          

if ( request.getParameter("vpnid") != null ) {
	VPNId = request.getParameter("vpnid");
} 	
			
String selected_source_ip_pool = "";
if (request.getParameter("cmbSelectSourceIPPool") != null) {
	selected_source_ip_pool = request.getParameter("cmbSelectSourceIPPool");
}

String selected_source_ip = null;
if ((request.getParameter("cmbSelectSourceIP") != null) && !("nosource".equals(request.getParameter("cmbSelectSourceIP")))) {
	selected_source_ip = request.getParameter("cmbSelectSourceIP");
}

String selected_group_ip_pool = "";
if (request.getParameter("cmbSelectGroupIPPool") != null) {
	selected_group_ip_pool = request.getParameter("cmbSelectGroupIPPool");
}

String selected_group_ip = null;
if (request.getParameter("cmbSelectGroupIP") != null) {
	selected_group_ip = request.getParameter("cmbSelectGroupIP");
}		

String multicast_qos_class = null;
if ( request.getParameter("cmbSelectQoSClass") != null ) {
	multicast_qos_class = request.getParameter("cmbSelectQoSClass");
} 	 

String multicast_rate_limit = null;
if ( request.getParameter("cmbSelectRateLimit") != null ) {
	multicast_rate_limit = request.getParameter("cmbSelectRateLimit");
} 	 
				
EXPMapping[] expMappings = null;
RateLimit[] rlList = null;

IPAddrPool[] multicastSourcesPools = null;
IPHost[] multicastSources = null;

IPAddrPool[] multicastGroupsPools = null;
IPHost[] multicastGroups = null;

boolean ipUnavailable = false;
boolean sourcePoolUnavailable = false;
boolean groupPoolUnavailable = false;

int minimum_length = 0;

Connection con = null;
               
try
{
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
	
	if (ds != null)
	{
		con = ds.getConnection();
		
		expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
		rlList = com.hp.ov.activator.vpn.inventory.RateLimit.findAll(con);
		 
		multicastSourcesPools 	= IPAddrPool.findAll(con, "type='Multicast Source' and addressfamily='IPv4'");
		multicastGroupsPools 	= IPAddrPool.findAll(con, "type='Multicast Group' and addressfamily='IPv4'");
		
		if (!("".equals(selected_source_ip_pool)))
		{
			multicastSources = IPHost.findByPoolname(con, selected_source_ip_pool, "v_iphost.count__<>'0'");
		}
		else if (multicastSourcesPools != null) 
		{
			selected_source_ip_pool = multicastSourcesPools[0].getName();
			multicastSources = IPHost.findByPoolname(con, selected_source_ip_pool, "v_iphost.count__<>'0'");
		}
		else 
		{
			sourcePoolUnavailable = true;
		}
		
		if (!("".equals(selected_group_ip_pool)))
		{
			multicastGroups = IPHost.findByPoolname(con, selected_group_ip_pool, "v_iphost.count__<>'0'");
		}
		else if (multicastGroupsPools != null) 
		{
			selected_group_ip_pool = multicastGroupsPools[0].getName();
			multicastGroups = IPHost.findByPoolname(con, selected_group_ip_pool, "v_iphost.count__<>'0'");
		}
		else 
		{
			groupPoolUnavailable = true;
		}
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
  <bean:message bundle="MulticastProfileApplicationResources" key="jsp.creation.title"/>
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
    <table:table>
	  <% if (!sourcePoolUnavailable && !groupPoolUnavailable) { %>
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
      
                                                  <html:hidden property="mcastprofileid" value="<%= MCastProfileId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text disabled="true" property="vpnid" size="24" value="<%= VPNId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsourcepool.alias"/>
                                  *
                              </table:cell>
              <table:cell>
					<select name="cmbSelectSourceIPPool" style="width:130px" onchange="reload();">
						<% String sourceIPPoolStr = null;
								
						for (int i=0; i < multicastSourcesPools.length; i++) 
						{
							sourceIPPoolStr = multicastSourcesPools[i].getName();

							if (sourceIPPoolStr.equals(selected_source_ip_pool))
							{%>
								<option value="<%=sourceIPPoolStr%>" selected><%=sourceIPPoolStr%></option> 
							<% } else { %>
								<option value="<%=sourceIPPoolStr%>" ><%=sourceIPPoolStr%></option> 
							<% }
					   }%>
					</select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsourcepool.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.alias"/>
                                  *
                              </table:cell>
              <table:cell>
				<% if (multicastSources != null) {
					 if (multicastSources.length > minimum_length) { %>
						<select name="cmbSelectSourceIP" style="width:130px">
							
							<% if ("auto".equals(selected_source_ip)) { %>
								<option value="auto" selected>Auto</option> 
							<% } else { %>
								<option value="auto">Auto</option> 
							<% } %>
							
								
								<% String iphostStr = null;
								
								for (int i=0; i < multicastSources.length; i++) 
								{
									iphostStr = multicastSources[i].getIp();

									if (iphostStr.equals(selected_source_ip))
									{%>
										<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
									<% } else { %>
										<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
									<% }
							   }%>
						</select>
					<% } else { 
						ipUnavailable = true;%>
						<img src="/activator/images/warning.gif"><bean:message bundle="MulticastProfileApplicationResources" key="multicastsourcepool.error.nofreeips"/>
						<html:hidden property="cmbSelectSourceIP" value="nosource"/>
					<% }
					} else { 
					  ipUnavailable = true; %>
					  <img src="/activator/images/warning.gif"><bean:message bundle="MulticastProfileApplicationResources" key="multicastsourcepool.error.nopool1"/>
					  <html:hidden property="cmbSelectSourceIP" value="nosource"/>
					<% } %>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgrouppoool.alias"/>
                                  *
                              </table:cell>
              <table:cell>
					<select name="cmbSelectGroupIPPool" style="width:130px" onchange="reload();">
						<% String groupIPPoolStr = null;
								
						for (int i=0; i < multicastGroupsPools.length; i++) 
						{
							groupIPPoolStr = multicastGroupsPools[i].getName();

							if (groupIPPoolStr.equals(selected_group_ip_pool))
							{%>
								<option value="<%=groupIPPoolStr%>" selected><%=groupIPPoolStr%></option> 
							<% } else { %>
								<option value="<%=groupIPPoolStr%>" ><%=groupIPPoolStr%></option> 
							<% }
					   }%>
					</select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgrouppoool.description"/>
                              </table:cell>
            </table:row>
													  <table:row>
              <table:cell>  
                <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgroup.alias"/>
                                  *
                              </table:cell>
              <table:cell>
				<% if (multicastGroups != null) {
						if (multicastGroups.length > minimum_length) { %>
						<select name="cmbSelectGroupIP" style="width:130px" >
								
							<% if ("auto".equals(selected_group_ip)) { %>
							<option value="auto" selected>Auto</option> 
							<% } else { %>
								<option value="auto">Auto</option> 
							<% } %>
								
								<% String iphostStr = null;
								
								for (int i=0; i < multicastGroups.length; i++) 
								{
									iphostStr = multicastGroups[i].getIp();
									
									if (iphostStr.equals(selected_group_ip))
									{%>
										<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
									<% } else { %>
										<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
									<% }
								}%>
						</select>
					<% } else {
						ipUnavailable = true; %>
						<bean:message bundle="MulticastProfileApplicationResources" key="multicastgrouppoool.error.nofreeips"/>
						<img src="/activator/images/warning.gif"><html:hidden property="cmbSelectGroupIP" value="nogroup"/>
					<% }
					} else { 
					  ipUnavailable = true; %>
					  <bean:message bundle="MulticastProfileApplicationResources" key="multicastgrouppoool.error.nopool1"/>
					  <img src="/activator/images/warning.gif"><html:hidden property="cmbSelectGroupIP" value="nogroup"/>
					<% } %>
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
								
								if ((rateLimit.getRatelimitname()).equals(multicast_rate_limit)) { %>
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
								
								if ((expMapping.getExpvalue()).equals(multicast_qos_class)) { %>
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
                              
		<html:hidden property="vpnid" value="<%= VPNId %>"/>
		<html:hidden property="multicastsource" value="1"/>
		<html:hidden property="multicastgroup" value="1"/>
		<html:hidden property="bandwidth" value="1" />
		<html:hidden property="cos" value="1"/>
      
      <table:row>
        <table:cell colspan="3" align="center">
        <br>
        </table:cell>
      </table:row>
      <table:row>
        <table:cell colspan="3" align="center">
			<% if (ipUnavailable) { %>
			<input type="button" disabled="true" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
		   <% } else { %>
          <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
		   <% } %>
          <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
	  
	  <% } else { %>
			<p style="color:red"><b><bean:message bundle="MulticastProfileApplicationResources" key="multicastprofile.error.cannot.create"/></b></p>
		<% if (sourcePoolUnavailable) { %>
			<p><b><img src="/activator/images/warning.gif"><bean:message bundle="MulticastProfileApplicationResources" key="multicastsourcepool.error.nopool2"/></b></p>
		<% } %>
		<% if (groupPoolUnavailable) { %>
			<p><b><img src="/activator/images/warning.gif"><bean:message bundle="MulticastProfileApplicationResources" key="multicastgrouppoool.error.nopool2"/></b></p>
		<% } %>
	<% } %>
		
    </table:table>
  </html:form>

  </body>

</html>
