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
String datasource = (String) request.getParameter(LSPConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitLSPAction.do?datasource=" + datasource + "&rimid=" + rimid;
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}

String isBulkModify = "false";
if ( request.getParameter("ismultiple") != null ) {
	isBulkModify = request.getParameter("ismultiple") ;
}

if ( _location_ == null ) {
                                                                          _location_ = "bandwidth";
                                                      }

													  
if ("true".equals(isBulkModify))
{%>
<html>
  <head>
    <title><bean:message bundle="LSPApplicationResources" key="jsp.multiupdate.title"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/jquery-ui.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
	<script src="/activator/javascript/jquery-1.10.2.js"></script>
	<script src="/activator/javascript/jquery-ui.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
	  .custom-combobox {
		position: relative;
		display: inline-block;
	}
	.custom-combobox-toggle {
		position: absolute;
		top: 0;
		bottom: 0;
		margin-left: -1px;
		padding: 0;
		/* support: IE7 */
		*height: 1.7em;
		*top: 0.1em;
	}
	.custom-combobox-input {
		margin: 0;
		padding: 0.3em;
	}
	.ui-state-default,
.ui-widget-content .ui-state-default,
.ui-widget-header .ui-state-default {
	border: 1px solid #d3d3d3;
	background: #ffffff;
	font-weight: normal;
	color: #555555;
}
    </style>
	<script>
	(function( $ ) {
		$.widget( "custom.combobox", {
			_create: function() {
				this.wrapper = $( "<span>" )
					.addClass( "custom-combobox" )
					.insertAfter( this.element );

				this.element.hide();
				this._createAutocomplete();
				this._createShowAllButton();
			},

			_createAutocomplete: function() {
				var org_onchange = this.element.closest("select").prop("onchange");
				var selected = this.element.children( ":selected" ),
					value = selected.val() ? selected.text() : "";

				this.input = $( "<input>" )
					.appendTo( this.wrapper )
					.val( value )
					.attr( "title", "" )
					.addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
					.autocomplete({
						delay: 0,
						minLength: 0,
						source: $.proxy( this, "_source" ),
						
						select: function( event, ui ) {
							org_onchange();
                             ui.item.option.selected = true;
                             /*self._trigger( "selected", event, {
                                 item: ui.item.option
                             });
                             select.trigger("change"); */                          
                         },
                         change: function( event, ui ) {
							if ( !ui.item ) {
                                 var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
                                     valid = false;
                                 select.children( "option" ).each(function() {
                                     if ( $( this ).text().match( matcher ) ) {
                                         this.selected = valid = true;
                                         return false;
                                     }
                                 });
                                 if ( !valid ) {
                                     // remove invalid value, as it didn't match anything
                                     $( this ).val( "" );
                                     select.val( "" );
                                     input.data( "autocomplete" ).term = "";
                                     return false;
                                 }
                             }
                         }
					})
					.tooltip({
						tooltipClass: "ui-state-highlight"
					});

				this._on( this.input, {
					autocompleteselect: function( event, ui ) {
						ui.item.option.selected = true;
						this._trigger( "select", event, {
							item: ui.item.option
						});
					},

					autocompletechange: "_removeIfInvalid"
				});
			},

			_createShowAllButton: function() {
				var input = this.input,
					wasOpen = false;

				$( "<a>" )
					.attr( "tabIndex", -1 )
					.attr( "title", "Show All Items" )
					.tooltip()
					.appendTo( this.wrapper )
					.button({
						icons: {
							primary: "ui-icon-triangle-1-s"
						},
						text: false
					})
					.removeClass( "ui-corner-all" )
					.addClass( "custom-combobox-toggle ui-corner-right" )
					.mousedown(function() {
						wasOpen = input.autocomplete( "widget" ).is( ":visible" );
					})
					.click(function() {
						input.focus();

						// Close if already visible
						if ( wasOpen ) {
							return;
						}
      
						// Pass empty string as value to search for, displaying all results
						input.autocomplete( "search", "" );
					});
			},

			_source: function( request, response ) {
				var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
				response( this.element.children( "option" ).map(function() {
					var text = $( this ).text();
					if ( this.value && ( !request.term || matcher.test(text) ) )
						return {
							label: text,
							value: text,
							option: this
						};
				}) );
			},

			_removeIfInvalid: function( event, ui ) {

				// Selected an item, nothing to do
				if ( ui.item ) {
					return;
				}
      
				// Search for a match (case-insensitive)
				var value = this.input.val(),
					valueLowerCase = value.toLowerCase(),
					valid = false;
				this.element.children( "option" ).each(function() {
					if ( $( this ).text().toLowerCase() === valueLowerCase ) {
						this.selected = valid = true;
						return false;
					}
				});
      
				// Found a match, nothing to do
				if ( valid ) {
					return;
				}
      
				// Remove invalid value
				this.input
					.val( "" )
					.attr( "title", value + " didn't match any item" )
					.tooltip( "open" );
				this.element.val( "" );
				this._delay(function() {
					this.input.tooltip( "close" ).attr( "title", "" );
				}, 2500 );
				this.input.autocomplete( "instance" ).term = "";
			},

			_destroy: function() {
				this.wrapper.remove();
				this.element.show();
			}
		});
	})( jQuery );
      
	$(function() {
		 $(".combobox").combobox();
	});

	</script>
    <script>
    function performCommit()
    {
      window.document.LSPForm.action = '/activator<%=moduleConfig%>/UpdateCommitLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.LSPForm.submit();
    }
	function reload()
	{
		window.document.LSPForm.action = '/activator<%=moduleConfig%>/UpdateFormLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>'; 
		window.document.LSPForm.submit();
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
	
	function clearBox(flag)
	{
		switch(flag) 
		{
			case '1':
				
				try
				{
					var networkid = document.getElementsByName("networkid");
					networkid[0].value = '';
				}
				catch (err) { /* Ignore */ }
				
				break;
			
			case '2':
			
				try
				{
					var headpeid = document.getElementsByName("headpeid");
					headpeid[0].value = '';
				}
				catch (err) { /* Ignore */ }
				
				break;
				
			case '3':
			
				try
				{
					var tailpeid = document.getElementsByName("tailpeid");
					tailpeid[0].value = '';
				}
				catch (err) { /* Ignore */ }
				
				break;
		}
	}
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">
 
  <%
  
	String networkid = ""; 
	if (request.getParameter("networkid") != null)
	{
		networkid = request.getParameter("networkid");
	}
	
	String headpeid = ""; 
	if (request.getParameter("headpeid") != null)
	{
		headpeid = request.getParameter("headpeid");
	}
	
	String tailpeid = ""; 
	if (request.getParameter("tailpeid") != null)
	{
		tailpeid = request.getParameter("tailpeid");
	}
	
	int lspcount = 0;
	boolean canSubmit = true;

	Connection con = null;
			 
	com.hp.ov.activator.vpn.inventory.LSP[] LSPList = null;
	com.hp.ov.activator.cr.inventory.Network[] networkList = null;
	
	ArrayList<LabelValueBean> networkListofValues = new ArrayList<LabelValueBean>();
	
	com.hp.ov.activator.vpn.inventory.PERouter[] headPEList = null;
	com.hp.ov.activator.vpn.inventory.PERouter[] tailPEList = null;
	
	ArrayList<LabelValueBean> headPEListofValues = new ArrayList<LabelValueBean>();
	ArrayList<LabelValueBean> tailPEListofValues = new ArrayList<LabelValueBean>();
	
	com.hp.ov.activator.vpn.inventory.RateLimit[] rlList = null;
		  
	try
	{
		DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
		if (ds != null)
		{
			con = ds.getConnection();
			
			networkList = com.hp.ov.activator.cr.inventory.Network.findAll(con,"CRModel#Network.Type='Network'");
			
			networkList = networkList != null ? networkList : new com.hp.ov.activator.cr.inventory.Network[0];
	  
			for (int i = 0; i < networkList.length; i++) 
			{
				com.hp.ov.activator.cr.inventory.Network networkListObject = networkList[i];
			  
				LabelValueBean networkObject = new LabelValueBean(networkListObject.getName(),networkListObject.getNetworkid());

				networkListofValues.add(networkObject);
			}
			
			String whereClause = "usagemode='Aggregated'";
			
			if (!("".equals(networkid))) 
			{
				whereClause += "and (headpe IN (select cr_networkelement.networkelementid from cr_networkelement where cr_networkelement.networkid='"+networkid+"') ";
				whereClause += "or tailpe IN (select cr_networkelement.networkelementid from cr_networkelement where cr_networkelement.networkid='"+networkid+"'))";
			}
			
			if (!("".equals(headpeid)))
			{
				whereClause += "and headpe = '"+headpeid+"' ";
			}
			
			if (!("".equals(tailpeid)))
			{
				whereClause += "and tailpe = '"+tailpeid+"' ";
			}
			
			LSPList = com.hp.ov.activator.vpn.inventory.LSP.findAll(con,whereClause);
			
			headPEList = com.hp.ov.activator.vpn.inventory.PERouter.findAll(con);	

			headPEList = headPEList != null ? headPEList : new com.hp.ov.activator.vpn.inventory.PERouter[0];

			for (int i = 0; i < headPEList.length; i++) 
			{
				com.hp.ov.activator.vpn.inventory.PERouter headPEListObject = headPEList[i];
			  
				LabelValueBean headPEObject = new LabelValueBean(headPEListObject.getName(),headPEListObject.getNetworkelementid());
			  
				headPEListofValues.add(headPEObject);
			}
									
			tailPEList = com.hp.ov.activator.vpn.inventory.PERouter.findAll(con);	

			tailPEList = tailPEList != null ? tailPEList : new com.hp.ov.activator.vpn.inventory.PERouter[0];

			for (int i = 0; i < tailPEList.length; i++) 
			{
				com.hp.ov.activator.vpn.inventory.PERouter tailPEListObject = tailPEList[i];
			  
				LabelValueBean tailPEObject = new LabelValueBean(tailPEListObject.getName(),tailPEListObject.getNetworkelementid());
			  
				tailPEListofValues.add(tailPEObject);
			}
			
			rlList = com.hp.ov.activator.vpn.inventory.RateLimit.findAll(con);
		}             
	}
	catch(Exception e)
	{
		System.out.println("Exception getting LSP from database: "+e);
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
	
	// Get list of BW
	ArrayList<String> RLListOfValues = new ArrayList<String>();

	rlList = rlList != null ? rlList : new com.hp.ov.activator.vpn.inventory.RateLimit[0];

	for (int i = 0; i < rlList.length; i++) 
	{
		com.hp.ov.activator.vpn.inventory.RateLimit rateLimit = rlList[i];
		RLListOfValues.add(rateLimit.getRatelimitname());
	}
 
  %>
  
	<center> 
		<h2 style="width:100%; text-align:center;"><bean:message bundle="LSPApplicationResources" key="jsp.multiupdate.title"/></h2>
	</center>

	<H1>
		<html:errors bundle="LSPApplicationResources" property="LSPID"/>
		<html:errors bundle="LSPApplicationResources" property="headPE"/>
		<html:errors bundle="LSPApplicationResources" property="tailPE"/>
		<html:errors bundle="LSPApplicationResources" property="headIP"/>
		<html:errors bundle="LSPApplicationResources" property="tailIP"/>
		<html:errors bundle="LSPApplicationResources" property="headVPNIP"/>
		<html:errors bundle="LSPApplicationResources" property="tailVPNIP"/>
		<html:errors bundle="LSPApplicationResources" property="Bandwidth"/>
		<html:errors bundle="LSPApplicationResources" property="LSPProfileName"/>
		<html:errors bundle="LSPApplicationResources" property="ActivationState"/>
		<html:errors bundle="LSPApplicationResources" property="AdminState"/>
		<html:errors bundle="LSPApplicationResources" property="TunnelId"/>
		<html:errors bundle="LSPApplicationResources" property="ActivationDate"/>
		<html:errors bundle="LSPApplicationResources" property="ModificationDate"/>
	</H1>
																											  
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
		
			<table:table> 
			  <table:header>
				<table:cell colspan="5" align="left">
					<bean:message bundle="InventoryResources" key="field.delete_lsps.filter"/>
				</table:cell>
			  </table:header>
			  <table:row>
				<table:cell>
					<bean:message bundle="InventoryResources" key="field.delete_lsps.networkid"/>
				</table:cell>
				<table:cell>
					<select name="networkid" id="combobox" class="combobox" onchange="reload();">
						<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
						<% for( int j = 0 ; j < networkListofValues.size() ; j++ )
						{
								LabelValueBean networkObject = networkListofValues.get(j);
								
								if ((networkObject.getValue()).equals(networkid)) { %>		 
									<option value="<%= networkObject.getValue() %>" selected><%= networkObject.getLabel() %></option>
								<% } else { %>
									<option value="<%= networkObject.getValue() %>"><%= networkObject.getLabel() %></option>
								<% } %>
								
						<% } %>
					</select>
				</table:cell>
				<table:cell>
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" onclick="clearBox('1'); reload();">
				</table:cell>
			  </table:row>
			  <table:row>
				<table:cell>
					<bean:message bundle="InventoryResources" key="field.head_pe.label"/>
				</table:cell>
				<table:cell>
					<select name="headpeid" id="combobox" class="combobox" onchange="reload();">
						<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
						<% for( int j = 0 ; j < headPEListofValues.size() ; j++ )
						{
								LabelValueBean headPEObject = headPEListofValues.get(j);
								
								if ((headPEObject.getValue()).equals(headpeid)) { %>		
									<option value="<%= headPEObject.getValue() %>" selected><%= headPEObject.getLabel() %></option>
								<% } else { %>
									<option value="<%= headPEObject.getValue() %>"><%= headPEObject.getLabel() %></option>
								<% } %>
						<% } %>
					</select>
				</table:cell>
				<table:cell>
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" onclick="clearBox('2'); reload();">
				</table:cell>
			  </table:row>
			  <table:row>
				<table:cell>
					<bean:message bundle="InventoryResources" key="field.tail_pe.label"/>
				</table:cell>
				<table:cell>
					<select name="tailpeid" id="combobox" class="combobox" onchange="reload();">
						<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
						<% for( int j = 0 ; j < tailPEListofValues.size() ; j++ )
						{
								LabelValueBean tailPEObject = tailPEListofValues.get(j);
															
								if ((tailPEObject.getValue()).equals(tailpeid)) { %>		
									<option value="<%= tailPEObject.getValue() %>" selected><%= tailPEObject.getLabel() %></option>
								<% } else { %>
									<option value="<%= tailPEObject.getValue() %>"><%= tailPEObject.getLabel() %></option>
								<% } %>
						<% } %>
					</select>
				</table:cell>
				<table:cell>
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" onclick="clearBox('3'); reload();">
				</table:cell>
			  </table:row>
			</table:table>
			
			<br>
			
			<table:table>
				<table:header>
					<table:cell width="8%">
						<bean:message bundle="LSPApplicationResources" key="field.lspid.name"/>
					</table:cell>
					<table:cell width="23%">
						<bean:message bundle="InventoryResources" key="field.head_pe.label"/>
					</table:cell>
					<table:cell width="23%">
						<bean:message bundle="InventoryResources" key="field.tail_pe.label"/>
					</table:cell>
					<table:cell width="23%">
						<bean:message bundle="InventoryResources" key="field.cos.label"/>
					</table:cell>
					<table:cell width="23%">
						<bean:message bundle="InventoryResources" key="field.bandwidth.label"/>
					</table:cell>
				</table:header>
			</table:table>

			  <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
			  
			  <div style="height: <bean:message bundle="InventoryResources" key="size.delete_lsps.scroll"/>; overflow-y: scroll;">
			  <table:table>
			  
			  <% LSPList = LSPList != null ? LSPList : new com.hp.ov.activator.vpn.inventory.LSP[0];
			  
				for (int i = 0; i < LSPList.length; i++) 
				{
					lspcount++; 
					
					com.hp.ov.activator.vpn.inventory.LSP LSPListObject = LSPList[i];
					
					String lspid = LSPListObject.getLspid();
					String headPE = LSPListObject.getHeadpename();
					String tailPE = LSPListObject.getTailpename();
					String cosName = "";
					String bandwidth = LSPListObject.getBandwidth();
					
					try
					{
						DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
						if (ds != null)
						{
							con = ds.getConnection();

							String lspProfileString = LSPListObject.getLspprofilename();
							
							com.hp.ov.activator.vpn.inventory.LSPProfile LSPProfileObject = com.hp.ov.activator.vpn.inventory.LSPProfile.findByLspprofilename(con,lspProfileString);
							
							cosName = LSPProfileObject.getCos();
						}      
					}
					catch(Exception e)
					{
						System.out.println("Exception getting LSP show info from database: "+e);
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
					<table:row>
						
						<table:cell width="8%"><%=lspid%></table:cell>
						<table:cell width="23%"><%=headPE%></table:cell>
						<table:cell width="23%"><%=tailPE%></table:cell>
						<table:cell width="23%"><%=cosName%></table:cell>
						
						<table:cell width="23%">
							<% 
								String bandwidthboxname = "bandwidth"+lspid;
							%>
							<select name="<%=bandwidthboxname%>">
								<% for( int j = 0 ; j < RLListOfValues.size() ; j++ )
								{
								String rateLimit = RLListOfValues.get(j);
												  
								if (!("Unknown".equals(rateLimit)))
								{
									if (rateLimit.equals(bandwidth))
									{ %>
										<option selected="selected" value="<%=rateLimit%>"><%=rateLimit%></option>
								<%	} else
									{ %>
										<option value="<%=rateLimit%>"><%=rateLimit%></option>
								<%	}
								}			
								} %>
							</select>
						
						</table:cell>
						
					</table:row>
					
					<%
				}
				
				if (lspcount < 1)
				{
					canSubmit = false; 
				}
				
				%>
				
			</table:table>
			</div>
		
		</table:table>
		
		<table:table>
			<table:row>
				<table:cell colspan="3" align="center">
					<br>
				</table:cell>
			</table:row>
			<table:row>
				<table:cell colspan="3" align="center">
					<% if (canSubmit) { %>
						<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
					<% } else { %>
						<input disabled="true" type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
					<% } %>
				</table:cell>
			</table:row>
		</table:table>
			
		<html:hidden property="headpe" value="1"/>
		<html:hidden property="tailpe" value="1"/>
		<html:hidden property="headip" value="1"/>
		<html:hidden property="tailip" value="1"/>
		<html:hidden property="headvpnip" value="1"/>
		<html:hidden property="tailvpnip" value="1"/>
		<html:hidden property="ismultiple" value="true"/>
		
	</html:form>
  </body>
</html>
	
<%}
else {			

String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("lspid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");

/** LSP ENABLE MODIFICATION - BEGIN **/
String isEnable = "false";
if ( request.getParameter("isenable") != null ) {
isEnable = request.getParameter("isenable") ;

isEnable = java.net.URLEncoder.encode( isEnable ,"UTF-8");
/** LSP ENABLE MODIFICATION - END **/

}								  
%>

<html>
  <head>
    <title><bean:message bundle="LSPApplicationResources" key="<%= LSPConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.LSPForm.action = '/activator<%=moduleConfig%>/UpdateFormLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.LSPForm.submit();
    }
    function performCommit()
    {
      window.document.LSPForm.action = '/activator<%=moduleConfig%>/UpdateCommitLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.LSPForm.submit();
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
com.hp.ov.activator.vpn.inventory.LSP beanLSP = (com.hp.ov.activator.vpn.inventory.LSP) request.getAttribute(LSPConstants.LSP_BEAN);
if(beanLSP==null)
   beanLSP = (com.hp.ov.activator.vpn.inventory.LSP) request.getSession().getAttribute(LSPConstants.LSP_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
LSPForm form = (LSPForm) request.getAttribute("LSPForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

String LSPID = beanLSP.getLspid();
        
            
                            
            
                
                String headPE = beanLSP.getHeadpe();
        
            
                            
            
                
                String tailPE = beanLSP.getTailpe();
        
            
                            
            
                
                String headIP = beanLSP.getHeadip();
        
            
                            
            
                
                String tailIP = beanLSP.getTailip();
        
            
                            
            
                
                String headVPNIP = beanLSP.getHeadvpnip();
        
            
                            
            
                
                String tailVPNIP = beanLSP.getTailvpnip();
        
            
                            
            
                
                String Bandwidth = beanLSP.getBandwidth();
        
          String BandwidthLabel = (String) request.getAttribute(LSPConstants.BANDWIDTH_LABEL);
      ArrayList BandwidthListOfValues = (ArrayList) request.getAttribute(LSPConstants.BANDWIDTH_LIST_OF_VALUES);
if(BandwidthListOfValues != null){
            
for( int i = 0 ; i < BandwidthListOfValues.size() ; i++ ){
                            
String  bandwidthValue = (BandwidthListOfValues.get(i)).toString();
if(bandwidthValue.toString().indexOf("[, ]") >0  || bandwidthValue.toString().indexOf("[Unknown, Unknown]")>0) {
BandwidthListOfValues.remove(i);
}
            
}
}
                            
            
                

String LSPProfileName = beanLSP.getLspprofilename();
        
            
                            
            
                
                String ActivationState = beanLSP.getActivationstate();
        
            
                            
            
                
                String AdminState = beanLSP.getAdminstate();
        
            
                            
            
                
String TunnelId = beanLSP.getTunnelid();
            
                            
            
                
        
                String ActivationDate = beanLSP.getActivationdate();
            
                            
            
                
        
                String ModificationDate = beanLSP.getModificationdate();
            
				String UsageMode = beanLSP.getUsagemode();
                            
// Customization to display BWALLOCATION from LSPProfile
String bwAllocation ="auto";
String classType ="";
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
classType =  beanLSPProfile.getCt();
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
            
                            
            
                
  %>

<center> 

<%
/** LSP ENABLE MODIFICATION - BEGIN **/
if ( isEnable.equals("true") ) 
{
%> 		  
  <h2 style="width:100%; text-align:center;">Enable LSP - Select bandwidth</h2>
<%
}
else
{
%>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPApplicationResources" key="jsp.update.title"/></h2>
<%
}
/** LSP ENABLE MODIFICATION - END **/
%>

</center>

<H1>
<html:errors bundle="LSPApplicationResources" property="LSPID"/>
        <html:errors bundle="LSPApplicationResources" property="headPE"/>
        <html:errors bundle="LSPApplicationResources" property="tailPE"/>
        <html:errors bundle="LSPApplicationResources" property="headIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailIP"/>
        <html:errors bundle="LSPApplicationResources" property="headVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="Bandwidth"/>
<html:errors bundle="LSPApplicationResources" property="LSPProfileName"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationState"/>
        <html:errors bundle="LSPApplicationResources" property="AdminState"/>
<html:errors bundle="LSPApplicationResources" property="TunnelId"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationDate"/>
        <html:errors bundle="LSPApplicationResources" property="ModificationDate"/>
  </H1>
                                                                                                          
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
                <bean:message bundle="LSPApplicationResources" key="field.lspid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
<html:text disabled="true" property="lspid" size="24" value="<%= LSPID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="LSPApplicationResources" key="field.lspid.description"/>
                                                                        </table:cell>
            </table:row>
                                
				                                            
				                                            
				                                            
				                                            
                                      <table:row>
              <table:cell>  
<bean:message bundle="LSPApplicationResources"
key="field.bandwidth.alias" />
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="bandwidth" value="<%= Bandwidth %>" >
<html:options collection="BandwidthListOfValues" property="value"
labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
<bean:message bundle="LSPApplicationResources"
key="field.bandwidth.description" />
                                                                        </table:cell>
            </table:row>
<%
if(LSPProfileName!=null){%>
                                      <table:row>
              <table:cell>  
<bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.alias"/>
                              </table:cell>
              <table:cell>
                                
<%
/** LSP ENABLE MODIFICATION - BEGIN **/
if ( isEnable.equals("true") || UsageMode.equals("Aggregated") || UsageMode.equals("Manual") ) 
{
%> 		  
  <html:select disabled="true" property="bwAllocation" value="<%= bwAllocation %>" >
  <html:option value="auto" >auto</html:option>
  <html:option value="manual" >manual</html:option>
  </html:select>
                                                          <%
}
                        else
{
                          %>
  <html:select property="bwAllocation" value="<%= bwAllocation %>" >
  <html:option value="auto" >auto</html:option>
  <html:option value="manual" >manual</html:option>
                                          </html:select>
<%
}
/** LSP ENABLE MODIFICATION - END **/
%>
				                                            
                                                </table:cell>
              <table:cell>
<bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.description"/>
                                                                        </table:cell>
            </table:row>
<%}%>			
				                                            
<table:row>
<table:cell>	
<bean:message bundle="LSPProfileApplicationResources" key="field.ct.alias"/>
</table:cell>
<table:cell>
				                                            
<html:text disabled="true" property="classType" size="24" value="<%= classType %>"/>
                                
                                                </table:cell>
              <table:cell>
<bean:message bundle="LSPProfileApplicationResources" key="field.ct.description"/>
                                                                        </table:cell>
            </table:row>
                                
                    
<%/** LSP ENABLE MODIFICATION - BEGIN **/
if ( isEnable.equals("true") ) 
{%> 		  
  <html:hidden property="enable" value="<%= String.valueOf(\"true\") %>"/>
<%}
else
{%>
  <html:hidden property="enable" value="<%= String.valueOf(\"false\") %>"/>
<%}
/** LSP ENABLE MODIFICATION - END **/%>
                    
<html:hidden property="lspid" value="<%= String.valueOf(LSPID) %>"/>
<html:hidden property="enable" value="<%= String.valueOf(\"true\") %>"/>
<html:hidden property="headpe" value="<%= headPE %>"/>
<html:hidden property="tailpe" value="<%= tailPE %>"/>
<html:hidden property="headip" value="<%= headIP %>"/>
<html:hidden property="tailip" value="<%= tailIP %>"/>	
<html:hidden property="headvpnip" value="<%= headVPNIP %>"/>
<html:hidden property="tailvpnip" value="<%= tailVPNIP %>"/>
<html:hidden property="lspprofilename" value="<%= LSPProfileName %>"/>
<html:hidden property="activationstate" value="<%= ActivationState %>"/>						
<html:hidden property="adminstate" value="<%= AdminState %>"/>
<html:hidden property="tunnelid" value="<%= TunnelId %>"/>
<html:hidden property="activationdate" value="<%= ActivationDate %>"/>
<html:hidden property="modificationdate" value="<%= ModificationDate %>"/>
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
<html:select  property="bandwidthhidden" value="<%= Bandwidth %>" style="visibility:hidden">
<html:options collection="BandwidthListOfValues" property="value" labelProperty="label" />
</html:select>
      
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

<% } %>
