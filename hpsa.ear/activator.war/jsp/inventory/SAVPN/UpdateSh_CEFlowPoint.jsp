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
String datasource = (String) request.getParameter(Sh_CEFlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSh_CEFlowPointAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("terminationpointid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "attachmentid";
                                                            }

%>

<html>
  <head>
    <title><bean:message bundle="Sh_CEFlowPointApplicationResources" key="<%= Sh_CEFlowPointConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_CEFlowPointForm.action = '/activator<%=moduleConfig%>/UpdateFormSh_CEFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.Sh_CEFlowPointForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_CEFlowPointForm.action = '/activator<%=moduleConfig%>/UpdateCommitSh_CEFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.Sh_CEFlowPointForm.submit();
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
com.hp.ov.activator.vpn.inventory.Sh_CEFlowPoint beanSh_CEFlowPoint = (com.hp.ov.activator.vpn.inventory.Sh_CEFlowPoint) request.getAttribute(Sh_CEFlowPointConstants.SH_CEFLOWPOINT_BEAN);
if(beanSh_CEFlowPoint==null)
   beanSh_CEFlowPoint = (com.hp.ov.activator.vpn.inventory.Sh_CEFlowPoint) request.getSession().getAttribute(Sh_CEFlowPointConstants.SH_CEFLOWPOINT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
Sh_CEFlowPointForm form = (Sh_CEFlowPointForm) request.getAttribute("Sh_CEFlowPointForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String TerminationPointID = beanSh_CEFlowPoint.getTerminationpointid();
        
            
                            
            
                
                String AttachmentId = beanSh_CEFlowPoint.getAttachmentid();
        
            
                            
            
                
                String QoSProfile_in = beanSh_CEFlowPoint.getQosprofile_in();
        
            
                            
            
                
                String QoSProfile_out = beanSh_CEFlowPoint.getQosprofile_out();
        
            
                            
            
                
                String RateLimit_in = beanSh_CEFlowPoint.getRatelimit_in();
        
            
                            
            
                
                String RateLimit_out = beanSh_CEFlowPoint.getRatelimit_out();
        
            
                            
            
                
                String Marker = beanSh_CEFlowPoint.getMarker();
        
            
                            
            
                
                String UploadStatus = beanSh_CEFlowPoint.getUploadstatus();
        
            
                            
            
                
                String DBPrimaryKey = beanSh_CEFlowPoint.getDbprimarykey();
        
            
                            
            
                
                String NE_ID = beanSh_CEFlowPoint.getNe_id();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_CEFlowPointApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_CEFlowPointApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="AttachmentId"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_CEFlowPointApplicationResources" property="NE_ID"/>
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
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="terminationpointid" value="<%= TerminationPointID %>"/>
                                                        <html:text disabled="true" property="terminationpointid" size="24" value="<%= TerminationPointID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.attachmentid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="attachmentid" size="24" value="<%= AttachmentId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.attachmentid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_in" size="24" value="<%= QoSProfile_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_out" size="24" value="<%= QoSProfile_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_in" size="24" value="<%= RateLimit_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_out" size="24" value="<%= RateLimit_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.marker.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.uploadstatus.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.dbprimarykey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ne_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ne_id" size="24" value="<%= NE_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ne_id.description"/>
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
