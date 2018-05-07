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
AccessLinkForm form = (AccessLinkForm) request.getAttribute("AccessLinkForm");
if(form==null) {
 form=new AccessLinkForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
                 java.text.SimpleDateFormat sdfNNMi_LastUpdateData = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
            String sdfNNMi_LastUpdateDataDesc = "Format: [" + sdfNNMi_LastUpdateData.toPattern() + "]. Example: [" + sdfNNMi_LastUpdateData.format(new Date()) + "]";
  
String datasource = (String) request.getParameter(AccessLinkConstants.DATASOURCE);
String tabName = (String) request.getParameter(AccessLinkConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.AccessLinkFormSearch;
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
                    if(document.getElementsByName("linkid___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                                      if(document.getElementsByName("ne1___hide")[0].checked) {
                            if(document.getElementsByName("tp1___hide")[0].checked) {
                                      if(document.getElementsByName("ne2___hide")[0].checked) {
                            if(document.getElementsByName("tp2___hide")[0].checked) {
                            if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("attachmentid___hide")[0].checked) {
                                                                              if(document.getElementsByName("nnmi_uuid___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_id___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_lastupdatedata___hide")[0].checked) {
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
            if(checkfalse){
    alert("<bean:message bundle="AccessLinkApplicationResources" key="<%= AccessLinkConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.AccessLinkFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitAccessLinkAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.AccessLinkFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="AccessLinkApplicationResources" key="<%= AccessLinkConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(AccessLinkConstants.USER) == null) {
  response.sendRedirect(AccessLinkConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "linkid";
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
      String LinkId = form.getLinkid();
            String Name = form.getName();
              String NE1 = form.getNe1();
            String TP1 = form.getTp1();
              String NE2 = form.getNe2();
            String TP2 = form.getTp2();
            String Type = form.getType();
            String AttachmentId = form.getAttachmentid();
                      String NNMi_UUId = form.getNnmi_uuid();
            String NNMi_Id = form.getNnmi_id();
            String NNMi_LastUpdateData = form.getNnmi_lastupdatedata();
          String NNMi_LastUpdateData___ = form.getNnmi_lastupdatedata___();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessLinkApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="AccessLinkApplicationResources" property="LinkId"/>
        <html:errors bundle="AccessLinkApplicationResources" property="Name"/>
          <html:errors bundle="AccessLinkApplicationResources" property="NE1"/>
        <html:errors bundle="AccessLinkApplicationResources" property="TP1"/>
          <html:errors bundle="AccessLinkApplicationResources" property="NE2"/>
        <html:errors bundle="AccessLinkApplicationResources" property="TP2"/>
        <html:errors bundle="AccessLinkApplicationResources" property="Type"/>
        <html:errors bundle="AccessLinkApplicationResources" property="AttachmentId"/>
                  <html:errors bundle="AccessLinkApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="AccessLinkApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="AccessLinkApplicationResources" property="NNMi_LastUpdateData"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitAccessLinkAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="linkid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.linkid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="linkid" size="16" value="<%= LinkId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.linkid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne1___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.ne1.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne1" size="16" value="<%= NE1 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.ne1.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="tp1___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.tp1.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="tp1" size="16" value="<%= TP1 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.tp1.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne2___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.ne2.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne2" size="16" value="<%= NE2 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.ne2.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="tp2___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.tp2.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="tp2" size="16" value="<%= TP2 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.tp2.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="attachmentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.attachmentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="attachmentid" size="16" value="<%= AttachmentId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.attachmentid.description"/>
                          </table:cell>
          </table:row>
                                                                                                      <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_uuid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_uuid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_uuid" size="16" value="<%= NNMi_UUId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_uuid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_id" size="16" value="<%= NNMi_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_lastupdatedata___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_lastupdatedata.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_lastupdatedata" size="16" value="<%= NNMi_LastUpdateData %>"/>
                                  -
                  <html:text property="nnmi_lastupdatedata___" size="16" value="<%= NNMi_LastUpdateData___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessLinkApplicationResources" key="field.nnmi_lastupdatedata.description"/>
              <%=sdfNNMi_LastUpdateDataDesc%>            </table:cell>
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
