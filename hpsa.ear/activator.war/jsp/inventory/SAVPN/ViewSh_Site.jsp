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

String refreshTree = (String) request.getAttribute(Sh_SiteConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Sh_SiteApplicationResources" key="<%= Sh_SiteConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Sh_Site beanSh_Site = (com.hp.ov.activator.vpn.inventory.Sh_Site) request.getAttribute(Sh_SiteConstants.SH_SITE_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getServiceid());
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getCustomerid());
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getServicename());
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getInitiationdate());
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getActivationdate());
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getModificationdate());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getState());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getType());
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getContactperson());
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getComments());
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getMarker());
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getUploadstatus());
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getDbprimarykey());
                      String __count = "" + beanSh_Site.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_Site.get__count()) : "";
              if( beanSh_Site.get__count()==Integer.MIN_VALUE)
  __count = "";
                String RemoteASN = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getRemoteasn());
                      String OSPF_Area = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getOspf_area());
                      String SiteOfOrigin = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getSiteoforigin());
                      boolean Managed = new Boolean(beanSh_Site.getManaged()).booleanValue();
                      String Multicast = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getMulticast());
                      String PostalAddress = StringFacility.replaceAllByHTMLCharacter(beanSh_Site.getPostaladdress());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_SiteApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="Sh_SiteApplicationResources" key="field.serviceid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ServiceId != null? ServiceId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.serviceid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.customerid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.customerid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.servicename.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ServiceName != null? ServiceName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.servicename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.initiationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.activationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.modificationdate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.contactperson.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.comments.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.marker.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.uploadstatus.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.dbprimarykey.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.remoteasn.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RemoteASN != null? RemoteASN : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.remoteasn.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.ospf_area.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= OSPF_Area != null? OSPF_Area : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.ospf_area.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.siteoforigin.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SiteOfOrigin != null? SiteOfOrigin : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.siteoforigin.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                    <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.managed.alias"/>
                          </table:cell>
            <table:cell>
              <%= Managed %>
            </table:cell>
            <table:cell>
              <bean:message bundle="Sh_SiteApplicationResources" key="field.managed.description"/>
            </table:cell>
          </table:row>
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.multicast.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("disabled" ,"disabled");
                                            valueShowMap.put("enabled" ,"enabled");
                                          if(Multicast!=null)
                     Multicast=(String)valueShowMap.get(Multicast);
              %>
              <%= Multicast != null? Multicast : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.multicast.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_SiteApplicationResources" key="field.postaladdress.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PostalAddress != null? PostalAddress : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_SiteApplicationResources" key="field.postaladdress.description"/>
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
