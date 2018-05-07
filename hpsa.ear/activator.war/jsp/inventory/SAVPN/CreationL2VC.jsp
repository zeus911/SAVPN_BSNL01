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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                                                 java.text.SimpleDateFormat sdfNNMi_LastUpdateData = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
            String sdfNNMi_LastUpdateDataDesc = "Format: [" + sdfNNMi_LastUpdateData.toPattern() + "]. Example: [" + sdfNNMi_LastUpdateData.format(new Date()) + "]";
      
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(L2VCConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitL2VCAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "name";
                                                                                                                  }
%>

<html>
  <head>
    <title><bean:message bundle="L2VCApplicationResources" key="<%= L2VCConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.L2VCForm.action = '/activator<%=moduleConfig%>/CreationFormL2VCAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.L2VCForm.submit();
    }
    function performCommit()
    {
      window.document.L2VCForm.action = '/activator<%=moduleConfig%>/CreationCommitL2VCAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.L2VCForm.submit();
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
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }
    </script>
  </head>
  <body style="overflow:auto;" onload="init();">
<%

com.hp.ov.activator.vpn.inventory.L2VC beanL2VC = (com.hp.ov.activator.vpn.inventory.L2VC) request.getAttribute(L2VCConstants.L2VC_BEAN);

      String LinkId = beanL2VC.getLinkid();
                String Name = beanL2VC.getName();
                String N1 = beanL2VC.getN1();
                String NE1 = beanL2VC.getNe1();
        String NE1Label = (String) request.getAttribute(L2VCConstants.NE1_LABEL);
ArrayList NE1ListOfValues = (ArrayList) request.getAttribute(L2VCConstants.NE1_LIST_OF_VALUES);
            String TP1 = beanL2VC.getTp1();
        String TP1Label = (String) request.getAttribute(L2VCConstants.TP1_LABEL);
ArrayList TP1ListOfValues = (ArrayList) request.getAttribute(L2VCConstants.TP1_LIST_OF_VALUES);
            String OldType = beanL2VC.getOldtype();
                String Type = beanL2VC.getType();
        String TypeLabel = (String) request.getAttribute(L2VCConstants.TYPE_LABEL);
ArrayList TypeListOfValues = (ArrayList) request.getAttribute(L2VCConstants.TYPE_LIST_OF_VALUES);
            boolean Attach = new Boolean(beanL2VC.getAttach()).booleanValue();
                String Network = beanL2VC.getNetwork();
        String NetworkLabel = (String) request.getAttribute(L2VCConstants.NETWORK_LABEL);
ArrayList NetworkListOfValues = (ArrayList) request.getAttribute(L2VCConstants.NETWORK_LIST_OF_VALUES);
            String N2 = beanL2VC.getN2();
                String NE2 = beanL2VC.getNe2();
        String NE2Label = (String) request.getAttribute(L2VCConstants.NE2_LABEL);
ArrayList NE2ListOfValues = (ArrayList) request.getAttribute(L2VCConstants.NE2_LIST_OF_VALUES);
            String TP2 = beanL2VC.getTp2();
        String TP2Label = (String) request.getAttribute(L2VCConstants.TP2_LABEL);
ArrayList TP2ListOfValues = (ArrayList) request.getAttribute(L2VCConstants.TP2_LIST_OF_VALUES);
            String PortMode = beanL2VC.getPortmode();
                String Roles = beanL2VC.getRoles();
        String RolesLabel = (String) request.getAttribute(L2VCConstants.ROLES_LABEL);
ArrayList RolesListOfValues = (ArrayList) request.getAttribute(L2VCConstants.ROLES_LIST_OF_VALUES);
            String NNMi_UUId = beanL2VC.getNnmi_uuid();
                String NNMi_Id = beanL2VC.getNnmi_id();
                String NNMi_LastUpdateData = (beanL2VC.getNnmi_lastupdatedata() == null) ? "" : beanL2VC.getNnmi_lastupdatedata();
                String L2VPN = beanL2VC.getL2vpn();
                String BPDUTunnel = beanL2VC.getBpdutunnel();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L2VCApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="L2VCApplicationResources" property="LinkId"/>
        <html:errors bundle="L2VCApplicationResources" property="Name"/>
        <html:errors bundle="L2VCApplicationResources" property="N1"/>
        <html:errors bundle="L2VCApplicationResources" property="NE1"/>
        <html:errors bundle="L2VCApplicationResources" property="TP1"/>
        <html:errors bundle="L2VCApplicationResources" property="OldType"/>
        <html:errors bundle="L2VCApplicationResources" property="Type"/>
        <html:errors bundle="L2VCApplicationResources" property="Attach"/>
        <html:errors bundle="L2VCApplicationResources" property="Network"/>
        <html:errors bundle="L2VCApplicationResources" property="N2"/>
        <html:errors bundle="L2VCApplicationResources" property="NE2"/>
        <html:errors bundle="L2VCApplicationResources" property="TP2"/>
        <html:errors bundle="L2VCApplicationResources" property="PortMode"/>
        <html:errors bundle="L2VCApplicationResources" property="Roles"/>
        <html:errors bundle="L2VCApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="L2VCApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="L2VCApplicationResources" property="NNMi_LastUpdateData"/>
        <html:errors bundle="L2VCApplicationResources" property="L2VPN"/>
        <html:errors bundle="L2VCApplicationResources" property="BPDUTunnel"/>
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
    allEvents = allEvents + "checkShowRulesNetwork();";//default invoked when loading HTML
    function checkShowRulesNetwork(){
          var TypePass = false;
      
              if (/^ASBRLink$|^AggregationTrunk$/.test(document.getElementsByName("type")[0].value)) {TypePass = true;}
                        var AttachPass = false;
      
              if (/^true$/.test(document.getElementsByName("attach")[0].value)) {AttachPass = true;}
                        
      

    var controlTr = document.getElementsByName("network")[0];
    
          if (false || TypePass || AttachPass ){
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('type')[0],'change',checkShowRulesNetwork);";
      allEvents = allEvents + "addListener(document.getElementsByName('attach')[0],'click',checkShowRulesNetwork);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesPortMode();";//default invoked when loading HTML
    function checkShowRulesPortMode(){
          var TypePass = false;
      
              if (/^AggregationTrunk$/.test(document.getElementsByName("type")[0].value)) {TypePass = true;}
                        var RolesPass = false;
      
              if (/^.*PE.*$/.test(document.getElementsByName("roles")[0].value)) {RolesPass = true;}
                        
      

    var controlTr = document.getElementsByName("portmode")[0];
    
          if (true && TypePass && RolesPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('type')[0],'change',checkShowRulesPortMode);";
      allEvents = allEvents + "addListener(document.getElementsByName('roles')[0],'change',checkShowRulesPortMode);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                    document.getElementsByName("network")[0].parentNode.parentNode.style.display="none";
                                                document.getElementsByName("portmode")[0].parentNode.parentNode.style.display="none";
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
      
                                                  <html:hidden property="linkid" value="<%= LinkId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="n1" value="<%= N1 %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.ne1.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ne1" value="<%= NE1 %>"/>
                                                        <html:select disabled="true" property="ne1" value="<%= NE1 %>" onchange="sendthis('ne1');">
                      <html:options collection="NE1ListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.ne1.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.tp1.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="tp1" value="<%= TP1 %>" onchange="sendthis('tp1');">
                      <html:options collection="TP1ListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.tp1.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="oldtype" value="<%= OldType %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="type" value="<%= Type %>" onchange="sendthis('type');">
                      <html:options collection="TypeListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                                    <input type="hidden" name="attach" value="<%= Attach %>"/>  
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.network.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="network" value="<%= Network %>" onchange="sendthis('network');">
                      <html:options collection="NetworkListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.network.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="n2" value="<%= N2 %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.ne2.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="ne2" value="<%= NE2 %>" onchange="sendthis('ne2');">
                      <html:options collection="NE2ListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.ne2.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.tp2.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="tp2" value="<%= TP2 %>" onchange="sendthis('tp2');">
                      <html:options collection="TP2ListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.tp2.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.portmode.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(PortMode==null||PortMode.trim().equals("")) {
                          selValue="SubIfPresent";
                        } else {
                          selValue=PortMode.toString();
                        }    
                    %>

                    <html:select  property="portmode" value="<%= selValue %>" >
                                            <html:option value="SubIfPresent" >SubIfPresent</html:option>
                                            <html:option value="SwitchPort" >SwitchPort</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.portmode.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="roles" value="<%= Roles %>"/>            
                                                                                <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>            
                                                                                <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>            
                                                                                <html:hidden property="nnmi_lastupdatedata" value="<%= NNMi_LastUpdateData %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.l2vpn.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="l2vpn" size="24" value="<%= L2VPN %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.l2vpn.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VCApplicationResources" key="field.bpdutunnel.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bpdutunnel" size="24" value="<%= BPDUTunnel %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VCApplicationResources" key="field.bpdutunnel.description"/>
                              </table:cell>
            </table:row>
                              
      
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
