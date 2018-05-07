<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
		com.hp.ov.activator.vpn.errorhandler.*,
        java.text.NumberFormat,
        javax.sql.DataSource,com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,java.sql.Connection,
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
String datasource = (String) request.getParameter(LSPConstants.DATASOURCE);

String isAggregated = "";
if ( (String) request.getAttribute("Aggregated") != null ) 
{
	isAggregated = (String) request.getAttribute("Aggregated");
}

String isManual = "";
if ( (String) request.getAttribute("Manual") != null ) 
{
	isManual = (String) request.getAttribute("Manual");
}

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");
//System.out.println("refreshTreeRimid:"+refreshTreeRimid );

String refreshTree = (String) request.getAttribute(LSPConstants.REFRESH_TREE);

String isError = "false";
if ( (String) request.getAttribute("activation_failed") != null ) 
{
	isError = (String) request.getAttribute("activation_failed");
}

if ("true".equals(isError))
{
	%>
	<html>
	  <head>
		<title><bean:message bundle="LSPApplicationResources" key="<%= LSPConstants.JSP_VIEW_TITLE %>"/></title>
	 
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
		<%=error_info%>
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
		</body>
	</html>
<%
}
else
{
  if (!("".equals(isAggregated)))
  { %>
  <html>
	<head>
			<% if ("true".equals(isAggregated)) { %>
				<title>Aggregated LSP Creation</title>
			<% } else { %>
				<title>Aggregated LSP Modify</title>
			<% } %>	
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
	<center>
	  <h2>
		<% if ("true".equals(isAggregated)) { %>
			Aggregated LSP Creation
		<% } else { %>
			Aggregated LSP Modify
		<% } %>		
	  </h2>
	</center>
	<center>
			<table:table>
		<table:header>
					<table:cell>
							<% if ("true".equals(isAggregated)) { %>
								Aggregated LSPs successfully created
							<% } else { %>
								Aggregated LSPs successfully updated
							<% } %>
					</table:cell>
		</table:header>
			</table:table>
			</center>
		</body>
	</html>
  <%}
  else if ("true".equals(isManual))
  {%>
   <html>
	<head>
			<title>Manual LSP Creation</title>
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
	<center>
	  <h2>
		Manual LSP Creation
	  </h2>
	</center>
	<center>
			<table:table>
		<table:header>
					<table:cell>
							Manual LSPs successfully created
					</table:cell>
		</table:header>
			</table:table>
			</center>
		</body>
	</html>
  <%}
  else 
  {
%>

<html>
  <head>
    <title><bean:message bundle="LSPApplicationResources" key="<%= LSPConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.LSP beanLSP = (com.hp.ov.activator.vpn.inventory.LSP) request.getAttribute(LSPConstants.LSP_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

      String LSPId = StringFacility.replaceAllByHTMLCharacter(beanLSP.getLspid());
              
                                
                      String TunnelId = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTunnelid());
              
                                
                      String headPE = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadpe());
              
                                
                      String headPEName = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadpename());
              
                                
                      String tailPE = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailpe());
              
                                
                      String tailPEName = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailpename());
              
                                
                      String headIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadip());
              
                                
                      String tailIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailip());
              
                                
                      String headVPNIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadvpnip());
              
                                
                      String tailVPNIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailvpnip());
              
                                
                  String Bandwidth = (String) request.getAttribute(LSPConstants.BANDWIDTH_LABEL);
Bandwidth= StringFacility.replaceAllByHTMLCharacter(Bandwidth);
        
                                
                  String TerminationPointID = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTerminationpointid());
              
                                
                          String LSPProfileName = StringFacility.replaceAllByHTMLCharacter(beanLSP.getLspprofilename());
              
                                
                      String ActivationState = StringFacility.replaceAllByHTMLCharacter(beanLSP.getActivationstate());
              
                                
                      String AdminState = StringFacility.replaceAllByHTMLCharacter(beanLSP.getAdminstate());
              
                                
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanLSP.getActivationdate());
              
                                
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanLSP.getModificationdate());
              
	// Customization to display BWALLOCATION from LSPProfile
String bwAllocation ="auto";
String ct ="";
String cos ="";
String lspfilter ="";


Connection con = null;
try
{
DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
if (ds != null)
{
con = ds.getConnection();
if(LSPProfileName!=null)
{
com.hp.ov.activator.vpn.inventory.LSPProfile beanLSPProfile =
(com.hp.ov.activator.vpn.inventory.LSPProfile) com.hp.ov.activator.vpn.inventory.LSPProfile.findByPrimaryKey(con,
LSPProfileName);
bwAllocation =  beanLSPProfile.getBwallocation();
ct =  beanLSPProfile.getCt();
cos =  beanLSPProfile.getCos();
lspfilter =   beanLSPProfile.getLspfilter();
                                
}
              
}
              
                                
}
catch(Exception e)
{
System.out.println("Exception getting bwAllocation"+e);
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
//we don't handle this exception because we think this should be 
//corrected manually. System cann't handle this problem by itself.
}
}
}

//ends here														
                                
                      String UsageMode = StringFacility.replaceAllByHTMLCharacter(beanLSP.getUsagemode());
    
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPApplicationResources" key="jsp.view.title"/>
</h2> 

<%
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
               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.lspid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= LSPId != null? LSPId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.lspid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tunnelid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= TunnelId != null? TunnelId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.tunnelid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.headpename.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= headPEName != null? headPEName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.headpename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tailpename.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= tailPEName != null? tailPEName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.tailpename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.headip.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= headIP != null? headIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.headip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tailip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= tailIP != null? tailIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.tailip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.headvpnip.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= headVPNIP != null? headVPNIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.headvpnip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tailvpnip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= tailVPNIP != null? tailVPNIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.tailvpnip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.bandwidth.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Bandwidth != null? Bandwidth : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.bandwidth.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.activationstate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ActivationState != null? ActivationState : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.activationstate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.adminstate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= AdminState != null? AdminState : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.adminstate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.activationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.modificationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.lspprofilename.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= LSPProfileName != null? LSPProfileName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.lspprofilename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.usagemode.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Service" ,"Service");
                                            valueShowMap.put("Manual" ,"Manual");
                                            valueShowMap.put("Aggregated" ,"Aggregated");
                                          if(UsageMode!=null)
                     UsageMode=(String)valueShowMap.get(UsageMode);
              %>
              <%= UsageMode != null? UsageMode : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="LSPApplicationResources" key="field.usagemode.description"/>
                                                                              </table:cell>
          </table:row>
                                                        
      
				<table:row>
						<table:cell>	
		
									<bean:message bundle="LSPProfileApplicationResources" key="field.ct.alias"/>
													</table:cell>
						<table:cell>
						
						  
														<%= ct != null? ct : "" %>
													</table:cell>
						<table:cell>
              				<bean:message bundle="LSPProfileApplicationResources" key="field.ct.description"/>
              				              				              										</table:cell>
					</table:row>
																				    	 
					  					<table:row>
						<table:cell>	
		
									<bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.alias"/>
													</table:cell>
						<table:cell>
						
						  
														<%= bwAllocation != null? bwAllocation : "" %>
													</table:cell>
						<table:cell>
              				<bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.description"/>
              				              				              										</table:cell>
					</table:row>
																				    	 
					  					<table:row>
						<table:cell>	
		
									<bean:message bundle="LSPProfileApplicationResources" key="field.cos.alias"/>
													</table:cell>
						<table:cell>
						
						  
														<%= cos != null? cos : "" %>
													</table:cell>
						<table:cell>
              				<bean:message bundle="LSPProfileApplicationResources" key="field.cos.description"/>
              				              				              										</table:cell>
					</table:row>
																				    	 
					  				
			
				
																				    	 
					  				
					  				
					  									<table:row>
						<table:cell>	
		
									<bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.alias"/>
													</table:cell>
						<table:cell>
						
						  
														<%= lspfilter != null? lspfilter : "" %>
													</table:cell>
						<table:cell>
              				<bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.description"/>
              				              				              										</table:cell>
					</table:row>
					  				
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

  </body>
</html>
<% }
} %>
