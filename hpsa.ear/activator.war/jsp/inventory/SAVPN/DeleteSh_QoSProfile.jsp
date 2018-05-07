<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
        com.hp.ov.activator.inventory.facilities.StringFacility " %>

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
%>

<%
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext()); 
// module name that can be used as solution name               
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<%
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(Sh_QoSProfileConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_QoSProfileApplicationResources" key="<%= Sh_QoSProfileConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_QoSProfileForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_QoSProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_QoSProfileForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_QoSProfileApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_QoSProfile beanSh_QoSProfile = (com.hp.ov.activator.vpn.inventory.Sh_QoSProfile) request.getAttribute(Sh_QoSProfileConstants.SH_QOSPROFILE_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String QoSProfileName = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getQosprofilename());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getCustomerid());
                        
                                  
                      String Prefix = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getPrefix());
                        
                                  
                      String Layer = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getLayer());
                        
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getDescription());
                        
                                  
                      String PEQoSProfileName = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getPeqosprofilename());
                        
                                  
                      String Profilename_in = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getProfilename_in());
                        
                                  
                      String Profilename_out = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getProfilename_out());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getDbprimarykey());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getMarker());
                        
                                  
                      String Compliant = StringFacility.replaceAllByHTMLCharacter(beanSh_QoSProfile.getCompliant());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_QoSProfileApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.qosprofilename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= QoSProfileName != null? QoSProfileName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.qosprofilename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.customerid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.customerid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.prefix.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Prefix != null? Prefix : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.prefix.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.layer.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("layer 3" ,"layer 3");
                                            valueShowMap.put("layer 2" ,"layer 2");
                                          if(Layer!=null)
                     Layer=(String)valueShowMap.get(Layer);
              %>
              <%= Layer != null? Layer : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.layer.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.peqosprofilename.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PEQoSProfileName != null? PEQoSProfileName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.peqosprofilename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Profilename_in != null? Profilename_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_in.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Profilename_out != null? Profilename_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_out.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.compliant.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("compliant" ,"compliant");
                                            valueShowMap.put("partial compliant" ,"partial compliant");
                                            valueShowMap.put("non compliant" ,"non compliant");
                                          if(Compliant!=null)
                     Compliant=(String)valueShowMap.get(Compliant);
              %>
              <%= Compliant != null? Compliant : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.compliant.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_QoSProfileAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="qosprofilename" value="<%= String.valueOf(QoSProfileName) %>"/>
              </html:form>
  </body>
</html>

