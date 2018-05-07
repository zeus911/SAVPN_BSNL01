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
String datasource = (String) request.getParameter(Sh_InterfaceConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSh_InterfaceAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("terminationpointid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "name";
                                                                                                                                                            }

%>

<html>
  <head>
    <title><bean:message bundle="Sh_InterfaceApplicationResources" key="<%= Sh_InterfaceConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_InterfaceForm.action = '/activator<%=moduleConfig%>/UpdateFormSh_InterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.Sh_InterfaceForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_InterfaceForm.action = '/activator<%=moduleConfig%>/UpdateCommitSh_InterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.Sh_InterfaceForm.submit();
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
com.hp.ov.activator.vpn.inventory.Sh_Interface beanSh_Interface = (com.hp.ov.activator.vpn.inventory.Sh_Interface) request.getAttribute(Sh_InterfaceConstants.SH_INTERFACE_BEAN);
if(beanSh_Interface==null)
   beanSh_Interface = (com.hp.ov.activator.vpn.inventory.Sh_Interface) request.getSession().getAttribute(Sh_InterfaceConstants.SH_INTERFACE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
Sh_InterfaceForm form = (Sh_InterfaceForm) request.getAttribute("Sh_InterfaceForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String TerminationPointID = beanSh_Interface.getTerminationpointid();
        
            
                            
            
                
                String Name = beanSh_Interface.getName();
        
            
                            
            
                
                String NE_ID = beanSh_Interface.getNe_id();
        
            
                            
            
                
                String EC_ID = beanSh_Interface.getEc_id();
        
            
                            
            
                
                String State = beanSh_Interface.getState();
        
            
                            
            
                
                String Marker = beanSh_Interface.getMarker();
        
            
                            
            
                
                String UploadStatus = beanSh_Interface.getUploadstatus();
        
            
                            
            
                
                String DBPrimaryKey = beanSh_Interface.getDbprimarykey();
        
            
                            
            
                
              String __count = "" + beanSh_Interface.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_Interface.get__count()) : "";
          
            
            if( beanSh_Interface.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
                String Type = beanSh_Interface.getType();
        
            
                            
            
                
                String ParentIf = beanSh_Interface.getParentif();
        
            
                            
            
                
                String IPAddr = beanSh_Interface.getIpaddr();
        
            
                            
            
                
                String SubType = beanSh_Interface.getSubtype();
        
            
                            
            
                
                String Encapsulation = beanSh_Interface.getEncapsulation();
        
            
                            
            
                
                String ifIndex = beanSh_Interface.getIfindex();
        
            
                            
            
                
                String ActiveState = beanSh_Interface.getActivestate();
        
            
                            
            
                
                String UsageState = beanSh_Interface.getUsagestate();
        
            
                            
            
                
                String VlanId = beanSh_Interface.getVlanid();
        
            
                            
            
                
              String DLCI = "" + beanSh_Interface.getDlci();
          
            
            if( beanSh_Interface.getDlci()==Integer.MIN_VALUE)
         DLCI = "";
                            
            
                
                String Timeslots = beanSh_Interface.getTimeslots();
        
            
                            
            
                
              String SlotsNumber = "" + beanSh_Interface.getSlotsnumber();
              SlotsNumber = (SlotsNumber != null && !(SlotsNumber.trim().equals(""))) ? nfA.format(beanSh_Interface.getSlotsnumber()) : "";
          
            
            if( beanSh_Interface.getSlotsnumber()==Integer.MIN_VALUE)
         SlotsNumber = "";
                            
            
                
              String Bandwidth = "" + beanSh_Interface.getBandwidth();
              Bandwidth = (Bandwidth != null && !(Bandwidth.trim().equals(""))) ? nfA.format(beanSh_Interface.getBandwidth()) : "";
          
            
            if( beanSh_Interface.getBandwidth()==Integer.MIN_VALUE)
         Bandwidth = "";
                            
            
                
                String LmiType = beanSh_Interface.getLmitype();
        
            
                            
            
                
                String IntfType = beanSh_Interface.getIntftype();
        
            
                            
            
                
                String BundleKey = beanSh_Interface.getBundlekey();
        
            
                            
            
                
                String BundleId = beanSh_Interface.getBundleid();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_InterfaceApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_InterfaceApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Name"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="NE_ID"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="EC_ID"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="State"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="DBPrimaryKey"/>
          <html:errors bundle="Sh_InterfaceApplicationResources" property="Type"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="ParentIf"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="IPAddr"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="SubType"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Encapsulation"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="ifIndex"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="ActiveState"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="UsageState"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="VlanId"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="DLCI"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Timeslots"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="SlotsNumber"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Bandwidth"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="LmiType"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="IntfType"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="BundleKey"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="BundleId"/>
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
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.terminationpointid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="terminationpointid" value="<%= TerminationPointID %>"/>
                                                        <html:text disabled="true" property="terminationpointid" size="24" value="<%= TerminationPointID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.terminationpointid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.name.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ne_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ne_id" size="24" value="<%= NE_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ne_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ec_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ec_id" size="24" value="<%= EC_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ec_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.state.alias"/>
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
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.marker.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.uploadstatus.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dbprimarykey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.__count.description"/>
              </table:cell>
      </table:row>
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.parentif.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="parentif" size="24" value="<%= ParentIf %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.parentif.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ipaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipaddr" size="24" value="<%= IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ipaddr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.subtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="subtype" size="24" value="<%= SubType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.subtype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.encapsulation.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="encapsulation" size="24" value="<%= Encapsulation %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.encapsulation.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ifindex.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ifindex" size="24" value="<%= ifIndex %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ifindex.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.activestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(ActiveState==null||ActiveState.trim().equals(""))
                           selValue="Activated";
                        else
                        selValue=ActiveState.toString();    
                          %>

                    <html:select  property="activestate" value="<%= selValue %>" >
                                            <html:option value="Activated" >Activated</html:option>
                                            <html:option value="Failed" >Failed</html:option>
                                            <html:option value="Undefined" >Undefined</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.activestate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.usagestate.alias"/>
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
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.usagestate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanid" size="24" value="<%= VlanId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.vlanid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dlci.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dlci" size="24" value="<%= DLCI %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dlci.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.timeslots.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="timeslots" size="24" value="<%= Timeslots %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.timeslots.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.slotsnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="slotsnumber" size="24" value="<%= SlotsNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.slotsnumber.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bandwidth.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bandwidth" size="24" value="<%= Bandwidth %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bandwidth.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.lmitype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="lmitype" size="24" value="<%= LmiType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.lmitype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.intftype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="intftype" size="24" value="<%= IntfType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.intftype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundlekey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bundlekey" size="24" value="<%= BundleKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundlekey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundleid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bundleid" size="24" value="<%= BundleId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundleid.description"/>
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
