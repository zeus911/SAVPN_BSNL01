<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
java.sql.*,
javax.sql.DataSource,
com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
java.util.StringTokenizer,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

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

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");
//System.out.println("refreshTreeRimid:"+refreshTreeRimid );

String refreshTree = (String) request.getAttribute(L3FlowPointConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="L3FlowPointApplicationResources" key="<%= L3FlowPointConstants.JSP_VIEW_TITLE %>"/></title>
 
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( refreshTree != null && refreshTree.equalsIgnoreCase("true") ) {
%>
      parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">
  

<%
com.hp.ov.activator.vpn.inventory.L3FlowPoint beanL3FlowPoint = (com.hp.ov.activator.vpn.inventory.L3FlowPoint) request.getAttribute(L3FlowPointConstants.L3FLOWPOINT_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String TerminationPointId = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getTerminationpointid());
                      String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getAttachmentid());
                      String VRFName = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getVrfname());
                      String PE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getPe_interfaceip());
                      String PE_InterfaceSecondaryIP = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getPe_interfacesecondaryip());
                      String CE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getCe_interfaceip());
                      String CE_InterfaceSecondaryIP = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getCe_interfacesecondaryip());
                      String Protocol = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getProtocol());
                      String OSPF_id = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getOspf_id());
                      String Rip_id = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getRip_id());
                      String Maximum_Prefix = "" + beanL3FlowPoint.getMaximum_prefix();
      Maximum_Prefix = (Maximum_Prefix != null && !(Maximum_Prefix.trim().equals(""))) ? nfA.format(beanL3FlowPoint.getMaximum_prefix()) : "";
              if( beanL3FlowPoint.getMaximum_prefix()==Integer.MIN_VALUE)
  Maximum_Prefix = "";
                String StaticRoutes = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getStaticroutes());
                      boolean SOO_Configured = new Boolean(beanL3FlowPoint.getSoo_configured()).booleanValue();
                      String RateLimit_in = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getRatelimit_in());
                      String QoSProfile_in = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getQosprofile_in());
                      String RateLimit_out = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getRatelimit_out());
                      String QoSProfile_out = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getQosprofile_out());
                      boolean QoSChildEnabled = new Boolean(beanL3FlowPoint.getQoschildenabled()).booleanValue();
                      String mCAR = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getMcar());
              
                                
                      String mCoS = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getMcos());
              
                                
                      String LoopbackId = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getLoopbackid());
              
                                
                      String Master = StringFacility.replaceAllByHTMLCharacter(beanL3FlowPoint.getMaster());
              
                                
                      String Priority = "" + beanL3FlowPoint.getPriority();
      Priority = (Priority != null && !(Priority.trim().equals(""))) ? nfA.format(beanL3FlowPoint.getPriority()) : "";
                      
              if( beanL3FlowPoint.getPriority()==Integer.MIN_VALUE)
  Priority = "";
                            
                String VRRP_Group_Id = "" + beanL3FlowPoint.getVrrp_group_id();
      VRRP_Group_Id = (VRRP_Group_Id != null && !(VRRP_Group_Id.trim().equals(""))) ? nfA.format(beanL3FlowPoint.getVrrp_group_id()) : "";
                      
              if( beanL3FlowPoint.getVrrp_group_id()==Integer.MIN_VALUE)
  VRRP_Group_Id = "";
                            
    
DataSource dataSource1 = (DataSource) InventoryTreeServlet.getDatasource(request.getParameter(L3FlowPointConstants.DATASOURCE));
Connection con1 = null;

com.hp.ov.activator.vpn.inventory.EXPMapping[] expMaps =null;
com.hp.ov.activator.vpn.inventory.StaticRoute[] staticRoutes = null;

try {
con1 = dataSource1.getConnection();


expMaps = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con1);
staticRoutes = com.hp.ov.activator.vpn.inventory.StaticRoute.findByAttachmentid(con1, AttachmentId);

// Get static routes

	

} catch (Exception e) {
e.printStackTrace();
} finally {
try {
con1.close();
} catch (Throwable th) {
// don't matter
}
}


                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3FlowPointApplicationResources" key="jsp.view.title"/>
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
      <%if(showTerminationPointId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TerminationPointId != null? TerminationPointId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showAttachmentId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.attachmentid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.attachmentid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.vrfname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VRFName != null? VRFName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.vrfname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PE_InterfaceIP != null? PE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfacesecondaryip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PE_InterfaceSecondaryIP != null? PE_InterfaceSecondaryIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfacesecondaryip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CE_InterfaceIP != null? CE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfaceip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfacesecondaryip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CE_InterfaceSecondaryIP != null? CE_InterfaceSecondaryIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfacesecondaryip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.protocol.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Protocol != null? Protocol : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.protocol.description"/>
                                                                              </table:cell>
          </table:row>
                                                           





<logic:notEqual name="<%=L3FlowPointConstants.L3FLOWPOINT_BEAN%>" property="ospf_id" value="0" scope="request">
<logic:equal name="<%=L3FlowPointConstants.L3FLOWPOINT_BEAN%>" property="protocol" value="OSPF" scope="request">

                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.ospf_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= OSPF_id != null? OSPF_id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.ospf_id.description"/>
                                                                              </table:cell>
          </table:row>
</logic:equal>
</logic:notEqual>                                                                        


<logic:notEqual name="<%=L3FlowPointConstants.L3FLOWPOINT_BEAN%>" property="rip_id" value="0" scope="request">
<logic:equal name="<%=L3FlowPointConstants.L3FLOWPOINT_BEAN%>" property="protocol" value="RIP" scope="request">
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.rip_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Rip_id != null? Rip_id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.rip_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
</logic:equal>
</logic:notEqual>   

<logic:notEqual name="<%=L3FlowPointConstants.L3FLOWPOINT_BEAN%>" property="maximum_prefix" value="0" scope="request">
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.maximum_prefix.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Maximum_Prefix != null? Maximum_Prefix : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.maximum_prefix.description"/>
                                                                              </table:cell>
          </table:row>
                                                           

</logic:notEqual>                   



<%
String routes = "";

staticRoutes = staticRoutes != null ? staticRoutes : new com.hp.ov.activator.vpn.inventory.StaticRoute[0];

for (int i = 0; i < staticRoutes.length; i++) 
{
	com.hp.ov.activator.vpn.inventory.StaticRoute staticRouteObj = staticRoutes[i];
	String staticRouteStr = staticRouteObj.getStaticrouteaddress();
	
	StringTokenizer ipaddress = new StringTokenizer(staticRouteStr, "/");
	String ip = ipaddress.nextToken();
	String mask = ipaddress.nextToken();
	
	routes += ip + "/" + mask +"<BR>";
}

%>

                                                                       
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.staticroutes.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= routes == null ? "" : routes %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.staticroutes.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                    <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.soo_configured.alias"/>
                          </table:cell>
            <table:cell>
              <%= SOO_Configured %>
            </table:cell>
            <table:cell>
              <bean:message bundle="L3FlowPointApplicationResources" key="field.soo_configured.description"/>
            </table:cell>
          </table:row>
                                        <%if(showRateLimit_in){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RateLimit_in != null? RateLimit_in : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showQoSProfile_in){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= QoSProfile_in != null? QoSProfile_in : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                              </table:cell>
          </table:row>
	  
	  <%String profileName = QoSProfile_in;%>
	  <%@include file="ProfileData.jsp"%>

                                            <%}%>      <%if(showRateLimit_out){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RateLimit_out != null? RateLimit_out : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showQoSProfile_out){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= QoSProfile_out != null? QoSProfile_out : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                              </table:cell>
          </table:row>
	  
	  <%String profileName = QoSProfile_out;%>
	  <%@include file="ProfileData.jsp"%>
                                            <%}%>               
                    <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.qoschildenabled.alias"/>
                          </table:cell>
            <table:cell>
              <%= QoSChildEnabled %>
            </table:cell>
            <table:cell>
              <bean:message bundle="L3FlowPointApplicationResources" key="field.qoschildenabled.description"/>
            </table:cell>
          </table:row>

			<%
			String className = "";
			final int expLength = expMaps == null ? 0 : expMaps.length;
			for (int i = 0; i < expLength; i++) {
			EXPMapping mapping = expMaps[i];
			if(mapping.getExpvalue().equals(mCoS))
			className = mapping.getClassname();
			}
			%>
                                        <%if(showmCAR){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.mcar.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= mCAR != null? mCAR : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.mcar.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showmCoS){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.mcos.alias"/>
                          </table:cell>
            <table:cell>
<%= mCoS== null ? "" : StringFacility.replaceAllByHTMLCharacter(className + '('+mCoS+')') %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.mcos.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showLoopbackId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.loopbackid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= LoopbackId != null? LoopbackId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.loopbackid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showMaster){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.master.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Master != null? Master : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.master.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showPriority){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.priority.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Priority != null? Priority : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.priority.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showVRRP_Group_Id){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3FlowPointApplicationResources" key="field.vrrp_group_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VRRP_Group_Id != null? VRRP_Group_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3FlowPointApplicationResources" key="field.vrrp_group_id.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

  </body>
</html>
