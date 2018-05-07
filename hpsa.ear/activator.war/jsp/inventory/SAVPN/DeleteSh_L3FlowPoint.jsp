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
String datasource = (String) request.getParameter(Sh_L3FlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_L3FlowPointApplicationResources" key="<%= Sh_L3FlowPointConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_L3FlowPointForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_L3FlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_L3FlowPointForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_L3FlowPointApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_L3FlowPoint beanSh_L3FlowPoint = (com.hp.ov.activator.vpn.inventory.Sh_L3FlowPoint) request.getAttribute(Sh_L3FlowPointConstants.SH_L3FLOWPOINT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TerminationPointID = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getTerminationpointid());
                        
                                  
                      String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getAttachmentid());
                        
                                  
                      String QoSProfile_in = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getQosprofile_in());
                        
                                  
                      String QoSProfile_out = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getQosprofile_out());
                        
                                  
                      String RateLimit_in = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getRatelimit_in());
                        
                                  
                      String RateLimit_out = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getRatelimit_out());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getDbprimarykey());
                        
                                  
                      String Protocol = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getProtocol());
                        
                                  
                        String Maximum_Prefix = "" + beanSh_L3FlowPoint.getMaximum_prefix();
                      Maximum_Prefix = (Maximum_Prefix != null && !(Maximum_Prefix.trim().equals(""))) ? nfA.format(beanSh_L3FlowPoint.getMaximum_prefix()) : "";
                          
                  if( beanSh_L3FlowPoint.getMaximum_prefix()==Integer.MIN_VALUE)
         Maximum_Prefix = "";
                            
                      String StaticRoutes = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getStaticroutes());
                        
                                  
                      String OSPF_id = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getOspf_id());
                        
                                  
                      String Rip_id = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getRip_id());
                        
                                  
                      String VRFName = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getVrfname());
                        
                                  
                      String PE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getPe_interfaceip());
                        
                                  
                      String CE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getCe_interfaceip());
                        
                                  
                      String mCAR = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getMcar());
                        
                                  
                      String mCoS = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getMcos());
                        
                                  
                      String LoopbackId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3FlowPoint.getLoopbackid());
                        
                                  
                      boolean SOO_Configured = new Boolean(beanSh_L3FlowPoint.getSoo_configured()).booleanValue();
                  
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_L3FlowPointApplicationResources" key="jsp.delete.title"/>
</h2> 

<%
%>

    <div style="width:100%; text-align:center;">
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
      
                                      <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TerminationPointID != null? TerminationPointID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.attachmentid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.attachmentid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_in != null? QoSProfile_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_out != null? QoSProfile_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_in != null? RateLimit_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_out != null? RateLimit_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.protocol.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Protocol != null? Protocol : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.protocol.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.maximum_prefix.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Maximum_Prefix != null? Maximum_Prefix : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.maximum_prefix.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.staticroutes.alias"/>
                          </table:cell>
            <table:cell>
                            <%= StaticRoutes != null? StaticRoutes : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.staticroutes.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ospf_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= OSPF_id != null? OSPF_id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ospf_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.rip_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Rip_id != null? Rip_id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.rip_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.vrfname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VRFName != null? VRFName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.vrfname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PE_InterfaceIP != null? PE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CE_InterfaceIP != null? CE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ce_interfaceip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcar.alias"/>
                          </table:cell>
            <table:cell>
                            <%= mCAR != null? mCAR : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcar.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcos.alias"/>
                          </table:cell>
            <table:cell>
                            <%= mCoS != null? mCoS : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcos.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.loopbackid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LoopbackId != null? LoopbackId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.loopbackid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                       <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.soo_configured.alias"/>
                          </table:cell>
            <table:cell>
              <%= SOO_Configured %>
            </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.soo_configured.description"/>
            </table:cell>
          </table:row>
                                               
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_L3FlowPointAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="terminationpointid" value="<%= String.valueOf(TerminationPointID) %>"/>
              </html:form>
  </body>
</html>

