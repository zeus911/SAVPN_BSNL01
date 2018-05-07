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
String datasource = (String) request.getParameter(GISFlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="GISFlowPointApplicationResources" key="<%= GISFlowPointConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.GISFlowPointForm.action = '/activator<%=moduleConfig%>/DeleteCommitGISFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.GISFlowPointForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="GISFlowPointApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.GISFlowPoint beanGISFlowPoint = (com.hp.ov.activator.vpn.inventory.GISFlowPoint) request.getAttribute(GISFlowPointConstants.GISFLOWPOINT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TerminationPointId = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getTerminationpointid());
                        
                                  
                      String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getAttachmentid());
                        
                                  
                      String VRFName = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getVrfname());
                        
                                  
                      String PE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getPe_interfaceip());
                        
                                  
                      String PE_InterfaceSecondaryIP = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getPe_interfacesecondaryip());
                        
                                  
                      String CE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getCe_interfaceip());
                        
                                  
                      String CE_InterfaceSecondaryIP = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getCe_interfacesecondaryip());
                        
                                  
                      String Protocol = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getProtocol());
                        
                                  
                      String OSPF_id = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getOspf_id());
                        
                                  
                      String Rip_id = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getRip_id());
                        
                                  
                        String Maximum_Prefix = "" + beanGISFlowPoint.getMaximum_prefix();
                      Maximum_Prefix = (Maximum_Prefix != null && !(Maximum_Prefix.trim().equals(""))) ? nfA.format(beanGISFlowPoint.getMaximum_prefix()) : "";
                          
                  if( beanGISFlowPoint.getMaximum_prefix()==Integer.MIN_VALUE)
         Maximum_Prefix = "";
                            
                      String StaticRoutes = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getStaticroutes());
                        
                                  
                      String IPPrefixRoutes = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getIpprefixroutes());
                        
                                  
                      boolean SOO_Configured = new Boolean(beanGISFlowPoint.getSoo_configured()).booleanValue();
                  
                                  
                      String RateLimit_in = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getRatelimit_in());
                        
                                  
                      String QoSProfile_in = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getQosprofile_in());
                        
                                  
                      String RateLimit_out = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getRatelimit_out());
                        
                                  
                      String QoSProfile_out = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getQosprofile_out());
                        
                                  
                      boolean QoSChildEnabled = new Boolean(beanGISFlowPoint.getQoschildenabled()).booleanValue();
                  
                                  
                      String mCAR = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getMcar());
                        
                                  
                      String mCoS = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getMcos());
                        
                                  
                      String LoopbackId = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getLoopbackid());
                        
                                  
                      String Master = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getMaster());
                        
                                  
                        String Priority = "" + beanGISFlowPoint.getPriority();
                      Priority = (Priority != null && !(Priority.trim().equals(""))) ? nfA.format(beanGISFlowPoint.getPriority()) : "";
                          
                  if( beanGISFlowPoint.getPriority()==Integer.MIN_VALUE)
         Priority = "";
                            
                        String VRRP_Group_Id = "" + beanGISFlowPoint.getVrrp_group_id();
                      VRRP_Group_Id = (VRRP_Group_Id != null && !(VRRP_Group_Id.trim().equals(""))) ? nfA.format(beanGISFlowPoint.getVrrp_group_id()) : "";
                          
                  if( beanGISFlowPoint.getVrrp_group_id()==Integer.MIN_VALUE)
         VRRP_Group_Id = "";
                            
                      String UsageMode = StringFacility.replaceAllByHTMLCharacter(beanGISFlowPoint.getUsagemode());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="GISFlowPointApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean TerminationPointIdPass_TerminationPointId = false ;
TerminationPointIdPass_TerminationPointId = java.util.regex.Pattern.compile("^\\S+$").matcher(TerminationPointId).matches();
boolean showTerminationPointId = false;
  if (true && TerminationPointIdPass_TerminationPointId ){
showTerminationPointId = true;
}


boolean AttachmentIdPass_AttachmentId = false ;
AttachmentIdPass_AttachmentId = java.util.regex.Pattern.compile("^\\S+$").matcher(AttachmentId).matches();
boolean showAttachmentId = false;
  if (true && AttachmentIdPass_AttachmentId ){
showAttachmentId = true;
}


boolean RateLimit_inPass_RateLimit_in = false ;
RateLimit_inPass_RateLimit_in = java.util.regex.Pattern.compile("^\\S+$").matcher(RateLimit_in).matches();
boolean showRateLimit_in = false;
  if (true && RateLimit_inPass_RateLimit_in ){
showRateLimit_in = true;
}


boolean QoSProfile_inPass_QoSProfile_in = false ;
QoSProfile_inPass_QoSProfile_in = java.util.regex.Pattern.compile("^\\S+$").matcher(QoSProfile_in).matches();
boolean showQoSProfile_in = false;
  if (true && QoSProfile_inPass_QoSProfile_in ){
showQoSProfile_in = true;
}


boolean RateLimit_outPass_RateLimit_out = false ;
RateLimit_outPass_RateLimit_out = java.util.regex.Pattern.compile("^\\S+$").matcher(RateLimit_out).matches();
boolean showRateLimit_out = false;
  if (true && RateLimit_outPass_RateLimit_out ){
showRateLimit_out = true;
}


boolean QoSProfile_outPass_QoSProfile_out = false ;
QoSProfile_outPass_QoSProfile_out = java.util.regex.Pattern.compile("^\\S+$").matcher(QoSProfile_out).matches();
boolean showQoSProfile_out = false;
  if (true && QoSProfile_outPass_QoSProfile_out ){
showQoSProfile_out = true;
}


boolean mCoSPass_mCAR = false ;
mCoSPass_mCAR = java.util.regex.Pattern.compile("^\\S+$").matcher(mCoS).matches();
boolean showmCAR = false;
  if (true && mCoSPass_mCAR ){
showmCAR = true;
}


boolean mCoSPass_mCoS = false ;
mCoSPass_mCoS = java.util.regex.Pattern.compile("^\\S+$").matcher(mCoS).matches();
boolean showmCoS = false;
  if (true && mCoSPass_mCoS ){
showmCoS = true;
}


boolean LoopbackIdPass_LoopbackId = false ;
LoopbackIdPass_LoopbackId = java.util.regex.Pattern.compile("^\\S+$").matcher(LoopbackId).matches();
boolean showLoopbackId = false;
  if (true && LoopbackIdPass_LoopbackId ){
showLoopbackId = true;
}


boolean MasterPass_Master = false ;
MasterPass_Master = java.util.regex.Pattern.compile("^\\S+$").matcher(Master).matches();
boolean showMaster = false;
  if (true && MasterPass_Master ){
showMaster = true;
}


boolean MasterPass_Priority = false ;
MasterPass_Priority = java.util.regex.Pattern.compile("^\\S+$").matcher(Master).matches();
boolean showPriority = false;
  if (true && MasterPass_Priority ){
showPriority = true;
}


boolean MasterPass_VRRP_Group_Id = false ;
MasterPass_VRRP_Group_Id = java.util.regex.Pattern.compile("^\\S+$").matcher(Master).matches();
boolean showVRRP_Group_Id = false;
  if (true && MasterPass_VRRP_Group_Id ){
showVRRP_Group_Id = true;
}

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
      
      <%if(showTerminationPointId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TerminationPointId != null? TerminationPointId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showAttachmentId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.attachmentid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.attachmentid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrfname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VRFName != null? VRFName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrfname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PE_InterfaceIP != null? PE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfacesecondaryip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PE_InterfaceSecondaryIP != null? PE_InterfaceSecondaryIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfacesecondaryip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CE_InterfaceIP != null? CE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfaceip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfacesecondaryip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CE_InterfaceSecondaryIP != null? CE_InterfaceSecondaryIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfacesecondaryip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.protocol.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Protocol != null? Protocol : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.protocol.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ospf_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= OSPF_id != null? OSPF_id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ospf_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.rip_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Rip_id != null? Rip_id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.rip_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.maximum_prefix.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Maximum_Prefix != null? Maximum_Prefix : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.maximum_prefix.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.staticroutes.alias"/>
                          </table:cell>
            <table:cell>
                            <%= StaticRoutes != null? StaticRoutes : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.staticroutes.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ipprefixroutes.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IPPrefixRoutes != null? IPPrefixRoutes : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ipprefixroutes.description"/>
                                                                      </table:cell>
          </table:row>
                                                                       <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.soo_configured.alias"/>
                          </table:cell>
            <table:cell>
              <%= SOO_Configured %>
            </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.soo_configured.description"/>
            </table:cell>
          </table:row>
                                         <%if(showRateLimit_in){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_in != null? RateLimit_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showQoSProfile_in){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_in != null? QoSProfile_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showRateLimit_out){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_out != null? RateLimit_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showQoSProfile_out){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_out != null? QoSProfile_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                          <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qoschildenabled.alias"/>
                          </table:cell>
            <table:cell>
              <%= QoSChildEnabled %>
            </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qoschildenabled.description"/>
            </table:cell>
          </table:row>
                                         <%if(showmCAR){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcar.alias"/>
                          </table:cell>
            <table:cell>
                            <%= mCAR != null? mCAR : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcar.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showmCoS){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcos.alias"/>
                          </table:cell>
            <table:cell>
                            <%= mCoS != null? mCoS : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcos.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showLoopbackId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.loopbackid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LoopbackId != null? LoopbackId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.loopbackid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showMaster){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.master.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Master != null? Master : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.master.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showPriority){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.priority.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Priority != null? Priority : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.priority.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showVRRP_Group_Id){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrrp_group_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VRRP_Group_Id != null? VRRP_Group_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrrp_group_id.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="GISFlowPointApplicationResources" key="field.usagemode.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Service" ,"Service");
                                            valueShowMap.put("Aggregated" ,"Aggregated");
                                          if(UsageMode!=null)
                     UsageMode=(String)valueShowMap.get(UsageMode);
              %>
              <%= UsageMode != null? UsageMode : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.usagemode.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitGISFlowPointAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="terminationpointid" value="<%= String.valueOf(TerminationPointId) %>"/>
              </html:form>
  </body>
</html>

