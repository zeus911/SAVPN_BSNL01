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
String datasource = (String) request.getParameter(NetworkElementConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitNetworkElementAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
              _location_ = "networkid";
                                                                                                                                                                                                                        }

%>

<html>
  <head>
    <title><bean:message bundle="NetworkElementApplicationResources" key="<%= NetworkElementConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.NetworkElementForm.action = '/activator<%=moduleConfig%>/UpdateFormNetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.NetworkElementForm.submit();
    }
    function performCommit()
    {
      window.document.NetworkElementForm.action = '/activator<%=moduleConfig%>/UpdateCommitNetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.NetworkElementForm.submit();
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
com.hp.ov.activator.vpn.inventory.NetworkElement beanNetworkElement = (com.hp.ov.activator.vpn.inventory.NetworkElement) request.getAttribute(NetworkElementConstants.NETWORKELEMENT_BEAN);
if(beanNetworkElement==null)
   beanNetworkElement = (com.hp.ov.activator.vpn.inventory.NetworkElement) request.getSession().getAttribute(NetworkElementConstants.NETWORKELEMENT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
NetworkElementForm form = (NetworkElementForm) request.getAttribute("NetworkElementForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String NetworkId = beanNetworkElement.getNetworkid();
        
          String NetworkIdLabel = (String) request.getAttribute(NetworkElementConstants.NETWORKID_LABEL);
      ArrayList NetworkIdListOfValues = (ArrayList) request.getAttribute(NetworkElementConstants.NETWORKID_LIST_OF_VALUES);
            
                            
            
                
                String NetworkElementId = beanNetworkElement.getNetworkelementid();
        
            
                            
            
                
                String Name = beanNetworkElement.getName();
        
            
                            
            
                
                String Description = beanNetworkElement.getDescription();
        
            
                            
            
                
                String Region = beanNetworkElement.getRegion();
        
            
                            
            
                
                String RegionNE = beanNetworkElement.getRegionne();
        
            
                            
            
                
                String Location = beanNetworkElement.getLocation();
        
          String LocationLabel = (String) request.getAttribute(NetworkElementConstants.LOCATION_LABEL);
      ArrayList LocationListOfValues = (ArrayList) request.getAttribute(NetworkElementConstants.LOCATION_LIST_OF_VALUES);
            
                            
            
                
                String IP = beanNetworkElement.getIp();
        
            
                            
            
                
                String Management_IP = beanNetworkElement.getManagement_ip();
        
            
                            
            
                
                String ManagementInterface = beanNetworkElement.getManagementinterface();
        
            
                            
            
                
              boolean PWPolicyEnabled = new Boolean(beanNetworkElement.getPwpolicyenabled()).booleanValue();
    
            
                            
            
                
                String PWPolicyEnabledC = beanNetworkElement.getPwpolicyenabledc();
        
            
                            
            
                
                String PWPolicy = beanNetworkElement.getPwpolicy();
        
          String PWPolicyLabel = (String) request.getAttribute(NetworkElementConstants.PWPOLICY_LABEL);
      ArrayList PWPolicyListOfValues = (ArrayList) request.getAttribute(NetworkElementConstants.PWPOLICY_LIST_OF_VALUES);
            
                            
            
                
              boolean UsernameEnabled = new Boolean(beanNetworkElement.getUsernameenabled()).booleanValue();
    
            
                            
            
                
                String UsernameEnabledC = beanNetworkElement.getUsernameenabledc();
        
            
                            
            
                
                String Username = beanNetworkElement.getUsername();
        
            
                            
            
                
                String Password = beanNetworkElement.getPassword();
        
            
                            
            
                  String PasswordCurrent = "" + beanNetworkElement.getPasswordCurrent();
                
                String EnablePassword = beanNetworkElement.getEnablepassword();
        
            
                            
            
                  String EnablePasswordCurrent = "" + beanNetworkElement.getEnablePasswordCurrent();
                
                String Vendor = beanNetworkElement.getVendor();
        
          String VendorLabel = (String) request.getAttribute(NetworkElementConstants.VENDOR_LABEL);
      ArrayList VendorListOfValues = (ArrayList) request.getAttribute(NetworkElementConstants.VENDOR_LIST_OF_VALUES);
            
                            
            
                
                String OSVersion = beanNetworkElement.getOsversion();
        
          String OSVersionLabel = (String) request.getAttribute(NetworkElementConstants.OSVERSION_LABEL);
      ArrayList OSVersionListOfValues = (ArrayList) request.getAttribute(NetworkElementConstants.OSVERSION_LIST_OF_VALUES);
            
                            
            
                
                String ElementType = beanNetworkElement.getElementtype();
        
          String ElementTypeLabel = (String) request.getAttribute(NetworkElementConstants.ELEMENTTYPE_LABEL);
      ArrayList ElementTypeListOfValues = (ArrayList) request.getAttribute(NetworkElementConstants.ELEMENTTYPE_LIST_OF_VALUES);
            
                            
            
                
                String SerialNumber = beanNetworkElement.getSerialnumber();
        
            
                            
            
                
                String Role = beanNetworkElement.getRole();
        
            
                            
            
                
                String AdminState = beanNetworkElement.getAdminstate();
        
            
                            
            
                
                String LifeCycleState = beanNetworkElement.getLifecyclestate();
        
            
                            
            
                
                String ROCommunity = beanNetworkElement.getRocommunity();
        
            
                            
            
                
                String RWCommunity = beanNetworkElement.getRwcommunity();
        
            
                            
            
                
                String NNMi_UUId = beanNetworkElement.getNnmi_uuid();
        
            
                            
            
                
                String NNMi_Id = beanNetworkElement.getNnmi_id();
        
            
                            
            
                
              String NNMi_LastUpdate = (beanNetworkElement.getNnmi_lastupdate() == null) ? "" : beanNetworkElement.getNnmi_lastupdate();
      NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                    String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
          sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
    
            
                            
            
                
                String EffectivePassword = beanNetworkElement.getEffectivepassword();
        
            
                            
            
                
              boolean EffectiveUsernameEnabled = new Boolean(beanNetworkElement.getEffectiveusernameenabled()).booleanValue();
    
            
                            
            
                
                String EffectiveUsername = beanNetworkElement.getEffectiveusername();
        
            
                            
            
                
                String EffectiveEnablePassword = beanNetworkElement.getEffectiveenablepassword();
        
            
                            
            
                
              String __count = "" + beanNetworkElement.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanNetworkElement.get__count()) : "";
          
            
            if( beanNetworkElement.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="NetworkElementApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="NetworkElementApplicationResources" property="NetworkId"/>
        <html:errors bundle="NetworkElementApplicationResources" property="NetworkElementId"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Name"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Description"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Region"/>
        <html:errors bundle="NetworkElementApplicationResources" property="RegionNE"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Location"/>
        <html:errors bundle="NetworkElementApplicationResources" property="IP"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Management_IP"/>
        <html:errors bundle="NetworkElementApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="NetworkElementApplicationResources" property="PWPolicyEnabled"/>
        <html:errors bundle="NetworkElementApplicationResources" property="PWPolicyEnabledC"/>
        <html:errors bundle="NetworkElementApplicationResources" property="PWPolicy"/>
        <html:errors bundle="NetworkElementApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="NetworkElementApplicationResources" property="UsernameEnabledC"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Username"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Password"/>
        <html:errors bundle="NetworkElementApplicationResources" property="EnablePassword"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Vendor"/>
        <html:errors bundle="NetworkElementApplicationResources" property="OSVersion"/>
        <html:errors bundle="NetworkElementApplicationResources" property="ElementType"/>
        <html:errors bundle="NetworkElementApplicationResources" property="SerialNumber"/>
        <html:errors bundle="NetworkElementApplicationResources" property="Role"/>
        <html:errors bundle="NetworkElementApplicationResources" property="AdminState"/>
        <html:errors bundle="NetworkElementApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="NetworkElementApplicationResources" property="ROCommunity"/>
        <html:errors bundle="NetworkElementApplicationResources" property="RWCommunity"/>
        <html:errors bundle="NetworkElementApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="NetworkElementApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="NetworkElementApplicationResources" property="NNMi_LastUpdate"/>
        <html:errors bundle="NetworkElementApplicationResources" property="EffectivePassword"/>
        <html:errors bundle="NetworkElementApplicationResources" property="EffectiveUsernameEnabled"/>
        <html:errors bundle="NetworkElementApplicationResources" property="EffectiveUsername"/>
        <html:errors bundle="NetworkElementApplicationResources" property="EffectiveEnablePassword"/>
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
                <bean:message bundle="NetworkElementApplicationResources" key="field.networkid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="networkid" value="<%= NetworkId %>" onchange="sendthis('networkid');">
                      <html:options collection="NetworkIdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.networkid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.networkelementid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="networkelementid" value="<%= NetworkElementId %>"/>
                                                        <html:text disabled="true" property="networkelementid" size="24" value="<%= NetworkElementId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.networkelementid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.description.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="region" value="<%= Region %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.regionne.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="regionne" size="24" value="<%= RegionNE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.regionne.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.location.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="location" value="<%= Location %>" >
                      <html:options collection="LocationListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.location.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.management_ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="management_ip" size="24" value="<%= Management_IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.management_ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.managementinterface.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(ManagementInterface==null||ManagementInterface.trim().equals(""))
                           selValue="telnet";
                        else
                        selValue=ManagementInterface.toString();    
                          %>

                    <html:select  property="managementinterface" value="<%= selValue %>" >
                                            <html:option value="telnet" >telnet</html:option>
                                            <html:option value="ssh" >ssh</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.managementinterface.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicyenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="pwpolicyenabled" value="true"/>
                  <html:hidden  property="pwpolicyenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicyenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="pwpolicyenabledc" value="<%= PWPolicyEnabledC %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicy.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="pwpolicy" value="<%= PWPolicy %>" >
                      <html:options collection="PWPolicyListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicy.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.usernameenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="usernameenabled" value="true"/>
                  <html:hidden  property="usernameenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.usernameenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="usernameenabledc" value="<%= UsernameEnabledC %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.username.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="username" size="24" value="<%= Username %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.username.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.password.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="password" size="24" value="<%= Password %>"/>
                                          <html:hidden property="passwordcurrent" value="<%= PasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.password.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.enablepassword.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="enablepassword" size="24" value="<%= EnablePassword %>"/>
                                          <html:hidden property="enablepasswordcurrent" value="<%= EnablePasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.enablepassword.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.vendor.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="vendor" value="<%= Vendor %>" onchange="sendthis('vendor');">
                      <html:options collection="VendorListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.vendor.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.osversion.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="osversion" value="<%= OSVersion %>" >
                      <html:options collection="OSVersionListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.osversion.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.elementtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="elementtype" value="<%= ElementType %>" >
                      <html:options collection="ElementTypeListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.elementtype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.serialnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serialnumber" size="24" value="<%= SerialNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.serialnumber.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.role.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(Role==null||Role.trim().equals(""))
                           selValue="PE";
                        else
                        selValue=Role.toString();    
                          %>

                    <html:select  property="role" value="<%= selValue %>" >
                                            <html:option value="PE" >PE</html:option>
                                            <html:option value="CE" >CE</html:option>
                                            <html:option value="P" >P</html:option>
                                            <html:option value="AccessSwitch" >AccessSwitch</html:option>
                                            <html:option value="AggregationSwitch" >AggregationSwitch</html:option>
                                            <html:option value="ASBR" >ASBR</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.role.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.adminstate.alias"/>
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
                <bean:message bundle="NetworkElementApplicationResources" key="field.adminstate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.lifecyclestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(LifeCycleState==null||LifeCycleState.trim().equals(""))
                           selValue="Planned";
                        else
                        selValue=LifeCycleState.toString();    
                          %>

                    <html:select  property="lifecyclestate" value="<%= selValue %>" >
                                            <html:option value="Planned" >Planned</html:option>
                                            <html:option value="Preconfigured" >Preconfigured</html:option>
                                            <html:option value="Accessible" >Accessible</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.lifecyclestate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.rocommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rocommunity" size="24" value="<%= ROCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.rocommunity.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.rwcommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.rwcommunity.description"/>
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
                                
                                                    <html:hidden property="effectivepassword" value="<%= EffectivePassword %>"/>            
				                                            
                                                    <input type="hidden" name="effectiveusernameenabled" value="<%= EffectiveUsernameEnabled %>"/>  
                                            
                                                    <html:hidden property="effectiveusername" value="<%= EffectiveUsername %>"/>            
				                                            
                                                    <html:hidden property="effectiveenablepassword" value="<%= EffectiveEnablePassword %>"/>            
				                                            
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="NetworkElementApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="NetworkElementApplicationResources" key="field.__count.description"/>
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
