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

String refreshTree = (String) request.getAttribute(Sh_TerminationPointConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Sh_TerminationPointApplicationResources" key="<%= Sh_TerminationPointConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Sh_TerminationPoint beanSh_TerminationPoint = (com.hp.ov.activator.vpn.inventory.Sh_TerminationPoint) request.getAttribute(Sh_TerminationPointConstants.SH_TERMINATIONPOINT_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String TerminationPointID = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getTerminationpointid());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getName());
                      String NE_ID = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getNe_id());
                      String EC_ID = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getEc_id());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getState());
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getMarker());
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getUploadstatus());
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_TerminationPoint.getDbprimarykey());
                      String __count = "" + beanSh_TerminationPoint.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_TerminationPoint.get__count()) : "";
              if( beanSh_TerminationPoint.get__count()==Integer.MIN_VALUE)
  __count = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_TerminationPointApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TerminationPointID != null? TerminationPointID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.terminationpointid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.ne_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NE_ID != null? NE_ID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.ne_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.ec_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= EC_ID != null? EC_ID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.ec_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.state.alias"/>
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
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.marker.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.uploadstatus.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.dbprimarykey.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TerminationPointApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
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
