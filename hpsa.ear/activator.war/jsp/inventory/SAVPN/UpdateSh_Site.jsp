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
String datasource = (String) request.getParameter(Sh_SiteConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSh_SiteAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
    <title><bean:message bundle="Sh_SiteApplicationResources" key="<%= Sh_SiteConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_SiteForm.action = '/activator<%=moduleConfig%>/UpdateFormSh_SiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.Sh_SiteForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_SiteForm.action = '/activator<%=moduleConfig%>/UpdateCommitSh_SiteAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.Sh_SiteForm.submit();
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
com.hp.ov.activator.vpn.inventory.Sh_Site beanSh_Site = (com.hp.ov.activator.vpn.inventory.Sh_Site) request.getAttribute(Sh_SiteConstants.SH_SITE_BEAN);
if(beanSh_Site==null)
   beanSh_Site = (com.hp.ov.activator.vpn.inventory.Sh_Site) request.getSession().getAttribute(Sh_SiteConstants.SH_SITE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
Sh_SiteForm form = (Sh_SiteForm) request.getAttribute("Sh_SiteForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ServiceId = beanSh_Site.getServiceid();
        
            
                            
            
                
                String CustomerId = beanSh_Site.getCustomerid();
        
            
                            
            
                
                String ServiceName = beanSh_Site.getServicename();
        
            
                            
            
                
                String InitiationDate = beanSh_Site.getInitiationdate();
        
            
                            
            
                
                String ActivationDate = beanSh_Site.getActivationdate();
        
            
                            
            
                
                String ModificationDate = beanSh_Site.getModificationdate();
        
            
                            
            
                
                String State = beanSh_Site.getState();
        
            
                            
            
                
                String Type = beanSh_Site.getType();
        
            
                            
            
                
                String ContactPerson = beanSh_Site.getContactperson();
        
            
                            
            
                
                String Comments = beanSh_Site.getComments();
        
            
                            
            
                
                String Marker = beanSh_Site.getMarker();
        
            
                            
            
                
                String UploadStatus = beanSh_Site.getUploadstatus();
        
            
                            
            
                
                String DBPrimaryKey = beanSh_Site.getDbprimarykey();
        
            
                            
            
                
              String __count = "" + beanSh_Site.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_Site.get__count()) : "";
          
            
            if( beanSh_Site.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
                String RemoteASN = beanSh_Site.getRemoteasn();
        
            
                            
            
                
                String OSPF_Area = beanSh_Site.getOspf_area();
        
            
                            
            
                
                String SiteOfOrigin = beanSh_Site.getSiteoforigin();
        
            
                            
            
                
              boolean Managed = new Boolean(beanSh_Site.getManaged()).booleanValue();
    
            
                            
            
                
                String Multicast = beanSh_Site.getMulticast();
        
            
                            
            
                
                String PostalAddress = beanSh_Site.getPostaladdress();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_SiteApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_SiteApplicationResources" property="ServiceId"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="CustomerId"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="ServiceName"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="InitiationDate"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="ActivationDate"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="ModificationDate"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="State"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="Type"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="ContactPerson"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="Comments"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="DBPrimaryKey"/>
          <html:errors bundle="Sh_SiteApplicationResources" property="RemoteASN"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="OSPF_Area"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="SiteOfOrigin"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="Managed"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="Multicast"/>
        <html:errors bundle="Sh_SiteApplicationResources" property="PostalAddress"/>
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
                <bean:message bundle="Sh_SiteApplicationResources" key="field.serviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="serviceid" value="<%= ServiceId %>"/>
                                                        <html:text disabled="true" property="serviceid" size="24" value="<%= ServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.serviceid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customerid" value="<%= CustomerId %>"/>
                                                        <html:text disabled="true" property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.customerid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.servicename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="servicename" size="24" value="<%= ServiceName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.servicename.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.initiationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.activationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.modificationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.contactperson.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.comments.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.marker.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.uploadstatus.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.dbprimarykey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.__count.description"/>
              </table:cell>
      </table:row>
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.remoteasn.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="remoteasn" size="24" value="<%= RemoteASN %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.remoteasn.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.ospf_area.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ospf_area" size="24" value="<%= OSPF_Area %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.ospf_area.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.siteoforigin.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="siteoforigin" size="24" value="<%= SiteOfOrigin %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.siteoforigin.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.managed.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox disabled="true" property="managed" value="true"/>
                  <html:hidden disabled="true" property="managed" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.managed.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.multicast.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="multicast" value="<%= Multicast %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(Multicast==null||Multicast.trim().equals(""))
                           selValue="disabled";
                        else
                        selValue=Multicast.toString();    
                          %>

                    <html:select disabled="true" property="multicast" value="<%= selValue %>" >
                                            <html:option value="disabled" >disabled</html:option>
                                            <html:option value="enabled" >enabled</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.multicast.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_SiteApplicationResources" key="field.postaladdress.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="postaladdress" size="24" value="<%= PostalAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_SiteApplicationResources" key="field.postaladdress.description"/>
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
