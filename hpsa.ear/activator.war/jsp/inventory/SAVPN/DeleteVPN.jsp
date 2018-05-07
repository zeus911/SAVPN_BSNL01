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
String datasource = (String) request.getParameter(VPNConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="VPNApplicationResources" key="<%= VPNConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.VPNForm.action = '/activator<%=moduleConfig%>/DeleteCommitVPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.VPNForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="VPNApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.VPN beanVPN = (com.hp.ov.activator.vpn.inventory.VPN) request.getAttribute(VPNConstants.VPN_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanVPN.getServiceid());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanVPN.getCustomerid());
                        
                                  
                      String Customer = StringFacility.replaceAllByHTMLCharacter(beanVPN.getCustomer());
                        
                                  
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanVPN.getContactperson());
                        
                                  
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanVPN.getServicename());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanVPN.getName());
                        
                                  
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanVPN.getInitiationdate());
                        
                                  
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanVPN.getActivationdate());
                        
                                  
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanVPN.getModificationdate());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanVPN.getState());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanVPN.getType());
                        
                                  
                      String QoSProfile_PE = StringFacility.replaceAllByHTMLCharacter(beanVPN.getQosprofile_pe());
                        
                                  
                      String QoSProfile_CE = StringFacility.replaceAllByHTMLCharacter(beanVPN.getQosprofile_ce());
                        
                                  
                      String VPNTopologyType = StringFacility.replaceAllByHTMLCharacter(beanVPN.getVpntopologytype());
                        
                                  
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanVPN.getComments());
                        
                                  
                        String __count = "" + beanVPN.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanVPN.get__count()) : "";
                          
                  if( beanVPN.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="VPNApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="VPNApplicationResources" key="field.customer.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Customer != null? Customer : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.customer.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.contactperson.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.initiationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.activationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showModificationDate){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.modificationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.qosprofile_pe.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_PE != null? QoSProfile_PE : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.qosprofile_pe.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                            <%if(showVPNTopologyType){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.vpntopologytype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VPNTopologyType != null? VPNTopologyType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.vpntopologytype.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="VPNApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VPNApplicationResources" key="field.comments.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                  
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitVPNAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="serviceid" value="<%= String.valueOf(ServiceId) %>"/>
              </html:form>
  </body>
</html>

