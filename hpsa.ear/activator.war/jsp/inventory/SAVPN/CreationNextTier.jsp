<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
		java.sql.Connection,
		javax.sql.DataSource,
		com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

    
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(NextTierConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitNextTierAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "originnetworkelementid";
                  }
%>

<html>
  <head>
    <title><bean:message bundle="NextTierApplicationResources" key="<%= NextTierConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
	function sendthis(focusthis) {
      window.document.NextTierForm.action = '/activator<%=moduleConfig%>/CreationFormNextTierAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.NextTierForm.submit();
    }

	function performCommit() {
      window.document.NextTierForm.action = '/activator<%=moduleConfig%>/CreationCommitNextTierAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.NextTierForm.submit();
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

<% String OriginNetworkElementId = request.getParameter("peid");
      
Connection con = null;

com.hp.ov.activator.cr.inventory.NetworkElement originNE = null;
com.hp.ov.activator.vpn.inventory.PERouter originPE = null;
com.hp.ov.activator.cr.inventory.Network originNetwork = null;
com.hp.ov.activator.cr.inventory.NetworkElement[] targetNetworkElementList = null;
com.hp.ov.activator.vpn.inventory.PERouter targetPE = null;
ArrayList<LabelValueBean> targetPEList = new ArrayList<LabelValueBean>();
      
try
{
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
	if (ds != null)
	{
		con = ds.getConnection();
		
		// Get Origin NE/PE
		originNE = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(con,OriginNetworkElementId);
		originPE = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkelementid(con,OriginNetworkElementId);

		// Find out target tier
		String targetTier = "1";
		if ("3".equals(originPE.getTier()))
		{
			targetTier="2";
		}			

		// Get Origin Network
		originNetwork = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,originNE.getNetworkid());
		
		// Get the list of the NEs that belong to a Network with the same ASN than the Origin network
		if ((originNetwork.getAsn() != null) && !("".equals(originNetwork.getAsn())) )
		{
			String whereClause = "CRModel#Networkelement.networkid IN (select networkid from cr_network where type ='Network' and asn = "+originNetwork.getAsn()+")";
			targetNetworkElementList = com.hp.ov.activator.cr.inventory.NetworkElement.findAll(con,whereClause);
		}
		else
		{
			String whereClause = "CRModel#Networkelement.networkid IN (select networkid from cr_network where type ='Network' and (asn is null or asn=''))";
			targetNetworkElementList = com.hp.ov.activator.cr.inventory.NetworkElement.findAll(con,whereClause);
		}
      
		targetNetworkElementList = targetNetworkElementList != null ? targetNetworkElementList : new com.hp.ov.activator.cr.inventory.NetworkElement[0];
      
	    // Filter Target PE list removing the PEs of a different target tier and the routers that are already a Next Tier for the current origin router
		for (int i = 0; i < targetNetworkElementList.length; i++) 
		{
			com.hp.ov.activator.vpn.inventory.PERouter targetNetworkElementListObject = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkelementid(con,targetNetworkElementList[i].getNetworkelementid());
			
			if (targetTier.equals(targetNetworkElementListObject.getTier()))
			{
				if (com.hp.ov.activator.vpn.inventory.NextTier.findByOriginnetworkelementidnexttiernetworkelementidCount(con,originPE.getNetworkelementid(),targetNetworkElementListObject.getNetworkelementid()) < 1) 
				{
					LabelValueBean targetPEObject = new LabelValueBean(targetNetworkElementListObject.getName(),targetNetworkElementListObject.getNetworkelementid());
					targetPEList.add(targetPEObject);
				}
			}
		}
		
	}             
}
catch(Exception e)
{
	System.out.println("Exception getting Network elements from database: "+e);
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

<center> 
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="NextTierApplicationResources" key="jsp.creation.title"/>
</h2> 
</center>


<H1>
      <html:errors bundle="NextTierApplicationResources" property="OriginNetworkElementId"/>
        <html:errors bundle="NextTierApplicationResources" property="NextTierNetworkElementId"/>
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
    <table:table>
      <table:header>
        <table:cell>
          <bean:message bundle="InventoryResources" key="description.heading"/>
        </table:cell>
        <table:cell colspan="2">
          <bean:message bundle="InventoryResources" key="value.heading"/>
        </table:cell>
      </table:header>
      
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="NextTierApplicationResources" key="field.originnetworkelementid.description"/>
                              </table:cell>
              <table:cell colspan="2">
                                                                       <%= originNE.getName() %>
                                                </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="NextTierApplicationResources" key="field.nexttiernetworkelementid.description"/>
                              </table:cell>
              <table:cell colspan="2">
                 <select name="nexttiernetworkelementid">
					
					<% for( int i = 0 ; i < targetPEList.size() ; i++ )
					{
						LabelValueBean targetPEObject = targetPEList.get(i); %>
                                         
						<option value="<%= targetPEObject.getValue() %>"><%= targetPEObject.getLabel() %></option>
					<% } %>	
				</select>
                                                </table:cell>
            </table:row>
                              
			<html:hidden property="originnetworkelementid" value="<%= originNE.getNetworkelementid() %>"/>
                              
      
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
