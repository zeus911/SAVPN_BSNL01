<!------------------------------------------------------------------------
hp OpenView service activator
(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.sql.Connection,
		javax.sql.DataSource,
		com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
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
String datasource = (String) request.getParameter(PERouterConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
    String strcount = (String)request.getAttribute("count");
    //int count =Integer.parseInt(strcount);
    int count = Integer.valueOf(strcount).intValue();
    String originalSchPolName = (String) request.getAttribute("originalSchPolName");
    String originalLifecyclestate = (String) request.getAttribute("originalLifecyclestate");
    String originalState = (String) request.getAttribute("originalState");
    
String formAction = "/UpdateCommitPERouterAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("networkelementid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
        _location_ = "networkelementid";    }
%>

<html>
  <head>
    <title><bean:message bundle="PERouterApplicationResources" key="<%= PERouterConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
  function sendthis(focusthis) {
    
	var tier_val = window.document.PERouterForm.tier.value;
      window.document.PERouterForm.action = '/activator<%=moduleConfig%>/UpdateFormPERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
	if(tier_val == 1 || tier_val == 2 || tier_val == 3 ){
	}
	else{
	alert("Please enter the valid tier (1/2/3)!" );
	window.document.PERouterForm.tier.value="1";
	window.document.PERouterForm.tier.focus();
	}
      window.document.PERouterForm.submit();
    }

  function performCommit() {

      window.document.PERouterForm.action = '/activator<%=moduleConfig%>/UpdateCommitPERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&originalSchPolName=<%=originalSchPolName%>&originalLifecyclestate=<%=originalLifecyclestate%>&originalState=<%=originalState%>';
      window.document.PERouterForm.submit();
      return true;
  }
  
  function confirmSubmit() {
	var checkboxes=document.getElementsByName("nexttierid");
	var okay=false;
	
	// Check whether there is at least one next tier checked
	for(var i=0,l=checkboxes.length;i<l;i++)
	{
		if(checkboxes[i].checked)
		{
			okay=true;
		}
	}
	
	if(okay)
	{
	  performCommit();
	}
	else 
	{
	  var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="NextTierApplicationResources" key="jsp.select.one"/>');
	  alertMsg.setBounds(400, 120);
	  alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
	  alertMsg.show();
	}
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
com.hp.ov.activator.vpn.inventory.PERouter beanPERouter = (com.hp.ov.activator.vpn.inventory.PERouter) request.getAttribute(PERouterConstants.PEROUTER_BEAN);
if(beanPERouter==null)
   beanPERouter = (com.hp.ov.activator.vpn.inventory.PERouter) request.getSession().getAttribute(PERouterConstants.PEROUTER_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
PERouterForm form = (PERouterForm) request.getAttribute("PERouterForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                String NetworkElementID = beanPERouter.getNetworkelementid();
            
                String NetworkID = beanPERouter.getNetworkid();  
                
                String Name = beanPERouter.getName();
        
                String Description = beanPERouter.getDescription();
        
                String Location = beanPERouter.getLocation();
        
                String IP = beanPERouter.getIp();
        
                String management_IP = beanPERouter.getManagement_ip();
                
                String ManagementInterface = beanPERouter.getManagementinterface();
        
            
                            
            
                
              boolean PWPolicyEnabled = new Boolean(beanPERouter.getPwpolicyenabled()).booleanValue();
    
            
                            
            
                
                String PWPolicyEnabledC = beanPERouter.getPwpolicyenabledc();
        
            
                            
            
                
                String PWPolicy = beanPERouter.getPwpolicy();
        
          String PWPolicyLabel = (String) request.getAttribute(PERouterConstants.PWPOLICY_LABEL);
      ArrayList PWPolicyListOfValues = (ArrayList) request.getAttribute(PERouterConstants.PWPOLICY_LIST_OF_VALUES);
            
              boolean UsernameEnabled = new Boolean(beanPERouter.getUsernameenabled()).booleanValue();
    
                String Username = beanPERouter.getUsername();
        
                String Password = beanPERouter.getPassword();
        
                  String PasswordCurrent = "" + beanPERouter.getPasswordCurrent();
                
                String EnablePassword = beanPERouter.getEnablepassword();
        
            
                            
            
                  String EnablePasswordCurrent = "" + beanPERouter.getEnablePasswordCurrent();
                
                String Vendor = beanPERouter.getVendor();
        
          String VendorLabel = (String) request.getAttribute(PERouterConstants.VENDOR_LABEL);
      ArrayList VendorListOfValues = (ArrayList) request.getAttribute(PERouterConstants.VENDOR_LIST_OF_VALUES);
            
                String OSVersion = beanPERouter.getOsversion();
        
          String OSVersionLabel = (String) request.getAttribute(NetworkElementConstants.OSVERSION_LABEL);
      ArrayList OSVersionListOfValues = (ArrayList) request.getAttribute(NetworkElementConstants.OSVERSION_LIST_OF_VALUES);
                
	  //  String Uploadedversion = beanPERouter.getUploadedversion();
                String ElementType = beanPERouter.getElementtype();
        
          String ElementTypeLabel = (String) request.getAttribute(PERouterConstants.ELEMENTTYPE_LABEL);
            
                ArrayList ElementTypeListOfValues = (ArrayList) request.getAttribute(PERouterConstants.ELEMENTTYPE_LIST_OF_VALUES);            
                
                String SerialNumber = beanPERouter.getSerialnumber();
        
                String Role = beanPERouter.getRole();
        
                String AdminState = beanPERouter.getAdminstate();
        
                String LifeCycleState = beanPERouter.getLifecyclestate();
        
              boolean Backup = new Boolean(beanPERouter.getBackup()).booleanValue();
    
                String SchPolicyName = beanPERouter.getSchpolicyname();
        
              boolean SkipActivation = new Boolean(beanPERouter.getSkipactivation()).booleanValue();
    
                String ROCommunity = beanPERouter.getRocommunity();
        
                String RWCommunity = beanPERouter.getRwcommunity();
        
                String NNMi_UUId = beanPERouter.getNnmi_uuid();
        
                String NNMi_Id = beanPERouter.getNnmi_id();
        
              String NNMi_LastUpdate = (beanPERouter.getNnmi_lastupdate() == null) ? "" : beanPERouter.getNnmi_lastupdate();
      NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy");
                    String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
          sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
    
              String __count = "" + beanPERouter.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanPERouter.get__count()) : "";
            if( beanPERouter.get__count()==Integer.MIN_VALUE)
         __count = "";
boolean BGPDiscovery = new Boolean(beanPERouter.getBgpdiscovery()).booleanValue();
            
String Tier = beanPERouter.getTier();
                            
    //customization
SchedulingPolicy[] schpolicy = (SchedulingPolicy[])request.getAttribute("SCHPOLICY");
com.hp.ov.activator.cr.inventory.Location[] locations = (com.hp.ov.activator.cr.inventory.Location[])request.getAttribute("LOCATIONS");
String region = (String)request.getAttribute("REGION");
com.hp.ov.activator.cr.inventory.Network[] networks = (com.hp.ov.activator.cr.inventory.Network[])request.getAttribute("NETWORKS");   
            
ArrayList<LabelValueBean> targetPEList = new ArrayList<LabelValueBean>();
ArrayList<LabelValueBean> alreadyNextTierList = new ArrayList<LabelValueBean>();
                
// Get next tier router values (if any)
if (!("1".equals(Tier))) 
{
	Connection con = null;
          
	com.hp.ov.activator.cr.inventory.NetworkElement originNE = null;
	com.hp.ov.activator.vpn.inventory.PERouter originPE = null;
	com.hp.ov.activator.cr.inventory.Network originNetwork = null;
	com.hp.ov.activator.cr.inventory.NetworkElement[] targetNetworkElementList = null;
	com.hp.ov.activator.vpn.inventory.PERouter targetPE = null;
            
	try
	{
		DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
		if (ds != null)
		{
			con = ds.getConnection();
                            
			// Get Origin NE/PE
			originNE = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(con,NetworkElementID);
			originPE = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkelementid(con,NetworkElementID);

			// Find out target tier
			String targetTier = "1";
			if ("3".equals(Tier))
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
					else
					{
						LabelValueBean targetPEObject = new LabelValueBean(targetNetworkElementListObject.getName(),targetNetworkElementListObject.getNetworkelementid());
						alreadyNextTierList.add(targetPEObject);		
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
}
                
  %>
<center> 
<h2 style="width:100%; text-align:center;">
    <%if (Role.equals("P")) {%>
    <bean:message bundle="PERouterApplicationResources" key="jsp.Pupdate.title"/>
    <%} else {%>
  <bean:message bundle="PERouterApplicationResources" key="jsp.update.title"/>
    <% } %>
</h2> 
</center>

<H1>
        <html:errors bundle="PERouterApplicationResources" property="NetworkElementID"/>
        <html:errors bundle="PERouterApplicationResources" property="NetworkID"/>
        <html:errors bundle="PERouterApplicationResources" property="Name"/>
        <html:errors bundle="PERouterApplicationResources" property="Description"/>
        <html:errors bundle="PERouterApplicationResources" property="Location"/>
        <html:errors bundle="PERouterApplicationResources" property="IP"/>
        <html:errors bundle="PERouterApplicationResources" property="Management_IP"/>
        <html:errors bundle="PERouterApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="PERouterApplicationResources" property="PWPolicyEnabled"/>
        <html:errors bundle="PERouterApplicationResources" property="PWPolicyEnabledC"/>
        <html:errors bundle="PERouterApplicationResources" property="PWPolicy"/>
        <html:errors bundle="PERouterApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="PERouterApplicationResources" property="Username"/>
        <html:errors bundle="PERouterApplicationResources" property="Password"/>
        <html:errors bundle="PERouterApplicationResources" property="EnablePassword"/>
        <html:errors bundle="PERouterApplicationResources" property="Vendor"/>
        <html:errors bundle="PERouterApplicationResources" property="OSVersion"/>
        <html:errors bundle="PERouterApplicationResources" property="ElementType"/>
        <html:errors bundle="PERouterApplicationResources" property="SerialNumber"/>
        <html:errors bundle="PERouterApplicationResources" property="Role"/>
        <html:errors bundle="PERouterApplicationResources" property="State"/>
        <html:errors bundle="PERouterApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="PERouterApplicationResources" property="Backup"/>
        <html:errors bundle="PERouterApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="PERouterApplicationResources" property="SkipActivation"/>
        <html:errors bundle="PERouterApplicationResources" property="ROCommunity"/>
        <html:errors bundle="PERouterApplicationResources" property="RWCommunity"/>
        <html:errors bundle="PERouterApplicationResources" property="BGPDiscovery"/>
        <html:errors bundle="PERouterApplicationResources" property="Tier"/>
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
    allEvents = allEvents + "checkShowRulesUsername();";//default invoked when loading HTML
    function checkShowRulesUsername(){
          var UsernameEnabledPass = false ;
            if(document.getElementsByName("usernameenabled")[0].checked) {UsernameEnabledPass = true;}            
    var controlTr = document.getElementsByName("username")[0];
          if (true && UsernameEnabledPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('usernameenabled')[0],'click',checkShowRulesUsername);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                                                              document.getElementsByName("username")[0].parentNode.parentNode.style.display="none";
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
                <bean:message bundle="PERouterApplicationResources" key="field.networkid.alias"/>
                              </table:cell>
              <table:cell>
            <%
if(count>0)
{
%>
<%= NetworkID%>

<html:hidden property="networkid"
value="<%= NetworkID %>" />
<%}
else
{
%>
                                                                        <select name="networkid" onchange="sendthis('networkid');">
            <%     if (networks != null) {            
                        for (int i=0; networks != null && i < networks.length; i++) { %>
                          <option<%= networks[i].getNetworkid().equals (NetworkID) ? " selected": "" %> value="<%=  networks[i].getNetworkid() %>"><%= networks[i].getNetworkid() %></option>
            <%          }
                      }
            %>
                    </select>
                <%}%>

                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.networkid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.networkelementid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="networkelementid" value="<%= NetworkElementID %>"/>
                                                        <html:text disabled="true" property="networkelementid" size="24" value="<%= NetworkElementID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.networkelementid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.description.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkApplicationResources" key="field.region.alias"/>
                              </table:cell>
<input type="hidden"  name="region" value="<%= region %>"></td>
              <table:cell>
<%= region %>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkApplicationResources" key="field.region.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.location.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                <select name="location">
                <%if (locations != null) {
                    for (int i=0; locations != null && i < locations.length; i++) { %>
                  <option<%= locations[i].getName().equals (Location) ? " selected": "" %> value="<%=  locations[i].getName() %>"><%= locations[i].getName() %></option>
                    <%}
                }%>
                </select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.location.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.management_ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="management_ip" size="24" value="<%= management_IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.management_ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.managementinterface.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(ManagementInterface==null||ManagementInterface.trim().equals(""))
                           selValue = "${field.listOfValueSelected}";
                        else
                        selValue=ManagementInterface.toString();    
                          %>

                    <html:select  property="managementinterface" value="<%= selValue %>" >
                                            <html:option value="telnet" >telnet</html:option>
                                            <html:option value="ssh" >ssh</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.managementinterface.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.pwpolicyenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="pwpolicyenabled" value="true"/>
                  <html:hidden  property="pwpolicyenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.pwpolicyenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="pwpolicyenabledc" value="<%= PWPolicyEnabledC %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.pwpolicy.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="pwpolicy" value="<%= PWPolicy %>" >
                      <html:options collection="PWPolicyListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.pwpolicy.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.usernameenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="usernameenabled" value="true" onclick="sendthis('usernameenabled');"/>
                  <html:hidden  property="usernameenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.usernameenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
				                                            
        <%    if (UsernameEnabled) {%>
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.username.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="username" size="24" value="<%= Username %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.username.description"/>
                                                                        </table:cell>
            </table:row>
                                
        <%    } %>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.password.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="password" size="24" value="<%= Password %>"/>
                                          <html:hidden property="passwordcurrent" value="<%= PasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.password.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.enablepassword.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="enablepassword" size="24" value="<%= EnablePassword %>"/>
                                          <html:hidden property="enablepasswordcurrent" value="<%= EnablePasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.enablepassword.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.vendor.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="vendor" value="<%= Vendor %>" onchange="sendthis('vendor');">
                      <html:options collection="VendorListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.vendor.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.osversion.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="osversion" value="<%= OSVersion %>" >
                      <html:options collection="OSVersionListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.osversion.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.elementtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="elementtype" value="<%= ElementType %>" >
                      <html:options collection="ElementTypeListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.elementtype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.bgpdiscovery.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="bgpdiscovery" value="true"/>
                  <html:hidden  property="bgpdiscovery" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.bgpdiscovery.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.tier.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="tier" size="24" value="<%= Tier %>" onchange="sendthis('tier')"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.tier.description"/>
                                                                        </table:cell>
            </table:row>
                                
			<% if (!("1".equals(Tier))) { %>
				<table:row>
					<table:cell>  
						<bean:message bundle="NextTierApplicationResources" key="jsp.view.nexttiers"/>
                    </table:cell>
					<table:cell>  
						<div style="height:100; overflow-y: scroll;">
							<table:table>
								<% for( int i = 0 ; i < alreadyNextTierList.size() ; i++ ) 
								{
									LabelValueBean alreadyNextTierObject = alreadyNextTierList.get(i);
									
									String nextTierId = alreadyNextTierObject.getValue(); 
									String nextTierName = alreadyNextTierObject.getLabel(); %>
									
									<table:row>
										<table:cell>  
											<input type="checkbox" name="nexttierid" value="<%=nextTierId%>" checked /><%=nextTierName%>
										</table:cell>
									</table:row>
									
								<% } %>
								<% for( int i = 0 ; i < targetPEList.size() ; i++ ) 
								{
									LabelValueBean targetPEObject = targetPEList.get(i);
									
									String nextTierId = targetPEObject.getValue(); 
									String nextTierName = targetPEObject.getLabel();  %>
									
									<table:row>
										<table:cell>  
											<input type="checkbox" name="nexttierid" value="<%=nextTierId%>"/><%=nextTierName%>
										</table:cell>
									</table:row>
									
								<% } %>
							</table:table>
						</div>
                    </table:cell>
					<table:cell>  
						<bean:message bundle="NextTierApplicationResources" key="jsp.view.nexttiers.description"/>
                    </table:cell>
				</table:row>
			<% } %>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.serialnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serialnumber" size="24" value="<%= SerialNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.serialnumber.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.role.alias"/>
                              </table:cell>
              <table:cell>
<%= Role %>
<input type=hidden name="role" value="<%= Role %>">
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.role.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.adminstate.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(AdminState==null||AdminState.trim().equals(""))
                           selValue="Up";
                        else
                        selValue=AdminState.toString();    
                          %>

                    <html:select  property="adminstate" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                            <html:option value="Reserved" >Reserved</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.adminstate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.lifecyclestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(LifeCycleState==null||LifeCycleState.trim().equals(""))

                        selValue = "Ready";
                        else
                        selValue=LifeCycleState.toString();    
                          %>
                    <html:select  property="lifecyclestate" value="<%= selValue %>" >
                                            <html:option value="Planned" >Planned</html:option>
                                            <html:option value="Accessible" >Accessible</html:option>
											<html:option value="Preconfigured">Preconfigured</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.lifecyclestate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.backup.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="backup" value="true" onclick="sendthis('backup');"/>
                  <html:hidden  property="backup" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.backup.description"/>
                                                                        </table:cell>
            </table:row>
                                
        <%if (Backup){
                %>
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.schpolicyname.alias"/>
                              </table:cell>
              <table:cell>
                <select name="schpolicyname">
                  <%if (schpolicy != null) {
                    for (int i=0; i < schpolicy.length; i++) { %>
                  <option<%=schpolicy[i].getSchedulingpolicyname().equals(SchPolicyName) ? " selected": "" %> value="<%=schpolicy[i].getSchedulingpolicyname()%>"><%=schpolicy[i].getSchedulingpolicyname()%></option>
                    <%}
                  }%>
                </select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.schpolicyname.description"/>
                                                                        </table:cell>
            </table:row>
            <%} else { %>
                    <input type="hidden" name="schpolicyname" value="-none-">
                    <table:row>
                <table:cell>
                    <bean:message bundle="PERouterApplicationResources"
                        key="field.schpolicyname.alias" />
                </table:cell>
                <table:cell>
                    -none-
                </table:cell>
                <table:cell>
                    <bean:message bundle="PERouterApplicationResources"
                        key="field.schpolicyname.description" />
                </table:cell>
            </table:row>
        <%}%>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.skipactivation.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="skipactivation" value="true"/>
                  <html:hidden  property="skipactivation" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.skipactivation.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.rocommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rocommunity" size="24" value="<%= ROCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.rocommunity.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PERouterApplicationResources" key="field.rwcommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PERouterApplicationResources" key="field.rwcommunity.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_uuid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_uuid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_id.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_lastupdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_lastupdate.description"/>
                <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
            </table:row>
                                
        <table:row>
            <table:cell>
                <bean:message bundle="PERouterApplicationResources"
                    key="field.count.alias" />
            </table:cell>
            <table:cell>
                <html:text disabled="true" property="__count" size="24"
                    value="<%= __count %>" />
            </table:cell>
            <table:cell>
                <bean:message bundle="PERouterApplicationResources"
                    key="field.count.description" />
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
		<% if ("1".equals(Tier)) { %>
			<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="return performCommit();">&nbsp;
		<% } else { %>
			<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="confirmSubmit();">&nbsp;
		<% } %>
        <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>

  </html:form>

  </body>

</html>
