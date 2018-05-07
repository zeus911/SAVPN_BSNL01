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
String datasource = (String) request.getParameter(Sh_TrafficClassifierConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSh_TrafficClassifierAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("name") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "customerid";
                                                            }

%>

<html>
  <head>
    <title><bean:message bundle="Sh_TrafficClassifierApplicationResources" key="<%= Sh_TrafficClassifierConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_TrafficClassifierForm.action = '/activator<%=moduleConfig%>/UpdateFormSh_TrafficClassifierAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.Sh_TrafficClassifierForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_TrafficClassifierForm.action = '/activator<%=moduleConfig%>/UpdateCommitSh_TrafficClassifierAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.Sh_TrafficClassifierForm.submit();
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
com.hp.ov.activator.vpn.inventory.Sh_TrafficClassifier beanSh_TrafficClassifier = (com.hp.ov.activator.vpn.inventory.Sh_TrafficClassifier) request.getAttribute(Sh_TrafficClassifierConstants.SH_TRAFFICCLASSIFIER_BEAN);
if(beanSh_TrafficClassifier==null)
   beanSh_TrafficClassifier = (com.hp.ov.activator.vpn.inventory.Sh_TrafficClassifier) request.getSession().getAttribute(Sh_TrafficClassifierConstants.SH_TRAFFICCLASSIFIER_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
Sh_TrafficClassifierForm form = (Sh_TrafficClassifierForm) request.getAttribute("Sh_TrafficClassifierForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String Name = beanSh_TrafficClassifier.getName();
        
            
                            
            
                
                String CustomerId = beanSh_TrafficClassifier.getCustomerid();
        
            
                            
            
                
                String DSCPs = beanSh_TrafficClassifier.getDscps();
        
            
                            
            
                
                String Filter = beanSh_TrafficClassifier.getFilter();
        
            
                            
            
                
                String CoSs = beanSh_TrafficClassifier.getCoss();
        
            
                            
            
                
                String Layer = beanSh_TrafficClassifier.getLayer();
        
            
                            
            
                
                String Compliant = beanSh_TrafficClassifier.getCompliant();
        
            
                            
            
                
                String Marker = beanSh_TrafficClassifier.getMarker();
        
            
                            
            
                
                String UploadStatus = beanSh_TrafficClassifier.getUploadstatus();
        
            
                            
            
                
                String DBPrimaryKey = beanSh_TrafficClassifier.getDbprimarykey();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="Name"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="CustomerId"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="DSCPs"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="Filter"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="CoSs"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="Layer"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="Compliant"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_TrafficClassifierApplicationResources" property="DBPrimaryKey"/>
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
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="name" value="<%= Name %>"/>
                                                        <html:text disabled="true" property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.customerid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.customerid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.dscps.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dscps" size="24" value="<%= DSCPs %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.dscps.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.filter.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="filter" size="24" value="<%= Filter %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.filter.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.coss.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="coss" size="24" value="<%= CoSs %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.coss.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.layer.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(Layer==null||Layer.trim().equals(""))
                           selValue="layer 3";
                        else
                        selValue=Layer.toString();    
                          %>

                    <html:select  property="layer" value="<%= selValue %>" >
                                            <html:option value="layer 3" >layer 3</html:option>
                                            <html:option value="layer 2" >layer 2</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.layer.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.compliant.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(Compliant==null||Compliant.trim().equals(""))
                           selValue="compliant";
                        else
                        selValue=Compliant.toString();    
                          %>

                    <html:select  property="compliant" value="<%= selValue %>" >
                                            <html:option value="compliant" >compliant</html:option>
                                            <html:option value="partial compliant" >partial compliant</html:option>
                                            <html:option value="non compliant" >non compliant</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.compliant.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.marker.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.uploadstatus.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="field.dbprimarykey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                    
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
