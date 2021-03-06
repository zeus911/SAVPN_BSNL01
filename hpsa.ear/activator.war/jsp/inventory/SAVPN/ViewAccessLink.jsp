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

String refreshTree = (String) request.getAttribute(AccessLinkConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="AccessLinkApplicationResources" key="<%= AccessLinkConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.AccessLink beanAccessLink = (com.hp.ov.activator.vpn.inventory.AccessLink) request.getAttribute(AccessLinkConstants.ACCESSLINK_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String LinkId = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getLinkid());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getName());
                      String N1 = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getN1());
                  String NE1 = (String) request.getAttribute(AccessLinkConstants.NE1_LABEL);
NE1= StringFacility.replaceAllByHTMLCharacter(NE1);
              String TP1 = (String) request.getAttribute(AccessLinkConstants.TP1_LABEL);
TP1= StringFacility.replaceAllByHTMLCharacter(TP1);
                  String N2 = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getN2());
                  String NE2 = (String) request.getAttribute(AccessLinkConstants.NE2_LABEL);
NE2= StringFacility.replaceAllByHTMLCharacter(NE2);
              String TP2 = (String) request.getAttribute(AccessLinkConstants.TP2_LABEL);
TP2= StringFacility.replaceAllByHTMLCharacter(TP2);
              String Type = (String) request.getAttribute(AccessLinkConstants.TYPE_LABEL);
Type= StringFacility.replaceAllByHTMLCharacter(Type);
                  String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getAttachmentid());
                      boolean Attach = new Boolean(beanAccessLink.getAttach()).booleanValue();
                      String PortMode = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getPortmode());
                  String Network = (String) request.getAttribute(AccessLinkConstants.NETWORK_LABEL);
Network= StringFacility.replaceAllByHTMLCharacter(Network);
              String Roles = (String) request.getAttribute(AccessLinkConstants.ROLES_LABEL);
Roles= StringFacility.replaceAllByHTMLCharacter(Roles);
                  String OldType = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getOldtype());
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getNnmi_uuid());
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanAccessLink.getNnmi_id());
                      String NNMi_LastUpdateData = (beanAccessLink.getNnmi_lastupdatedata() == null) ? "" : beanAccessLink.getNnmi_lastupdatedata();
NNMi_LastUpdateData= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdateData);
      java.text.SimpleDateFormat sdfNNMi_LastUpdateData = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
      String sdfNNMi_LastUpdateDataDesc = "Format: [" + sdfNNMi_LastUpdateData.toPattern() + "]. Example: [" + sdfNNMi_LastUpdateData.format(new Date()) + "]";
sdfNNMi_LastUpdateDataDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDataDesc);
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessLinkApplicationResources" key="jsp.view.title"/>
</h2> 

<%

boolean TypePass_PortMode = false ;
TypePass_PortMode = java.util.regex.Pattern.compile("^AggregationTrunk$").matcher(Type).matches();
boolean RolesPass_PortMode = false ;
RolesPass_PortMode = java.util.regex.Pattern.compile("^.*PE.*$").matcher(Roles).matches();
boolean showPortMode = false;
  if (true && TypePass_PortMode && RolesPass_PortMode ){
showPortMode = true;
}


boolean TypePass_Network = false ;
TypePass_Network = java.util.regex.Pattern.compile("^ASBRLink$|^AggregationTrunk$").matcher(Type).matches();
boolean AttachPass_Network = false ;
 AttachPass_Network = java.util.regex.Pattern.compile("^true$").matcher("" + Attach).matches();

boolean showNetwork = false;
  if (false || TypePass_Network || AttachPass_Network ){
showNetwork = true;
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
              <bean:message bundle="AccessLinkApplicationResources" key="field.linkid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= LinkId != null? LinkId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.linkid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.n1.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= N1 != null? N1 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.n1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.ne1.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NE1 != null? NE1 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.ne1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.tp1.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= TP1 != null? TP1 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.tp1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.n2.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= N2 != null? N2 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.n2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.ne2.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NE2 != null? NE2 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.ne2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.tp2.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= TP2 != null? TP2 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.tp2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.attachmentid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.attachmentid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                        <%if(showPortMode){%>         
                                                        <%}%>      <%if(showNetwork){%>         
                                                        <%}%>               
                                                 
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_uuid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_lastupdatedata.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_LastUpdateData != null? NNMi_LastUpdateData : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_lastupdatedata.description"/>
                      <%=sdfNNMi_LastUpdateDataDesc%>                                                        </table:cell>
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
