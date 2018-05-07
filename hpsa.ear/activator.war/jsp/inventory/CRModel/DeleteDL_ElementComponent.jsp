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
String datasource = (String) request.getParameter(DL_ElementComponentConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="DL_ElementComponentApplicationResources" key="<%= DL_ElementComponentConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.DL_ElementComponentForm.action = '/activator<%=moduleConfig%>/DeleteCommitDL_ElementComponentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.DL_ElementComponentForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="DL_ElementComponentApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.nnmi.dl.inventory.DL_ElementComponent beanDL_ElementComponent = (com.hp.ov.activator.nnmi.dl.inventory.DL_ElementComponent) request.getAttribute(DL_ElementComponentConstants.DL_ELEMENTCOMPONENT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String EC_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getEc_id());
                        
                                  
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getNnmi_id());
                        
                                  
                      String NE_NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getNe_nnmi_id());
                        
                                  
                      String ParentEC_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getParentec_id());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getName());
                        
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getDescription());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getState());
                        
                                  
                      String ECType = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getEctype());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getType());
                        
                                  
                      String ComponentNumber = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getComponentnumber());
                        
                                  
                        String Capacity = "" + beanDL_ElementComponent.getCapacity();
                      Capacity = (Capacity != null && !(Capacity.trim().equals(""))) ? nfA.format(beanDL_ElementComponent.getCapacity()) : "";
                          
                  if( beanDL_ElementComponent.getCapacity()==Integer.MIN_VALUE)
         Capacity = "";
                            
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getNnmi_uuid());
                        
                                  
                      String NNMi_LastUpdate = (beanDL_ElementComponent.getNnmi_lastupdate() == null) ? "" : beanDL_ElementComponent.getNnmi_lastupdate();
        NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                            java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
                sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                  
                                  
                      String StateName = StringFacility.replaceAllByHTMLCharacter(beanDL_ElementComponent.getStatename());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="DL_ElementComponentApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ec_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= EC_Id != null? EC_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ec_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ne_nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NE_NNMi_Id != null? NE_NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ne_nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.parentec_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ParentEC_Id != null? ParentEC_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.parentec_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Up" ,"Up");
                                            valueShowMap.put("Down" ,"Down");
                                            valueShowMap.put("Unknown" ,"Unknown");
                                            valueShowMap.put("Added" ,"Added");
                                            valueShowMap.put("Removed" ,"Removed");
                                          if(State!=null)
                     State=(String)valueShowMap.get(State);
              %>
              <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ectype.alias"/>
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
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ectype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.componentnumber.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ComponentNumber != null? ComponentNumber : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.componentnumber.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.capacity.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Capacity != null? Capacity : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.capacity.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_uuid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_lastupdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.statename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= StateName != null? StateName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_ElementComponentApplicationResources" key="field.statename.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitDL_ElementComponentAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="ec_id" value="<%= String.valueOf(EC_Id) %>"/>
              </html:form>
  </body>
</html>

