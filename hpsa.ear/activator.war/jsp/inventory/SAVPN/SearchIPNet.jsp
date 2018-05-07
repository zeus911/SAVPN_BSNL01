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
IPNetForm form = (IPNetForm) request.getAttribute("IPNetForm");
if(form==null) {
 form=new IPNetForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(IPNetConstants.DATASOURCE);
String tabName = (String) request.getParameter(IPNetConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.IPNetFormSearch;
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
                    if(document.getElementsByName("ipnetaddr___hide")[0].checked) {
                            if(document.getElementsByName("pe1_ipaddr___hide")[0].checked) {
                            if(document.getElementsByName("ce1_ipaddr___hide")[0].checked) {
                            if(document.getElementsByName("pe2_ipaddr___hide")[0].checked) {
                            if(document.getElementsByName("ce2_ipaddr___hide")[0].checked) {
                            if(document.getElementsByName("netmask___hide")[0].checked) {
                            if(document.getElementsByName("hostmask___hide")[0].checked) {
                            if(document.getElementsByName("poolname___hide")[0].checked) {
                            if(document.getElementsByName("ipnetaddrstr___hide")[0].checked) {
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
                                                              if(checkfalse){
    alert("<bean:message bundle="IPNetApplicationResources" key="<%= IPNetConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.IPNetFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitIPNetAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.IPNetFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="IPNetApplicationResources" key="<%= IPNetConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(IPNetConstants.USER) == null) {
  response.sendRedirect(IPNetConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "ipnetaddr";
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
      String IPNetAddr = form.getIpnetaddr();
            String PE1_IPAddr = form.getPe1_ipaddr();
            String CE1_IPAddr = form.getCe1_ipaddr();
            String PE2_IPAddr = form.getPe2_ipaddr();
            String CE2_IPAddr = form.getCe2_ipaddr();
            String Netmask = form.getNetmask();
            String Hostmask = form.getHostmask();
            String PoolName = form.getPoolname();
            String IPNetAddrStr = form.getIpnetaddrstr();
                
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPNetApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="IPNetApplicationResources" property="IPNetAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="PE1_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="CE1_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="PE2_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="CE2_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="Netmask"/>
        <html:errors bundle="IPNetApplicationResources" property="Hostmask"/>
        <html:errors bundle="IPNetApplicationResources" property="PoolName"/>
        <html:errors bundle="IPNetApplicationResources" property="IPNetAddrStr"/>
                <html:errors bundle="IPNetApplicationResources" property="__count"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitIPNetAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="ipnetaddr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipnetaddr" size="16" value="<%= IPNetAddr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddr.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pe1_ipaddr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.pe1_ipaddr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="pe1_ipaddr" size="16" value="<%= PE1_IPAddr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.pe1_ipaddr.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ce1_ipaddr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ce1_ipaddr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ce1_ipaddr" size="16" value="<%= CE1_IPAddr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ce1_ipaddr.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pe2_ipaddr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.pe2_ipaddr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="pe2_ipaddr" size="16" value="<%= PE2_IPAddr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.pe2_ipaddr.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ce2_ipaddr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ce2_ipaddr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ce2_ipaddr" size="16" value="<%= CE2_IPAddr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ce2_ipaddr.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="netmask___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.netmask.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="netmask" size="16" value="<%= Netmask %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.netmask.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="hostmask___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.hostmask.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="hostmask" size="16" value="<%= Hostmask %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.hostmask.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="poolname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.poolname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="poolname" size="16" value="<%= PoolName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.poolname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipnetaddrstr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddrstr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipnetaddrstr" size="16" value="<%= IPNetAddrStr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddrstr.description"/>
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
