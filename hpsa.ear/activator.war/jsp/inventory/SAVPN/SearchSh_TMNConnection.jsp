<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors " %>

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
Sh_TMNConnectionForm form = (Sh_TMNConnectionForm) request.getAttribute("Sh_TMNConnectionForm");
if(form==null) {
 form=new Sh_TMNConnectionForm();
} 
    
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(Sh_TMNConnectionConstants.DATASOURCE);
String tabName = (String) request.getParameter(Sh_TMNConnectionConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.Sh_TMNConnectionFormSearch;
var formEl = formObj.elements;
for (var i=0; i<formEl.length; i++)
{
var element = formEl[i];
if (element.type == 'submit') { continue; }
if (element.type == 'reset') { continue; }
if (element.type == 'button') { continue; }
if (element.type == 'hidden') { continue; }
if (element.type == 'text') { element.value = ''; }
if (element.type == 'textarea') { element.value = ''; }
if (element.type == 'checkbox') {  element.checked = false;  }
if (element.type == 'radio') {if(element.value == '') element.checked=true; else element.checked=false;}
if (element.type == 'select-multiple') { element.selectedIndex = -1; }
if (element.type == 'select-one') { element.selectedIndex = -1; }
}
}
  function performCommit() {
  var checkfalse=false;
                    if(document.getElementsByName("connectionid___hide")[0].checked) {
                            if(document.getElementsByName("networkid1___hide")[0].checked) {
                            if(document.getElementsByName("networkid2___hide")[0].checked) {
                            if(document.getElementsByName("ne1___hide")[0].checked) {
                            if(document.getElementsByName("tp1___hide")[0].checked) {
                            if(document.getElementsByName("ne2___hide")[0].checked) {
                            if(document.getElementsByName("tp2___hide")[0].checked) {
                            if(document.getElementsByName("marker___hide")[0].checked) {
                            if(document.getElementsByName("uploadstatus___hide")[0].checked) {
                            if(document.getElementsByName("dbprimarykey___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="Sh_TMNConnectionApplicationResources" key="<%= Sh_TMNConnectionConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.Sh_TMNConnectionFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSh_TMNConnectionAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.Sh_TMNConnectionFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="Sh_TMNConnectionApplicationResources" key="<%= Sh_TMNConnectionConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(Sh_TMNConnectionConstants.USER) == null) {
  response.sendRedirect(Sh_TMNConnectionConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "connectionid";
                        %>

    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( _location_ != null ) {
%>
      var elems = document.getElementsByName("<%=_location_%>");
      var elem = elems == null || elems.length == 0 ? null : elems[0];
      if (elem != null) {
        elem.focus();
      }
<%
}
%>
    }
    </script>
  </head>

  <body style="overflow:auto;" onload="init();">

<%
      String ConnectionID = form.getConnectionid();
            String NetworkID1 = form.getNetworkid1();
            String NetworkID2 = form.getNetworkid2();
            String NE1 = form.getNe1();
            String TP1 = form.getTp1();
            String NE2 = form.getNe2();
            String TP2 = form.getTp2();
            String Marker = form.getMarker();
            String UploadStatus = form.getUploadstatus();
            String DBPrimaryKey = form.getDbprimarykey();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_TMNConnectionApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="Sh_TMNConnectionApplicationResources" property="ConnectionID"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="NetworkID1"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="NetworkID2"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="NE1"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="TP1"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="NE2"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="TP2"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_TMNConnectionApplicationResources" property="DBPrimaryKey"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSh_TMNConnectionAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

  <html:form action="<%=searchFormAction%>" style="text-align:center;">
    <table:table>
      <table:header>
        <table:cell>
          <bean:message bundle="InventoryResources" key="hide.heading"/>
        </table:cell>

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
              <center>
                <html:checkbox property="connectionid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.connectionid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="connectionid" size="16" value="<%= ConnectionID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.connectionid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="networkid1___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid1.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="networkid1" size="16" value="<%= NetworkID1 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid1.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="networkid2___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid2.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="networkid2" size="16" value="<%= NetworkID2 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid2.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne1___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne1.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne1" size="16" value="<%= NE1 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne1.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="tp1___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp1.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="tp1" size="16" value="<%= TP1 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp1.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne2___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne2.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne2" size="16" value="<%= NE2 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne2.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="tp2___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp2.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="tp2" size="16" value="<%= TP2 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp2.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="marker___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.marker.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="marker" size="16" value="<%= Marker %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.marker.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="uploadstatus___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.uploadstatus.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="uploadstatus" size="16" value="<%= UploadStatus %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.uploadstatus.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dbprimarykey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.dbprimarykey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dbprimarykey" size="16" value="<%= DBPrimaryKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.dbprimarykey.description"/>
                          </table:cell>
          </table:row>
              
  
            <table:row>
              <table:cell colspan="4" align="center">
              <br>
              </table:cell>
            </table:row>
            <table:row>
              <table:cell colspan="4" align="center">
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.submit.button"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.reset.button"/>" class="ButtonReset" onclick="clearForm();">
              </table:cell>
            </table:row>
    </table:table>

  </html:form>

  </body>

</html>
