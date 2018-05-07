<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
String datasource = (String) request.getParameter(ElementCompTypeConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="ElementCompTypeApplicationResources" key="<%= ElementCompTypeConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.ElementCompTypeForm.action = '/activator<%=moduleConfig%>/DeleteCommitElementCompTypeAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.ElementCompTypeForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="ElementCompTypeApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.cr.inventory.ElementCompType beanElementCompType = (com.hp.ov.activator.cr.inventory.ElementCompType) request.getAttribute(ElementCompTypeConstants.ELEMENTCOMPTYPE_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String Type = StringFacility.replaceAllByHTMLCharacter(beanElementCompType.getType());
                        
                                  
              String ElementTypeGroupName = (String) request.getAttribute(ElementCompTypeConstants.ELEMENTTYPEGROUPNAME_LABEL);
      ElementTypeGroupName = StringFacility.replaceAllByHTMLCharacter(ElementTypeGroupName);
      String ElementTypeGroupName_key = beanElementCompType.getElementtypegroupname();
      ElementTypeGroupName_key = StringFacility.replaceAllByHTMLCharacter(ElementTypeGroupName_key);
          
                                  
                      String ECType = StringFacility.replaceAllByHTMLCharacter(beanElementCompType.getEctype());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="ElementCompTypeApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="ElementCompTypeApplicationResources" key="field.type.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ElementCompTypeApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ElementCompTypeApplicationResources" key="field.elementtypegroupname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= ElementTypeGroupName != null? ElementTypeGroupName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ElementCompTypeApplicationResources" key="field.elementtypegroupname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ElementCompTypeApplicationResources" key="field.ectype.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Slot" ,"Slot");
                                            valueShowMap.put("Port" ,"Port");
                                            valueShowMap.put("Controller" ,"Controller");
                                          if(ECType!=null)
                     ECType=(String)valueShowMap.get(ECType);
              %>
              <%= ECType != null? ECType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ElementCompTypeApplicationResources" key="field.ectype.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitElementCompTypeAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="ectype" value="<%= String.valueOf(ECType) %>"/>
                        <html:hidden property="elementtypegroupname" value="<%= String.valueOf(ElementTypeGroupName_key) %>"/>  
                        <html:hidden property="type" value="<%= String.valueOf(Type) %>"/>
              </html:form>
  </body>
</html>
