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

String refreshTree = (String) request.getAttribute(Sh_IPNetConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Sh_IPNetApplicationResources" key="<%= Sh_IPNetConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Sh_IPNet beanSh_IPNet = (com.hp.ov.activator.vpn.inventory.Sh_IPNet) request.getAttribute(Sh_IPNetConstants.SH_IPNET_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String IPNetAddr = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getIpnetaddr());
                      String PE1_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getPe1_ipaddr());
                      String CE1_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getCe1_ipaddr());
                      String PE2_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getPe2_ipaddr());
                      String CE2_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getCe2_ipaddr());
                      String Netmask = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getNetmask());
                      String Hostmask = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getHostmask());
                      String PoolName = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getPoolname());
                      String IPNetAddrStr = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getIpnetaddrstr());
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getMarker());
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getUploadstatus());
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_IPNet.getDbprimarykey());
                      String __count = "" + beanSh_IPNet.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_IPNet.get__count()) : "";
              if( beanSh_IPNet.get__count()==Integer.MIN_VALUE)
  __count = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_IPNetApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.ipnetaddr.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= IPNetAddr != null? IPNetAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.ipnetaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe1_ipaddr.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= PE1_IPAddr != null? PE1_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe1_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce1_ipaddr.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= CE1_IPAddr != null? CE1_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce1_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe2_ipaddr.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PE2_IPAddr != null? PE2_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.pe2_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce2_ipaddr.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CE2_IPAddr != null? CE2_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.ce2_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.netmask.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Netmask != null? Netmask : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.netmask.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.hostmask.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Hostmask != null? Hostmask : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.hostmask.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.poolname.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= PoolName != null? PoolName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.poolname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.marker.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.uploadstatus.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.dbprimarykey.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_IPNetApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_IPNetApplicationResources" key="field.__count.description"/>
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
