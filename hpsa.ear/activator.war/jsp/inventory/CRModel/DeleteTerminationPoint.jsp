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
String datasource = (String) request.getParameter(TerminationPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="TerminationPointApplicationResources" key="<%= TerminationPointConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.TerminationPointForm.action = '/activator<%=moduleConfig%>/DeleteCommitTerminationPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.TerminationPointForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="TerminationPointApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.cr.inventory.TerminationPoint beanTerminationPoint = (com.hp.ov.activator.cr.inventory.TerminationPoint) request.getAttribute(TerminationPointConstants.TERMINATIONPOINT_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TerminationPointId = StringFacility.replaceAllByHTMLCharacter(beanTerminationPoint.getTerminationpointid());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanTerminationPoint.getName());
                        
                                  
              String NE_Id = (String) request.getAttribute(TerminationPointConstants.NE_ID_LABEL);
      NE_Id = StringFacility.replaceAllByHTMLCharacter(NE_Id);
      String NE_Id_key = beanTerminationPoint.getNe_id();
      NE_Id_key = StringFacility.replaceAllByHTMLCharacter(NE_Id_key);
          
                                  
              String EC_Id = (String) request.getAttribute(TerminationPointConstants.EC_ID_LABEL);
      EC_Id = StringFacility.replaceAllByHTMLCharacter(EC_Id);
      String EC_Id_key = beanTerminationPoint.getEc_id();
      EC_Id_key = StringFacility.replaceAllByHTMLCharacter(EC_Id_key);
          
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanTerminationPoint.getState());
                        
                                  
                        String __count = "" + beanTerminationPoint.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanTerminationPoint.get__count()) : "";
                          
                  if( beanTerminationPoint.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="TerminationPointApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="TerminationPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TerminationPointId != null? TerminationPointId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.terminationpointid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TerminationPointApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TerminationPointApplicationResources" key="field.ne_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NE_Id != null? NE_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.ne_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TerminationPointApplicationResources" key="field.ec_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= EC_Id != null? EC_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.ec_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TerminationPointApplicationResources" key="field.state.alias"/>
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
              <bean:message bundle="TerminationPointApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TerminationPointApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.__count.description"/>
                                    <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitTerminationPointAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="terminationpointid" value="<%= String.valueOf(TerminationPointId) %>"/>
              </html:form>
  </body>
</html>

