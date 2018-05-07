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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                                           java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy");
            String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
    
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(ElementComponentConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitElementComponentAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "ne_id";
                                                                                          }
%>

<html>
  <head>
    <title><bean:message bundle="ElementComponentApplicationResources" key="<%= ElementComponentConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.ElementComponentForm.action = '/activator<%=moduleConfig%>/CreationFormElementComponentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.ElementComponentForm.submit();
    }
    function performCommit()
    {
      window.document.ElementComponentForm.action = '/activator<%=moduleConfig%>/CreationCommitElementComponentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.ElementComponentForm.submit();
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
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }
    </script>
  </head>
  <body style="overflow:auto;" onload="init();">
<%

com.hp.ov.activator.cr.inventory.ElementComponent beanElementComponent = (com.hp.ov.activator.cr.inventory.ElementComponent) request.getAttribute(ElementComponentConstants.ELEMENTCOMPONENT_BEAN);

      String ElementComponentId = beanElementComponent.getElementcomponentid();
                String NE_Id = beanElementComponent.getNe_id();
        String NE_IdLabel = (String) request.getAttribute(ElementComponentConstants.NE_ID_LABEL);
ArrayList NE_IdListOfValues = (ArrayList) request.getAttribute(ElementComponentConstants.NE_ID_LIST_OF_VALUES);
            String ParentEC_Id = beanElementComponent.getParentec_id();
        String ParentEC_IdLabel = (String) request.getAttribute(ElementComponentConstants.PARENTEC_ID_LABEL);
ArrayList ParentEC_IdListOfValues = (ArrayList) request.getAttribute(ElementComponentConstants.PARENTEC_ID_LIST_OF_VALUES);
            String Name = beanElementComponent.getName();
                String Description = beanElementComponent.getDescription();
                String State = beanElementComponent.getState();
                String ECType = beanElementComponent.getEctype();
                String Type = beanElementComponent.getType();
        String TypeLabel = (String) request.getAttribute(ElementComponentConstants.TYPE_LABEL);
ArrayList TypeListOfValues = (ArrayList) request.getAttribute(ElementComponentConstants.TYPE_LIST_OF_VALUES);
            String OtherType = beanElementComponent.getOthertype();
                String ComponentNumber = beanElementComponent.getComponentnumber();
                String Capacity = "" + beanElementComponent.getCapacity();
      Capacity = (Capacity != null && !(Capacity.trim().equals(""))) ? nfA.format(beanElementComponent.getCapacity()) : "";
                      String NNMi_UUId = beanElementComponent.getNnmi_uuid();
                String NNMi_Id = beanElementComponent.getNnmi_id();
                String NNMi_LastUpdate = (beanElementComponent.getNnmi_lastupdate() == null) ? "" : beanElementComponent.getNnmi_lastupdate();
            
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ElementComponentApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="ElementComponentApplicationResources" property="ElementComponentId"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NE_Id"/>
        <html:errors bundle="ElementComponentApplicationResources" property="ParentEC_Id"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Name"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Description"/>
        <html:errors bundle="ElementComponentApplicationResources" property="State"/>
        <html:errors bundle="ElementComponentApplicationResources" property="ECType"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Type"/>
        <html:errors bundle="ElementComponentApplicationResources" property="OtherType"/>
        <html:errors bundle="ElementComponentApplicationResources" property="ComponentNumber"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Capacity"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NNMi_LastUpdate"/>
    </h1>
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
    allEvents = allEvents + "checkShowRulesType();";//default invoked when loading HTML
    function checkShowRulesType(){
          var ECTypePass = false;
      
              if (/^Slot$/.test(document.getElementsByName("ectype")[0].value)) {ECTypePass = true;}
                        
      

    var controlTr = document.getElementsByName("type")[0];
    
          if (true && ECTypePass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('ectype')[0],'change',checkShowRulesType);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesOtherType();";//default invoked when loading HTML
    function checkShowRulesOtherType(){
          var ECTypePass = false;
      
              if (/^Port$|^Controller$/.test(document.getElementsByName("ectype")[0].value)) {ECTypePass = true;}
                        
      

    var controlTr = document.getElementsByName("othertype")[0];
    
          if (true && ECTypePass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('ectype')[0],'change',checkShowRulesOtherType);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                              document.getElementsByName("type")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("othertype")[0].parentNode.parentNode.style.display="none";
                                                  // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
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
      
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
                                                  <html:hidden property="elementcomponentid" value="<%= ElementComponentId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="ElementComponentApplicationResources" key="field.ne_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="ne_id" value="<%= NE_Id %>" onchange="sendthis('ne_id');">
                      <html:options collection="NE_IdListOfValues" property="value" labelProperty="label" />
                    </html:select>
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
                                                                        <html:select  property="parentec_id" value="<%= ParentEC_Id %>" >
                      <html:options collection="ParentEC_IdListOfValues" property="value" labelProperty="label" />
                    </html:select>
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
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
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
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
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
                        String selValue=null;                                    
                        if(State==null||State.trim().equals("")) {
                          selValue="Up";
                        } else {
                          selValue=State.toString();
                        }    
                    %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                            <html:option value="Added" >Added</html:option>
                                            <html:option value="Removed" >Removed</html:option>
                                          </html:select>
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
                        String selValue=null;                                    
                        if(ECType==null||ECType.trim().equals("")) {
                          selValue="Slot";
                        } else {
                          selValue=ECType.toString();
                        }    
                    %>

                    <html:select  property="ectype" value="<%= selValue %>" >
                                            <html:option value="Slot" >Slot</html:option>
                                            <html:option value="Port" >Port</html:option>
                                            <html:option value="Controller" >Controller</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ElementComponentApplicationResources" key="field.ectype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ElementComponentApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="type" value="<%= Type %>" >
                      <html:options collection="TypeListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ElementComponentApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ElementComponentApplicationResources" key="field.othertype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="othertype" size="24" value="<%= OtherType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ElementComponentApplicationResources" key="field.othertype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ElementComponentApplicationResources" key="field.componentnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="componentnumber" size="24" value="<%= ComponentNumber %>"/>
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
                                                                        <html:text  property="capacity" size="24" value="<%= Capacity %>"/>
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
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
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
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
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
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_lastupdate.description"/>
                <%=sdfNNMi_LastUpdateDesc%>              </table:cell>
            </table:row>
                                            
      
      <table:row>
        <table:cell colspan="3" align="center">
        <br>
        </table:cell>
      </table:row>
      <table:row>
        <table:cell colspan="3" align="center">
          <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
          <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>
  </html:form>

  </body>

</html>
