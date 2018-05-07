<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
		java.util.HashMap,
        org.apache.struts.action.ActionErrors,
		java.sql.Connection,
		java.text.NumberFormat,
		java.sql.PreparedStatement, 
		java.sql.ResultSet,
		javax.sql.DataSource,
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
String datasource = (String) request.getParameter(MulticastSiteConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitMulticastSiteAction.do?datasource=" + datasource + "&rimid=" + rimid;
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("attachmentid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                _location_ = "rpmode";
                              }

String selected_multiple_check = "No";
String selected_multiple_number = "2";
int multipleNumber = 2;
  
HashMap<Integer, String> multipleRPs = new HashMap<Integer,String>();
HashMap<Integer, String> multipleGRs = new HashMap<Integer,String>();

com.hp.ov.activator.vpn.inventory.MulticastSite beanMulticastSite = (com.hp.ov.activator.vpn.inventory.MulticastSite) request.getAttribute(MulticastSiteConstants.MULTICASTSITE_BEAN);
if(beanMulticastSite==null)
   beanMulticastSite = (com.hp.ov.activator.vpn.inventory.MulticastSite) request.getSession().getAttribute(MulticastSiteConstants.MULTICASTSITE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
MulticastSiteForm form = (MulticastSiteForm) request.getAttribute("MulticastSiteForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String AttachmentId = beanMulticastSite.getAttachmentid();
        
            
                            
            
                
                String MulticastLoopbackAddress = beanMulticastSite.getMulticastloopbackaddress();
        
            
                            
            
                
                String VirtualTunnelId = beanMulticastSite.getVirtualtunnelid();
        
            
                            
            
                
                String RPMode = beanMulticastSite.getRpmode();
        
            
                            
            
                
                String RPAddress = beanMulticastSite.getRpaddress();
        
            
                            
            
                
                String MSDPLocalAddress = beanMulticastSite.getMsdplocaladdress();
        
            
                            
            
                
                String MSDPPeerAddress = beanMulticastSite.getMsdppeeraddress();
        
            
String assign_mode = "false";
if ( request.getParameter("isassign") != null ) {
	assign_mode = request.getParameter("isassign");
}

if ("true".equals(assign_mode))
{
	Connection con = null;
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
	
	MulticastProfile[] multicastProfiles = null;
	Vector mcast_profile_list = new Vector<String>();
	
	String vpn_id = "";
	if ( request.getParameter("vpn_id") != null ) {
		vpn_id = request.getParameter("vpn_id");
	}
	
	EXPMapping[] expMappings = null;
	HashMap<String, String> cosNames = new HashMap<String, String>();	
	
	try
	{	 	
		if (ds != null)
		{
			con = ds.getConnection();
	
			multicastProfiles = MulticastProfile.findByVpnid(con, vpn_id);
			
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			try 
			{
				String query = "select MCastProfileId from V_MCASTProfileMembership where AttachmentId = ?";
								
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, AttachmentId);
				
				rset = pstmt.executeQuery();

				while(rset.next())
				{
					mcast_profile_list.addElement(rset.getString(1));
				}
			}
			catch (Exception e)
			{
				System.out.println("Exception getting Multicast Profiles for attachment: " + e.getMessage());
			}
			finally
			{
				try{ rset.close(); }catch(Exception ignoreme){}
				try{ pstmt.close();}catch(Exception ignoreme){}
			}
                            
			try
			{
				expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
				expMappings = expMappings != null ? expMappings : new EXPMapping[0];
				
				for (int i = 0; i < expMappings.length; i++) 
				{
					EXPMapping expMapping = expMappings[i];
            
					cosNames.put(expMapping.getExpvalue(), expMapping.getClassname());
				}
			}
			catch (Exception e)
			{
				System.out.println("Exception getting COS Profile Names: " + e.getMessage());
			}
		}
	}
	catch (Exception e) 
	{
		System.out.println("Exception trying to get Multicast Profiles: " + e.getMessage());
		e.printStackTrace();
	}
	finally
	{
		if (con != null) 
		{
			con.close();
		}
	}
	%>
                
	<html>
	  <head>
		<title><bean:message bundle="MulticastSiteApplicationResources" key="jsp.assign.title"/></title>
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
		  window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/UpdateFormMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
		  window.document.MulticastSiteForm.submit();
		}
		function performCommit()
		{
		  window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/UpdateCommitMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
		  window.document.MulticastSiteForm.submit();
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
		function toggle(source) 
		{
		  var checkboxes = document.getElementsByName('mcastprofileid');
		  
		  for(var i=0,l=checkboxes.length;i<l;i++)
		  {
			checkboxes[i].checked = source.checked;
		  }
		}
		</script>
	  </head>

	  <body style="overflow:auto;" onload="init();">
<h2 style="width:100%; text-align:center;">
		  <bean:message bundle="MulticastSiteApplicationResources" key="jsp.assign.title"/>
</h2> 

<h1>
      <html:errors bundle="MulticastSiteApplicationResources" property="AttachmentId"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MulticastLoopbackAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="VirtualTunnelId"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="RPMode"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="RPAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MSDPLocalAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MSDPPeerAddress"/>
  </h1>
<script>
var allEvents = "";
			function addListener(element,eventName,functionName)
			{
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
            
		<html:form action="<%= formAction %>" style="text-align:center;">
		<input type="hidden" name="_update_commit_" value="true"/> 
              
			<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                
			<table:table>
				<b><bean:message bundle="MulticastSiteApplicationResources" key="field.selectprofiles.description"/></b>
			</table:table>
        
			<br>

    <table:table>
      <table:header>
					<table:cell width="15%"><input type="checkbox" name="togglebox" onClick="toggle(this);"/> <bean:message bundle="MulticastSiteApplicationResources" key="field.selectall.alias"/></table:cell>
					<table:cell width="15%"><bean:message bundle="MulticastSiteApplicationResources" key="field.mcastprofileid.alias"/></table:cell>
					<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.mcastsource.alias"/></table:cell>
					<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.mcastgroup.alias"/></table:cell>
					<table:cell width="15%"><bean:message bundle="MulticastSiteApplicationResources" key="field.mcastcos.alias"/></table:cell>
					<table:cell width="15%"><bean:message bundle="MulticastSiteApplicationResources" key="field.mcastrl.alias"/></table:cell>
      </table:header>
			</table:table>
      
			<div style="height: <bean:message bundle="InventoryResources" key="size.assign_mcast_profiles.scroll"/>; overflow-y: scroll;">
			<table:table>
				<% if (multicastProfiles != null) {%>
					<% for (int i=0; i < multicastProfiles.length; i++) {
						MulticastProfile mcastProfile = multicastProfiles[i]; %>
      
                                    <table:row>
						   <% if((mcast_profile_list != null) && (mcast_profile_list.contains(mcastProfile.getMcastprofileid()))) { %>
							<table:cell width="15%"> <input type="checkbox" name="mcastprofileid" value="<%=mcastProfile.getMcastprofileid()%>" checked /> </table:cell>
						   <% } else { %>	
							<table:cell width="15%"> <input type="checkbox" name="mcastprofileid" value="<%=mcastProfile.getMcastprofileid()%>"/> </table:cell>
						   <% } %>
						   <table:cell width="15%"> <%= mcastProfile.getMcastprofileid() %> </table:cell>
						   <table:cell width="20%"> <%= mcastProfile.getMulticastsource() %> </table:cell>
						   <table:cell width="20%"> <%= mcastProfile.getMulticastgroup() %> </table:cell>
						   <table:cell width="15%"> <%= cosNames.get(mcastProfile.getCos()) %> </table:cell>
						   <table:cell width="15%"> <%= mcastProfile.getBandwidth() %> </table:cell>
            </table:row>
					<% } %>
				<% } else { %>
                                      <table:row>
						<table:cell colspan="4" align="center"><bean:message bundle="MulticastSiteApplicationResources" key="message.nomcastprofiles.description"/></table:cell>
            </table:row>
				<% } %>
			</table:table>
			</div>
                                
			<table:table>
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
                                
			<html:hidden property="isAssign" value="<%=assign_mode%>"/>
			<html:hidden property="isassign" value="<%=assign_mode%>"/>
			<html:hidden property="AttachmentId" value="<%= AttachmentId %>"/>     
			<html:hidden property="MulticastLoopbackAddress" value="<%= MulticastLoopbackAddress %>"/>     
			<html:hidden property="VirtualTunnelId" value="<%= VirtualTunnelId %>"/>     
			<html:hidden property="attachmentid" value="<%= AttachmentId %>"/>
			<html:hidden property="multicastloopbackaddress" value="<%= MulticastLoopbackAddress %>"/>
			<html:hidden property="virtualtunnelid" value="<%= VirtualTunnelId %>"/>
			<html:hidden property="rpmode" value="<%= RPMode %>"/>     
			<html:hidden property="vpn_id" value="<%= vpn_id %>"/>     	
                                
	  </html:form>
	 </body>
	</html>	
<%}
else
{	
	Connection con = null;
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);

	IPAddrPool[] multicastLocalRPPools = null;
	IPHost[] multicastLocalRPs = null;
	IPHost currentRPIP = null;
		 
	IPAddrPool[] multicastLocalMSDPPools = null;
	IPHost[] multicastLocalMSDPs = null;
	IPHost currentMSDPLocalIP = null;

	String current_rp_pool_name = "";
	String current_msdp_pool_name = "";

	String selected_local_rp_pool = "";
	String selected_rp_msdp_local_pool = "";

	String selected_rp_ip_local_pool = "";
	String selected_rp_ip_local_manual = "";
	String selected_rp_ip_remote = "";

	String selected_rp_mode = RPMode;
	if (request.getParameter("cmbRPMode") != null) {
		selected_rp_mode = request.getParameter("cmbRPMode");
	}

	String selected_anycast_rp_mode = "Anycast-non-RP";
	if (request.getParameter("cmbAnycastRPMode") != null) {
		selected_anycast_rp_mode = request.getParameter("cmbAnycastRPMode");
	}	 
	else
	{
		if ("Anycast-RP".equals(selected_rp_mode) || "Anycast-non-RP".equals(selected_rp_mode))
		{
			selected_anycast_rp_mode = selected_rp_mode;
			selected_rp_mode = "Anycast";
		}
	}

	String selected_auto_rp_mode = "Auto-RP-Discovery";
	if (request.getParameter("cmbAutoRPMode") != null) {
		selected_auto_rp_mode = request.getParameter("cmbAutoRPMode");
	}
	else
	{
		if ("Auto-RP-Discovery".equals(selected_rp_mode) || "Auto-RP-Announce".equals(selected_rp_mode) || "Auto-RP-Mapping".equals(selected_rp_mode))
		{
			selected_auto_rp_mode = selected_rp_mode;
			selected_rp_mode = "Auto";
		}
	}

	String selected_rp_msdp_check = "";
	String selected_rp_msdp_local = "";
	String selected_rp_msdp_local_manual = "";
	String selected_rp_msdp_peer = MSDPPeerAddress;

	// Default value
	if (("".equals(selected_rp_msdp_peer)) || (selected_rp_msdp_peer == null))
	{
		selected_rp_msdp_peer = "";
	}

	if (request.getParameter("radiorpmsdp") != null) {
		selected_rp_msdp_check = request.getParameter("radiorpmsdp");
		
		if ("Disabled".equals(selected_rp_msdp_check))
		{
			MSDPLocalAddress = "";
			MSDPPeerAddress = "";
		}
	}

	if (request.getParameter("cmbMultipleMode") != null) {
		selected_multiple_check = request.getParameter("cmbMultipleMode");
	}

	// Default value
	if (("".equals(selected_rp_msdp_check)) || (selected_rp_msdp_check == null))
	{
		selected_rp_msdp_check = "Disabled";
	}

	int minimum_length = 0;

	try
	{	 	
		if (ds != null)
		{
			con = ds.getConnection();
			
			if ((RPAddress != null) && !("".equals(RPAddress)) && (RPAddress.contains("#") || RPAddress.contains("|")))
			{
				String[] tokens = RPAddress.split("#");
				int count = 0;
				
				for (String t : tokens)
				{
					count++;
					
					String rpAddr = t.substring(0, t.indexOf("|"));
					String grAddr = t.substring(t.indexOf("|")+1, t.length());
					
					multipleRPs.put(count, rpAddr);
					multipleGRs.put(count, grAddr);
				}
				
				multipleNumber = count; 
				selected_multiple_number = String.valueOf(multipleNumber);
				
				if (request.getParameter("cmbMultipleMode") == null)
				{
					selected_multiple_check = "Yes";
				}
				
				// Default remaining empty HashMap entries
				for (int i=count+1; i<=5; i++)
				{
					multipleRPs.put(i, "");
					multipleGRs.put(i, "");
				}
			}
			else
			{
				// Default empty HashMap entries
				for (int i=1; i<=5; i++)
				{
					multipleRPs.put(i, "");
					multipleGRs.put(i, "");
				}
			}
		
			if (!("".equals(RPAddress)) && RPAddress != null && !(RPAddress.contains("|")))
			{
				currentRPIP = IPHost.findByIp(con, RPAddress);
				if (currentRPIP != null)
				{
					if ("Local".equals(selected_rp_mode) || "Auto".equals(selected_rp_mode))
					{
						current_rp_pool_name = currentRPIP.getPoolname();
						selected_local_rp_pool = currentRPIP.getPoolname();
						selected_rp_ip_local_pool = RPAddress;
					}
					
					if ("Remote".equals(selected_rp_mode))
					{
						selected_rp_ip_remote = RPAddress;
					}
					
					if ("Anycast-RP".equals(selected_anycast_rp_mode))
					{
						selected_rp_ip_local_manual = RPAddress; 
					}

					if ("Anycast-non-RP".equals(selected_anycast_rp_mode))
					{
						selected_rp_ip_remote = RPAddress;
					}
				}
				else
				{
					if ("Local".equals(selected_rp_mode) || "Auto".equals(selected_rp_mode))
					{
						selected_rp_ip_local_manual = RPAddress; 
					}
					
					if ("Remote".equals(selected_rp_mode))
					{
						selected_rp_ip_remote = RPAddress;
					}
					
					if ("Anycast-RP".equals(selected_anycast_rp_mode))
					{
						selected_rp_ip_local_manual = RPAddress; 
					}

					if ("Anycast-non-RP".equals(selected_anycast_rp_mode))
					{
						selected_rp_ip_remote = RPAddress;
					}
				}
			}
			
			if (!("".equals(MSDPLocalAddress)) && MSDPLocalAddress != null)
			{	
				currentMSDPLocalIP = IPHost.findByIp(con, MSDPLocalAddress);	
				selected_rp_msdp_check = "Enabled";
				
				if (currentMSDPLocalIP != null)
				{
					current_msdp_pool_name = currentMSDPLocalIP.getPoolname();
					selected_rp_msdp_local_pool = currentMSDPLocalIP.getPoolname();
					selected_rp_msdp_local = MSDPLocalAddress;
				}
				else
				{
					selected_rp_msdp_local_manual = MSDPLocalAddress; 
				}
			}
			
			if ("Auto-RP-Mapping".equals(selected_auto_rp_mode))
			{
				selected_local_rp_pool = "norp";
			}

			if (request.getParameter("cmbLocalRPPool") != null) {
				selected_local_rp_pool = request.getParameter("cmbLocalRPPool");
			}
			
			if (request.getParameter("cmbLocalRPPool") != null) {
				selected_local_rp_pool = request.getParameter("cmbLocalRPPool");
			}
			
			if ("Auto-RP-Announce".equals(selected_auto_rp_mode) && "norp".equals(selected_local_rp_pool))
			{
				selected_local_rp_pool = "manual";
			}
			
			if ("Local".equals(selected_rp_mode) && "norp".equals(selected_local_rp_pool))
			{
				selected_local_rp_pool = "manual";
			}
			
			// Default value
			if (("".equals(selected_local_rp_pool)) || (selected_local_rp_pool == null))
			{
				selected_local_rp_pool = "manual";
			}
			
			if (request.getParameter("cmbRPMSDPLocalPool") != null) {
				selected_rp_msdp_local_pool = request.getParameter("cmbRPMSDPLocalPool");
			}
			
			// Default value
			if (("".equals(selected_rp_msdp_local_pool)) || (selected_rp_msdp_local_pool == null))
			{
				selected_rp_msdp_local_pool = "manual";
			}
			
			multicastLocalRPPools	= IPAddrPool.findAll(con, "type='Multicast RP' and addressfamily='IPv4'");
			multicastLocalMSDPPools = IPAddrPool.findAll(con, "type='Multicast MSDP' and addressfamily='IPv4'");

			if (!("".equals(selected_local_rp_pool)) && !("manual".equals(selected_local_rp_pool)))
			{
				multicastLocalRPs = IPHost.findByPoolname(con, selected_local_rp_pool, "v_iphost.count__<>'0'");
			}

			if (!("".equals(selected_rp_msdp_local_pool)) && !("manual".equals(selected_rp_msdp_local_pool)))
			{
				multicastLocalMSDPs = IPHost.findByPoolname(con, selected_rp_msdp_local_pool, "v_iphost.count__<>'0'");
			}
		}
	}
	catch (Exception e) 
	{
		System.out.println("Exception trying to get Multicast RP & MSDP Address Pools data: " + e.getMessage());
		e.printStackTrace();
	}
	finally
	{
		if (con != null) 
		{
			con.close();
		}
	}          

	if (request.getParameter("selectRPIPLocalManual") != null) {
		selected_rp_ip_local_manual = request.getParameter("selectRPIPLocalManual");
	}

	if (request.getParameter("selectRPIPLocalPool") != null) {
		selected_rp_ip_local_pool = request.getParameter("selectRPIPLocalPool");
	}

	if (request.getParameter("selectRPIPRemote") != null) {
		selected_rp_ip_remote = request.getParameter("selectRPIPRemote");
	} 

	if (request.getParameter("selectRPMSDPLocal") != null) {
		selected_rp_msdp_local = request.getParameter("selectRPMSDPLocal");
	}

	if (request.getParameter("selectRPMSDPLocalManual") != null) {
		selected_rp_msdp_local_manual = request.getParameter("selectRPMSDPLocalManual");
	}

	if (request.getParameter("selectRPMSDPPeer") != null) {
		selected_rp_msdp_peer = request.getParameter("selectRPMSDPPeer");
	}

	if (request.getParameter("cmbMultipleNum") != null) 
	{
		selected_multiple_number = request.getParameter("cmbMultipleNum");

		try 
		{
			multipleNumber = Integer.parseInt(selected_multiple_number); 
		}
		catch (Exception e)
		{
			selected_multiple_number = "2"; 
			multipleNumber = 2; 
		}
	}

	if (request.getParameter("selectRPMultiple1") != null) {
		multipleRPs.put(1, request.getParameter("selectRPMultiple1"));
	}

	if (request.getParameter("selectRPMultiple2") != null) {
		multipleRPs.put(2, request.getParameter("selectRPMultiple2"));
	}

	if (request.getParameter("selectRPMultiple3") != null) {
		multipleRPs.put(3, request.getParameter("selectRPMultiple3"));
	}

	if (request.getParameter("selectRPMultiple4") != null) {
		multipleRPs.put(4, request.getParameter("selectRPMultiple4"));
	}

	if (request.getParameter("selectRPMultiple5") != null) {
		multipleRPs.put(5, request.getParameter("selectRPMultiple5"));
	}

	if (request.getParameter("selectGRMultiple1") != null) {
		multipleGRs.put(1, request.getParameter("selectGRMultiple1"));
	}

	if (request.getParameter("selectGRMultiple2") != null) {
		multipleGRs.put(2, request.getParameter("selectGRMultiple2"));
	}

	if (request.getParameter("selectGRMultiple3") != null) {
		multipleGRs.put(3, request.getParameter("selectGRMultiple3"));
	}

	if (request.getParameter("selectGRMultiple4") != null) {
		multipleGRs.put(4, request.getParameter("selectGRMultiple4"));
	}

	if (request.getParameter("selectGRMultiple5") != null) {
		multipleGRs.put(5, request.getParameter("selectGRMultiple5"));
	}
					
	%>


	<html>
	  <head>
		<title><bean:message bundle="MulticastSiteApplicationResources" key="<%= MulticastSiteConstants.JSP_CREATION_TITLE %>"/></title>
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
		  window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/UpdateFormMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
		  window.document.MulticastSiteForm.submit();
		}
		function performCommit()
		{
			var doSubmit = true;
			var isValid = true;
			var isMultiple = false;

			var form = window.document.MulticastSiteForm;
			window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/UpdateCommitMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
		  
			if (form.cmbRPMode.value == "Remote")
			{
				if (form.cmbMultipleMode.value == "Yes")
				{
					isMultiple = true;
				}
			}
			
			if (form.cmbRPMode.value == "Anycast")
			{
				if (form.cmbAnycastRPMode.value == "Anycast-non-RP")
				{
					if (form.cmbMultipleMode.value == "Yes")
					{
						isMultiple = true;
					}
				}
			}
		  
			if (form.cmbRPMode.value == "Local")
			{
				if (form.cmbLocalRPPool.value == "manual")
				{
					isValid = ValidateIPaddress(form.selectRPIPLocalManual, "Local RP");
					if (isValid == false) doSubmit = false;
				}
				else
				{
					isValid = ValidateIPaddress(form.selectRPIPLocalPool, "Local RP");
					if (isValid == false) doSubmit = false;
				}
			}
			
			if (form.cmbRPMode.value == "Remote")
			{
				if (isMultiple == true)
				{
					var multipleRPString = "";
					
					<% for (int i=1; i <= multipleNumber; i++) 
					{ 
						String RPfieldName = "selectRPMultiple"+String.valueOf(i);%>
						
						isValid = ValidateIPaddress(form.<%=RPfieldName%>, "Remote RP");
						if (isValid == false) doSubmit = false;
						
						<% String GRfieldName = "selectGRMultiple"+String.valueOf(i);%>
						
						isValid = ValidateIPaddressGR(form.<%=GRfieldName%>, "Group Ranges IP");
						if (isValid == false) doSubmit = false;
						
						if (doSubmit == true) 
						{
							multipleRPString = multipleRPString + "#" + form.<%=RPfieldName%>.value + "|" + form.<%=GRfieldName%>.value;
						}
					<%}%>
					
					isValid = checkDuplicateEntries();
					if (isValid == false) doSubmit = false;
					
					form.multipleRPString.value = multipleRPString.substring(1);
				}
				else
				{
					isValid = ValidateIPaddress(form.selectRPIPRemote, "Remote RP");
					if (isValid == false) doSubmit = false;
				}
			}
			
			if (form.cmbRPMode.value == "Anycast")
			{
				if (form.cmbAnycastRPMode.value == "Anycast-RP")
				{
					isValid = ValidateIPaddress(form.selectRPIPLocalManual, "Local RP");
					if (isValid == false) doSubmit = false;
				}
				else
				{
					if (isMultiple == true)
					{
						var multipleRPString = "";
						
						<% for (int i=1; i <= multipleNumber; i++) 
						{ 
							String RPfieldName = "selectRPMultiple"+String.valueOf(i);%>
							
							isValid = ValidateIPaddress(form.<%=RPfieldName%>, "Remote RP");
							if (isValid == false) doSubmit = false;
							
							<% String GRfieldName = "selectGRMultiple"+String.valueOf(i);%>
							
							isValid = ValidateIPaddressGR(form.<%=GRfieldName%>, "Group Ranges IP");
							if (isValid == false) doSubmit = false;
							
							if (doSubmit == true) 
							{
								multipleRPString = multipleRPString + "#" + form.<%=RPfieldName%>.value + "|" + form.<%=GRfieldName%>.value;
							}
						<%}%>
						
						isValid = checkDuplicateEntries();
						if (isValid == false) doSubmit = false;
						
						form.multipleRPString.value = multipleRPString.substring(1);
					}
					else
					{
						isValid = ValidateIPaddress(form.selectRPIPRemote, "Remote RP");
						if (isValid == false) doSubmit = false;
					}
				}
			}
					
			if (form.cmbRPMode.value == "Auto")
			{
				if (form.cmbAutoRPMode.value != "Auto-RP-Discovery")
				{
					if (form.cmbLocalRPPool.value != "norp")
					{
						if (form.cmbLocalRPPool.value == "manual")
						{
							isValid = ValidateIPaddress(form.selectRPIPLocalManual, "Local RP");
							if (isValid == false) doSubmit = false;
						}
						else
						{
							isValid = ValidateIPaddress(form.selectRPIPLocalPool, "Local RP");
							if (isValid == false) doSubmit = false;
						}
					}
				}
			}
			
			if (document.getElementsByName('radiorpmsdp')[0].checked)
			{
				if (form.cmbRPMSDPLocalPool.value == "manual")
				{
					isValid = ValidateIPaddress(form.selectRPMSDPLocalManual, "Local MSDP");
					if (isValid == false) doSubmit = false;
		}
				else
		{
					isValid = ValidateIPaddress(form.selectRPMSDPLocal, "Local MSDP");
					if (isValid == false) doSubmit = false;
				}
			
				isValid = ValidateIPaddress(form.selectRPMSDPPeer, "Remote MSDP");
				if (isValid == false) doSubmit = false;
			}
		  
			if (doSubmit == true)
			{
				form.submitButton.disabled='true';
				window.document.MulticastSiteForm.submit();
			}
		}
		function reload(){
			window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/UpdateFormMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>'; 
		  window.document.MulticastSiteForm.submit();
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
		function ValidateIPaddress(inputText, addressType)  
		{  
			var ipformat = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;  
				
			if(inputText.value.match(ipformat))  
			{  
				return true;  
			}  
			else  
			{  
				var alert = new HPSAAlert("You have entered an invalid "+addressType+" IP address: "+inputText.value); 
				alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
				alert.setBounds(500, 120);
				alert.show();
								
				return false;  
			}  
		}
				
		function ValidateIPaddressGR(inputText, addressType)  
		{  
			var ipformat = /^(22[4-9]|23[0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\/(3[0-2]|[0-2][0-9]|[1-9]?)$/;  
					
			if(inputText.value.match(ipformat))  
			{  
				return true;  
			}  
			else  
			{  
				var alert = new HPSAAlert("You have entered an invalid Multicast Address for group ranges: "+inputText.value); 
				alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
				alert.setBounds(500, 120);
				alert.show();
			
				return false;  
			}  
		}
				
		function checkDuplicateEntries()
		{
			var form = window.document.MulticastSiteForm;
								
			<% 
				for (int a=1; a <= multipleNumber; a++) 
				{
					String RPA = "selectRPMultiple"+String.valueOf(a);
					String GRA = "selectGRMultiple"+String.valueOf(a);
				
					for (int b=1; b <= multipleNumber; b++) 
					{
						if (a==b) continue;
					
						String RPB = "selectRPMultiple"+String.valueOf(b);
						String GRB = "selectGRMultiple"+String.valueOf(b);
						%>
							var rp_a = form.<%=RPA%>.value;
							var rp_b = form.<%=RPB%>.value;
			
							if (rp_a == rp_b)
							{
								var alert = new HPSAAlert("There are duplicate entries among the multiple RP list");
								alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
								alert.setBounds(500, 120);
								alert.show();
				
								return false;
							}
								
							var gr_a = form.<%=GRA%>.value;
							var gr_b = form.<%=GRB%>.value;
				
							if (gr_a == gr_b) 
							{
								var alert = new HPSAAlert("There are duplicate entries among the multiple group ranges list");
								alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
								alert.setBounds(500, 120);
								alert.show();
					
								return false;
							}
						<%
					}
				}
	  %>

			return true;
		}
		</script>
	  </head>
	  
	<body style="overflow:auto;" onload="init();">
	<h2 style="width:100%; text-align:center;">
	  <bean:message bundle="MulticastSiteApplicationResources" key="jsp.update.title"/>
	</h2> 

	<h1>
		  <html:errors bundle="MulticastSiteApplicationResources" property="AttachmentId"/>
			<html:errors bundle="MulticastSiteApplicationResources" property="MulticastLoopbackAddress"/>
			<html:errors bundle="MulticastSiteApplicationResources" property="VirtualTunnelId"/>
			<html:errors bundle="MulticastSiteApplicationResources" property="RPMode"/>
			<html:errors bundle="MulticastSiteApplicationResources" property="RPAddress"/>
			<html:errors bundle="MulticastSiteApplicationResources" property="MSDPLocalAddress"/>
			<html:errors bundle="MulticastSiteApplicationResources" property="MSDPPeerAddress"/>
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
				  <table:cell width="20%">  
					<bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.alias"/>
								  </table:cell>
				  <table:cell width="30%">
														  <html:hidden property="attachmentid" value="<%= AttachmentId %>"/>
															<html:text disabled="true" property="attachmentid" value="<%= AttachmentId %>"/>
													</table:cell>
				  <table:cell width="50%">
					<bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
				  <table:cell width="20%">  
					<bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.alias"/>
									  *
                              </table:cell>
				  <table:cell width="30%">
														  <html:hidden property="multicastloopbackaddress" value="<%= MulticastLoopbackAddress %>"/>
															<html:text disabled="true" property="multicastloopbackaddress" value="<%= MulticastLoopbackAddress %>"/>
                                                </table:cell>
				  <table:cell width="50%">
					<bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.description"/>
																			</table:cell>
				</table:row>
									
										  <table:row>
				  <table:cell width="20%">  
					<bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.alias"/>
									  *
								  </table:cell>
				  <table:cell width="30%">
														  <html:hidden property="virtualtunnelid" value="<%= VirtualTunnelId %>"/>
															<html:text disabled="true" property="virtualtunnelid" value="<%= VirtualTunnelId %>"/>
													</table:cell>
				  <table:cell width="50%">
					<bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.description"/>
                                                                        </table:cell>
            </table:row>
                                
			</table:table>
			
		<br>
		<table:table>
		<table:header>
			<table:cell></table:cell>
			<table:cell></table:cell>
			<table:cell></table:cell>
		</table:header>
		<table:row>
		   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.alias"/></table:cell>
		   <table:cell width="30%">
				<select name="cmbRPMode" style="width:130px" onchange="reload();">
					<% if ("Disabled".equals(selected_rp_mode)) { %>
						<option value="Disabled" selected>Disabled</option> 
					<% } else { %>
						<option value="Disabled">Disabled</option> 
					<% } %>
					<% if ("Remote".equals(selected_rp_mode)) { %>
						<option value="Remote" selected>Remote</option> 
					<% } else { %>
						<option value="Remote">Remote</option> 
					<% } %>
					<% if ("Local".equals(selected_rp_mode)) { %>
						<option value="Local" selected>Local</option> 
					<% } else { %>
						<option value="Local">Local</option> 
					<% } %>
					<% if ("Anycast".equals(selected_rp_mode)) { %>
						<option value="Anycast" selected>Anycast</option> 
					<% } else { %>
						<option value="Anycast">Anycast</option> 
					<% } %>
					<% if ("Auto".equals(selected_rp_mode)) { %>
						<option value="Auto" selected>Auto RP</option> 
					<% } else { %>
						<option value="Auto">Auto RP</option> 
					<% } %>
				</select>
		   </table:cell>
		   <table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.description"/></table:cell>
		</table:row>
		
		<% if ("Local".equals(selected_rp_mode)) { %>
										  <table:row>
			   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/></table:cell>
				<% if (multicastLocalRPPools != null) { %>
					<% if (multicastLocalRPPools.length > minimum_length) { %>
						<table:cell width="30%">
							<select name="cmbLocalRPPool" style="width:130px" onchange="reload();">
									
								<% if ("manual".equals(selected_local_rp_pool)) { %>
									<option value="manual" selected>Manual</option> 
								<% } else { %>
									<option value="manual">Manual</option> 
								<% } %>
									
									<% String ipPoolStr = null;
									
									for (int i=0; i < multicastLocalRPPools.length; i++) 
									{
										ipPoolStr = multicastLocalRPPools[i].getName();
										
										if (ipPoolStr.equals(selected_local_rp_pool))
										{%>
											<option value="<%=ipPoolStr%>" selected><%=ipPoolStr%></option> 
										<% } else { %>
											<option value="<%=ipPoolStr%>" ><%=ipPoolStr%></option> 
										<% }
									}%>
							</select>
						</table:cell>
					<% } else { %>
						<table:cell width="30%">
							<select name="cmbLocalRPPool" style="width:130px"><option value="manual" selected>Manual</option>
						</table:cell>
					<% }
				} else { %>
					<table:cell width="30%">
						<select name="cmbLocalRPPool" style="width:130px"><option value="manual" selected>Manual</option>
								  </table:cell>
				<% } %>
				<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddresspool.description"/></table:cell>
			</table:row>
			<table:row>	
				<table:cell width="20%"></table:cell>
				<% if ("manual".equals(selected_local_rp_pool)) { %>
					<% if (!("".equals(selected_rp_ip_local_manual))) { %>
						<table:cell width="30%">
							<input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="<%=selected_rp_ip_local_manual%>">
						</table:cell>
					<% } else { %>
						<table:cell width="30%">
							<input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()">
						</table:cell>
					<% } %>
				<% } else { %>
					<% if (multicastLocalRPs != null) { %>
						<% if (multicastLocalRPs.length > minimum_length) { %>
							<table:cell width="30%">
								<select name="selectRPIPLocalPool" style="width:130px" >
									
																			  <%
									if (selected_local_rp_pool.equals(current_rp_pool_name))
									{
										if (selected_rp_ip_local_pool.equals(RPAddress))
										{%>
											<option value="<%=RPAddress%>" selected><%=RPAddress%></option> 
										<%}
							else
										{%>
											<option value="<%=RPAddress%>"><%=RPAddress%></option> 
										<%}
									}
									
									String iphostStr = null;
									
									for (int i=0; i < multicastLocalRPs.length; i++) 
									{
										iphostStr = multicastLocalRPs[i].getIp();
										
										if (iphostStr.equals(selected_rp_ip_local_pool))
										{%>
											<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
										<% } else { %>
											<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
										<% }
									}%>
								</select>
							</table:cell>
						<% } else { %>
							<table:cell width="30%">No free IP Addresses available in current Multicast RP Pool</table:cell>
						<% }
					} else { %>
						<table:cell width="30%">Current IP Address Pool could not be found</table:cell>
					<% } %>
				<% } %>
				<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/></table:cell>
			</table:row>
		<% } %>

		<% if ("Anycast".equals(selected_rp_mode)) { %>
			<table:row>
				<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.anycastmode.alias"/></table:cell> 
				<table:cell width="30%">
					<select name="cmbAnycastRPMode" style="width:130px" onchange="reload();">
						<% if ("Anycast-non-RP".equals(selected_anycast_rp_mode)) { %>
							<option value="Anycast-non-RP" selected>Non-RP</option> 
						<% } else { %>
							<option value="Anycast-non-RP">Non-RP</option> 
						<% } %>
						<% if ("Anycast-RP".equals(selected_anycast_rp_mode)) { %>
							<option value="Anycast-RP" selected>RP</option> 
						<% } else { %>
							<option value="Anycast-RP">RP</option> 
						<% } %>
					</select>
													</table:cell>
				<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.anycastmode.description"/></table:cell> 
			</table:row>
			<% if ("Anycast-RP".equals(selected_anycast_rp_mode)) { %>
				<table:row>
				   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/></table:cell>
					<% if (!("".equals(selected_rp_ip_local_manual))) { %>
						<table:cell width="30%">
							<input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="<%=selected_rp_ip_local_manual%>">
						</table:cell>
					<% } else { %>
						<table:cell width="30%">
							<input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()">
																			</table:cell>
					<% } %>
					<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/></table:cell>
				</table:row>
			<% } else { %>
										  <table:row>
					<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpmode.alias"/></table:cell>
					<table:cell width="30%">
						<select name="cmbMultipleMode" style="width:55px" onchange="reload();">
							<% if ("Yes".equals(selected_multiple_check)) { %>
								<option value="Yes" selected>Yes</option> 
							<% } else { %>
								<option value="Yes">Yes</option> 
							<% } %>
							<% if ("No".equals(selected_multiple_check)) { %>
								<option value="No" selected>No</option> 
							<% } else { %>
								<option value="No">No</option> 
							<% } %>
						</select>
								  </table:cell>
					<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpmode.description"/></table:cell>
				</table:row>
				<% if ("No".equals(selected_multiple_check)) { %>
					<table:row>
					   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/></table:cell>
							<% if (!("".equals(selected_rp_ip_remote))) { %>
								<table:cell width="30%">
									<input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="<%=selected_rp_ip_remote%>" onFocus="this.select()">
								</table:cell>
							<% } else { %>
								<table:cell width="30%">
									<input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="Enter Address" onFocus="this.select()">
													</table:cell>
							<% } %>
						<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/></table:cell>
					</table:row>
				<% } else { %>
					<table:row>
					   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpnumber.alias"/></table:cell>
					   <table:cell width="30%">
							<select name="cmbMultipleNum" style="width:55px" onchange="reload();">
								<% if ("2".equals(selected_multiple_number)) { %>
									<option value="2" selected>2</option> 
								<% } else { %>
									<option value="2">2</option> 
								<% } %>
								<% if ("3".equals(selected_multiple_number)) { %>
									<option value="3" selected>3</option> 
								<% } else { %>
									<option value="3">3</option> 
								<% } %>
								<% if ("4".equals(selected_multiple_number)) { %>
									<option value="4" selected>4</option> 
								<% } else { %>
									<option value="4">4</option> 
								<% } %>
								<% if ("5".equals(selected_multiple_number)) { %>
									<option value="5" selected>5</option> 
								<% } else { %>
									<option value="5">5</option> 
								<% } %>
							</select>
																			</table:cell>
					   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpnumber.description"/></table:cell>
					</table:row>
					<% for (int i=1; i <= multipleNumber; i++) { %>
						<table:row>
							<% if (i == 1) { %>
								<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerp.alias"/></table:cell>
							<% } else { %>
								<table:cell width="20%"></table:cell>
							<% } 
							String rpAddrEntryName = "selectRPMultiple"+String.valueOf(i);
							String grpRangesAddrEntryName = "selectGRMultiple"+String.valueOf(i);%>
							<table:cell width="30%">
								<%if (!("".equals(multipleRPs.get(i)))) { %>
									<input type="text" name="<%=rpAddrEntryName%>" maxlength="15" value="<%=multipleRPs.get(i)%>" onFocus="this.select()">
								<% } else { %>
									<input type="text" name="<%=rpAddrEntryName%>" maxlength="15" value="Enter Address" onFocus="this.select()">
								<% } %>							
								<% if (!("".equals(multipleGRs.get(i)))) { %>
									<input type="text" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="<%=multipleGRs.get(i)%>" onFocus="this.select()">
								<% } else { %>
									<input type="text" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="Enter Address/mask" onFocus="this.select()">
								<% } %>
							</table:cell>
							<% if (i == 1) { %>
								<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerp.description"/></table:cell>
							<% } else { %>
								<table:cell width="50%"></table:cell>
							<% } %>
				</table:row>
					<% } %>
				<% } %>
			<% } %>
		<% } %>
									
		<% if ("Auto".equals(selected_rp_mode)) { %>
										  <table:row>
				<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.autorpmode.alias"/></table:cell> 
				<table:cell width="30%">
					<select name="cmbAutoRPMode" style="width:130px" onchange="reload();">
						<% if ("Auto-RP-Discovery".equals(selected_auto_rp_mode)) { %>
							<option value="Auto-RP-Discovery" selected>Discovery</option> 
						<% } else { %>
							<option value="Auto-RP-Discovery">Discovery</option> 
						<% } %>
						<% if ("Auto-RP-Announce".equals(selected_auto_rp_mode)) { %>
							<option value="Auto-RP-Announce" selected>Announce</option> 
						<% } else { %>
							<option value="Auto-RP-Announce">Announce</option> 
						<% } %>
						<% if ("Auto-RP-Mapping".equals(selected_auto_rp_mode)) { %>
							<option value="Auto-RP-Mapping" selected>Mapping</option> 
						<% } else { %>
							<option value="Auto-RP-Mapping">Mapping</option> 
						<% } %>
					</select>
								  </table:cell>
				<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.autorpmode.description"/></table:cell>
			</table:row>
			<% if (!("Auto-RP-Discovery".equals(selected_auto_rp_mode))) { %>
				<table:row>
				   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/></table:cell>
					<% if (multicastLocalRPPools != null) { %>
						<% if (multicastLocalRPPools.length > minimum_length) { %>
							<table:cell width="30%">
								<select name="cmbLocalRPPool" style="width:130px" onchange="reload();">
								
									<% if ("Auto-RP-Mapping".equals(selected_auto_rp_mode)) { %>
										<% if ("norp".equals(selected_local_rp_pool)) { %>
											<option value="norp" selected>No RP</option> 
										<% } else { %>
											<option value="norp">No RP</option> 
										<% } %>
									<% } %>
										
									<% if ("manual".equals(selected_local_rp_pool)) { %>
										<option value="manual" selected>Manual</option> 
									<% } else { %>
										<option value="manual">Manual</option> 
									<% } %>
										
										<% String ipPoolStr = null;
										
										for (int i=0; i < multicastLocalRPPools.length; i++) 
										{
											ipPoolStr = multicastLocalRPPools[i].getName();
											
											if (ipPoolStr.equals(selected_local_rp_pool))
											{%>
												<option value="<%=ipPoolStr%>" selected><%=ipPoolStr%></option> 
											<% } else { %>
												<option value="<%=ipPoolStr%>" ><%=ipPoolStr%></option> 
											<% }
										}%>
								</select>
							</table:cell>
						<% } else { %>
							<table:cell width="30%">
								<select name="cmbLocalRPPool" style="width:130px"><option value="manual" selected>Manual</option>
							</table:cell>
						<% }
					} else { %>
						<table:cell width="30%">
							<select name="cmbLocalRPPool" style="width:130px"><option value="manual" selected>Manual</option>
													</table:cell>
					<% } %>
					<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddresspool.description"/></table:cell>
				</table:row>
				<% if ("norp".equals(selected_local_rp_pool)) { %>
					<input type="hidden" name="selectRPIPLocalManual" value="">
				<% } else { %>
					<table:row>	
						<table:cell width="20%"></table:cell>
						<% if ("manual".equals(selected_local_rp_pool)) { %>
							<% if (!("".equals(selected_rp_ip_local_manual))) { %>
								<table:cell width="30%">
									<input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="<%=selected_rp_ip_local_manual%>">
								</table:cell>
							<% } else { %>
								<table:cell width="30%">
									<input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()">
								</table:cell>
							<% } %>
						<% } else { %>
							<% if (multicastLocalRPs != null) { %>
								<% if (multicastLocalRPs.length > minimum_length) { %>
									<table:cell width="30%">
										<select name="selectRPIPLocalPool" style="width:130px" >
											
											<% 
											if (selected_local_rp_pool.equals(current_rp_pool_name))
											{
												if (selected_rp_ip_local_pool.equals(RPAddress))
												{%>
													<option value="<%=RPAddress%>" selected><%=RPAddress%></option> 
												<%}
												else
												{%>
													<option value="<%=RPAddress%>"><%=RPAddress%></option> 
												<%}
											}
											
											String iphostStr = null;
											
											for (int i=0; i < multicastLocalRPs.length; i++) 
											{
												iphostStr = multicastLocalRPs[i].getIp();
												
												if (iphostStr.equals(selected_rp_ip_local_pool))
												{%>
													<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
												<% } else { %>
													<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
												<% }
											}%>
										</select>
									</table:cell>
								<% } else { %>
									<table:cell width="30%">No free IP Addresses available in current Multicast RP Pool</table:cell>
								<% }
							} else { %>
								<table:cell width="30%">Current IP Address Pool could not be found</table:cell>
							<% } %>
						<% } %>
						<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/></table:cell>
					</table:row>
				<% } %>
			<% } %>
		<% } %>

		<% if ("Remote".equals(selected_rp_mode)) { %>
			<table:row>
				<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpmode.alias"/></table:cell>
				<table:cell width="30%">
					<select name="cmbMultipleMode" style="width:55px" onchange="reload();">
						<% if ("Yes".equals(selected_multiple_check)) { %>
							<option value="Yes" selected>Yes</option> 
						<% } else { %>
							<option value="Yes">Yes</option> 
						<% } %>
						<% if ("No".equals(selected_multiple_check)) { %>
							<option value="No" selected>No</option> 
						<% } else { %>
							<option value="No">No</option> 
						<% } %>
					</select>
				</table:cell>
				<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpmode.description"/></table:cell>
			</table:row>
			<% if ("No".equals(selected_multiple_check)) { %>
				<table:row>
				   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/></table:cell>
						<% if (!("".equals(selected_rp_ip_remote))) { %>
							<table:cell width="30%">
								<input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="<%=selected_rp_ip_remote%>" onFocus="this.select()">
							</table:cell>
						<% } else { %>
							<table:cell width="30%">
								<input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="Enter Address" onFocus="this.select()">
							</table:cell>
						<% } %>
					<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/></table:cell>
				</table:row>
			<% } else { %>
				<table:row>
				   <table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpnumber.alias"/></table:cell>
				   <table:cell width="30%">
						<select name="cmbMultipleNum" style="width:55px" onchange="reload();">
							<% if ("2".equals(selected_multiple_number)) { %>
								<option value="2" selected>2</option> 
							<% } else { %>
								<option value="2">2</option> 
							<% } %>
							<% if ("3".equals(selected_multiple_number)) { %>
								<option value="3" selected>3</option> 
							<% } else { %>
								<option value="3">3</option> 
							<% } %>
							<% if ("4".equals(selected_multiple_number)) { %>
								<option value="4" selected>4</option> 
							<% } else { %>
								<option value="4">4</option> 
							<% } %>
							<% if ("5".equals(selected_multiple_number)) { %>
								<option value="5" selected>5</option> 
							<% } else { %>
								<option value="5">5</option> 
							<% } %>
						</select>
																			</table:cell>
				   <table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerpnumber.description"/></table:cell>
				</table:row>
				<% for (int i=1; i <= multipleNumber; i++) { %>
					<table:row>
						<% if (i == 1) { %>
							<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerp.alias"/></table:cell>
						<% } else { %>
							<table:cell width="20%"></table:cell>
						<% } 
						String rpAddrEntryName = "selectRPMultiple"+String.valueOf(i);
						String grpRangesAddrEntryName = "selectGRMultiple"+String.valueOf(i);%>
						<table:cell width="30%">
							<%if (!("".equals(multipleRPs.get(i)))) { %>
								<input type="text" name="<%=rpAddrEntryName%>" maxlength="15" value="<%=multipleRPs.get(i)%>" onFocus="this.select()">
							<% } else { %>
								<input type="text" name="<%=rpAddrEntryName%>" maxlength="15" value="Enter Address" onFocus="this.select()">
							<% } %>							
							<% if (!("".equals(multipleGRs.get(i)))) { %>
								<input type="text" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="<%=multipleGRs.get(i)%>" onFocus="this.select()">
							<% } else { %>
								<input type="text" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="Enter Address/mask" onFocus="this.select()">
							<% } %>
						</table:cell>
						<% if (i == 1) { %>
							<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerp.description"/></table:cell>
						<% } else { %>
							<table:cell width="50%"></table:cell>
						<% } %>
					</table:row>
				<% } %>
			<% } %>
		<% } %>
		</table:table>
									
		<% if (!("Disabled".equals(selected_rp_mode))) { %>
		<br>
		<table:table>
		  <table:header>
			<table:cell></table:cell>
			<table:cell></table:cell>
			<table:cell></table:cell>
		  </table:header>
										  <table:row>
				<table:cell width="20%">MSDP</table:cell>
				<table:cell width="30%">
					<table:table>
						<table:row>
							<% if ("Enabled".equals(selected_rp_msdp_check)) { %>
								<table:cell width="25%">
									<center><img src="/activator/images/greenOrb.png"></center>
								  </table:cell>
								<table:cell width="25%">
									<center><input type="radio" name="radiorpmsdp" value="Enabled" id="r1" onchange="reload();" checked="checked"></center>					
													</table:cell>
							<% } else { %>
								<table:cell width="25%">
									<center><img src="/activator/images/greenOrb.png"></center>
																			</table:cell>
								<table:cell width="25%">
									<center><input type="radio" name="radiorpmsdp" value="Enabled" id="r1" onchange="reload();"></center>
								</table:cell>
							<% } %>							
							<% if ("Disabled".equals(selected_rp_msdp_check)) { %>
								<table:cell width="25%">
									<center><img src="/activator/images/redOrb.png"></center>
								</table:cell>
								<table:cell width="25%">
									<center><input type="radio" name="radiorpmsdp" value="Disabled" id="r2" onchange="reload();" checked="checked"></center>
								</table:cell>
							<% } else { %>
								<table:cell width="25%">
									<center><img src="/activator/images/redOrb.png"></center>
								</table:cell>
								<table:cell width="25%">
									<center><input type="radio" name="radiorpmsdp" value="Disabled" id="r2" onchange="reload();"></center>
								</table:cell>
							<% } %>
						</table:row>
					</table:table>
				</table:cell>
				<table:cell width="50%">Multicast Source Discovery Protocol</table:cell>
			</table:row>
			<% if ("Enabled".equals(selected_rp_msdp_check)) { %>
				<table:row>
					<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.alias"/></table:cell>
					<table:cell width="30%">
						<% if (multicastLocalMSDPPools != null) { %>
							<% if (multicastLocalMSDPPools.length > minimum_length) { %>
									<select name="cmbRPMSDPLocalPool" style="width:130px" onchange="reload();">
										<% if ("manual".equals(selected_rp_msdp_local_pool)) { %>
											<option value="manual" selected>Manual</option> 
										<% } else { %>
											<option value="manual">Manual</option> 
										<% } %>
											
											<% String ipPoolStr = null;
											
											for (int i=0; i < multicastLocalMSDPPools.length; i++) 
											{
												ipPoolStr = multicastLocalMSDPPools[i].getName();
												
												if (ipPoolStr.equals(selected_rp_msdp_local_pool))
												{%>
													<option value="<%=ipPoolStr%>" selected><%=ipPoolStr%></option> 
												<% } else { %>
													<option value="<%=ipPoolStr%>" ><%=ipPoolStr%></option> 
												<% }
											}%>
									</select>
							<% } else { %>
									<select name="cmbRPMSDPLocalPool" style="width:130px" ><option value="manual" selected>Manual</option> 
							<% }
						} else { %>
								<select name="cmbRPMSDPLocalPool" style="width:130px" ><option value="manual" selected>Manual</option>
						<% } %>
					</table:cell>
					<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdresspool.description"/></table:cell>
				</table:row>
				<table:row>
					<table:cell width="20%"></table:cell>
					<table:cell width="30%">
						<% if ("manual".equals(selected_rp_msdp_local_pool)) { %>
							<% if (!("".equals(selected_rp_msdp_local_manual))) { %>
									<input type="text" size="15" name="selectRPMSDPLocalManual" maxlength="15" value="<%=selected_rp_msdp_local_manual%>" onFocus="this.select()">
									<input type="hidden" name="selectRPMSDPLocal" value="">
							<% } else { %>
									<input type="text" size="15" name="selectRPMSDPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()">
									<input type="hidden" name="selectRPMSDPLocal" value="">
							<% } %>
						<% } else { %>
							<% if (multicastLocalMSDPs != null) { %>
								<% if (multicastLocalMSDPs.length > minimum_length) { %>
										<select name="selectRPMSDPLocal" style="width:130px" >	
											<% 
											if (selected_rp_msdp_local_pool.equals(current_msdp_pool_name))
											{
												if (selected_rp_msdp_local.equals(MSDPLocalAddress))
												{%>
													<option value="<%=MSDPLocalAddress%>" selected><%=MSDPLocalAddress%></option> 
												<%}
												else
												{%>
													<option value="<%=MSDPLocalAddress%>"><%=MSDPLocalAddress%></option> 
												<%}
											}
											String iphostStr = null;
											
											for (int i=0; i < multicastLocalMSDPs.length; i++) 
											{
												iphostStr = multicastLocalMSDPs[i].getIp();
												
												if (iphostStr.equals(selected_rp_msdp_local))
												{%>
													<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
												<% } else { %>
													<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
												<% }
											}%>
										</select>
										<input type="hidden" name="selectRPMSDPLocalManual" value="">
								<% } else { %>
									No free IP Addresses available in current Multicast RP Pool
								<% }
							} else { %>
								Current IP Address Pool could not be found
							<% } %>
						<% } %>
					</table:cell>
					<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.description"/></table:cell>
				</table:row>
				<table:row>
					<table:cell width="20%"><bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.alias"/></table:cell>
					<% if (!("".equals(selected_rp_msdp_peer))) { %>
						<table:cell width="30%">
							<input type="text" size="15" name="selectRPMSDPPeer" maxlength="15" value="<%=selected_rp_msdp_peer%>" onFocus="this.select()">
						</table:cell>
					<% } else { %>
						<table:cell width="30%">
							<input type="text" size="15" name="selectRPMSDPPeer" maxlength="15" value="Enter Address" onFocus="this.select()">
						</table:cell>
					<% } %>
					<table:cell width="50%"><bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.description"/></table:cell>
				</table:row>
			<% } %>
			</table:table>	
			<br>
		<% } else { %>
			<input type="hidden" name="radiorpmsdp" value="">
		<% } %>             
									
		  <input type="hidden" name="multipleRPString" value="">
                    
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
		  <html:hidden property="AttachmentId" value="<%= AttachmentId %>"/>     
		  <html:hidden property="MulticastLoopbackAddress" value="<%= MulticastLoopbackAddress %>"/>     
		  <html:hidden property="VirtualTunnelId" value="<%= VirtualTunnelId %>"/>     
		  <html:hidden property="rpmode" value="<%= RPMode %>"/>     
      
		  <table:table>	  
      <table:row>
        <table:cell colspan="3" align="center">
        </table:cell>
      </table:row>
      <table:row>
        <table:cell colspan="3" align="center">
			<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="submitButton" class="ButtonSubmit" onclick="performCommit();">&nbsp;
        </table:cell>
      </table:row>
    </table:table>

  </html:form>

  </body>

</html>
<% } %>
