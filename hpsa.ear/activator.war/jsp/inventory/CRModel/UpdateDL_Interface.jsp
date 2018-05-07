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
String datasource = (String) request.getParameter(DL_InterfaceConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_InterfaceAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
                    _location_ = "name";
                                                                                                                                                                  }

%>

<html>
  <head>
    <title><bean:message bundle="DL_InterfaceApplicationResources" key="<%= DL_InterfaceConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.DL_InterfaceForm.action = '/activator<%=moduleConfig%>/UpdateFormDL_InterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.DL_InterfaceForm.submit();
    }
    function performCommit()
    {
      window.document.DL_InterfaceForm.action = '/activator<%=moduleConfig%>/UpdateCommitDL_InterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.DL_InterfaceForm.submit();
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
com.hp.ov.activator.nnmi.dl.inventory.DL_Interface beanDL_Interface = (com.hp.ov.activator.nnmi.dl.inventory.DL_Interface) request.getAttribute(DL_InterfaceConstants.DL_INTERFACE_BEAN);
if(beanDL_Interface==null)
   beanDL_Interface = (com.hp.ov.activator.nnmi.dl.inventory.DL_Interface) request.getSession().getAttribute(DL_InterfaceConstants.DL_INTERFACE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_InterfaceForm form = (DL_InterfaceForm) request.getAttribute("DL_InterfaceForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String NNMi_Id = beanDL_Interface.getNnmi_id();
        
            
                            
            
                
                String Name = beanDL_Interface.getName();
        
            
                            
            
                
                String NE_NNMi_Id = beanDL_Interface.getNe_nnmi_id();
        
            
                            
            
                
                String EC_NNMi_Id = beanDL_Interface.getEc_nnmi_id();
        
            
                            
            
                
                String State = beanDL_Interface.getState();
        
            
                            
            
                
                String StateName = beanDL_Interface.getStatename();
        
            
                            
            
                
                String Type = beanDL_Interface.getType();
        
            
                            
            
                
                String ParentIf = beanDL_Interface.getParentif();
        
            
                            
            
                
                String IPAddr = beanDL_Interface.getIpaddr();
        
            
                            
            
                
                String Subtype = beanDL_Interface.getSubtype();
        
            
                            
            
                
                String Encapsulation = beanDL_Interface.getEncapsulation();
        
            
                            
            
                
                String Description = beanDL_Interface.getDescription();
        
            
                            
            
                
                String IFIndex = beanDL_Interface.getIfindex();
        
            
                            
            
                
                String ActivationState = beanDL_Interface.getActivationstate();
        
            
                            
            
                
                String UsageState = beanDL_Interface.getUsagestate();
        
            
                            
            
                
                String VLANId = beanDL_Interface.getVlanid();
        
            
                            
            
                
                String VLANMode = beanDL_Interface.getVlanmode();
        
            
                            
            
                
                String DLCI = beanDL_Interface.getDlci();
        
            
                            
            
                
                String Timeslots = beanDL_Interface.getTimeslots();
        
            
                            
            
                
                String NumberOfSlots = beanDL_Interface.getNumberofslots();
        
            
                            
            
                
                String Bandwidth = beanDL_Interface.getBandwidth();
        
            
                            
            
                
                String LMIType = beanDL_Interface.getLmitype();
        
            
                            
            
                
                String IntfType = beanDL_Interface.getIntftype();
        
            
                            
            
                
                String BundleKey = beanDL_Interface.getBundlekey();
        
            
                            
            
                
                String BundleId = beanDL_Interface.getBundleid();
        
            
                            
            
                
                String NNMi_UUId = beanDL_Interface.getNnmi_uuid();
        
            
                            
            
                
              String NNMi_LastUpdate = (beanDL_Interface.getNnmi_lastupdate() == null) ? "" : beanDL_Interface.getNnmi_lastupdate();
      NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                    String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
          sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
    
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_InterfaceApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="DL_InterfaceApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="Name"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="NE_NNMi_Id"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="EC_NNMi_Id"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="State"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="StateName"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="Type"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="ParentIf"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="IPAddr"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="Subtype"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="Encapsulation"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="Description"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="IFIndex"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="ActivationState"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="UsageState"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="VLANId"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="VLANMode"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="DLCI"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="Timeslots"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="NumberOfSlots"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="Bandwidth"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="LMIType"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="IntfType"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="BundleKey"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="BundleId"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="DL_InterfaceApplicationResources" property="NNMi_LastUpdate"/>
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
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.name.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ne_nnmi_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ne_nnmi_id" value="<%= NE_NNMi_Id %>"/>
                                                        <html:text disabled="true" property="ne_nnmi_id" size="24" value="<%= NE_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ne_nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ec_nnmi_id.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ec_nnmi_id" value="<%= EC_NNMi_Id %>"/>
                                                        <html:text disabled="true" property="ec_nnmi_id" size="24" value="<%= EC_NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ec_nnmi_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(State==null||State.trim().equals(""))
                           selValue="Up";
                        else
                        selValue=State.toString();    
                          %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="statename" value="<%= StateName %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.parentif.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="parentif" size="24" value="<%= ParentIf %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.parentif.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ipaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipaddr" size="24" value="<%= IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.subtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="subtype" size="24" value="<%= Subtype %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.subtype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.encapsulation.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="encapsulation" size="24" value="<%= Encapsulation %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.encapsulation.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.description.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ifindex.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ifindex" size="24" value="<%= IFIndex %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.ifindex.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.activationstate.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(ActivationState==null||ActivationState.trim().equals(""))
                           selValue="Activated";
                        else
                        selValue=ActivationState.toString();    
                          %>

                    <html:select  property="activationstate" value="<%= selValue %>" >
                                            <html:option value="Activated" >Activated</html:option>
                                            <html:option value="Failed" >Failed</html:option>
                                            <html:option value="Undefined" >Undefined</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.activationstate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.usagestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(UsageState==null||UsageState.trim().equals(""))
                           selValue="Available";
                        else
                        selValue=UsageState.toString();    
                          %>

                    <html:select  property="usagestate" value="<%= selValue %>" >
                                            <html:option value="Available" >Available</html:option>
                                            <html:option value="SubIfPresent" >SubIfPresent</html:option>
                                            <html:option value="Uplink" >Uplink</html:option>
                                            <html:option value="Reserved" >Reserved</html:option>
                                            <html:option value="InBundle" >InBundle</html:option>
                                            <html:option value="Trunk" >Trunk</html:option>
                                            <html:option value="ASBRLink" >ASBRLink</html:option>
                                            <html:option value="SwitchPort" >SwitchPort</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.usagestate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanid" size="24" value="<%= VLANId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanmode.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanmode" size="24" value="<%= VLANMode %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanmode.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.dlci.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dlci" size="24" value="<%= DLCI %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.dlci.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.timeslots.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="timeslots" size="24" value="<%= Timeslots %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.timeslots.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.numberofslots.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="numberofslots" size="24" value="<%= NumberOfSlots %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.numberofslots.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.bandwidth.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bandwidth" size="24" value="<%= Bandwidth %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.bandwidth.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.lmitype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="lmitype" size="24" value="<%= LMIType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.lmitype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.intftype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="intftype" size="24" value="<%= IntfType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.intftype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundlekey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bundlekey" size="24" value="<%= BundleKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundlekey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundleid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bundleid" size="24" value="<%= BundleId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundleid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_uuid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_uuid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_lastupdate.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_lastupdate.description"/>
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
        <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
        <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>

  </html:form>

  </body>

</html>
