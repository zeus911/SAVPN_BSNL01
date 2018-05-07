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
String datasource = (String) request.getParameter(EXPMappingConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitEXPMappingAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("position") ;
}

if ( _location_ == null ) {
                            _location_ = "position";
                                    }

%>

<html>
  <head>
    <title><bean:message bundle="EXPMappingApplicationResources" key="<%= EXPMappingConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
    function sendthis(focusthis)
    {
      window.document.EXPMappingForm.action = '/activator<%=moduleConfig%>/UpdateFormEXPMappingAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.EXPMappingForm.submit();
    }
    function performCommit()
    {
      window.document.EXPMappingForm.action = '/activator<%=moduleConfig%>/UpdateCommitEXPMappingAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.EXPMappingForm.submit();
    }
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
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
      var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alert.setBounds(400, 120);
      alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alert.show();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">

<%
    com.hp.ov.activator.vpn.inventory.EXPMapping[] beanEXPMappings = (com.hp.ov.activator.vpn.inventory.EXPMapping[]) request
            .getAttribute(EXPMappingConstants.EXPMAPPING_BEAN);
    if (beanEXPMappings == null)
        beanEXPMappings = (com.hp.ov.activator.vpn.inventory.EXPMapping[]) request
        .getSession().getAttribute(
                EXPMappingConstants.EXPMAPPING_BEAN);
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="EXPMappingApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="EXPMappingApplicationResources" property="Position"/>
        <html:errors bundle="EXPMappingApplicationResources" property="ClassName"/>
        <html:errors bundle="EXPMappingApplicationResources" property="ExpValue"/>
        <html:errors bundle="EXPMappingApplicationResources" property="DSCPValue"/>
        <html:errors bundle="EXPMappingApplicationResources" property="PLP"/>
    <html:errors bundle="EXPMappingApplicationResources" property="queueName" />
    
  </H1>
<script>
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  // hide field
                                        // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
<input type="hidden" name="_update_commit_" value="true"/> 
    <table:table>
      <table:header>
        <table:cell>
                <bean:message bundle="EXPMappingApplicationResources" key="field.classname.alias"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EXPMappingApplicationResources" key="field.expvalue.alias"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="EXPMappingApplicationResources" key="field.dscpvalue.alias"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="EXPMappingApplicationResources" key="field.plp.alias" />
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EXPMappingApplicationResources" key="field.queuename.alias" />
                                                                        </table:cell>
        </table:header>
<%! final int MAX_CLASS_NUMBER = 8;%>       
<% final int CLASS_NUMBER = beanEXPMappings.length;%>
<input type="hidden" name="classCount" value="<%=MAX_CLASS_NUMBER%>">
<%
     int i=0;
     while(i<MAX_CLASS_NUMBER){
     EXPMapping mapping=null;
     if(i<CLASS_NUMBER){
     mapping = beanEXPMappings[i];
     }
   
     String className = null;
     String exp = null;
     String dscp = null;
     String plp = null;
     String queueName = null;
     final String classId = "class"+i;
     final String classIdExp = classId + "exp";
     final String classIdDscp = classId + "dscp";
     final String classIdPlp = classId + "plp";
     final String classIdqueueName = classId + "queueName";
     if(mapping != null){
         className = mapping.getClassname();
         exp = mapping.getExpvalue();
         dscp = mapping.getDscpvalue();
         plp = mapping.getPlp();
         if(plp==null)
         plp=""; 
         queueName = mapping.getQueuename();
         if(queueName==null)
         queueName="";
     }else{
    mapping= new EXPMapping();
    className = ""; exp = ""; dscp = ""; plp = ""; queueName = "";
    }
%>
                                      <table:row>
              <table:cell>  
                <html:text property="<%=classId%>" size="20"
                    value="<%=className%>" />
                                                </table:cell>
              <table:cell>
                <html:text property="<%=classIdExp%>" size="5" maxlength="5"
                    value="<%= exp %>" />
                                                                        </table:cell>
              <table:cell>  
                <html:text property="<%=classIdDscp%>" size="5" maxlength="5"
                    value="<%= dscp %>" />
                              </table:cell>
              <table:cell>
                <html:text property="<%=classIdPlp%>" size="5" maxlength="5"
                    value="<%= plp %>" />
                                                </table:cell>
              <table:cell>
                <html:text property="<%=classIdqueueName%>" size="8"  value="<%= queueName %>" />
                                                                        </table:cell>
            </table:row>
<%
i++;
        }
%>
        <html:hidden property="ClassName" value="nouse" />
        <html:hidden property="ExpValue" value="nouse" />
        <html:hidden property="DSCPValue" value="nouse" />
        <html:hidden property="PLP" value="nouse" />
        <html:hidden property="queueName" value="nouse" />
      <table:row>
            <table:cell colspan="5" align="center">
        <br>
        </table:cell>
      </table:row>
      <table:row>
            <table:cell colspan="5" align="center">
                <input type="button"
                    value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>"
                    name="enviando" class="ButtonSubmit"
                    onclick="this.disabled='true'; performCommit();">&nbsp;
                    <input type="reset"
                    value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>"
                    class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>

  </html:form>

  </body>

</html>
