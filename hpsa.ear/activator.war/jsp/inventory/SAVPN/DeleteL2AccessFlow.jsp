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
String datasource = (String) request.getParameter(L2AccessFlowConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="L2AccessFlowApplicationResources" key="<%= L2AccessFlowConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.L2AccessFlowForm.action = '/activator<%=moduleConfig%>/DeleteCommitL2AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.L2AccessFlowForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="L2AccessFlowApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.L2AccessFlow beanL2AccessFlow = (com.hp.ov.activator.vpn.inventory.L2AccessFlow) request.getAttribute(L2AccessFlowConstants.L2ACCESSFLOW_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getServiceid());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getCustomerid());
                        
                                  
                      String Customer = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getCustomer());
                        
                                  
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getServicename());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getName());
                        
                                  
                      String VPNName = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getVpnname());
                        
                                  
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getInitiationdate());
                        
                                  
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getActivationdate());
                        
                                  
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getModificationdate());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getState());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getType());
                        
                                  
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getContactperson());
                        
                                  
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getComments());
                        
                                  
                      String SiteId = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getSiteid());
                        
                                  
                      String VlanId = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getVlanid());
                        
                                  
                      String PE_Status = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getPe_status());
                        
                                  
                      String CE_Status = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getCe_status());
                        
                                  
                      String AccessNW_Status = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getAccessnw_status());
                        
                                  
                      String ASBR_Status = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getAsbr_status());
                        
                                  
                      boolean VLANMapping = new Boolean(beanL2AccessFlow.getVlanmapping()).booleanValue();
                  
                                  
                      String InterfaceType = StringFacility.replaceAllByHTMLCharacter(beanL2AccessFlow.getInterfacetype());
                        
                                  
                        String __count = "" + beanL2AccessFlow.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanL2AccessFlow.get__count()) : "";
                          
                  if( beanL2AccessFlow.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="L2AccessFlowApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean ModificationDatePass_ModificationDate = false ;
ModificationDatePass_ModificationDate = java.util.regex.Pattern.compile("^[0-9]+.*$").matcher(ModificationDate).matches();
boolean showModificationDate = false;
  if (true && ModificationDatePass_ModificationDate ){
showModificationDate = true;
}


boolean VlanIdPass_VlanId = false ;
VlanIdPass_VlanId = java.util.regex.Pattern.compile("^[1-9][0-9]*$").matcher(VlanId).matches();
boolean showVlanId = false;
  if (true && VlanIdPass_VlanId ){
showVlanId = true;
}


boolean TypePass_VLANMapping = false ;
TypePass_VLANMapping = java.util.regex.Pattern.compile("^initial$").matcher(Type).matches();
boolean showVLANMapping = false;
  if (true && TypePass_VLANMapping ){
showVLANMapping = true;
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
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.customer.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Customer != null? Customer : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.customer.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.vpnname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VPNName != null? VPNName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.vpnname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.initiationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.activationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showModificationDate){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.modificationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.contactperson.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.comments.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.siteid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= SiteId != null? SiteId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.siteid.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showVlanId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VlanId != null? VlanId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.vlanid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.pe_status.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("In Progress" ,"In Progress");
                                            valueShowMap.put("Partial" ,"Partial");
                                            valueShowMap.put("OK" ,"OK");
                                            valueShowMap.put("Ignore" ,"Ignore");
                                            valueShowMap.put("Failure" ,"Failure");
                                          if(PE_Status!=null)
                     PE_Status=(String)valueShowMap.get(PE_Status);
              %>
              <%= PE_Status != null? PE_Status : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.pe_status.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("In Progress" ,"In Progress");
                                            valueShowMap.put("Partial" ,"Partial");
                                            valueShowMap.put("OK" ,"OK");
                                            valueShowMap.put("Ignore" ,"Ignore");
                                            valueShowMap.put("Failure" ,"Failure");
                                          if(AccessNW_Status!=null)
                     AccessNW_Status=(String)valueShowMap.get(AccessNW_Status);
              %>
              <%= AccessNW_Status != null? AccessNW_Status : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.accessnw_status.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                            <%if(showVLANMapping){%>                    <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.vlanmapping.alias"/>
                          </table:cell>
            <table:cell>
              <%= VLANMapping %>
            </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.vlanmapping.description"/>
            </table:cell>
          </table:row>
                                   <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.interfacetype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= InterfaceType != null? InterfaceType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="L2AccessFlowApplicationResources" key="field.interfacetype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                  
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitL2AccessFlowAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="serviceid" value="<%= String.valueOf(ServiceId) %>"/>
              </html:form>
  </body>
</html>

