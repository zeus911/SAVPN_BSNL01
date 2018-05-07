<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors " %>

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
Sh_L3FlowPointForm form = (Sh_L3FlowPointForm) request.getAttribute("Sh_L3FlowPointForm");
if(form==null) {
 form=new Sh_L3FlowPointForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(Sh_L3FlowPointConstants.DATASOURCE);
String tabName = (String) request.getParameter(Sh_L3FlowPointConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.Sh_L3FlowPointFormSearch;
var formEl = formObj.elements;
for (var i=0; i<formEl.length; i++)
{
var element = formEl[i];
if (element.type == 'submit') { continue; }
if (element.type == 'reset') { continue; }
if (element.type == 'button') { continue; }
if (element.type == 'hidden') { continue; }
if (element.type == 'text') { element.value = ''; }
if (element.type == 'textarea') { element.value = ''; }
if (element.type == 'checkbox') {  element.checked = false;  }
if (element.type == 'radio') {if(element.value == '') element.checked=true; else element.checked=false;}
if (element.type == 'select-multiple') { element.selectedIndex = -1; }
if (element.type == 'select-one') { element.selectedIndex = -1; }
}
}
  function performCommit() {
  var checkfalse=false;
                    if(document.getElementsByName("terminationpointid___hide")[0].checked) {
                            if(document.getElementsByName("attachmentid___hide")[0].checked) {
                            if(document.getElementsByName("qosprofile_in___hide")[0].checked) {
                            if(document.getElementsByName("qosprofile_out___hide")[0].checked) {
                            if(document.getElementsByName("ratelimit_in___hide")[0].checked) {
                            if(document.getElementsByName("ratelimit_out___hide")[0].checked) {
                            if(document.getElementsByName("marker___hide")[0].checked) {
                            if(document.getElementsByName("uploadstatus___hide")[0].checked) {
                            if(document.getElementsByName("dbprimarykey___hide")[0].checked) {
                            if(document.getElementsByName("protocol___hide")[0].checked) {
                            if(document.getElementsByName("maximum_prefix___hide")[0].checked) {
                            if(document.getElementsByName("staticroutes___hide")[0].checked) {
                            if(document.getElementsByName("ospf_id___hide")[0].checked) {
                            if(document.getElementsByName("rip_id___hide")[0].checked) {
                            if(document.getElementsByName("vrfname___hide")[0].checked) {
                            if(document.getElementsByName("pe_interfaceip___hide")[0].checked) {
                            if(document.getElementsByName("ce_interfaceip___hide")[0].checked) {
                            if(document.getElementsByName("mcar___hide")[0].checked) {
                            if(document.getElementsByName("mcos___hide")[0].checked) {
                            if(document.getElementsByName("loopbackid___hide")[0].checked) {
                            if(document.getElementsByName("soo_configured___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="Sh_L3FlowPointApplicationResources" key="<%= Sh_L3FlowPointConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.Sh_L3FlowPointFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSh_L3FlowPointAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.Sh_L3FlowPointFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="Sh_L3FlowPointApplicationResources" key="<%= Sh_L3FlowPointConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(Sh_L3FlowPointConstants.USER) == null) {
  response.sendRedirect(Sh_L3FlowPointConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "terminationpointid";
                                              %>

    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
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
%>
    }
    </script>
  </head>

  <body style="overflow:auto;" onload="init();">

<%
      String TerminationPointID = form.getTerminationpointid();
            String AttachmentId = form.getAttachmentid();
            String QoSProfile_in = form.getQosprofile_in();
            String QoSProfile_out = form.getQosprofile_out();
            String RateLimit_in = form.getRatelimit_in();
            String RateLimit_out = form.getRatelimit_out();
            String Marker = form.getMarker();
            String UploadStatus = form.getUploadstatus();
            String DBPrimaryKey = form.getDbprimarykey();
            String Protocol = form.getProtocol();
            String Maximum_Prefix = form.getMaximum_prefix();
          String Maximum_Prefix___ = form.getMaximum_prefix___();
            String StaticRoutes = form.getStaticroutes();
            String OSPF_id = form.getOspf_id();
            String Rip_id = form.getRip_id();
            String VRFName = form.getVrfname();
            String PE_InterfaceIP = form.getPe_interfaceip();
            String CE_InterfaceIP = form.getCe_interfaceip();
            String mCAR = form.getMcar();
            String mCoS = form.getMcos();
            String LoopbackId = form.getLoopbackid();
            String SOO_Configured = form.getSoo_configured();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_L3FlowPointApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="Sh_L3FlowPointApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="AttachmentId"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Protocol"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Maximum_Prefix"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="StaticRoutes"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="OSPF_id"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Rip_id"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="VRFName"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="PE_InterfaceIP"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="CE_InterfaceIP"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="mCAR"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="mCoS"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="LoopbackId"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="SOO_Configured"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSh_L3FlowPointAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

  <html:form action="<%=searchFormAction%>" style="text-align:center;">
    <table:table>
      <table:header>
        <table:cell>
          <bean:message bundle="InventoryResources" key="hide.heading"/>
        </table:cell>

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

                        <table:row>
            <table:cell>
              <center>
                <html:checkbox property="terminationpointid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.terminationpointid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="terminationpointid" size="16" value="<%= TerminationPointID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.terminationpointid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="attachmentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.attachmentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="attachmentid" size="16" value="<%= AttachmentId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.attachmentid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_in___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_in.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_in" size="16" value="<%= QoSProfile_in %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_in.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_out___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_out.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_out" size="16" value="<%= QoSProfile_out %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_out.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ratelimit_in___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_in.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ratelimit_in" size="16" value="<%= RateLimit_in %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_in.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ratelimit_out___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_out.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ratelimit_out" size="16" value="<%= RateLimit_out %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_out.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="marker___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.marker.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="marker" size="16" value="<%= Marker %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.marker.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="uploadstatus___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.uploadstatus.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="uploadstatus" size="16" value="<%= UploadStatus %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.uploadstatus.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dbprimarykey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.dbprimarykey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dbprimarykey" size="16" value="<%= DBPrimaryKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.dbprimarykey.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="protocol___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.protocol.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="protocol" size="16" value="<%= Protocol %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.protocol.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="maximum_prefix___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.maximum_prefix.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="maximum_prefix" size="16" value="<%= Maximum_Prefix %>"/>
                                  -
                  <html:text property="maximum_prefix___" size="16" value="<%= Maximum_Prefix___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.maximum_prefix.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="staticroutes___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.staticroutes.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="staticroutes" size="16" value="<%= StaticRoutes %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.staticroutes.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ospf_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ospf_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ospf_id" size="16" value="<%= OSPF_id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ospf_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rip_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.rip_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rip_id" size="16" value="<%= Rip_id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.rip_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vrfname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.vrfname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vrfname" size="16" value="<%= VRFName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.vrfname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pe_interfaceip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="pe_interfaceip" size="16" value="<%= PE_InterfaceIP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ce_interfaceip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ce_interfaceip" size="16" value="<%= CE_InterfaceIP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ce_interfaceip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="mcar___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcar.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="mcar" size="16" value="<%= mCAR %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcar.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="mcos___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcos.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="mcos" size="16" value="<%= mCoS %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcos.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="loopbackid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.loopbackid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="loopbackid" size="16" value="<%= LoopbackId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.loopbackid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="soo_configured___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.soo_configured.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="soo_configured" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="soo_configured" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="soo_configured" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.soo_configured.description"/>
                          </table:cell>
          </table:row>
              
  
            <table:row>
              <table:cell colspan="4" align="center">
              <br>
              </table:cell>
            </table:row>
            <table:row>
              <table:cell colspan="4" align="center">
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.submit.button"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.reset.button"/>" class="ButtonReset" onclick="clearForm();">
              </table:cell>
            </table:row>
    </table:table>

  </html:form>

  </body>

</html>
