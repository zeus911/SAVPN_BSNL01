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
String datasource = (String) request.getParameter(L3VPNConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitL3VPNAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
    <title><bean:message bundle="L3VPNApplicationResources" key="<%= L3VPNConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.L3VPNForm.action = '/activator<%=moduleConfig%>/UpdateFormL3VPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.L3VPNForm.submit();
    }
    function performCommit()
    {
      window.document.L3VPNForm.action = '/activator<%=moduleConfig%>/UpdateCommitL3VPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.L3VPNForm.submit();
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
com.hp.ov.activator.vpn.inventory.L3VPN beanL3VPN = (com.hp.ov.activator.vpn.inventory.L3VPN) request.getAttribute(L3VPNConstants.L3VPN_BEAN);
if(beanL3VPN==null)
   beanL3VPN = (com.hp.ov.activator.vpn.inventory.L3VPN) request.getSession().getAttribute(L3VPNConstants.L3VPN_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
L3VPNForm form = (L3VPNForm) request.getAttribute("L3VPNForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ServiceId = beanL3VPN.getServiceid();
        
            
                            
            
                
                String CustomerId = beanL3VPN.getCustomerid();
        
            
                            
            
                
                String Customer = beanL3VPN.getCustomer();
        
            
                            
            
                
                String ContactPerson = beanL3VPN.getContactperson();
        
            
                            
            
                
                String ServiceName = beanL3VPN.getServicename();
        
            
                            
            
                
                String Name = beanL3VPN.getName();
        
            
                            
            
                
                String InitiationDate = beanL3VPN.getInitiationdate();
        
            
                            
            
                
                String ActivationDate = beanL3VPN.getActivationdate();
        
            
                            
            
                
                String ModificationDate = beanL3VPN.getModificationdate();
        
            
                            
            
                
                String QoSProfile_PE = beanL3VPN.getQosprofile_pe();
        
            
                            
            
                
                String QoSProfile_CE = beanL3VPN.getQosprofile_ce();
        
            
                            
            
                
                String State = beanL3VPN.getState();
        
            
                            
            
                
                String Type = beanL3VPN.getType();
        
            
                            
            
                
                String AddressFamily = beanL3VPN.getAddressfamily();
        
            
                            
            
                
                String VPNTopologyType = beanL3VPN.getVpntopologytype();
        
            
                            
            
                
                String RCFlag = beanL3VPN.getRcflag();
        
            
                            
            
                
                String Multicast = beanL3VPN.getMulticast();
        
            
                            
            
                
                String ParentId = beanL3VPN.getParentid();
        
            
                            
            
                
                String RTExport = beanL3VPN.getRtexport();
        
            
                            
            
                
                String RTImport = beanL3VPN.getRtimport();
        
            
                            
            
                
                String Comments = beanL3VPN.getComments();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3VPNApplicationResources" key="jsp.update.title"/>
</h2> 

<H1>
      <html:errors bundle="L3VPNApplicationResources" property="ServiceId"/>
        <html:errors bundle="L3VPNApplicationResources" property="CustomerId"/>
        <html:errors bundle="L3VPNApplicationResources" property="Customer"/>
        <html:errors bundle="L3VPNApplicationResources" property="ContactPerson"/>
        <html:errors bundle="L3VPNApplicationResources" property="ServiceName"/>
        <html:errors bundle="L3VPNApplicationResources" property="Name"/>
        <html:errors bundle="L3VPNApplicationResources" property="InitiationDate"/>
        <html:errors bundle="L3VPNApplicationResources" property="ActivationDate"/>
        <html:errors bundle="L3VPNApplicationResources" property="ModificationDate"/>
        <html:errors bundle="L3VPNApplicationResources" property="QoSProfile_PE"/>
        <html:errors bundle="L3VPNApplicationResources" property="QoSProfile_CE"/>
        <html:errors bundle="L3VPNApplicationResources" property="State"/>
        <html:errors bundle="L3VPNApplicationResources" property="Type"/>
        <html:errors bundle="L3VPNApplicationResources" property="AddressFamily"/>
        <html:errors bundle="L3VPNApplicationResources" property="VPNTopologyType"/>
        <html:errors bundle="L3VPNApplicationResources" property="RCFlag"/>
        <html:errors bundle="L3VPNApplicationResources" property="Multicast"/>
        <html:errors bundle="L3VPNApplicationResources" property="ParentId"/>
        <html:errors bundle="L3VPNApplicationResources" property="RTExport"/>
        <html:errors bundle="L3VPNApplicationResources" property="RTImport"/>
        <html:errors bundle="L3VPNApplicationResources" property="Comments"/>
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
    allEvents = allEvents + "checkShowRulesVPNTopologyType();";//default invoked when loading HTML
    function checkShowRulesVPNTopologyType(){
          var TypePass = false ;
      if (/^L3VPN$/.test(document.getElementsByName("type")[0].value)) {TypePass = true;}
            
    var controlTr = document.getElementsByName("vpntopologytype")[0];
          if (true && TypePass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('type')[0],'keyup',checkShowRulesVPNTopologyType);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesMulticast();";//default invoked when loading HTML
    function checkShowRulesMulticast(){
          var RCFlagPass = false ;
      if (/^0$/.test(document.getElementsByName("rcflag")[0].value)) {RCFlagPass = true;}
            
    var controlTr = document.getElementsByName("multicast")[0];
          if (true && RCFlagPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('rcflag')[0],'keyup',checkShowRulesMulticast);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesParentId();";//default invoked when loading HTML
    function checkShowRulesParentId(){
          var RCFlagPass = false ;
      if (/^1$/.test(document.getElementsByName("rcflag")[0].value)) {RCFlagPass = true;}
            
    var controlTr = document.getElementsByName("parentid")[0];
          if (true && RCFlagPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('rcflag')[0],'keyup',checkShowRulesParentId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesRTExport();";//default invoked when loading HTML
    function checkShowRulesRTExport(){
          var RCFlagPass = false ;
      if (/^1$/.test(document.getElementsByName("rcflag")[0].value)) {RCFlagPass = true;}
            
    var controlTr = document.getElementsByName("rtexport")[0];
          if (true && RCFlagPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('rcflag')[0],'keyup',checkShowRulesRTExport);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesRTImport();";//default invoked when loading HTML
    function checkShowRulesRTImport(){
          var RCFlagPass = false ;
      if (/^1$/.test(document.getElementsByName("rcflag")[0].value)) {RCFlagPass = true;}
            
    var controlTr = document.getElementsByName("rtimport")[0];
          if (true && RCFlagPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('rcflag')[0],'keyup',checkShowRulesRTImport);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                    document.getElementsByName("modificationdate")[0].parentNode.parentNode.style.display="none";
                                                            document.getElementsByName("vpntopologytype")[0].parentNode.parentNode.style.display="none";
                                    document.getElementsByName("multicast")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("parentid")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("rtexport")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("rtimport")[0].parentNode.parentNode.style.display="none";
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
				                                            
                                                    <html:hidden property="customerid" value="<%= CustomerId %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.customer.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customer" value="<%= Customer %>"/>
                                                        <html:text disabled="true" property="customer" size="24" value="<%= Customer %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.customer.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.contactperson.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="servicename" value="<%= ServiceName %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.name.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="name" value="<%= Name %>"/>
                                                        <html:text disabled="true" property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="initiationdate" value="<%= InitiationDate %>"/>
                                                        <html:text disabled="true" property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.initiationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="activationdate" value="<%= ActivationDate %>"/>
                                                        <html:text disabled="true" property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.activationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="modificationdate" value="<%= ModificationDate %>"/>
                                                        <html:text disabled="true" property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.modificationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.qosprofile_pe.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="qosprofile_pe" value="<%= QoSProfile_PE %>"/>
                                                        <html:text disabled="true" property="qosprofile_pe" size="24" value="<%= QoSProfile_PE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.qosprofile_pe.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="qosprofile_ce" value="<%= QoSProfile_CE %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="state" value="<%= State %>"/>
                                                        <html:text disabled="true" property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="type" value="<%= Type %>"/>
                                                        <html:text disabled="true" property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.addressfamily.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="addressfamily" value="<%= AddressFamily %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(AddressFamily==null||AddressFamily.trim().equals(""))
                           selValue="IPv4";
                        else
                        selValue=AddressFamily.toString();    
                          %>

                    <html:select disabled="true" property="addressfamily" value="<%= selValue %>" >
                                            <html:option value="IPv4" >IPv4</html:option>
                                            <html:option value="IPv6" >IPv6</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.addressfamily.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.vpntopologytype.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="vpntopologytype" value="<%= VPNTopologyType %>"/>
                                                        <html:text disabled="true" property="vpntopologytype" size="24" value="<%= VPNTopologyType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.vpntopologytype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="rcflag" value="<%= RCFlag %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.multicast.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="multicast" value="<%= Multicast %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(Multicast==null||Multicast.trim().equals(""))
                           selValue="unsupported";
                        else
                        selValue=Multicast.toString();    
                          %>

                    <html:select disabled="true" property="multicast" value="<%= selValue %>" >
                                            <html:option value="unsupported" >unsupported</html:option>
                                            <html:option value="disabled" >disabled</html:option>
                                            <html:option value="enabled" >enabled</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.multicast.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.parentid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="parentid" value="<%= ParentId %>"/>
                                                        <html:text disabled="true" property="parentid" size="24" value="<%= ParentId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.parentid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.rtexport.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="rtexport" value="<%= RTExport %>"/>
                                                        <html:text disabled="true" property="rtexport" size="24" value="<%= RTExport %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.rtexport.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.rtimport.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="rtimport" value="<%= RTImport %>"/>
                                                        <html:text disabled="true" property="rtimport" size="24" value="<%= RTImport %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.rtimport.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                       <html:textarea property="comments" rows="5" cols="25" value="<%= Comments %>" />
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNApplicationResources" key="field.comments.description"/>
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
