<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
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
String datasource = (String) request.getParameter(CERouterConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitCERouterAction.do?datasource=" + datasource + "&rimid=" + rimid;

String originalSchPolName = (String) request.getAttribute("originalSchPolName");
String originalLifecyclestate = (String) request.getAttribute("originalLifecyclestate");
String originalState = (String) request.getAttribute("originalState");


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
              _location_ = "networkelementid";
                                                                                                                                                                                                                                                                        }


%>


<html>
  <head>
    <title><bean:message bundle="CERouterApplicationResources" key="<%= CERouterConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.CERouterForm.action = '/activator<%=moduleConfig%>/UpdateFormCERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.CERouterForm.submit();
    }
    function performCommit()
    {
      window.document.CERouterForm.action = '/activator<%=moduleConfig%>/UpdateCommitCERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&originalSchPolName=<%=originalSchPolName%>&originalLifecyclestate=<%=originalLifecyclestate%>&originalState=<%=originalState%>';
      window.document.CERouterForm.submit();
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
com.hp.ov.activator.vpn.inventory.CERouter beanCERouter = (com.hp.ov.activator.vpn.inventory.CERouter) request.getAttribute(CERouterConstants.CEROUTER_BEAN);
if(beanCERouter==null)
   beanCERouter = (com.hp.ov.activator.vpn.inventory.CERouter) request.getSession().getAttribute(CERouterConstants.CEROUTER_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
CERouterForm form = (CERouterForm) request.getAttribute("CERouterForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String NetworkId = beanCERouter.getNetworkid();
        
          String NetworkIdLabel = (String) request.getAttribute(CERouterConstants.NETWORKID_LABEL);
      ArrayList NetworkIdListOfValues = (ArrayList) request.getAttribute(CERouterConstants.NETWORKID_LIST_OF_VALUES);
            
                            
            
                
                String NetworkElementId = beanCERouter.getNetworkelementid();
        
            
                            
            
                
                String Name = beanCERouter.getName();
        
            
                            
            
                
                String Description = beanCERouter.getDescription();
        
            
                            
                String Location = beanCERouter.getLocation();
        
          String LocationLabel = (String) request.getAttribute(CERouterConstants.LOCATION_LABEL);
      ArrayList LocationListOfValues = (ArrayList) request.getAttribute(CERouterConstants.LOCATION_LIST_OF_VALUES);
            
                            
            
                
                String IP = beanCERouter.getIp();
        
            
                            
            
                
                String Management_IP = beanCERouter.getManagement_ip();
        
            
                            
            
                
                String ManagementInterface = beanCERouter.getManagementinterface();
        
            
                            
            
                
              boolean PWPolicyEnabled = new Boolean(beanCERouter.getPwpolicyenabled()).booleanValue();
    
            
                            
            
                
                String PWPolicyEnabledC = beanCERouter.getPwpolicyenabledc();
        
            
                            
            
                
                String PWPolicy = beanCERouter.getPwpolicy();
        
          String PWPolicyLabel = (String) request.getAttribute(CERouterConstants.PWPOLICY_LABEL);
      ArrayList PWPolicyListOfValues = (ArrayList) request.getAttribute(CERouterConstants.PWPOLICY_LIST_OF_VALUES);
            
                            
            
                
              boolean UsernameEnabled = new Boolean(beanCERouter.getUsernameenabled()).booleanValue();
    
            
                            
            
                
                String Username = beanCERouter.getUsername();
        
            
                            
            
                
                String Password = beanCERouter.getPassword();
        
            
                            
            
                  String PasswordCurrent = "" + beanCERouter.getPasswordCurrent();
                
                String EnablePassword = beanCERouter.getEnablepassword();
        
            
                            
            
                  String EnablePasswordCurrent = "" + beanCERouter.getEnablePasswordCurrent();
                
                String Vendor = beanCERouter.getVendor();
        
          String VendorLabel = (String) request.getAttribute(CERouterConstants.VENDOR_LABEL);
      ArrayList VendorListOfValues = (ArrayList) request.getAttribute(CERouterConstants.VENDOR_LIST_OF_VALUES);
            
                            
            
                
                String OSVersion = beanCERouter.getOsversion();
        
          String OSVersionLabel = (String) request.getAttribute(CERouterConstants.OSVERSION_LABEL);
      ArrayList OSVersionListOfValues = (ArrayList) request.getAttribute(CERouterConstants.OSVERSION_LIST_OF_VALUES);
            
                            
            
                
                String ElementType = beanCERouter.getElementtype();
        
          String ElementTypeLabel = (String) request.getAttribute(CERouterConstants.ELEMENTTYPE_LABEL);
      ArrayList ElementTypeListOfValues = (ArrayList) request.getAttribute(CERouterConstants.ELEMENTTYPE_LIST_OF_VALUES);
            
                            
            
                
                String SerialNumber = beanCERouter.getSerialnumber();
        
            
                            
            
                
                String Role = beanCERouter.getRole();
        
            
                            
            
                
                String AdminState = beanCERouter.getAdminstate();
        
            
                            
            
                
                String LifeCycleState = beanCERouter.getLifecyclestate();
        
            
                            
            
                
              boolean Backup = new Boolean(beanCERouter.getBackup()).booleanValue();
    
            
                            
            
                String SchPolicyName = beanCERouter.getSchpolicyname();
        
          String SchPolicyNameLabel = (String) request.getAttribute(CERouterConstants.SCHPOLICYNAME_LABEL);
      ArrayList SchPolicyNameListOfValues = (ArrayList) request.getAttribute(CERouterConstants.SCHPOLICYNAME_LIST_OF_VALUES);
            
                            
            
                
              boolean SkipActivation = new Boolean(beanCERouter.getSkipactivation()).booleanValue();
    
            
                            
            
                
                String ROCommunity = beanCERouter.getRocommunity();
        
            
                            
            
                
                String RWCommunity = beanCERouter.getRwcommunity();
        
            
                            
            
                
                String Managed = beanCERouter.getManaged();
        
            
                            
            
                
                String ManagedC = beanCERouter.getManagedc();
        
            
                            
            
                
                String CE_LoopbackPool = beanCERouter.getCe_loopbackpool();
        
            
                            
            
                
                String NNMi_UUId = beanCERouter.getNnmi_uuid();
        
            
                            
            
                
                String NNMi_Id = beanCERouter.getNnmi_id();
        
            
                            
            
                
              String NNMi_LastUpdate = (beanCERouter.getNnmi_lastupdate() == null) ? "" : beanCERouter.getNnmi_lastupdate();
      NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                    String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
          sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
    
            SchedulingPolicy[] schpolicy = (SchedulingPolicy[])request.getAttribute("SCHPOLICY");
			com.hp.ov.activator.cr.inventory.Location[] locations = (com.hp.ov.activator.cr.inventory.Location[])request.getAttribute("LOCATIONS");
			String region = (String)request.getAttribute("REGION");
			com.hp.ov.activator.cr.inventory.Network[] networks = (com.hp.ov.activator.cr.inventory.Network[])request.getAttribute("NETWORKS");  
			
			String disable = "";
            if("Ready".equals(LifeCycleState))
				disable = "disabled";
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="CERouterApplicationResources" key="jsp.update.title"/>
</h2> 

<H1>
      <html:errors bundle="CERouterApplicationResources" property="NetworkId"/>
        <html:errors bundle="CERouterApplicationResources" property="NetworkElementId"/>
        <html:errors bundle="CERouterApplicationResources" property="Name"/>
        <html:errors bundle="CERouterApplicationResources" property="Description"/>
        <html:errors bundle="CERouterApplicationResources" property="Location"/>
        <html:errors bundle="CERouterApplicationResources" property="IP"/>
        <html:errors bundle="CERouterApplicationResources" property="Management_IP"/>
        <html:errors bundle="CERouterApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="CERouterApplicationResources" property="PWPolicyEnabled"/>
        <html:errors bundle="CERouterApplicationResources" property="PWPolicyEnabledC"/>
        <html:errors bundle="CERouterApplicationResources" property="PWPolicy"/>
        <html:errors bundle="CERouterApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="CERouterApplicationResources" property="Username"/>
        <html:errors bundle="CERouterApplicationResources" property="Password"/>
        <html:errors bundle="CERouterApplicationResources" property="EnablePassword"/>
        <html:errors bundle="CERouterApplicationResources" property="Vendor"/>
        <html:errors bundle="CERouterApplicationResources" property="OSVersion"/>
        <html:errors bundle="CERouterApplicationResources" property="ElementType"/>
        <html:errors bundle="CERouterApplicationResources" property="SerialNumber"/>
        <html:errors bundle="CERouterApplicationResources" property="Role"/>
        <html:errors bundle="CERouterApplicationResources" property="AdminState"/>
        <html:errors bundle="CERouterApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="CERouterApplicationResources" property="Backup"/>
        <html:errors bundle="CERouterApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="CERouterApplicationResources" property="SkipActivation"/>
        <html:errors bundle="CERouterApplicationResources" property="ROCommunity"/>
        <html:errors bundle="CERouterApplicationResources" property="RWCommunity"/>
        <html:errors bundle="CERouterApplicationResources" property="Managed"/>
        <html:errors bundle="CERouterApplicationResources" property="ManagedC"/>
        <html:errors bundle="CERouterApplicationResources" property="CE_LoopbackPool"/>
        <html:errors bundle="CERouterApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="CERouterApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="CERouterApplicationResources" property="NNMi_LastUpdate"/>
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
    allEvents = allEvents + "checkShowRulesCE_LoopbackPool();";//default invoked when loading HTML
    function checkShowRulesCE_LoopbackPool(){
          var CE_LoopbackPoolPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("ce_loopbackpool")[0].value)) {CE_LoopbackPoolPass = true;}
            
    var controlTr = document.getElementsByName("ce_loopbackpool")[0];
          if (true && CE_LoopbackPoolPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('ce_loopbackpool')[0],'keyup',checkShowRulesCE_LoopbackPool);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                                                              document.getElementsByName("username")[0].parentNode.parentNode.style.display="none";
                                                                                                                                    document.getElementsByName("ce_loopbackpool")[0].parentNode.parentNode.style.display="none";
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
                <bean:message bundle="CERouterApplicationResources" key="field.networkid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <select name="networkid" <%=disable%> onchange="sendthis('networkid');">
            <%     if (networks != null) {            
                        for (int i=0; networks != null && i < networks.length; i++) { %>
                          <option<%= networks[i].getNetworkid().equals (NetworkId) ? " selected": "" %> value="<%=  networks[i].getNetworkid() %>"><%= networks[i].getNetworkid() %></option>
            <%          }
                      }
            %>
                    </select>
                                                </table:cell>
			 <html:hidden property="networkid" value="<%= NetworkId %>"/>						
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.networkid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.networkelementid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="networkelementid" value="<%= NetworkElementId %>"/>
                                                        <html:text disabled="true" property="networkelementid" size="24" value="<%= NetworkElementId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.networkelementid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.description.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="region" value="<%= region %>"/>            
				                                            
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
                <bean:message bundle="CERouterApplicationResources" key="field.location.alias"/>
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
                <bean:message bundle="CERouterApplicationResources" key="field.location.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.management_ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="management_ip" size="24" value="<%= Management_IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.management_ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.managementinterface.alias"/>
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
                <bean:message bundle="CERouterApplicationResources" key="field.managementinterface.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.pwpolicyenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="pwpolicyenabled" value="true"/>
                  <html:hidden  property="pwpolicyenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.pwpolicyenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="pwpolicyenabledc" value="<%= PWPolicyEnabledC %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.pwpolicy.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="pwpolicy" value="<%= PWPolicy %>" >
                      <html:options collection="PWPolicyListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.pwpolicy.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.usernameenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="usernameenabled" value="true" onclick="sendthis('usernameenabled');"/>
                  <html:hidden  property="usernameenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.usernameenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
				                                            
  <%   if (UsernameEnabled) {%>            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.username.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="username" size="24" value="<%= Username %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.username.description"/>
                                                                        </table:cell>
            </table:row>
                                
            <%   } %>

                                                 
  
        
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.password.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="password" size="24" value="<%= Password %>"/>
                                          <html:hidden property="passwordcurrent" value="<%= PasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.password.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.enablepassword.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="enablepassword" size="24" value="<%= EnablePassword %>"/>
                                          <html:hidden property="enablepasswordcurrent" value="<%= EnablePasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.enablepassword.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.vendor.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="vendor" value="<%= Vendor %>" onchange="sendthis('vendor');">
                      <html:options collection="VendorListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.vendor.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.osversion.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="osversion" value="<%= OSVersion %>" >
                      <html:options collection="OSVersionListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.osversion.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.elementtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="elementtype" value="<%= ElementType %>" >
                      <html:options collection="ElementTypeListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.elementtype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.serialnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serialnumber" size="24" value="<%= SerialNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.serialnumber.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.role.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="role" value="<%= Role %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(Role==null||Role.trim().equals(""))
                           selValue="CE";
                        else
                        selValue=Role.toString();    
                          %>

                    <html:select disabled="true" property="role" value="<%= selValue %>" >
                                            <html:option value="CE" >CE</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.role.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.adminstate.alias"/>
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
                <bean:message bundle="CERouterApplicationResources" key="field.adminstate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.lifecyclestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
						if(LifeCycleState == null){
							LifeCycleState="Planned";
						}
                        selValue=LifeCycleState.toString();    
                          %>

                    <select   name="lifecyclestate" <%=disable%> value="<%= selValue %>">
					<%						if("Ready".equals(selValue)){%>
											<option value="Planned" >Ready</option>
											<%}
					%>
                                            <option value="Planned" >Planned</option>
                                            <option value="Preconfigured" >Preconfigured</option>
                                            <option value="Accessible" >Accessible</option>
                                          </select>
                                                </table:cell>
              <table:cell>
			    <html:hidden property="lifecyclestate"  value="<%= LifeCycleState %>"/>						
                <bean:message bundle="CERouterApplicationResources" key="field.lifecyclestate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.backup.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="backup" value="true" onclick="sendthis('backup');"/>
                  <html:hidden  property="backup" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.backup.description"/>
                                                                        </table:cell>
            </table:row>
                                
        <%if (Backup){
                %>
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.schpolicyname.alias"/>
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
                <bean:message bundle="CERouterApplicationResources" key="field.schpolicyname.description"/>
                                                                        </table:cell>
            </table:row>
			<%} else { %>
                    <input type="hidden" name="schpolicyname" value="-none-">
                    <table:row>
                <table:cell>
                    <bean:message bundle="CERouterApplicationResources"
                        key="field.schpolicyname.alias" />
                </table:cell>
                <table:cell>
                    -none-
                                                </table:cell>
              <table:cell>
                    <bean:message bundle="CERouterApplicationResources"
                        key="field.schpolicyname.description" />
                                                                        </table:cell>
            </table:row>
        <%}%>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.skipactivation.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="skipactivation" value="true"/>
                  <html:hidden  property="skipactivation" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.skipactivation.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.rocommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rocommunity" size="24" value="<%= ROCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.rocommunity.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.rwcommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.rwcommunity.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.managed.alias"/>
                              </table:cell>
              <table:cell>
                    <input type="checkbox" name="managed" value="true" disabled checked>
                    <input type="hidden" name="managed" value="true">          

                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.managed.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="managedc" value="<%= ManagedC %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.ce_loopbackpool.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce_loopbackpool" size="24" value="<%= CE_LoopbackPool %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.ce_loopbackpool.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.nnmi_uuid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.nnmi_uuid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.nnmi_id.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="CERouterApplicationResources" key="field.nnmi_lastupdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="CERouterApplicationResources" key="field.nnmi_lastupdate.description"/>
                <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
            </table:row>
                                
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
      
      <table:row>
        <table:cell colspan="3" align="center">
        <br>
        </table:cell>
      </table:row>
      <table:row>
        <table:cell colspan="3" align="center">
        <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick=" return performCommit();">&nbsp;
        <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>

  </html:form>

  </body>

</html>
