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
String datasource = (String) request.getParameter(NetworkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="NetworkApplicationResources" key="<%= NetworkConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.NetworkForm.action = '/activator<%=moduleConfig%>/DeleteCommitNetworkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.NetworkForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="NetworkApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Network beanNetwork = (com.hp.ov.activator.vpn.inventory.Network) request.getAttribute(NetworkConstants.NETWORK_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String NetworkId = StringFacility.replaceAllByHTMLCharacter(beanNetwork.getNetworkid());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanNetwork.getName());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanNetwork.getType());
                        
                                  
                      String ASN = StringFacility.replaceAllByHTMLCharacter(beanNetwork.getAsn());
                        
                                  
                      boolean isService = new Boolean(beanNetwork.getIsservice()).booleanValue();
                  
                                  
                      String ASNC = StringFacility.replaceAllByHTMLCharacter(beanNetwork.getAsnc());
                        
                                  
              String Region = (String) request.getAttribute(NetworkConstants.REGION_LABEL);
      Region = StringFacility.replaceAllByHTMLCharacter(Region);
      String Region_key = beanNetwork.getRegion();
      Region_key = StringFacility.replaceAllByHTMLCharacter(Region_key);
          
                                  
              String ParentNetworkId = (String) request.getAttribute(NetworkConstants.PARENTNETWORKID_LABEL);
      ParentNetworkId = StringFacility.replaceAllByHTMLCharacter(ParentNetworkId);
      String ParentNetworkId_key = beanNetwork.getParentnetworkid();
      ParentNetworkId_key = StringFacility.replaceAllByHTMLCharacter(ParentNetworkId_key);
          
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="NetworkApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean TypePass_ASNC = false ;
TypePass_ASNC = java.util.regex.Pattern.compile("^Network$").matcher(Type).matches();
boolean showASNC = false;
  if (true && TypePass_ASNC ){
showASNC = true;
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
              <bean:message bundle="NetworkApplicationResources" key="field.networkid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NetworkId != null? NetworkId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkApplicationResources" key="field.networkid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="NetworkApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="NetworkApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Network" ,"Network");
                                            valueShowMap.put("AccessNetwork" ,"AccessNetwork");
                                            valueShowMap.put("Topology" ,"Topology");
                                          if(Type!=null)
                     Type=(String)valueShowMap.get(Type);
              %>
              <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                                     <%if(showASNC){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="NetworkApplicationResources" key="field.asnc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ASNC != null? ASNC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkApplicationResources" key="field.asnc.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="NetworkApplicationResources" key="field.region.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Region != null? Region : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkApplicationResources" key="field.region.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="NetworkApplicationResources" key="field.parentnetworkid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ParentNetworkId != null? ParentNetworkId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkApplicationResources" key="field.parentnetworkid.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitNetworkAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="networkid" value="<%= String.valueOf(NetworkId) %>"/>
              </html:form>
  </body>
</html>
