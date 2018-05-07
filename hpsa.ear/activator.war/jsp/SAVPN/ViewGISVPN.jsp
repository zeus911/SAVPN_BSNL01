<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>
<%@ taglib uri="/WEB-INF/xmaps-taglib.tld" prefix="xmaps" %>

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

String refreshTree = (String) request.getAttribute(GISVPNConstants.REFRESH_TREE);

String isMap = "false";

if ( request.getParameter("ismap") != null ) {
	isMap = request.getParameter("ismap");
}

%>

<%
if ("true".equals(isMap))
{
	String routerdiag = "false";

	if ( request.getParameter("routerdiag") != null ) {
		routerdiag = request.getParameter("routerdiag");
	}
%>
<html>
  <head>
    <title><bean:message bundle="GISVPNApplicationResources" key="<%= GISVPNConstants.JSP_VIEW_TITLE %>"/></title>
 
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
	<% if ("true".equals(routerdiag)) { %>
		<xmaps:draw scope="database" name="routerdiag" solution="SAVPN" sort="sugiyama" gap="140" />
	<% } else { %>
		<xmaps:draw scope="database" name="l3vpndiag" solution="SAVPN" sort="sugiyama" gap="140" />
	<% } %>
  </body>
</html>
<%
}
else
{	
%>
<html>
  <head>
    <title><bean:message bundle="GISVPNApplicationResources" key="<%= GISVPNConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.GISVPN beanGISVPN = (com.hp.ov.activator.vpn.inventory.GISVPN) request.getAttribute(GISVPNConstants.GISVPN_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getServiceid());
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getCustomerid());
                      String Customer = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getCustomer());
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getContactperson());
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getServicename());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getName());
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getInitiationdate());
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getActivationdate());
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getModificationdate());
                      String QoSProfile_PE = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getQosprofile_pe());
                      String QoSProfile_CE = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getQosprofile_ce());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getState());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getType());
                      String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getAddressfamily());
                      String VPNTopologyType = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getVpntopologytype());
                      String RCFlag = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getRcflag());
                      String Multicast = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getMulticast());
                      String ParentId = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getParentid());
                      String RTExport = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getRtexport());
                      String RTImport = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getRtimport());
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getComments());
                      String __count = "" + beanGISVPN.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanGISVPN.get__count()) : "";
              if( beanGISVPN.get__count()==Integer.MIN_VALUE)
  __count = "";
                String dummy = StringFacility.replaceAllByHTMLCharacter(beanGISVPN.getDummy());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="GISVPNApplicationResources" key="jsp.view.title"/>
</h2> 

<%

boolean ModificationDatePass_ModificationDate = false ;
ModificationDatePass_ModificationDate = java.util.regex.Pattern.compile("^[0-9]+.*$").matcher(ModificationDate).matches();
boolean showModificationDate = false;
  if (true && ModificationDatePass_ModificationDate ){
showModificationDate = true;
}


boolean TypePass_VPNTopologyType = false ;
TypePass_VPNTopologyType = java.util.regex.Pattern.compile("^L3VPN$").matcher(Type).matches();
boolean showVPNTopologyType = false;
  if (true && TypePass_VPNTopologyType ){
showVPNTopologyType = true;
}


boolean RCFlagPass_Multicast = false ;
RCFlagPass_Multicast = java.util.regex.Pattern.compile("^0$").matcher(RCFlag).matches();
boolean showMulticast = false;
  if (true && RCFlagPass_Multicast ){
showMulticast = true;
}


boolean RCFlagPass_ParentId = false ;
RCFlagPass_ParentId = java.util.regex.Pattern.compile("^1$").matcher(RCFlag).matches();
boolean showParentId = false;
  if (true && RCFlagPass_ParentId ){
showParentId = true;
}


boolean RCFlagPass_RTExport = false ;
RCFlagPass_RTExport = java.util.regex.Pattern.compile("^1$").matcher(RCFlag).matches();
boolean showRTExport = false;
  if (true && RCFlagPass_RTExport ){
showRTExport = true;
}


boolean RCFlagPass_RTImport = false ;
RCFlagPass_RTImport = java.util.regex.Pattern.compile("^1$").matcher(RCFlag).matches();
boolean showRTImport = false;
  if (true && RCFlagPass_RTImport ){
showRTImport = true;
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
              <bean:message bundle="GISVPNApplicationResources" key="field.customer.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Customer != null? Customer : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.customer.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.contactperson.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.initiationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.activationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showModificationDate){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.modificationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.qosprofile_pe.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= QoSProfile_PE != null? QoSProfile_PE : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.qosprofile_pe.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.addressfamily.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("IPv4" ,"IPv4");
                                            valueShowMap.put("IPv6" ,"IPv6");
                                          if(AddressFamily!=null)
                     AddressFamily=(String)valueShowMap.get(AddressFamily);
              %>
              <%= AddressFamily != null? AddressFamily : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.addressfamily.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showVPNTopologyType){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.vpntopologytype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VPNTopologyType != null? VPNTopologyType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.vpntopologytype.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                        <%if(showMulticast){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.multicast.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("unsupported" ,"unsupported");
                                            valueShowMap.put("disabled" ,"disabled");
                                            valueShowMap.put("enabled" ,"enabled");
                                          if(Multicast!=null)
                     Multicast=(String)valueShowMap.get(Multicast);
              %>
              <%= Multicast != null? Multicast : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.multicast.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showParentId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.parentid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ParentId != null? ParentId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.parentid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showRTExport){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.rtexport.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RTExport != null? RTExport : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.rtexport.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showRTImport){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.rtimport.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RTImport != null? RTImport : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.rtimport.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.comments.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="GISVPNApplicationResources" key="field.dummy.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= dummy != null? dummy : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="GISVPNApplicationResources" key="field.dummy.description"/>
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
<%
}
%>