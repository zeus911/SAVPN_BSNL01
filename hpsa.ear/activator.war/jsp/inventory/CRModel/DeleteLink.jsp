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
String datasource = (String) request.getParameter(LinkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="LinkApplicationResources" key="<%= LinkConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.LinkForm.action = '/activator<%=moduleConfig%>/DeleteCommitLinkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.LinkForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="LinkApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.cr.inventory.Link beanLink = (com.hp.ov.activator.cr.inventory.Link) request.getAttribute(LinkConstants.LINK_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String LinkId = StringFacility.replaceAllByHTMLCharacter(beanLink.getLinkid());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanLink.getName());
                        
                                  
                      String N1 = StringFacility.replaceAllByHTMLCharacter(beanLink.getN1());
                        
                                  
              String NE1 = (String) request.getAttribute(LinkConstants.NE1_LABEL);
      NE1 = StringFacility.replaceAllByHTMLCharacter(NE1);
      String NE1_key = beanLink.getNe1();
      NE1_key = StringFacility.replaceAllByHTMLCharacter(NE1_key);
          
                                  
              String TP1 = (String) request.getAttribute(LinkConstants.TP1_LABEL);
      TP1 = StringFacility.replaceAllByHTMLCharacter(TP1);
      String TP1_key = beanLink.getTp1();
      TP1_key = StringFacility.replaceAllByHTMLCharacter(TP1_key);
          
                                  
                      String OldType = StringFacility.replaceAllByHTMLCharacter(beanLink.getOldtype());
                        
                                  
              String Type = (String) request.getAttribute(LinkConstants.TYPE_LABEL);
      Type = StringFacility.replaceAllByHTMLCharacter(Type);
      String Type_key = beanLink.getType();
      Type_key = StringFacility.replaceAllByHTMLCharacter(Type_key);
          
                                  
                      boolean Attach = new Boolean(beanLink.getAttach()).booleanValue();
                  
                                  
              String Network = (String) request.getAttribute(LinkConstants.NETWORK_LABEL);
      Network = StringFacility.replaceAllByHTMLCharacter(Network);
      String Network_key = beanLink.getNetwork();
      Network_key = StringFacility.replaceAllByHTMLCharacter(Network_key);
          
                                  
                      String N2 = StringFacility.replaceAllByHTMLCharacter(beanLink.getN2());
                        
                                  
              String NE2 = (String) request.getAttribute(LinkConstants.NE2_LABEL);
      NE2 = StringFacility.replaceAllByHTMLCharacter(NE2);
      String NE2_key = beanLink.getNe2();
      NE2_key = StringFacility.replaceAllByHTMLCharacter(NE2_key);
          
                                  
              String TP2 = (String) request.getAttribute(LinkConstants.TP2_LABEL);
      TP2 = StringFacility.replaceAllByHTMLCharacter(TP2);
      String TP2_key = beanLink.getTp2();
      TP2_key = StringFacility.replaceAllByHTMLCharacter(TP2_key);
          
                                  
                      String PortMode = StringFacility.replaceAllByHTMLCharacter(beanLink.getPortmode());
                        
                                  
              String Roles = (String) request.getAttribute(LinkConstants.ROLES_LABEL);
      Roles = StringFacility.replaceAllByHTMLCharacter(Roles);
      String Roles_key = beanLink.getRoles();
      Roles_key = StringFacility.replaceAllByHTMLCharacter(Roles_key);
          
                                  
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanLink.getNnmi_uuid());
                        
                                  
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanLink.getNnmi_id());
                        
                                  
                      String NNMi_LastUpdateData = (beanLink.getNnmi_lastupdatedata() == null) ? "" : beanLink.getNnmi_lastupdatedata();
        NNMi_LastUpdateData= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdateData);
                            java.text.SimpleDateFormat sdfNNMi_LastUpdateData = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                                String sdfNNMi_LastUpdateDataDesc = "Format: [" + sdfNNMi_LastUpdateData.toPattern() + "]. Example: [" + sdfNNMi_LastUpdateData.format(new Date()) + "]";
                sdfNNMi_LastUpdateDataDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDataDesc);
                  
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="LinkApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean TypePass_Network = false ;
TypePass_Network = java.util.regex.Pattern.compile("^ASBRLink$|^AggregationTrunk$").matcher(Type).matches();
boolean AttachPass_Network = false ;
 AttachPass_Network = java.util.regex.Pattern.compile("^true$").matcher("" + Attach).matches();

boolean showNetwork = false;
  if (false || TypePass_Network || AttachPass_Network ){
showNetwork = true;
}


boolean TypePass_PortMode = false ;
TypePass_PortMode = java.util.regex.Pattern.compile("^AggregationTrunk$").matcher(Type).matches();
boolean RolesPass_PortMode = false ;
RolesPass_PortMode = java.util.regex.Pattern.compile("^.*PE.*$").matcher(Roles).matches();
boolean showPortMode = false;
  if (true && TypePass_PortMode && RolesPass_PortMode ){
showPortMode = true;
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
              <bean:message bundle="LinkApplicationResources" key="field.linkid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= LinkId != null? LinkId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.linkid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.n1.alias"/>
                          </table:cell>
            <table:cell>
                            <%= N1 != null? N1 : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.n1.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.ne1.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NE1 != null? NE1 : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.ne1.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.tp1.alias"/>
                          </table:cell>
            <table:cell>
                            <%= TP1 != null? TP1 : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.tp1.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                            <%if(showNetwork){%>                                                         <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.n2.alias"/>
                          </table:cell>
            <table:cell>
                            <%= N2 != null? N2 : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.n2.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.ne2.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NE2 != null? NE2 : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.ne2.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.tp2.alias"/>
                          </table:cell>
            <table:cell>
                            <%= TP2 != null? TP2 : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.tp2.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showPortMode){%>                                                         <%}%>                                                                               <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.nnmi_uuid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LinkApplicationResources" key="field.nnmi_lastupdatedata.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_LastUpdateData != null? NNMi_LastUpdateData : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LinkApplicationResources" key="field.nnmi_lastupdatedata.description"/>
              <%=sdfNNMi_LastUpdateDataDesc%>                                                        </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitLinkAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="linkid" value="<%= String.valueOf(LinkId) %>"/>
              </html:form>
  </body>
</html>

