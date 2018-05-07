<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnmi.dl.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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

String refreshTree = (String) request.getAttribute(DL_InterfaceConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="DL_InterfaceApplicationResources" key="<%= DL_InterfaceConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.nnmi.dl.inventory.DL_Interface beanDL_Interface = (com.hp.ov.activator.nnmi.dl.inventory.DL_Interface) request.getAttribute(DL_InterfaceConstants.DL_INTERFACE_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getNnmi_id());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getName());
                      String NE_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getNe_nnmi_id());
                      String EC_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getEc_nnmi_id());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getState());
                      String StateName = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getStatename());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getType());
                      String ParentIf = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getParentif());
                      String IPAddr = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getIpaddr());
                      String Subtype = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getSubtype());
                      String Encapsulation = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getEncapsulation());
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getDescription());
                      String IFIndex = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getIfindex());
                      String ActivationState = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getActivationstate());
                      String UsageState = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getUsagestate());
                      String VLANId = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getVlanid());
                      String VLANMode = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getVlanmode());
                      String DLCI = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getDlci());
                      String Timeslots = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getTimeslots());
                      String NumberOfSlots = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getNumberofslots());
                      String Bandwidth = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getBandwidth());
                      String LMIType = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getLmitype());
                      String IntfType = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getIntftype());
                      String BundleKey = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getBundlekey());
                      String BundleId = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getBundleid());
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanDL_Interface.getNnmi_uuid());
                      String NNMi_LastUpdate = (beanDL_Interface.getNnmi_lastupdate() == null) ? "" : beanDL_Interface.getNnmi_lastupdate();
NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
      java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
      String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_InterfaceApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.ne_nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NE_NNMi_Id != null? NE_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.ne_nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.ec_nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= EC_NNMi_Id != null? EC_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.ec_nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.state.alias"/>
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
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.statename.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= StateName != null? StateName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.statename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.parentif.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ParentIf != null? ParentIf : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.parentif.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.ipaddr.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IPAddr != null? IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.subtype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Subtype != null? Subtype : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.subtype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.encapsulation.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Encapsulation != null? Encapsulation : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.encapsulation.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.description.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.ifindex.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IFIndex != null? IFIndex : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.ifindex.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.activationstate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Activated" ,"Activated");
                                            valueShowMap.put("Failed" ,"Failed");
                                            valueShowMap.put("Undefined" ,"Undefined");
                                            valueShowMap.put("Ready" ,"Ready");
                                          if(ActivationState!=null)
                     ActivationState=(String)valueShowMap.get(ActivationState);
              %>
              <%= ActivationState != null? ActivationState : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.activationstate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.usagestate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Available" ,"Available");
                                            valueShowMap.put("SubIfPresent" ,"SubIfPresent");
                                            valueShowMap.put("Uplink" ,"Uplink");
                                            valueShowMap.put("Reserved" ,"Reserved");
                                            valueShowMap.put("InBundle" ,"InBundle");
                                            valueShowMap.put("Trunk" ,"Trunk");
                                            valueShowMap.put("ASBRLink" ,"ASBRLink");
                                            valueShowMap.put("SwitchPort" ,"SwitchPort");
                                          if(UsageState!=null)
                     UsageState=(String)valueShowMap.get(UsageState);
              %>
              <%= UsageState != null? UsageState : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.usagestate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VLANId != null? VLANId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanmode.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VLANMode != null? VLANMode : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanmode.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.dlci.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DLCI != null? DLCI : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.dlci.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.timeslots.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Timeslots != null? Timeslots : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.timeslots.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.numberofslots.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NumberOfSlots != null? NumberOfSlots : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.numberofslots.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.bandwidth.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Bandwidth != null? Bandwidth : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.bandwidth.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.lmitype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= LMIType != null? LMIType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.lmitype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.intftype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IntfType != null? IntfType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.intftype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundlekey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= BundleKey != null? BundleKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundlekey.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundleid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= BundleId != null? BundleId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.bundleid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_uuid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_uuid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_lastupdate.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_lastupdate.description"/>
                      <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
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
