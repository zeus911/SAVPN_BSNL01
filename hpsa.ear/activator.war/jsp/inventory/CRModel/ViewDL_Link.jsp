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

String refreshTree = (String) request.getAttribute(DL_LinkConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="DL_LinkApplicationResources" key="<%= DL_LinkConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.nnmi.dl.inventory.DL_Link beanDL_Link = (com.hp.ov.activator.nnmi.dl.inventory.DL_Link) request.getAttribute(DL_LinkConstants.DL_LINK_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getNnmi_id());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getName());
                      String NE1_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getNe1_nnmi_id());
                      String TP1_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getTp1_nnmi_id());
                      String NE2_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getNe2_nnmi_id());
                      String TP2_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getTp2_nnmi_id());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getType());
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getNnmi_uuid());
                      String NNMi_LastUpdateData = (beanDL_Link.getNnmi_lastupdatedata() == null) ? "" : beanDL_Link.getNnmi_lastupdatedata();
NNMi_LastUpdateData= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdateData);
      java.text.SimpleDateFormat sdfNNMi_LastUpdateData = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
      String sdfNNMi_LastUpdateDataDesc = "Format: [" + sdfNNMi_LastUpdateData.toPattern() + "]. Example: [" + sdfNNMi_LastUpdateData.format(new Date()) + "]";
sdfNNMi_LastUpdateDataDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDataDesc);
                      String StateName = StringFacility.replaceAllByHTMLCharacter(beanDL_Link.getStatename());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_LinkApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.ne1_nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NE1_NNMi_Id != null? NE1_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.ne1_nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.tp1_nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TP1_NNMi_Id != null? TP1_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.tp1_nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.ne2_nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NE2_NNMi_Id != null? NE2_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.ne2_nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.tp2_nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TP2_NNMi_Id != null? TP2_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.tp2_nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("ASBRLink" ,"ASBRLink");
                                            valueShowMap.put("AggregationTrunk" ,"AggregationTrunk");
                                            valueShowMap.put("AccessTrunk" ,"AccessTrunk");
                                            valueShowMap.put("AccessLink" ,"AccessLink");
                                          if(Type!=null)
                     Type=(String)valueShowMap.get(Type);
              %>
              <%= Type != null? Type : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_uuid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_uuid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_lastupdatedata.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_LastUpdateData != null? NNMi_LastUpdateData : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_lastupdatedata.description"/>
                      <%=sdfNNMi_LastUpdateDataDesc%>                                                        </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_LinkApplicationResources" key="field.statename.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= StateName != null? StateName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_LinkApplicationResources" key="field.statename.description"/>
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
