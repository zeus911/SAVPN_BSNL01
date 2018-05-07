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

String refreshTree = (String) request.getAttribute(Sh_AccessFlowConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Sh_AccessFlowApplicationResources" key="<%= Sh_AccessFlowConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Sh_AccessFlow beanSh_AccessFlow = (com.hp.ov.activator.vpn.inventory.Sh_AccessFlow) request.getAttribute(Sh_AccessFlowConstants.SH_ACCESSFLOW_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getServiceid());
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getCustomerid());
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getServicename());
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getInitiationdate());
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getActivationdate());
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getModificationdate());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getState());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getType());
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getContactperson());
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getComments());
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getMarker());
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getUploadstatus());
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getDbprimarykey());
                      String __count = "" + beanSh_AccessFlow.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_AccessFlow.get__count()) : "";
              if( beanSh_AccessFlow.get__count()==Integer.MIN_VALUE)
  __count = "";
                String SiteId = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getSiteid());
                      String VlanId = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getVlanid());
                      String PE_Status = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getPe_status());
                      String CE_Status = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getCe_status());
                      String AccessNW_Status = StringFacility.replaceAllByHTMLCharacter(beanSh_AccessFlow.getAccessnw_status());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_AccessFlowApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.serviceid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ServiceId != null? ServiceId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.serviceid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.customerid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.customerid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.servicename.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ServiceName != null? ServiceName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.servicename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.initiationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.activationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.modificationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.contactperson.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.comments.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.marker.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.uploadstatus.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.dbprimarykey.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.siteid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= SiteId != null? SiteId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.siteid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VlanId != null? VlanId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.vlanid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.pe_status.alias"/>
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
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.pe_status.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.ce_status.alias"/>
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
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.ce_status.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
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
                      <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.accessnw_status.description"/>
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
