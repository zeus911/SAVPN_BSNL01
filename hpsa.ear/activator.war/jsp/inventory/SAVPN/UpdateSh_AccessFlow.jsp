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
String datasource = (String) request.getParameter(Sh_AccessFlowConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSh_AccessFlowAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("serviceid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                          _location_ = "servicename";
                                                                                                            }

%>

<html>
  <head>
    <title><bean:message bundle="Sh_AccessFlowApplicationResources" key="<%= Sh_AccessFlowConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_AccessFlowForm.action = '/activator<%=moduleConfig%>/UpdateFormSh_AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.Sh_AccessFlowForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_AccessFlowForm.action = '/activator<%=moduleConfig%>/UpdateCommitSh_AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.Sh_AccessFlowForm.submit();
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
com.hp.ov.activator.vpn.inventory.Sh_AccessFlow beanSh_AccessFlow = (com.hp.ov.activator.vpn.inventory.Sh_AccessFlow) request.getAttribute(Sh_AccessFlowConstants.SH_ACCESSFLOW_BEAN);
if(beanSh_AccessFlow==null)
   beanSh_AccessFlow = (com.hp.ov.activator.vpn.inventory.Sh_AccessFlow) request.getSession().getAttribute(Sh_AccessFlowConstants.SH_ACCESSFLOW_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
Sh_AccessFlowForm form = (Sh_AccessFlowForm) request.getAttribute("Sh_AccessFlowForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ServiceId = beanSh_AccessFlow.getServiceid();
        
            
                            
            
                
                String CustomerId = beanSh_AccessFlow.getCustomerid();
        
            
                            
            
                
                String ServiceName = beanSh_AccessFlow.getServicename();
        
            
                            
            
                
                String InitiationDate = beanSh_AccessFlow.getInitiationdate();
        
            
                            
            
                
                String ActivationDate = beanSh_AccessFlow.getActivationdate();
        
            
                            
            
                
                String ModificationDate = beanSh_AccessFlow.getModificationdate();
        
            
                            
            
                
                String State = beanSh_AccessFlow.getState();
        
            
                            
            
                
                String Type = beanSh_AccessFlow.getType();
        
            
                            
            
                
                String ContactPerson = beanSh_AccessFlow.getContactperson();
        
            
                            
            
                
                String Comments = beanSh_AccessFlow.getComments();
        
            
                            
            
                
                String Marker = beanSh_AccessFlow.getMarker();
        
            
                            
            
                
                String UploadStatus = beanSh_AccessFlow.getUploadstatus();
        
            
                            
            
                
                String DBPrimaryKey = beanSh_AccessFlow.getDbprimarykey();
        
            
                            
            
                
              String __count = "" + beanSh_AccessFlow.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_AccessFlow.get__count()) : "";
          
            
            if( beanSh_AccessFlow.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
                String SiteId = beanSh_AccessFlow.getSiteid();
        
            
                            
            
                
                String VlanId = beanSh_AccessFlow.getVlanid();
        
            
                            
            
                
                String PE_Status = beanSh_AccessFlow.getPe_status();
        
            
                            
            
                
                String CE_Status = beanSh_AccessFlow.getCe_status();
        
            
                            
            
                
                String AccessNW_Status = beanSh_AccessFlow.getAccessnw_status();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_AccessFlowApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_AccessFlowApplicationResources" property="ServiceId"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="CustomerId"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="ServiceName"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="InitiationDate"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="ActivationDate"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="ModificationDate"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="State"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="Type"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="ContactPerson"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="Comments"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="DBPrimaryKey"/>
          <html:errors bundle="Sh_AccessFlowApplicationResources" property="SiteId"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="VlanId"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="PE_Status"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="CE_Status"/>
        <html:errors bundle="Sh_AccessFlowApplicationResources" property="AccessNW_Status"/>
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
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.serviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="serviceid" value="<%= ServiceId %>"/>
                                                        <html:text disabled="true" property="serviceid" size="24" value="<%= ServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.serviceid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customerid" value="<%= CustomerId %>"/>
                                                        <html:text disabled="true" property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.customerid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.servicename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="servicename" size="24" value="<%= ServiceName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.servicename.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.initiationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.activationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.modificationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.contactperson.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.comments.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.marker.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.uploadstatus.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.dbprimarykey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.__count.description"/>
              </table:cell>
      </table:row>
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.siteid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="siteid" value="<%= SiteId %>"/>
                                                        <html:text disabled="true" property="siteid" size="24" value="<%= SiteId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.siteid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanid" size="24" value="<%= VlanId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.vlanid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.pe_status.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="pe_status" value="<%= PE_Status %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(PE_Status==null||PE_Status.trim().equals(""))
                           selValue="In Progress";
                        else
                        selValue=PE_Status.toString();    
                          %>

                    <html:select disabled="true" property="pe_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.pe_status.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.ce_status.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ce_status" value="<%= CE_Status %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(CE_Status==null||CE_Status.trim().equals(""))
                           selValue="In Progress";
                        else
                        selValue=CE_Status.toString();    
                          %>

                    <html:select disabled="true" property="ce_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.ce_status.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="accessnw_status" value="<%= AccessNW_Status %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(AccessNW_Status==null||AccessNW_Status.trim().equals(""))
                           selValue="In Progress";
                        else
                        selValue=AccessNW_Status.toString();    
                          %>

                    <html:select disabled="true" property="accessnw_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_AccessFlowApplicationResources" key="field.accessnw_status.description"/>
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
