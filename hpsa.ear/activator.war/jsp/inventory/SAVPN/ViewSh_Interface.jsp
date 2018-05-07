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

String refreshTree = (String) request.getAttribute(Sh_InterfaceConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Sh_InterfaceApplicationResources" key="<%= Sh_InterfaceConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Sh_Interface beanSh_Interface = (com.hp.ov.activator.vpn.inventory.Sh_Interface) request.getAttribute(Sh_InterfaceConstants.SH_INTERFACE_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String TerminationPointID = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getTerminationpointid());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getName());
                      String NE_ID = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getNe_id());
                      String EC_ID = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getEc_id());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getState());
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getMarker());
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getUploadstatus());
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getDbprimarykey());
                      String __count = "" + beanSh_Interface.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_Interface.get__count()) : "";
              if( beanSh_Interface.get__count()==Integer.MIN_VALUE)
  __count = "";
                String Type = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getType());
                      String ParentIf = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getParentif());
                      String IPAddr = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getIpaddr());
                      String SubType = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getSubtype());
                      String Encapsulation = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getEncapsulation());
                      String ifIndex = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getIfindex());
                      String ActiveState = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getActivestate());
                      String UsageState = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getUsagestate());
                      String VlanId = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getVlanid());
                      String DLCI = "" + beanSh_Interface.getDlci();
              if( beanSh_Interface.getDlci()==Integer.MIN_VALUE)
  DLCI = "";
                String Timeslots = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getTimeslots());
                      String SlotsNumber = "" + beanSh_Interface.getSlotsnumber();
      SlotsNumber = (SlotsNumber != null && !(SlotsNumber.trim().equals(""))) ? nfA.format(beanSh_Interface.getSlotsnumber()) : "";
              if( beanSh_Interface.getSlotsnumber()==Integer.MIN_VALUE)
  SlotsNumber = "";
                String Bandwidth = "" + beanSh_Interface.getBandwidth();
      Bandwidth = (Bandwidth != null && !(Bandwidth.trim().equals(""))) ? nfA.format(beanSh_Interface.getBandwidth()) : "";
              if( beanSh_Interface.getBandwidth()==Integer.MIN_VALUE)
  Bandwidth = "";
                String LmiType = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getLmitype());
                      String IntfType = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getIntftype());
                      String BundleKey = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getBundlekey());
                      String BundleId = StringFacility.replaceAllByHTMLCharacter(beanSh_Interface.getBundleid());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_InterfaceApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TerminationPointID != null? TerminationPointID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.terminationpointid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ne_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NE_ID != null? NE_ID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ne_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ec_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= EC_ID != null? EC_ID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ec_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Up" ,"Up");
                                            valueShowMap.put("Down" ,"Down");
                                            valueShowMap.put("Unknown" ,"Unknown");
                                          if(State!=null)
                     State=(String)valueShowMap.get(State);
              %>
              <%= State != null? State : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.marker.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.uploadstatus.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dbprimarykey.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.parentif.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ParentIf != null? ParentIf : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.parentif.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ipaddr.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IPAddr != null? IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.subtype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SubType != null? SubType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.subtype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.encapsulation.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Encapsulation != null? Encapsulation : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.encapsulation.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ifindex.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ifIndex != null? ifIndex : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ifindex.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.activestate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Activated" ,"Activated");
                                            valueShowMap.put("Failed" ,"Failed");
                                            valueShowMap.put("Undefined" ,"Undefined");
                                            valueShowMap.put("Ready" ,"Ready");
                                          if(ActiveState!=null)
                     ActiveState=(String)valueShowMap.get(ActiveState);
              %>
              <%= ActiveState != null? ActiveState : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.activestate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.usagestate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Available" ,"Available");
                                            valueShowMap.put("SubIfPresent" ,"SubIfPresent");
                                            valueShowMap.put("Uplink" ,"Uplink");
                                            valueShowMap.put("Reserved" ,"Reserved");
                                            valueShowMap.put("InBundle" ,"InBundle");
                                          if(UsageState!=null)
                     UsageState=(String)valueShowMap.get(UsageState);
              %>
              <%= UsageState != null? UsageState : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.usagestate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VlanId != null? VlanId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.vlanid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dlci.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DLCI != null? DLCI : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dlci.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.timeslots.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Timeslots != null? Timeslots : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.timeslots.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.slotsnumber.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SlotsNumber != null? SlotsNumber : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.slotsnumber.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bandwidth.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Bandwidth != null? Bandwidth : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bandwidth.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.lmitype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= LmiType != null? LmiType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.lmitype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.intftype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IntfType != null? IntfType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.intftype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundlekey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= BundleKey != null? BundleKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundlekey.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundleid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= BundleId != null? BundleId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundleid.description"/>
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
