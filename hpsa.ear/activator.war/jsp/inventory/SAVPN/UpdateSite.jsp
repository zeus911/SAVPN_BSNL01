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
String datasource = (String) request.getParameter(SiteConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSiteAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("serviceid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                          _location_ = "contactperson";
                                                                                                                                                }

%>

<html>
  <head>
    <title><bean:message bundle="SiteApplicationResources" key="<%= SiteConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.SiteForm.action = '/activator<%=moduleConfig%>/UpdateFormSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.SiteForm.submit();
    }
    function performCommit()
    {
      window.document.SiteForm.action = '/activator<%=moduleConfig%>/UpdateCommitSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.SiteForm.submit();
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
com.hp.ov.activator.vpn.inventory.Site beanSite = (com.hp.ov.activator.vpn.inventory.Site) request.getAttribute(SiteConstants.SITE_BEAN);
if(beanSite==null)
   beanSite = (com.hp.ov.activator.vpn.inventory.Site) request.getSession().getAttribute(SiteConstants.SITE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
SiteForm form = (SiteForm) request.getAttribute("SiteForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ServiceId = beanSite.getServiceid();
        
            
                            
            
                
                String Customer = beanSite.getCustomer();
        
            
                            
            
                
                String ContactPerson = beanSite.getContactperson();
        
            
                            
            
                
                String SiteName = beanSite.getSitename();
        
            
                            
            
                
                String ServiceName = beanSite.getServicename();
        
            
                            
            
                
                String VPNName = beanSite.getVpnname();
        
            
                            
            
                
                String Region = beanSite.getRegion();
        
            
                            
            
                
                String InitiationDate = beanSite.getInitiationdate();
        
            
                            
            
                
                String ActivationDate = beanSite.getActivationdate();
        
            
                            
            
                
                String ModificationDate = beanSite.getModificationdate();
        
            
                            
            
                
                String State = beanSite.getState();
        
            
                            
            
                
                String Type = beanSite.getType();
        
            
                            
            
                
                String SiteOfOrigin = beanSite.getSiteoforigin();
        
            
                            
            
                
              boolean Managed = new Boolean(beanSite.getManaged()).booleanValue();
    
            
                            
            
                
                String ManagedStr = beanSite.getManagedstr();
        
            
                            
            
                
                String Multicast = beanSite.getMulticast();
        
            
                            
            
                
                String Protocol = beanSite.getProtocol();
        
            
                            
            
                
                String RemoteASN = beanSite.getRemoteasn();
        
            
                            
            
                
                String OSPF_Area = beanSite.getOspf_area();
        
            
                            
            
                
                String StaticRoutes = beanSite.getStaticroutes();
        
            
                            
            
                
                String Comments = beanSite.getComments();
        
            
                            
            
                
                String L3FlowpointID = beanSite.getL3flowpointid();
        
            
                            
            
                
                String CustomerId = beanSite.getCustomerid();
        
            
                            
            
                
                String PostalAddress = beanSite.getPostaladdress();
        
            
                            
            
                
              String __count = "" + beanSite.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSite.get__count()) : "";
          
            
            if( beanSite.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="SiteApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="SiteApplicationResources" property="ServiceId"/>
        <html:errors bundle="SiteApplicationResources" property="Customer"/>
        <html:errors bundle="SiteApplicationResources" property="ContactPerson"/>
        <html:errors bundle="SiteApplicationResources" property="SiteName"/>
        <html:errors bundle="SiteApplicationResources" property="ServiceName"/>
        <html:errors bundle="SiteApplicationResources" property="VPNName"/>
        <html:errors bundle="SiteApplicationResources" property="Region"/>
        <html:errors bundle="SiteApplicationResources" property="InitiationDate"/>
        <html:errors bundle="SiteApplicationResources" property="ActivationDate"/>
        <html:errors bundle="SiteApplicationResources" property="ModificationDate"/>
        <html:errors bundle="SiteApplicationResources" property="State"/>
        <html:errors bundle="SiteApplicationResources" property="Type"/>
        <html:errors bundle="SiteApplicationResources" property="SiteOfOrigin"/>
        <html:errors bundle="SiteApplicationResources" property="Managed"/>
        <html:errors bundle="SiteApplicationResources" property="ManagedStr"/>
        <html:errors bundle="SiteApplicationResources" property="Multicast"/>
        <html:errors bundle="SiteApplicationResources" property="Protocol"/>
        <html:errors bundle="SiteApplicationResources" property="RemoteASN"/>
        <html:errors bundle="SiteApplicationResources" property="OSPF_Area"/>
        <html:errors bundle="SiteApplicationResources" property="StaticRoutes"/>
        <html:errors bundle="SiteApplicationResources" property="Comments"/>
        <html:errors bundle="SiteApplicationResources" property="L3FlowpointID"/>
        <html:errors bundle="SiteApplicationResources" property="CustomerId"/>
        <html:errors bundle="SiteApplicationResources" property="PostalAddress"/>
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
    allEvents = allEvents + "checkShowRulesModificationDate();";//default invoked when loading HTML
    function checkShowRulesModificationDate(){
          var ModificationDatePass = false ;
      if (/^[0-9]+.*$/.test(document.getElementsByName("modificationdate")[0].value)) {ModificationDatePass = true;}
            
    var controlTr = document.getElementsByName("modificationdate")[0];
          if (true && ModificationDatePass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('modificationdate')[0],'keyup',checkShowRulesModificationDate);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesSiteOfOrigin();";//default invoked when loading HTML
    function checkShowRulesSiteOfOrigin(){
          var SiteOfOriginPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("siteoforigin")[0].value)) {SiteOfOriginPass = true;}
            
    var controlTr = document.getElementsByName("siteoforigin")[0];
          if (true && SiteOfOriginPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('siteoforigin')[0],'keyup',checkShowRulesSiteOfOrigin);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesMulticast();";//default invoked when loading HTML
    function checkShowRulesMulticast(){
          var L3FlowpointIDPass = false ;
      if (/^[1-9][0-9]*$/.test(document.getElementsByName("l3flowpointid")[0].value)) {L3FlowpointIDPass = true;}
            
    var controlTr = document.getElementsByName("multicast")[0];
          if (true && L3FlowpointIDPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('l3flowpointid')[0],'keyup',checkShowRulesMulticast);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesProtocol();";//default invoked when loading HTML
    function checkShowRulesProtocol(){
          var L3FlowpointIDPass = false ;
      if (/^[1-9][0-9]*$/.test(document.getElementsByName("l3flowpointid")[0].value)) {L3FlowpointIDPass = true;}
            
    var controlTr = document.getElementsByName("protocol")[0];
          if (true && L3FlowpointIDPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('l3flowpointid')[0],'keyup',checkShowRulesProtocol);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesRemoteASN();";//default invoked when loading HTML
    function checkShowRulesRemoteASN(){
          var ProtocolPass = false ;
      if (/^BGP$/.test(document.getElementsByName("protocol")[0].value)) {ProtocolPass = true;}
            
    var controlTr = document.getElementsByName("remoteasn")[0];
          if (true && ProtocolPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('protocol')[0],'keyup',checkShowRulesRemoteASN);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesOSPF_Area();";//default invoked when loading HTML
    function checkShowRulesOSPF_Area(){
          var ProtocolPass = false ;
      if (/^OSPF$/.test(document.getElementsByName("protocol")[0].value)) {ProtocolPass = true;}
            
    var controlTr = document.getElementsByName("ospf_area")[0];
          if (true && ProtocolPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('protocol')[0],'keyup',checkShowRulesOSPF_Area);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesStaticRoutes();";//default invoked when loading HTML
    function checkShowRulesStaticRoutes(){
          var L3FlowpointIDPass = false ;
      if (/^[1-9][0-9]*$/.test(document.getElementsByName("l3flowpointid")[0].value)) {L3FlowpointIDPass = true;}
            
    var controlTr = document.getElementsByName("staticroutes")[0];
          if (true && L3FlowpointIDPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('l3flowpointid')[0],'keyup',checkShowRulesStaticRoutes);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                          document.getElementsByName("modificationdate")[0].parentNode.parentNode.style.display="none";
                                          document.getElementsByName("siteoforigin")[0].parentNode.parentNode.style.display="none";
                                          document.getElementsByName("multicast")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("protocol")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("remoteasn")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("ospf_area")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("staticroutes")[0].parentNode.parentNode.style.display="none";
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
      
                                                  <html:hidden property="serviceid" value="<%= ServiceId %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.customer.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customer" value="<%= Customer %>"/>
                                                        <html:text disabled="true" property="customer" size="24" value="<%= Customer %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.customer.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.contactperson.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.sitename.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="sitename" value="<%= SiteName %>"/>
                                                        <html:text disabled="true" property="sitename" size="24" value="<%= SiteName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.sitename.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="servicename" value="<%= ServiceName %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.vpnname.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="vpnname" value="<%= VPNName %>"/>
                                                        <html:text disabled="true" property="vpnname" size="24" value="<%= VPNName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.vpnname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.region.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="region" value="<%= Region %>"/>
                                                        <html:text disabled="true" property="region" size="24" value="<%= Region %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.region.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="initiationdate" value="<%= InitiationDate %>"/>
                                                        <html:text disabled="true" property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.initiationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="activationdate" value="<%= ActivationDate %>"/>
                                                        <html:text disabled="true" property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.activationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="modificationdate" value="<%= ModificationDate %>"/>
                                                        <html:text disabled="true" property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.modificationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="state" value="<%= State %>"/>
                                                        <html:text disabled="true" property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="type" value="<%= Type %>"/>
                                                        <html:text disabled="true" property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.siteoforigin.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="siteoforigin" value="<%= SiteOfOrigin %>"/>
                                                        <html:text disabled="true" property="siteoforigin" size="24" value="<%= SiteOfOrigin %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.siteoforigin.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <input type="hidden" name="managed" value="<%= Managed %>"/>  
                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.managedstr.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="managedstr" value="<%= ManagedStr %>"/>
                                                        <html:text disabled="true" property="managedstr" size="24" value="<%= ManagedStr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.managedstr.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.multicast.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="multicast" value="<%= Multicast %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(Multicast==null||Multicast.trim().equals(""))
                           selValue="disabled";
                        else
                        selValue=Multicast.toString();    
                          %>

                    <html:select disabled="true" property="multicast" value="<%= selValue %>" >
                                            <html:option value="disabled" >disabled</html:option>
                                            <html:option value="enabled" >enabled</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.multicast.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.protocol.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="protocol" value="<%= Protocol %>"/>
                                                        <html:text disabled="true" property="protocol" size="24" value="<%= Protocol %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.protocol.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.remoteasn.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="remoteasn" value="<%= RemoteASN %>"/>
                                                        <html:text disabled="true" property="remoteasn" size="24" value="<%= RemoteASN %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.remoteasn.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.ospf_area.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ospf_area" value="<%= OSPF_Area %>"/>
                                                        <html:text disabled="true" property="ospf_area" size="24" value="<%= OSPF_Area %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.ospf_area.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.staticroutes.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="staticroutes" value="<%= StaticRoutes %>"/>
                                                        <html:text disabled="true" property="staticroutes" size="24" value="<%= StaticRoutes %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.staticroutes.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="SiteApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SiteApplicationResources" key="field.comments.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="l3flowpointid" value="<%= L3FlowpointID %>"/>            
				                                            
                                                    <html:hidden property="customerid" value="<%= CustomerId %>"/>            
				                                            
                                                    <html:hidden property="postaladdress" value="<%= PostalAddress %>"/>            
				                                            
                        
                    
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
