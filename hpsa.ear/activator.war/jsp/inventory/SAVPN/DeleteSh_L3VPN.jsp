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
String datasource = (String) request.getParameter(Sh_L3VPNConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_L3VPNApplicationResources" key="<%= Sh_L3VPNConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_L3VPNForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_L3VPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_L3VPNForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_L3VPNApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_L3VPN beanSh_L3VPN = (com.hp.ov.activator.vpn.inventory.Sh_L3VPN) request.getAttribute(Sh_L3VPNConstants.SH_L3VPN_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getServiceid());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getCustomerid());
                        
                                  
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getServicename());
                        
                                  
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getInitiationdate());
                        
                                  
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getActivationdate());
                        
                                  
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getModificationdate());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getState());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getType());
                        
                                  
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getContactperson());
                        
                                  
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getComments());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getDbprimarykey());
                        
                                  
                        String __count = "" + beanSh_L3VPN.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_L3VPN.get__count()) : "";
                          
                  if( beanSh_L3VPN.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
                      String VPNTopologyType = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getVpntopologytype());
                        
                                  
                      String QoSProfile_PE = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getQosprofile_pe());
                        
                                  
                      String QoSProfile_CE = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getQosprofile_ce());
                        
                                  
                      String ParentId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getParentid());
                        
                                  
                      String Multicast = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPN.getMulticast());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_L3VPNApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.serviceid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= ServiceId != null? ServiceId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.serviceid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.customerid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.customerid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.servicename.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ServiceName != null? ServiceName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.servicename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.initiationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.activationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.modificationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.contactperson.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.comments.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.__count.description"/>
                                    <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.vpntopologytype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VPNTopologyType != null? VPNTopologyType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.vpntopologytype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_pe.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_PE != null? QoSProfile_PE : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_pe.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_ce.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_CE != null? QoSProfile_CE : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_ce.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.parentid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ParentId != null? ParentId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.parentid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.multicast.alias"/>
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
              <bean:message bundle="Sh_L3VPNApplicationResources" key="field.multicast.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_L3VPNAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="serviceid" value="<%= String.valueOf(ServiceId) %>"/>
              </html:form>
  </body>
</html>

