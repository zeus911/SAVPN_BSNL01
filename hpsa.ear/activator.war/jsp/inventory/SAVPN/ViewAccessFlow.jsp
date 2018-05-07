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

String refreshTree = (String) request.getAttribute(AccessFlowConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="AccessFlowApplicationResources" key="<%= AccessFlowConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.AccessFlow beanAccessFlow = (com.hp.ov.activator.vpn.inventory.AccessFlow) request.getAttribute(AccessFlowConstants.ACCESSFLOW_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getServiceid());
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getCustomerid());
                      String Customer = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getCustomer());
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getContactperson());
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getServicename());
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getInitiationdate());
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getActivationdate());
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getModificationdate());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getState());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getType());
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getComments());
                      String __count = "" + beanAccessFlow.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanAccessFlow.get__count()) : "";
              if( beanAccessFlow.get__count()==Integer.MIN_VALUE)
  __count = "";
                String Name = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getName());
                      String VPNName = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getVpnname());
                      String SiteId = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getSiteid());
                      String VlanId = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getVlanid());
                      String PE_Status = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getPe_status());
                      String CE_Status = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getCe_status());
                      String AccessNW_Status = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getAccessnw_status());
                      String ASBR_Status = StringFacility.replaceAllByHTMLCharacter(beanAccessFlow.getAsbr_status());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessFlowApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="AccessFlowApplicationResources" key="field.customer.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Customer != null? Customer : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.customer.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.contactperson.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.initiationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.activationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showModificationDate){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.modificationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.comments.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.vpnname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VPNName != null? VPNName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.vpnname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.siteid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= SiteId != null? SiteId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.siteid.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showVlanId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VlanId != null? VlanId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.vlanid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.pe_status.alias"/>
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
                      <bean:message bundle="AccessFlowApplicationResources" key="field.pe_status.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.ce_status.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("In Progress" ,"In Progress");
                                            valueShowMap.put("Partial" ,"Partial");
                                            valueShowMap.put("OK" ,"OK");
                                            valueShowMap.put("Ignore" ,"Ignore");
                                            valueShowMap.put("Failure" ,"Failure");
                                          if(CE_Status!=null)
                     CE_Status=(String)valueShowMap.get(CE_Status);
              %>
              <%= CE_Status != null? CE_Status : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.ce_status.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
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
                      <bean:message bundle="AccessFlowApplicationResources" key="field.accessnw_status.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessFlowApplicationResources" key="field.asbr_status.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("In Progress" ,"In Progress");
                                            valueShowMap.put("Partial" ,"Partial");
                                            valueShowMap.put("OK" ,"OK");
                                            valueShowMap.put("Ignore" ,"Ignore");
                                            valueShowMap.put("Failure" ,"Failure");
                                          if(ASBR_Status!=null)
                     ASBR_Status=(String)valueShowMap.get(ASBR_Status);
              %>
              <%= ASBR_Status != null? ASBR_Status : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="AccessFlowApplicationResources" key="field.asbr_status.description"/>
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
