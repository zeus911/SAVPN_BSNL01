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
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitServiceAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
                                _location_ = "contactperson";
                                                            }

%>

<html>
  <head>
    <title><bean:message bundle="ServiceApplicationResources" key="<%= ServiceConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.ServiceForm.action = '/activator<%=moduleConfig%>/UpdateFormServiceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.ServiceForm.submit();
    }
    function performCommit()
    {
      window.document.ServiceForm.action = '/activator<%=moduleConfig%>/UpdateCommitServiceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.ServiceForm.submit();
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
com.hp.ov.activator.vpn.inventory.Service beanService = (com.hp.ov.activator.vpn.inventory.Service) request.getAttribute(ServiceConstants.SERVICE_BEAN);
if(beanService==null)
   beanService = (com.hp.ov.activator.vpn.inventory.Service) request.getSession().getAttribute(ServiceConstants.SERVICE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
ServiceForm form = (ServiceForm) request.getAttribute("ServiceForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ServiceId = beanService.getServiceid();
        
            
                            
            
                
                String CustomerId = beanService.getCustomerid();
        
            
                            
            
                
                String Customer = beanService.getCustomer();
        
            
                            
            
                
                String ContactPerson = beanService.getContactperson();
        
            
                            
            
                
                String ServiceName = beanService.getServicename();
        
            
                            
            
                
                String InitiationDate = beanService.getInitiationdate();
        
            
                            
            
                
                String ActivationDate = beanService.getActivationdate();
        
            
                            
            
                
                String ModificationDate = beanService.getModificationdate();
        
            
                            
            
                
                String State = beanService.getState();
        
            
                            
            
                
                String Type = beanService.getType();
        
            
                            
            
                
                String Comments = beanService.getComments();
        
            
                            
            
                
              String __count = "" + beanService.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanService.get__count()) : "";
          
            
            if( beanService.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ServiceApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="ServiceApplicationResources" property="ServiceId"/>
        <html:errors bundle="ServiceApplicationResources" property="CustomerId"/>
        <html:errors bundle="ServiceApplicationResources" property="Customer"/>
        <html:errors bundle="ServiceApplicationResources" property="ContactPerson"/>
        <html:errors bundle="ServiceApplicationResources" property="ServiceName"/>
        <html:errors bundle="ServiceApplicationResources" property="InitiationDate"/>
        <html:errors bundle="ServiceApplicationResources" property="ActivationDate"/>
        <html:errors bundle="ServiceApplicationResources" property="ModificationDate"/>
        <html:errors bundle="ServiceApplicationResources" property="State"/>
        <html:errors bundle="ServiceApplicationResources" property="Type"/>
        <html:errors bundle="ServiceApplicationResources" property="Comments"/>
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
    allEvents = allEvents + "checkShowRulesModificationDate();";//default invoked when loading HTML
    function checkShowRulesModificationDate(){
          var ModificationDatePass = false ;
      if (/^[0-9]+.*$/.test(document.getElementsByName("modificationdate")[0].value)) {ModificationDatePass = true;}
            
    var controlTr = document.getElementsByName("modificationdate")[0];
          if (true && ModificationDatePass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('modificationdate')[0],'keyup',checkShowRulesModificationDate);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                              document.getElementsByName("modificationdate")[0].parentNode.parentNode.style.display="none";
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
      
                                                  <html:hidden property="serviceid" value="<%= ServiceId %>"/>            
				                                            
                                                    <html:hidden property="customerid" value="<%= CustomerId %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ServiceApplicationResources" key="field.customer.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customer" value="<%= Customer %>"/>
                                                        <html:text disabled="true" property="customer" size="24" value="<%= Customer %>"/>
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
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ServiceApplicationResources" key="field.contactperson.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="servicename" value="<%= ServiceName %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ServiceApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="initiationdate" value="<%= InitiationDate %>"/>
                                                        <html:text disabled="true" property="initiationdate" size="24" value="<%= InitiationDate %>"/>
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
                                                      <html:hidden property="activationdate" value="<%= ActivationDate %>"/>
                                                        <html:text disabled="true" property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ServiceApplicationResources" key="field.activationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ServiceApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="modificationdate" value="<%= ModificationDate %>"/>
                                                        <html:text disabled="true" property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ServiceApplicationResources" key="field.modificationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ServiceApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="state" value="<%= State %>"/>
                                                        <html:text disabled="true" property="state" size="24" value="<%= State %>"/>
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
                                                      <html:hidden property="type" value="<%= Type %>"/>
                                                        <html:text disabled="true" property="type" size="24" value="<%= Type %>"/>
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
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ServiceApplicationResources" key="field.comments.description"/>
                                                                        </table:cell>
            </table:row>
                                
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="ServiceApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="ServiceApplicationResources" key="field.__count.description"/>
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
