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
String datasource = (String) request.getParameter(Sh_L3AccessFlowConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_L3AccessFlowApplicationResources" key="<%= Sh_L3AccessFlowConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_L3AccessFlowForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_L3AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_L3AccessFlowForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_L3AccessFlowApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_L3AccessFlow beanSh_L3AccessFlow = (com.hp.ov.activator.vpn.inventory.Sh_L3AccessFlow) request.getAttribute(Sh_L3AccessFlowConstants.SH_L3ACCESSFLOW_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getServiceid());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getCustomerid());
                        
                                  
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getServicename());
                        
                                  
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getInitiationdate());
                        
                                  
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getActivationdate());
                        
                                  
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getModificationdate());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getState());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getType());
                        
                                  
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getContactperson());
                        
                                  
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getComments());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getDbprimarykey());
                        
                                  
                        String __count = "" + beanSh_L3AccessFlow.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_L3AccessFlow.get__count()) : "";
                          
                  if( beanSh_L3AccessFlow.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
                      String SiteId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getSiteid());
                        
                                  
                      String VlanId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getVlanid());
                        
                                  
                      String PE_Status = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getPe_status());
                        
                                  
                      String CE_Status = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getCe_status());
                        
                                  
                      String AccessNW_Status = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getAccessnw_status());
                        
                                  
                      String IPNet = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getIpnet());
                        
                                  
                      String Netmask = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getNetmask());
                        
                                  
                      String Domain_id = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getDomain_id());
                        
                                  
                      String MDTData = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getMdtdata());
                        
                                  
                      String LoopAddr = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getLoopaddr());
                        
                                  
                      String RP = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getRp());
                        
                                  
                      boolean CE_based_QoS = new Boolean(beanSh_L3AccessFlow.getCe_based_qos()).booleanValue();
                  
                                  
                      String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanSh_L3AccessFlow.getAddressfamily());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.serviceid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= ServiceId != null? ServiceId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.serviceid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.customerid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.customerid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.servicename.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ServiceName != null? ServiceName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.servicename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.initiationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.activationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.modificationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.contactperson.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.comments.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.__count.description"/>
                                    <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.siteid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= SiteId != null? SiteId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.siteid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VlanId != null? VlanId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.vlanid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.pe_status.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("In Progress" ,"In Progress");
                                            valueShowMap.put("Partial" ,"Partial");
                                            valueShowMap.put("OK" ,"OK");
                                            valueShowMap.put("Ignore" ,"Ignore");
                                          if(PE_Status!=null)
                     PE_Status=(String)valueShowMap.get(PE_Status);
              %>
              <%= PE_Status != null? PE_Status : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.pe_status.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_status.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("In Progress" ,"In Progress");
                                            valueShowMap.put("Partial" ,"Partial");
                                            valueShowMap.put("OK" ,"OK");
                                            valueShowMap.put("Ignore" ,"Ignore");
                                          if(CE_Status!=null)
                     CE_Status=(String)valueShowMap.get(CE_Status);
              %>
              <%= CE_Status != null? CE_Status : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_status.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("In Progress" ,"In Progress");
                                            valueShowMap.put("Partial" ,"Partial");
                                            valueShowMap.put("OK" ,"OK");
                                            valueShowMap.put("Ignore" ,"Ignore");
                                          if(AccessNW_Status!=null)
                     AccessNW_Status=(String)valueShowMap.get(AccessNW_Status);
              %>
              <%= AccessNW_Status != null? AccessNW_Status : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.accessnw_status.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ipnet.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IPNet != null? IPNet : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ipnet.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.netmask.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Netmask != null? Netmask : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.netmask.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.domain_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Domain_id != null? Domain_id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.domain_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.mdtdata.alias"/>
                          </table:cell>
            <table:cell>
                            <%= MDTData != null? MDTData : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.mdtdata.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.loopaddr.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LoopAddr != null? LoopAddr : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.loopaddr.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.rp.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("yes" ,"yes");
                                            valueShowMap.put("no" ,"no");
                                          if(RP!=null)
                     RP=(String)valueShowMap.get(RP);
              %>
              <%= RP != null? RP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.rp.description"/>
                                                                      </table:cell>
          </table:row>
                                                                       <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_based_qos.alias"/>
                          </table:cell>
            <table:cell>
              <%= CE_based_QoS %>
            </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_based_qos.description"/>
            </table:cell>
          </table:row>
                                                                         <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.addressfamily.alias"/>
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
              <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.addressfamily.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_L3AccessFlowAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="serviceid" value="<%= String.valueOf(ServiceId) %>"/>
              </html:form>
  </body>
</html>

