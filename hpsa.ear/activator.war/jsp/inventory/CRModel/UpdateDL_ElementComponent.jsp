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
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_ElementComponentAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("ec_id") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                                              _location_ = "type";
                                          }

%>

<html>
  <head>
    <title><bean:message bundle="DL_ElementComponentApplicationResources" key="<%= DL_ElementComponentConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.DL_ElementComponentForm.action = '/activator<%=moduleConfig%>/UpdateFormDL_ElementComponentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.DL_ElementComponentForm.submit();
    }
    function performCommit()
    {
      window.document.DL_ElementComponentForm.action = '/activator<%=moduleConfig%>/UpdateCommitDL_ElementComponentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.DL_ElementComponentForm.submit();
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
com.hp.ov.activator.nnmi.dl.inventory.DL_ElementComponent beanDL_ElementComponent = (com.hp.ov.activator.nnmi.dl.inventory.DL_ElementComponent) request.getAttribute(DL_ElementComponentConstants.DL_ELEMENTCOMPONENT_BEAN);
if(beanDL_ElementComponent==null)
   beanDL_ElementComponent = (com.hp.ov.activator.nnmi.dl.inventory.DL_ElementComponent) request.getSession().getAttribute(DL_ElementComponentConstants.DL_ELEMENTCOMPONENT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_ElementComponentForm form = (DL_ElementComponentForm) request.getAttribute("DL_ElementComponentForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String EC_Id = beanDL_ElementComponent.getEc_id();
        
            
                            
            
                
                String NNMi_Id = beanDL_ElementComponent.getNnmi_id();
        
            
                            
            
                
                String NE_NNMi_Id = beanDL_ElementComponent.getNe_nnmi_id();
        
            
                            
            
                
                String ParentEC_Id = beanDL_ElementComponent.getParentec_id();
        
            
                            
            
                
                String Name = beanDL_ElementComponent.getName();
        
            
                            
            
                
                String Description = beanDL_ElementComponent.getDescription();
        
            
                            
            
                
                String State = beanDL_ElementComponent.getState();
        
            
                            
            
                
                String ECType = beanDL_ElementComponent.getEctype();
        
            
                            
            
                
                String Type = beanDL_ElementComponent.getType();
        
            
                            
            
                
                String ComponentNumber = beanDL_ElementComponent.getComponentnumber();
        
            
                            
            
                
              String Capacity = "" + beanDL_ElementComponent.getCapacity();
              Capacity = (Capacity != null && !(Capacity.trim().equals(""))) ? nfA.format(beanDL_ElementComponent.getCapacity()) : "";
          
            
            if( beanDL_ElementComponent.getCapacity()==Integer.MIN_VALUE)
         Capacity = "";
                            
            
                
                String NNMi_UUId = beanDL_ElementComponent.getNnmi_uuid();
        
            
                            
            
                
              String NNMi_LastUpdate = (beanDL_ElementComponent.getNnmi_lastupdate() == null) ? "" : beanDL_ElementComponent.getNnmi_lastupdate();
      NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy");
                    String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
          sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
    
            
                            
            
                
                String StateName = beanDL_ElementComponent.getStatename();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_ElementComponentApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="DL_ElementComponentApplicationResources" property="EC_Id"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="NE_NNMi_Id"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="ParentEC_Id"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="Name"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="Description"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="State"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="ECType"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="Type"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="ComponentNumber"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="Capacity"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="NNMi_LastUpdate"/>
        <html:errors bundle="DL_ElementComponentApplicationResources" property="StateName"/>
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
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ec_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ec_id" value="<%= EC_Id %>"/>
                                                        <html:text disabled="true" property="ec_id" size="24" value="<%= EC_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ec_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ne_nnmi_id.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ne_nnmi_id" value="<%= NE_NNMi_Id %>"/>
                                                        <html:text disabled="true" property="ne_nnmi_id" size="24" value="<%= NE_NNMi_Id %>"/>
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
                                                      <html:hidden property="parentec_id" value="<%= ParentEC_Id %>"/>
                                                        <html:text disabled="true" property="parentec_id" size="24" value="<%= ParentEC_Id %>"/>
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
                                                      <html:hidden property="name" value="<%= Name %>"/>
                                                        <html:text disabled="true" property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="description" value="<%= Description %>"/>            
				                                            
                                                    <html:hidden property="state" value="<%= State %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.ectype.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ectype" value="<%= ECType %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(ECType==null||ECType.trim().equals(""))
                           selValue="Slot";
                        else
                        selValue=ECType.toString();    
                          %>

                    <html:select disabled="true" property="ectype" value="<%= selValue %>" >
                                            <html:option value="Slot" >Slot</html:option>
                                            <html:option value="Port" >Port</html:option>
                                            <html:option value="Controller" >Controller</html:option>
                                          </html:select>
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
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="componentnumber" value="<%= ComponentNumber %>"/>            
				                                            
                                                    <html:hidden property="capacity" value="<%= Capacity %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_uuid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
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
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DL_ElementComponentApplicationResources" key="field.nnmi_lastupdate.description"/>
                <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="statename" value="<%= StateName %>"/>            
				                                            
                    
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
      
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
