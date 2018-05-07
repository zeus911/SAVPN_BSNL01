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

String refreshTree = (String) request.getAttribute(AccessNetworkConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="AccessNetworkApplicationResources" key="<%= AccessNetworkConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.AccessNetwork beanAccessNetwork = (com.hp.ov.activator.vpn.inventory.AccessNetwork) request.getAttribute(AccessNetworkConstants.ACCESSNETWORK_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String NetworkId = StringFacility.replaceAllByHTMLCharacter(beanAccessNetwork.getNetworkid());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanAccessNetwork.getName());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanAccessNetwork.getType());
                      String ASN = StringFacility.replaceAllByHTMLCharacter(beanAccessNetwork.getAsn());
                  String Region = (String) request.getAttribute(AccessNetworkConstants.REGION_LABEL);
Region= StringFacility.replaceAllByHTMLCharacter(Region);
              String ParentNetworkId = (String) request.getAttribute(AccessNetworkConstants.PARENTNETWORKID_LABEL);
ParentNetworkId= StringFacility.replaceAllByHTMLCharacter(ParentNetworkId);
                  String State = StringFacility.replaceAllByHTMLCharacter(beanAccessNetwork.getState());
                      String ManagementVlans = StringFacility.replaceAllByHTMLCharacter(beanAccessNetwork.getManagementvlans());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessNetworkApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="AccessNetworkApplicationResources" key="field.networkid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NetworkId != null? NetworkId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessNetworkApplicationResources" key="field.networkid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessNetworkApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessNetworkApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessNetworkApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Network" ,"Network");
                                            valueShowMap.put("AccessNetwork" ,"AccessNetwork");
                                            valueShowMap.put("Topology" ,"Topology");
                                          if(Type!=null)
                     Type=(String)valueShowMap.get(Type);
              %>
              <%= Type != null? Type : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="AccessNetworkApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessNetworkApplicationResources" key="field.region.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Region != null? Region : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessNetworkApplicationResources" key="field.region.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessNetworkApplicationResources" key="field.parentnetworkid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ParentNetworkId != null? ParentNetworkId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessNetworkApplicationResources" key="field.parentnetworkid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessNetworkApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Ready" ,"Ready");
                                            valueShowMap.put("Accessible" ,"Accessible");
                                            valueShowMap.put("Preconfigured" ,"Preconfigured");
                                            valueShowMap.put("Planned" ,"Planned");
                                          if(State!=null)
                     State=(String)valueShowMap.get(State);
              %>
              <%= State != null? State : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="AccessNetworkApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessNetworkApplicationResources" key="field.managementvlans.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ManagementVlans != null? ManagementVlans : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessNetworkApplicationResources" key="field.managementvlans.description"/>
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
