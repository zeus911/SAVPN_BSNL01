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

String refreshTree = (String) request.getAttribute(L2VPNConstants.REFRESH_TREE);

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
    <title><bean:message bundle="L2VPNApplicationResources" key="<%= L2VPNConstants.JSP_VIEW_TITLE %>"/></title>
 
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
		<xmaps:draw scope="database" name="l2vpndiag" solution="SAVPN" sort="sugiyama" gap="140" />
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
    <title><bean:message bundle="L2VPNApplicationResources" key="<%= L2VPNConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.L2VPN beanL2VPN = (com.hp.ov.activator.vpn.inventory.L2VPN) request.getAttribute(L2VPNConstants.L2VPN_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getServiceid());
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getCustomerid());
                      String Customer = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getCustomer());
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getContactperson());
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getServicename());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getName());
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getInitiationdate());
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getActivationdate());
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getModificationdate());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getState());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getType());
                      String VPNTopologyType = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getVpntopologytype());
                      String InterfaceType = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getInterfacetype());
                      String VlanId = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getVlanid());
                      String QoSProfile_PE = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getQosprofile_pe());
                      String QoSProfile_CE = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getQosprofile_ce());
                      boolean Fixed = new Boolean(beanL2VPN.getFixed()).booleanValue();
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanL2VPN.getComments());
                      String __count = "" + beanL2VPN.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanL2VPN.get__count()) : "";
              if( beanL2VPN.get__count()==Integer.MIN_VALUE)
  __count = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L2VPNApplicationResources" key="jsp.view.title"/>
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


boolean VlanIdPass_VlanId = false ;
VlanIdPass_VlanId = java.util.regex.Pattern.compile("^[1-9][0-9]*$").matcher(VlanId).matches();
boolean showVlanId = false;
  if (true && VlanIdPass_VlanId ){
showVlanId = true;
}


boolean InterfaceTypePass_Fixed = false ;
InterfaceTypePass_Fixed = java.util.regex.Pattern.compile("^VPLS-PortVlan$").matcher(InterfaceType).matches();
boolean showFixed = false;
  if (true && InterfaceTypePass_Fixed ){
showFixed = true;
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
              <bean:message bundle="L2VPNApplicationResources" key="field.customer.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Customer != null? Customer : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.customer.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.contactperson.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.initiationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.activationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showModificationDate){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.modificationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showVPNTopologyType){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.vpntopologytype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VPNTopologyType != null? VPNTopologyType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.vpntopologytype.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.interfacetype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= InterfaceType != null? InterfaceType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.interfacetype.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showVlanId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VlanId != null? VlanId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.vlanid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.qosprofile_pe.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= QoSProfile_PE != null? QoSProfile_PE : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.qosprofile_pe.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                        <%if(showFixed){%>         
                    <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.fixed.alias"/>
                                *
                          </table:cell>
            <table:cell>
              <%= Fixed %>
            </table:cell>
            <table:cell>
              <bean:message bundle="L2VPNApplicationResources" key="field.fixed.description"/>
            </table:cell>
          </table:row>
                                  <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L2VPNApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L2VPNApplicationResources" key="field.comments.description"/>
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