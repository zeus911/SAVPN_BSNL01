<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
		java.sql.*,
javax.sql.DataSource,
com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
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

String refreshTree = (String) request.getAttribute(SiteConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="SiteApplicationResources" key="<%= SiteConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Site beanSite = (com.hp.ov.activator.vpn.inventory.Site) request.getAttribute(SiteConstants.SITE_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanSite.getServiceid());
                      String Customer = StringFacility.replaceAllByHTMLCharacter(beanSite.getCustomer());
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanSite.getContactperson());
                      String SiteName = StringFacility.replaceAllByHTMLCharacter(beanSite.getSitename());
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanSite.getServicename());
                      String VPNName = StringFacility.replaceAllByHTMLCharacter(beanSite.getVpnname());
                      String Region = StringFacility.replaceAllByHTMLCharacter(beanSite.getRegion());
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanSite.getInitiationdate());
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanSite.getActivationdate());
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanSite.getModificationdate());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSite.getState());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanSite.getType());
                      String SiteOfOrigin = StringFacility.replaceAllByHTMLCharacter(beanSite.getSiteoforigin());
                      boolean Managed = new Boolean(beanSite.getManaged()).booleanValue();
                      String ManagedStr = StringFacility.replaceAllByHTMLCharacter(beanSite.getManagedstr());
                      String Multicast = StringFacility.replaceAllByHTMLCharacter(beanSite.getMulticast());
                      String Protocol = StringFacility.replaceAllByHTMLCharacter(beanSite.getProtocol());
                      String RemoteASN = StringFacility.replaceAllByHTMLCharacter(beanSite.getRemoteasn());
                      String OSPF_Area = StringFacility.replaceAllByHTMLCharacter(beanSite.getOspf_area());
                      String StaticRoutes = StringFacility.replaceAllByHTMLCharacter(beanSite.getStaticroutes());
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanSite.getComments());
                      String L3FlowpointID = StringFacility.replaceAllByHTMLCharacter(beanSite.getL3flowpointid());
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSite.getCustomerid());
                      String PostalAddress = StringFacility.replaceAllByHTMLCharacter(beanSite.getPostaladdress());
                      String __count = "" + beanSite.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSite.get__count()) : "";
              if( beanSite.get__count()==Integer.MIN_VALUE)
  __count = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="SiteApplicationResources" key="jsp.view.title"/>
</h2> 

<%

boolean ModificationDatePass_ModificationDate = false ;
ModificationDatePass_ModificationDate = java.util.regex.Pattern.compile("^[0-9]+.*$").matcher(ModificationDate).matches();
boolean showModificationDate = false;
  if (true && ModificationDatePass_ModificationDate ){
showModificationDate = true;
}


boolean SiteOfOriginPass_SiteOfOrigin = false ;
SiteOfOriginPass_SiteOfOrigin = java.util.regex.Pattern.compile("^\\S+$").matcher(SiteOfOrigin).matches();
boolean showSiteOfOrigin = false;
  if (true && SiteOfOriginPass_SiteOfOrigin ){
showSiteOfOrigin = true;
}


boolean L3FlowpointIDPass_Multicast = false ;
L3FlowpointIDPass_Multicast = java.util.regex.Pattern.compile("^[1-9][0-9]*$").matcher(L3FlowpointID).matches();
boolean showMulticast = false;
  if (true && L3FlowpointIDPass_Multicast ){
showMulticast = true;
}


boolean L3FlowpointIDPass_Protocol = false ;
L3FlowpointIDPass_Protocol = java.util.regex.Pattern.compile("^[1-9][0-9]*$").matcher(L3FlowpointID).matches();
boolean showProtocol = false;
  if (true && L3FlowpointIDPass_Protocol ){
showProtocol = true;
}


boolean ProtocolPass_RemoteASN = false ;
ProtocolPass_RemoteASN = java.util.regex.Pattern.compile("^BGP$").matcher(Protocol).matches();
boolean showRemoteASN = false;
  if (true && ProtocolPass_RemoteASN ){
showRemoteASN = true;
}


boolean ProtocolPass_OSPF_Area = false ;
ProtocolPass_OSPF_Area = java.util.regex.Pattern.compile("^OSPF$").matcher(Protocol).matches();
boolean showOSPF_Area = false;
  if (true && ProtocolPass_OSPF_Area ){
showOSPF_Area = true;
}


DataSource dataSource1 = (DataSource) InventoryTreeServlet.getDatasource(request.getParameter(L3FlowPointConstants.DATASOURCE));
Connection con1 = null;

com.hp.ov.activator.vpn.inventory.StaticRoute[] staticRoutes = null;
com.hp.ov.activator.vpn.inventory.AccessFlow[] accessFlows = null;

try {
con1 = dataSource1.getConnection();


accessFlows = com.hp.ov.activator.vpn.inventory.AccessFlow.findBySiteid(con1, ServiceId);

if (accessFlows != null)
{
	staticRoutes = com.hp.ov.activator.vpn.inventory.StaticRoute.findByAttachmentid(con1, accessFlows[0].getServiceid());
}

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

boolean showStaticRoutes = false;
 if (staticRoutes != null )
 {
showStaticRoutes = true;
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
               
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.customer.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Customer != null? Customer : "" %>
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
            
              
                            <%= ContactPerson != null? ContactPerson : "" %>
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
            
              
                            <%= SiteName != null? SiteName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.sitename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.vpnname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VPNName != null? VPNName : "" %>
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
            
              
                            <%= Region != null? Region : "" %>
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
            
              
                            <%= InitiationDate != null? InitiationDate : "" %>
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
            
              
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.activationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showModificationDate){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.modificationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= State != null? State : "" %>
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
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showSiteOfOrigin){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.siteoforigin.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SiteOfOrigin != null? SiteOfOrigin : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.siteoforigin.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.managedstr.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ManagedStr != null? ManagedStr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.managedstr.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showMulticast){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.multicast.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("disabled" ,"disabled");
                                            valueShowMap.put("enabled" ,"enabled");
                                          if(Multicast!=null)
                     Multicast=(String)valueShowMap.get(Multicast);
              %>
              <%= Multicast != null? Multicast : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.multicast.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showProtocol){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.protocol.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Protocol != null? Protocol : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.protocol.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showRemoteASN){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.remoteasn.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RemoteASN != null? RemoteASN : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.remoteasn.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showOSPF_Area){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.ospf_area.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= OSPF_Area != null? OSPF_Area : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.ospf_area.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showStaticRoutes){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.staticroutes.alias"/>
                          </table:cell>
            <table:cell>
            
              
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
	
							<%= routes == null ? "" : routes %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.staticroutes.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SiteApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SiteApplicationResources" key="field.comments.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                                                 
                                              
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

  </body>
</html>
