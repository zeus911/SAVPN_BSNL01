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
Sh_CEFlowPointForm form = (Sh_CEFlowPointForm) request.getAttribute("Sh_CEFlowPointForm");
if(form==null) {
 form=new Sh_CEFlowPointForm();
} 
    
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(Sh_CEFlowPointConstants.DATASOURCE);
String tabName = (String) request.getParameter(Sh_CEFlowPointConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.Sh_CEFlowPointFormSearch;
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
                    if(document.getElementsByName("terminationpointid___hide")[0].checked) {
                            if(document.getElementsByName("attachmentid___hide")[0].checked) {
                            if(document.getElementsByName("qosprofile_in___hide")[0].checked) {
                            if(document.getElementsByName("qosprofile_out___hide")[0].checked) {
                            if(document.getElementsByName("ratelimit_in___hide")[0].checked) {
                            if(document.getElementsByName("ratelimit_out___hide")[0].checked) {
                            if(document.getElementsByName("marker___hide")[0].checked) {
                            if(document.getElementsByName("uploadstatus___hide")[0].checked) {
                            if(document.getElementsByName("dbprimarykey___hide")[0].checked) {
                            if(document.getElementsByName("ne_id___hide")[0].checked) {
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
    alert("<bean:message bundle="Sh_CEFlowPointApplicationResources" key="<%= Sh_CEFlowPointConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.Sh_CEFlowPointFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSh_CEFlowPointAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.Sh_CEFlowPointFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="Sh_CEFlowPointApplicationResources" key="<%= Sh_CEFlowPointConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(Sh_CEFlowPointConstants.USER) == null) {
  response.sendRedirect(Sh_CEFlowPointConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "terminationpointid";
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
      String TerminationPointID = form.getTerminationpointid();
            String AttachmentId = form.getAttachmentid();
            String QoSProfile_in = form.getQosprofile_in();
            String QoSProfile_out = form.getQosprofile_out();
            String RateLimit_in = form.getRatelimit_in();
            String RateLimit_out = form.getRatelimit_out();
            String Marker = form.getMarker();
            String UploadStatus = form.getUploadstatus();
            String DBPrimaryKey = form.getDbprimarykey();
            String NE_ID = form.getNe_id();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_CEFlowPointApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="Sh_CEFlowPointApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="AttachmentId"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="NE_ID"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSh_CEFlowPointAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="terminationpointid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.terminationpointid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="terminationpointid" size="16" value="<%= TerminationPointID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.terminationpointid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="attachmentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.attachmentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="attachmentid" size="16" value="<%= AttachmentId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.attachmentid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_in___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_in.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_in" size="16" value="<%= QoSProfile_in %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_in.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_out___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_out.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_out" size="16" value="<%= QoSProfile_out %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_out.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ratelimit_in___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_in.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ratelimit_in" size="16" value="<%= RateLimit_in %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_in.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ratelimit_out___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_out.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ratelimit_out" size="16" value="<%= RateLimit_out %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_out.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="marker___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.marker.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="marker" size="16" value="<%= Marker %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.marker.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="uploadstatus___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.uploadstatus.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="uploadstatus" size="16" value="<%= UploadStatus %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.uploadstatus.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dbprimarykey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.dbprimarykey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dbprimarykey" size="16" value="<%= DBPrimaryKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.dbprimarykey.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ne_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne_id" size="16" value="<%= NE_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ne_id.description"/>
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
