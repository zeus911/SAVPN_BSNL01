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
Sh_QoSProfileForm form = (Sh_QoSProfileForm) request.getAttribute("Sh_QoSProfileForm");
if(form==null) {
 form=new Sh_QoSProfileForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(Sh_QoSProfileConstants.DATASOURCE);
String tabName = (String) request.getParameter(Sh_QoSProfileConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.Sh_QoSProfileFormSearch;
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
                    if(document.getElementsByName("qosprofilename___hide")[0].checked) {
                            if(document.getElementsByName("customerid___hide")[0].checked) {
                            if(document.getElementsByName("prefix___hide")[0].checked) {
                            if(document.getElementsByName("layer___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
                            if(document.getElementsByName("peqosprofilename___hide")[0].checked) {
                            if(document.getElementsByName("profilename_in___hide")[0].checked) {
                            if(document.getElementsByName("profilename_out___hide")[0].checked) {
                            if(document.getElementsByName("uploadstatus___hide")[0].checked) {
                            if(document.getElementsByName("dbprimarykey___hide")[0].checked) {
                            if(document.getElementsByName("marker___hide")[0].checked) {
                            if(document.getElementsByName("compliant___hide")[0].checked) {
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
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="Sh_QoSProfileApplicationResources" key="<%= Sh_QoSProfileConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.Sh_QoSProfileFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSh_QoSProfileAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.Sh_QoSProfileFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="Sh_QoSProfileApplicationResources" key="<%= Sh_QoSProfileConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(Sh_QoSProfileConstants.USER) == null) {
  response.sendRedirect(Sh_QoSProfileConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "qosprofilename";
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
      String QoSProfileName = form.getQosprofilename();
            String CustomerId = form.getCustomerid();
            String Prefix = form.getPrefix();
            String Layer = form.getLayer();
            String Description = form.getDescription();
            String PEQoSProfileName = form.getPeqosprofilename();
            String Profilename_in = form.getProfilename_in();
            String Profilename_out = form.getProfilename_out();
            String UploadStatus = form.getUploadstatus();
            String DBPrimaryKey = form.getDbprimarykey();
            String Marker = form.getMarker();
            String Compliant = form.getCompliant();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_QoSProfileApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="Sh_QoSProfileApplicationResources" property="QoSProfileName"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="CustomerId"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Prefix"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Layer"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Description"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="PEQoSProfileName"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Profilename_in"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Profilename_out"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_QoSProfileApplicationResources" property="Compliant"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSh_QoSProfileAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="qosprofilename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.qosprofilename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofilename" size="16" value="<%= QoSProfileName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.qosprofilename.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customerid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.customerid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customerid" size="16" value="<%= CustomerId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.customerid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="prefix___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.prefix.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="prefix" size="16" value="<%= Prefix %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.prefix.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="layer___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.layer.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="layer" size="16" value="<%= Layer %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.layer.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="peqosprofilename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.peqosprofilename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="peqosprofilename" size="16" value="<%= PEQoSProfileName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.peqosprofilename.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="profilename_in___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_in.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="profilename_in" size="16" value="<%= Profilename_in %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_in.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="profilename_out___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_out.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="profilename_out" size="16" value="<%= Profilename_out %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.profilename_out.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="uploadstatus___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.uploadstatus.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="uploadstatus" size="16" value="<%= UploadStatus %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.uploadstatus.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dbprimarykey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.dbprimarykey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dbprimarykey" size="16" value="<%= DBPrimaryKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.dbprimarykey.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="marker___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.marker.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="marker" size="16" value="<%= Marker %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.marker.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="compliant___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.compliant.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="compliant" size="16" value="<%= Compliant %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_QoSProfileApplicationResources" key="field.compliant.description"/>
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
