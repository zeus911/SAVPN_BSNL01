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
String datasource = (String) request.getParameter(MulticastSiteConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="MulticastSiteApplicationResources" key="<%= MulticastSiteConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.MulticastSiteForm.action = '/activator<%=moduleConfig%>/DeleteCommitMulticastSiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.MulticastSiteForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="MulticastSiteApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.MulticastSite beanMulticastSite = (com.hp.ov.activator.vpn.inventory.MulticastSite) request.getAttribute(MulticastSiteConstants.MULTICASTSITE_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getAttachmentid());
                        
                                  
                      String MulticastLoopbackAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getMulticastloopbackaddress());
                        
                                  
                      String VirtualTunnelId = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getVirtualtunnelid());
                        
                                  
                      String RPMode = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getRpmode());
                        
                                  
                      String RPAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getRpaddress());
                        
                                  
                      String MSDPLocalAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getMsdplocaladdress());
                        
                                  
                      String MSDPPeerAddress = StringFacility.replaceAllByHTMLCharacter(beanMulticastSite.getMsdppeeraddress());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="MulticastSiteApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean AttachmentIdPass_AttachmentId = false ;
AttachmentIdPass_AttachmentId = java.util.regex.Pattern.compile("^\\S+$").matcher(AttachmentId).matches();
boolean showAttachmentId = false;
  if (true && AttachmentIdPass_AttachmentId ){
showAttachmentId = true;
}


boolean VirtualTunnelIdPass_VirtualTunnelId = false ;
VirtualTunnelIdPass_VirtualTunnelId = java.util.regex.Pattern.compile("^\\S+$").matcher(VirtualTunnelId).matches();
boolean showVirtualTunnelId = false;
  if (true && VirtualTunnelIdPass_VirtualTunnelId ){
showVirtualTunnelId = true;
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
      
      <%if(showAttachmentId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= MulticastLoopbackAddress != null? MulticastLoopbackAddress : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showVirtualTunnelId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= VirtualTunnelId != null? VirtualTunnelId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Disabled" ,"Disabled");
                                            valueShowMap.put("Auto-RP-Announce" ,"Auto-RP-Announce");
                                            valueShowMap.put("Auto-RP-Discovery" ,"Auto-RP-Discovery");
                                            valueShowMap.put("Auto-RP-Mapping" ,"Auto-RP-Mapping");
                                            valueShowMap.put("Remote" ,"Remote");
                                            valueShowMap.put("Local" ,"Local");
                                            valueShowMap.put("Anycast-non-RP" ,"Anycast-non-RP");
                                            valueShowMap.put("Anycast-RP" ,"Anycast-RP");
                                          if(RPMode!=null)
                     RPMode=(String)valueShowMap.get(RPMode);
              %>
              <%= RPMode != null? RPMode : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RPAddress != null? RPAddress : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.alias"/>
                          </table:cell>
            <table:cell>
                            <%= MSDPLocalAddress != null? MSDPLocalAddress : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.alias"/>
                          </table:cell>
            <table:cell>
                            <%= MSDPPeerAddress != null? MSDPPeerAddress : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitMulticastSiteAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="attachmentid" value="<%= String.valueOf(AttachmentId) %>"/>
              </html:form>
  </body>
</html>

