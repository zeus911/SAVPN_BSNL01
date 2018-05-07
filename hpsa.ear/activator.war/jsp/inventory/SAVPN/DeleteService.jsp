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
String datasource = (String) request.getParameter(ServiceConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="ServiceApplicationResources" key="<%= ServiceConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.ServiceForm.action = '/activator<%=moduleConfig%>/DeleteCommitServiceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.ServiceForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="ServiceApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Service beanService = (com.hp.ov.activator.vpn.inventory.Service) request.getAttribute(ServiceConstants.SERVICE_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanService.getServiceid());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanService.getCustomerid());
                        
                                  
                      String Customer = StringFacility.replaceAllByHTMLCharacter(beanService.getCustomer());
                        
                                  
                      String ContactPerson = StringFacility.replaceAllByHTMLCharacter(beanService.getContactperson());
                        
                                  
                      String ServiceName = StringFacility.replaceAllByHTMLCharacter(beanService.getServicename());
                        
                                  
                      String InitiationDate = StringFacility.replaceAllByHTMLCharacter(beanService.getInitiationdate());
                        
                                  
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanService.getActivationdate());
                        
                                  
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanService.getModificationdate());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanService.getState());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanService.getType());
                        
                                  
                      String Comments = StringFacility.replaceAllByHTMLCharacter(beanService.getComments());
                        
                                  
                        String __count = "" + beanService.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanService.get__count()) : "";
                          
                  if( beanService.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="ServiceApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean ModificationDatePass_ModificationDate = false ;
ModificationDatePass_ModificationDate = java.util.regex.Pattern.compile("^[0-9]+.*$").matcher(ModificationDate).matches();
boolean showModificationDate = false;
  if (true && ModificationDatePass_ModificationDate ){
showModificationDate = true;
}

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
              <bean:message bundle="ServiceApplicationResources" key="field.customer.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Customer != null? Customer : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.customer.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.contactperson.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ContactPerson != null? ContactPerson : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.contactperson.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.initiationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= InitiationDate != null? InitiationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.initiationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.activationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showModificationDate){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.modificationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Comments != null? Comments : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.comments.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceApplicationResources" key="field.__count.description"/>
                                    <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitServiceAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="serviceid" value="<%= String.valueOf(ServiceId) %>"/>
              </html:form>
  </body>
</html>

