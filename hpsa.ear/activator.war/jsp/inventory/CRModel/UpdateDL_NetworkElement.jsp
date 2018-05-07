<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnmi.dl.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
String datasource = (String) request.getParameter(DL_NetworkElementConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_NetworkElementAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("nnmi_id") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "network";
                                                                                                                                                                        }

%>

<html>
  <head>
    <title><bean:message bundle="DL_NetworkElementApplicationResources" key="<%= DL_NetworkElementConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.DL_NetworkElementForm.action = '/activator<%=moduleConfig%>/UpdateFormDL_NetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.DL_NetworkElementForm.submit();
    }
    function performCommit()
    {
      window.document.DL_NetworkElementForm.action = '/activator<%=moduleConfig%>/UpdateCommitDL_NetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.DL_NetworkElementForm.submit();
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
com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement beanDL_NetworkElement = (com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement) request.getAttribute(DL_NetworkElementConstants.DL_NETWORKELEMENT_BEAN);
if(beanDL_NetworkElement==null)
   beanDL_NetworkElement = (com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement) request.getSession().getAttribute(DL_NetworkElementConstants.DL_NETWORKELEMENT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_NetworkElementForm form = (DL_NetworkElementForm) request.getAttribute("DL_NetworkElementForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String NNMi_Id = beanDL_NetworkElement.getNnmi_id();
        
            
                            
            
                
                String Network = beanDL_NetworkElement.getNetwork();
        
          String NetworkLabel = (String) request.getAttribute(DL_NetworkElementConstants.NETWORK_LABEL);
      ArrayList NetworkListOfValues = (ArrayList) request.getAttribute(DL_NetworkElementConstants.NETWORK_LIST_OF_VALUES);
            
                            
            
                
                String Name = beanDL_NetworkElement.getName();
        
            
                            
            
                
                String Description = beanDL_NetworkElement.getDescription();
        
            
                            
            
                
                String Location = beanDL_NetworkElement.getLocation();
        
            
                            
            
                
                String IP = beanDL_NetworkElement.getIp();
        
            
                            
            
                
                String Management_IP = beanDL_NetworkElement.getManagement_ip();
        
            
                            
            
                
                String ManagementInterface = beanDL_NetworkElement.getManagementinterface();
        
            
                            
            
                
              boolean PWPolicyEnabled = new Boolean(beanDL_NetworkElement.getPwpolicyenabled()).booleanValue();
    
            
                            
            
                
                String PWPolicy = beanDL_NetworkElement.getPwpolicy();
        
            
                            
            
                
              boolean UsernameEnabled = new Boolean(beanDL_NetworkElement.getUsernameenabled()).booleanValue();
    
            
                            
            
                
                String Username = beanDL_NetworkElement.getUsername();
        
            
                            
            
                
                String Password = beanDL_NetworkElement.getPassword();
        
            
                            
            
                  String PasswordCurrent = "" + beanDL_NetworkElement.getPasswordCurrent();
                
                String EnablePassword = beanDL_NetworkElement.getEnablepassword();
        
            
                            
            
                  String EnablePasswordCurrent = "" + beanDL_NetworkElement.getEnablePasswordCurrent();
                
                String Vendor = beanDL_NetworkElement.getVendor();
        
            
                            
            
                
                String OSVersionGroup = beanDL_NetworkElement.getOsversiongroup();
        
            
                            
            
                
                String OSVersion = beanDL_NetworkElement.getOsversion();
        
            
                            
            
                
                String ElementTypeGroup = beanDL_NetworkElement.getElementtypegroup();
        
            
                            
            
                
                String ElementType = beanDL_NetworkElement.getElementtype();
        
            
                            
            
                
                String SerialNumber = beanDL_NetworkElement.getSerialnumber();
        
            
                            
            
                
                String Role = beanDL_NetworkElement.getRole();
        
            
                            
            
                
                String AdminState = beanDL_NetworkElement.getAdminstate();
        
            
                            
            
                
                String LifeCycleState = beanDL_NetworkElement.getLifecyclestate();
        
            
                            
            
                
                String ROCommunity = beanDL_NetworkElement.getRocommunity();
        
            
                            
            
                
                String RWCommunity = beanDL_NetworkElement.getRwcommunity();
        
            
                            
            
                
                String NNMi_UUId = beanDL_NetworkElement.getNnmi_uuid();
        
            
                            
            
                
              String NNMi_LastUpdate = (beanDL_NetworkElement.getNnmi_lastupdate() == null) ? "" : beanDL_NetworkElement.getNnmi_lastupdate();
      NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                    String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
          sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
    
            
                            
            
                
                String StateName = beanDL_NetworkElement.getStatename();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_NetworkElementApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="DL_NetworkElementApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Network"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Name"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Description"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Location"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="IP"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Management_IP"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="PWPolicyEnabled"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="PWPolicy"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Username"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Password"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="EnablePassword"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Vendor"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="OSVersionGroup"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="OSVersion"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ElementTypeGroup"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ElementType"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="SerialNumber"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Role"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="AdminState"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ROCommunity"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="RWCommunity"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="NNMi_LastUpdate"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="StateName"/>
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
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.network.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="network" value="<%= Network %>" >
                      <html:options collection="NetworkListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.network.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.name.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.description.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.location.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="location" size="24" value="<%= Location %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.location.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.management_ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="management_ip" size="24" value="<%= Management_IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.management_ip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.managementinterface.alias"/>
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
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.managementinterface.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <input type="hidden" name="pwpolicyenabled" value="<%= PWPolicyEnabled %>"/>  
                                            
                                                    <html:hidden property="pwpolicy" value="<%= PWPolicy %>"/>            
				                                            
                                                    <input type="hidden" name="usernameenabled" value="<%= UsernameEnabled %>"/>  
                                            
                                                    <html:hidden property="username" value="<%= Username %>"/>            
				                                            
                                                    <html:hidden property="password" value="<%= Password %>"/>            
								<html:hidden property="passwordcurrent" value="<%= PasswordCurrent %>"/>
				                                            
                                                    <html:hidden property="enablepassword" value="<%= EnablePassword %>"/>            
								<html:hidden property="enablepasswordcurrent" value="<%= EnablePasswordCurrent %>"/>
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.vendor.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vendor" size="24" value="<%= Vendor %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.vendor.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="osversiongroup" value="<%= OSVersionGroup %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversion.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="osversion" size="24" value="<%= OSVersion %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversion.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="elementtypegroup" value="<%= ElementTypeGroup %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="elementtype" size="24" value="<%= ElementType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.serialnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serialnumber" size="24" value="<%= SerialNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.serialnumber.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.role.alias"/>
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
                                            <html:option value="AccessSwitch" >AccessSwitch</html:option>
                                            <html:option value="AggregationSwitch" >AggregationSwitch</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.role.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.adminstate.alias"/>
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
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.adminstate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.lifecyclestate.alias"/>
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
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.lifecyclestate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rocommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rocommunity" size="24" value="<%= ROCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rocommunity.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rwcommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rwcommunity.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_uuid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_uuid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_lastupdate.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_lastupdate.description"/>
                <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="statename" value="<%= StateName %>"/>            
				                                            
                    
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
