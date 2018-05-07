<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

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

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");

String refreshTree = (String) request.getAttribute(ElementComponentConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="ElementComponentApplicationResources" key="<%= ElementComponentConstants.JSP_VIEW_TITLE %>"/></title>
 
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( refreshTree != null && refreshTree.equalsIgnoreCase("true") ) {
%>
      parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">
  

<%
com.hp.ov.activator.cr.inventory.ElementComponent beanElementComponent = (com.hp.ov.activator.cr.inventory.ElementComponent) request.getAttribute(ElementComponentConstants.ELEMENTCOMPONENT_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ElementComponentId = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getElementcomponentid());
                  String NE_Id = (String) request.getAttribute(ElementComponentConstants.NE_ID_LABEL);
NE_Id= StringFacility.replaceAllByHTMLCharacter(NE_Id);
              String ParentEC_Id = (String) request.getAttribute(ElementComponentConstants.PARENTEC_ID_LABEL);
ParentEC_Id= StringFacility.replaceAllByHTMLCharacter(ParentEC_Id);
                  String Name = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getName());
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getDescription());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getState());
                      String ECType = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getEctype());
                  String Type = (String) request.getAttribute(ElementComponentConstants.TYPE_LABEL);
Type= StringFacility.replaceAllByHTMLCharacter(Type);
                  String OtherType = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getOthertype());
                      String ComponentNumber = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getComponentnumber());
                      String Capacity = "" + beanElementComponent.getCapacity();
      Capacity = (Capacity != null && !(Capacity.trim().equals(""))) ? nfA.format(beanElementComponent.getCapacity()) : "";
              if( beanElementComponent.getCapacity()==Integer.MIN_VALUE)
  Capacity = "";
                String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getNnmi_uuid());
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanElementComponent.getNnmi_id());
                      String NNMi_LastUpdate = (beanElementComponent.getNnmi_lastupdate() == null) ? "" : beanElementComponent.getNnmi_lastupdate();
NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
      java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy");
      String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                      String __count = "" + beanElementComponent.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanElementComponent.get__count()) : "";
              if( beanElementComponent.get__count()==Integer.MIN_VALUE)
  __count = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ElementComponentApplicationResources" key="jsp.view.title"/>
</h2> 

<%

boolean ECTypePass_Type = false ;
ECTypePass_Type = java.util.regex.Pattern.compile("^Slot$").matcher(ECType).matches();
boolean showType = false;
  if (true && ECTypePass_Type ){
showType = true;
}


boolean ECTypePass_OtherType = false ;
ECTypePass_OtherType = java.util.regex.Pattern.compile("^Port$|^Controller$").matcher(ECType).matches();
boolean showOtherType = false;
  if (true && ECTypePass_OtherType ){
showOtherType = true;
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
              <bean:message bundle="ElementComponentApplicationResources" key="field.elementcomponentid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ElementComponentId != null? ElementComponentId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.elementcomponentid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.ne_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NE_Id != null? NE_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.ne_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.parentec_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ParentEC_Id != null? ParentEC_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.parentec_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.description.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.state.alias"/>
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
                      <bean:message bundle="ElementComponentApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.ectype.alias"/>
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
                      <bean:message bundle="ElementComponentApplicationResources" key="field.ectype.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showType){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.type.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>      <%if(showOtherType){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.othertype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= OtherType != null? OtherType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.othertype.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.componentnumber.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ComponentNumber != null? ComponentNumber : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.componentnumber.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.capacity.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Capacity != null? Capacity : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.capacity.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_uuid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_lastupdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_lastupdate.description"/>
                      <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ElementComponentApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ElementComponentApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                        
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

  </body>
</html>
