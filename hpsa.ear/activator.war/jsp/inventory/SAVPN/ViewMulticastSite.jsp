<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
		java.sql.*,
		java.sql.Connection,
		com.hp.ov.activator.vpn.errorhandler.*,
		javax.sql.DataSource,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
		com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

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

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String datasource = (String) request.getParameter(MulticastProfileConstants.DATASOURCE);

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");

String refreshTree = (String) request.getAttribute(MulticastSiteConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="MulticastSiteApplicationResources" key="<%= MulticastSiteConstants.JSP_VIEW_TITLE %>"/></title>
 
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( refreshTree != null && refreshTree.equalsIgnoreCase("true") ) {
%>
      parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">
  


<%
String isError = "false";
if ( (String) request.getAttribute("activation_failed") != null ) 
{
	isError = (String) request.getAttribute("activation_failed");
}

if ("true".equals(isError))
{
	String act_id = "";
	if ( (String) request.getAttribute("activation_identifier") != null ) 
	{
		act_id = (String) request.getAttribute("activation_identifier");
	}

	String error_info = "";
	if ( (String) request.getAttribute("error_info") != null ) 
	{
		error_info = (String) request.getAttribute("error_info");
	}
	
	%>
	<h2 style="width:100%; text-align:center;">
		<bean:message bundle="MulticastSiteApplicationResources" key="MulticastSite.modify.error"/>
	</h2> 
	
	<div style="width:100%; text-align:center;">
		<table:table>
			<table:header>
			<table:cell></table:cell>
			<table:cell></table:cell>
			<table:cell></table:cell>
		  </table:header>
			<table:row>
				<table:cell><b>Error description</b></table:cell>
				<table:cell><%=error_info%></table:cell>
			</table:row>
<%
	
	String module_name 		= "GenericCLI";
	String service_type		= "";
	String equipment_name	= null;
	String primary_key		= null;
	String element_type		= null;
	String vendor			= null;
	
	int networkelementSize 	= 0;
	
	boolean show_ne_link 			= true;
	boolean show_activation_dialog 	= false;
	
	com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements = null;
	
	Connection con = null;
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
		
	try 
	{
		if (ds != null)  
		{
			con = ds.getConnection();
			
			if (con != null) 
			{				
				ErrorHandler erHandler = new ErrorHandler(); 
				ActivationInformation[] act = erHandler.getActivationInfo(con, act_id, module_name);

				if(act!=null && act.length!=0 )
				{
					networkElements = new NetworkElement[act.length];
					int i=0;
					show_activation_dialog=true;%>

					<table:row>
						<table:cell><b>Activation Attempts</b></table:cell>
						<table:cell>
							<table:table>
								<table:header>
									<table:cell>Time stamp</table:cell>
									<table:cell>Activation dialog</table:cell>
									<table:cell>Equipment name(IP)</table:cell>
									<table:cell>Protocol</table:cell>
									<table:cell>Device dialog</table:cell>
								</table:header>
			
								<% for (;i<act.length;++i)  
								{
									String ipaddress = act[i].getHost();
									NetworkElement nes[] = NetworkElement.findByManagement_ip(con,ipaddress);
									
									if(nes !=null && nes.length >0) 
									{
										equipment_name 	= nes[0].getName();
										primary_key 	= nes[0].getNetworkelementid();
										vendor 			= nes[0].getVendor();
										element_type 	= nes[0].getElementtype();
										
										boolean exist = false;
										
										for (int j=0;j<networkelementSize;++j)
										{
											if(equipment_name.equals(networkElements[j].getName()))
											{
												exist = true;
												break;
											}
										}
										if(!exist)
										{
											networkElements[networkelementSize] = nes[0];
											networkelementSize++;
										}
									}
									else 
									{
										equipment_name="";
									}
									
									//find the Equipment Details 
									String format = "E MMM d HH:mm:ss z yyyy";
									java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format);
									java.util.Date date = new java.util.Date(new Long(act[i].getTime_stamp()).longValue()); %>
							
								<table:row> 
									<table:cell><%= formatter.format(date)%></table:cell>
									<table:cell>
										<a href="#" onClick="val= '/activator/customJSP/ErrorHandler/Update_Error_Handler/show_activation_dialog.jsp?message_id=<%=act[i].getMessageId()%>&equipment_name=<%=equipment_name%>&element_type=<%=element_type%>&vendor=<%=vendor%>&action=view&service_type=<%=act[i].getDescription()%>'; window.open(val,'ActivationDialog','resizable=yes,status=yes,width=750,height=500,scrollbars=yes');"><%= act[i].getDescription()%></a>
										<input width="15%" type="button" value="Save" onClick="val='/activator/customJSP/ErrorHandler/Update_Error_Handler/show_activation_dialog.jsp?message_id=<%=act[i].getMessageId()%>&equipment_name=<%=equipment_name%>&element_type=<%=element_type%>&vendor=<%=vendor%>&action=save&service_type=<%=act[i].getDescription()%>'; window.open(val,'SaveResMgrLog','resizable=yes,status=yes,width=750,height=500,scrollbars=yes');">                
									</table:cell>
									<table:cell>
										<%if(equipment_name!="" && show_ne_link)
										{%>
										<U> 
											<a style="cursor: pointer;  cursor: hand;" onClick="val='/activator/inventory/SAVPN/ViewFormNetworkElementAction.do?networkelementid=<%=primary_key%>&datasource=inventoryDB'; a=window.open(val,'Equipmentwindow<%=primary_key%>','resizable=yes,status=yes,width=750,height=300,scrollbars=yes');a.focus();"><%=equipment_name%></a>
										</U> (<%= act[i].getHost()%>)

										<%}else if(show_ne_link){%>

										<%= act[i].getHost()%>

										<%}else if (equipment_name!=""){%>

										<%=equipment_name+"(" +act[i].getHost()+")"%>


										<%}else{%>

										<%=act[i].getHost()%>

										<%}%>
									</table:cell>
									<table:cell><%= act[i].getProtocol()%></table:cell>
									<table:cell>
										<input type="button" value="View" onClick="val= '/activator/customJSP/ErrorHandler/Update_Error_Handler/show_cli_interaction.jsp?message_id=<%= act[i].getMessageId()%>&action=view&service_type=<%=act[i].getDescription()%>'; b=window.open(val,'ViewResMgrLog<%=i%>','resizable=yes,status=yes,width=800,height=400,scrollbars=yes');b.focus();">
										<input width="15%" type="button" value="Save" onClick="val='/activator/customJSP/ErrorHandler/Update_Error_Handler/show_cli_interaction.jsp?message_id=<%= act[i].getMessageId()%>&action=save&service_type=<%=act[i].getDescription()%>'; window.open(val,'SaveResMgrLog','resizable=yes,status=yes,width=800,height=400,scrollbars=yes');">
									</table:cell>
								</table:row>              
							<%  }//end of for loop  %>
							</table:table>
						</table:cell>
					</table:row>
		<%		}
			}
		}
	} 
	catch (Exception e) 
	{
		e.printStackTrace();
		out.println("Exception in error handler proceesing  : " + e.getMessage());
	} 
	finally
	{
		try
		{
			con.close();
		}
		catch(Exception ex)
		{
			out.println("Exception during the closing DB connection : " + ex.getMessage());
		}
	}
	
	if(!show_activation_dialog)
	{ %>
			<table:row>    
				<table:cell><b>Probable causes</b></table:cell>
				<table:cell>
					No Activation error dialogs available from CLI plug-in. Some likely reasons could be :<br>
					1) Resources may not be available for activation. Check e.g. for available device interfaces or IP address pool entries.<br>
					2) A workflow has been stopped. Check the MWFM log files for more details. <br>
					3) The VPN SVP is running in demo mode. Check service provider related inventory parameters.<br>
				</table:cell>
			</table:row>
	<%}
	
	%>
	
			<table:row>
				<table:cell colspan="2" align="center">
					<br>
				</table:cell>
			</table:row>
		</table:table>
	</div>
	
<%
}
else 
{
com.hp.ov.activator.vpn.inventory.MulticastSite beanMulticastSite = (com.hp.ov.activator.vpn.inventory.MulticastSite) request.getAttribute(MulticastSiteConstants.MULTICASTSITE_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getAttachmentid());
                      String MulticastLoopbackAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getMulticastloopbackaddress());
                      String VirtualTunnelId = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getVirtualtunnelid());
                      String RPMode = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getRpmode());
                      String RPAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getRpaddress());
                      String MSDPLocalAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getMsdplocaladdress());
                      String MSDPPeerAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getMsdppeeraddress());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="MulticastSiteApplicationResources" key="jsp.view.title"/>
</h2> 

<%

boolean AttachmentIdPass_AttachmentId = false ;
AttachmentIdPass_AttachmentId = java.util.regex.Pattern.compile("^\\S+$").matcher(AttachmentId).matches();
boolean showAttachmentId = false;
  if (true && AttachmentIdPass_AttachmentId ){
showAttachmentId = true;
}


boolean VirtualTunnelIdPass_VirtualTunnelId = false ;
VirtualTunnelIdPass_VirtualTunnelId = java.util.regex.Pattern.compile("^\\S+$").matcher(VirtualTunnelId).matches();
boolean showVirtualTunnelId = false;
  if (true && VirtualTunnelIdPass_VirtualTunnelId ){
showVirtualTunnelId = true;
}

int multipleNumber = 2;
boolean isMultiple = false;

HashMap<Integer, String> multipleRPs = new HashMap<Integer,String>();
HashMap<Integer, String> multipleGRs = new HashMap<Integer,String>();

if (RPAddress.contains("#") || RPAddress.contains("|"))
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
	
	// Default remaining empty HashMap entries
	for (int i=count+1; i<=5; i++)
	{
		multipleRPs.put(i, "");
		multipleGRs.put(i, "");
	}
	
	isMultiple = true;
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

%>

    <div style="width:100%; text-align:center;">
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
      <%if(showAttachmentId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= MulticastLoopbackAddress != null? MulticastLoopbackAddress : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showVirtualTunnelId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= VirtualTunnelId != null? VirtualTunnelId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Disabled" ,"Disabled");
                                            valueShowMap.put("Auto-RP-Announce" ,"Auto-RP-Announce");
                                            valueShowMap.put("Auto-RP-Discovery" ,"Auto-RP-Discovery");
                                            valueShowMap.put("Auto-RP-Mapping" ,"Auto-RP-Mapping");
                                            valueShowMap.put("Remote" ,"Remote");
                                            valueShowMap.put("Local" ,"Local");
                                            valueShowMap.put("Anycast-non-RP" ,"Anycast-non-RP");
                                            valueShowMap.put("Anycast-RP" ,"Anycast-RP");
                                          if(RPMode!=null)
                     RPMode=(String)valueShowMap.get(RPMode);
              %>
              <%= RPMode != null? RPMode : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
			<% if (isMultiple) { %>
				<% for (int i=1; i <= multipleNumber; i++) { %>
                                 <table:row>
						<% if (i == 1) { %>
							<table:cell><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerp.alias"/></table:cell>
						<% } else { %>
							<table:cell></table:cell>
						<% } %>
            
						<table:cell><%=multipleRPs.get(i)%> / <%=multipleGRs.get(i)%></table:cell>
              
						<% if (i == 1) { %>
							<table:cell><bean:message bundle="MulticastSiteApplicationResources" key="field.multiplerp.description"/></table:cell>
						<% } else { %>
							<table:cell></table:cell>
						<% } %>
					</table:row>
				<% } %>
			<% } else { %>
				<table:row>
					<table:cell><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/></table:cell>
					<table:cell><%= RPAddress != null? RPAddress : "" %></table:cell>
					<table:cell><bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/></table:cell>
          </table:row>
			<% } %>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= MSDPLocalAddress != null? MSDPLocalAddress : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= MSDPPeerAddress != null? MSDPPeerAddress : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.description"/>
                                                                              </table:cell>
          </table:row>
                                                        
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>
	<% } %>
  </body>
</html>
