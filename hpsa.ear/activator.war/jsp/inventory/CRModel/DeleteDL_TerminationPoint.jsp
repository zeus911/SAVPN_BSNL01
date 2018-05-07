<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnmi.dl.inventory.*,
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
String datasource = (String) request.getParameter(DL_TerminationPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="DL_TerminationPointApplicationResources" key="<%= DL_TerminationPointConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.DL_TerminationPointForm.action = '/activator<%=moduleConfig%>/DeleteCommitDL_TerminationPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.DL_TerminationPointForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="DL_TerminationPointApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.nnmi.dl.inventory.DL_TerminationPoint beanDL_TerminationPoint = (com.hp.ov.activator.nnmi.dl.inventory.DL_TerminationPoint) request.getAttribute(DL_TerminationPointConstants.DL_TERMINATIONPOINT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_TerminationPoint.getNnmi_id());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanDL_TerminationPoint.getName());
                        
                                  
                      String NE_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_TerminationPoint.getNe_nnmi_id());
                        
                                  
                      String EC_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_TerminationPoint.getEc_nnmi_id());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanDL_TerminationPoint.getState());
                        
                                  
                      String StateName = StringFacility.replaceAllByHTMLCharacter(beanDL_TerminationPoint.getStatename());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="DL_TerminationPointApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ne_nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NE_NNMi_Id != null? NE_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ne_nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ec_nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= EC_NNMi_Id != null? EC_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ec_nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Up" ,"Up");
                                            valueShowMap.put("Down" ,"Down");
                                            valueShowMap.put("Unknown" ,"Unknown");
                                          if(State!=null)
                     State=(String)valueShowMap.get(State);
              %>
              <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.statename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= StateName != null? StateName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.statename.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitDL_TerminationPointAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="nnmi_id" value="<%= String.valueOf(NNMi_Id) %>"/>
              </html:form>
  </body>
</html>

