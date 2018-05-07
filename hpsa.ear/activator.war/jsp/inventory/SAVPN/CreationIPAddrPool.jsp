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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(IPAddrPoolConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitIPAddrPoolAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "name";
                                                }
%>

<html>
  <head>
    <title><bean:message bundle="IPAddrPoolApplicationResources" key="<%= IPAddrPoolConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.IPAddrPoolForm.action = '/activator<%=moduleConfig%>/CreationFormIPAddrPoolAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.IPAddrPoolForm.submit();
    }
    function performCommit()
    {
      window.document.IPAddrPoolForm.action = '/activator<%=moduleConfig%>/CreationCommitIPAddrPoolAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.IPAddrPoolForm.submit();
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

com.hp.ov.activator.vpn.inventory.IPAddrPool beanIPAddrPool = (com.hp.ov.activator.vpn.inventory.IPAddrPool) request.getAttribute(IPAddrPoolConstants.IPADDRPOOL_BEAN);

            String Name = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getName());
      
      
                  String IPNet = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getIpnet());
      
      
                  String Mask = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getMask());
      
      
                  String IPNetAddress = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getIpnetaddress());
      
      
                  String Type = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getType());
      
      
                  String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getAddressfamily());
      
					IPNet = "value";
					Mask = "value";
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.creation.title"/>
</h2> 


<H1>
      <html:errors bundle="IPAddrPoolApplicationResources" property="Name"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="IPNet"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="Mask"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="IPNetAddress"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="Type"/>
        <html:errors bundle="IPAddrPoolApplicationResources" property="AddressFamily"/>
  </H1>
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
<script type="text/javascript">
function change(tipv4Host, tipv6Host) {
	var selectBox1 = document.forms[0].type;
	var selectedValue1 = selectBox1.options[selectBox1.selectedIndex].value;
	var selectBox2 = document.forms[0].addressfamily;
	if(selectedValue1 == "IPHost"){
		if(tipv4Host == false){
			selectBox2[0].disabled=true;
			selectBox2.selectedIndex = 1;
		}
		else if(tipv6Host == false){
			selectBox2[1].disabled=true;
			selectBox2.selectedIndex = 0;
		}
		else{
		selectBox2[0].disabled=false;
		selectBox2[1].disabled=false;
		}
	}
}
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
<%
         IPAddrPool[] iphosts = (com.hp.ov.activator.vpn.inventory.IPAddrPool[]) request.getAttribute("iphosts");
         IPAddrPool[] mdtDefaults = (com.hp.ov.activator.vpn.inventory.IPAddrPool[]) request.getAttribute("mdtDefaults");
         IPAddrPool[] mdtDatas = (com.hp.ov.activator.vpn.inventory.IPAddrPool[]) request.getAttribute("mdtDatas");
         IPAddrPool[] nats = (com.hp.ov.activator.vpn.inventory.IPAddrPool[]) request.getAttribute("nats");
         IPAddrPool[] multicastLoopbacks = (com.hp.ov.activator.vpn.inventory.IPAddrPool[]) request.getAttribute("multicastLoopbacks");
         String typeStr= (String)request.getAttribute("TYPE");
         if (typeStr == null)
         	typeStr="";
      
		boolean ipv4Host = true;
		boolean ipv6Host = true;
		if (iphosts != null && iphosts.length == 1){
			com.hp.ov.activator.vpn.inventory.IPAddrPool temPool = iphosts[0];
			String addFamily = temPool.getAddressfamily();
			if("IPv4".equalsIgnoreCase(addFamily)){
				ipv4Host = false;
			}
			else{
				ipv6Host = false;
			}
		}
		else if(iphosts != null && iphosts.length > 1){
			ipv4Host = false;
			ipv6Host = false;
		}
		String onChangeMethod="change("+ipv4Host+","+ipv6Host+")";
%>
                                    <table:row>
              <table:cell>  
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="ipnet" value="<%= IPNet %>"/>            
                                                                                <html:hidden property="mask" value="<%= Mask %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnetaddress.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnetaddress" size="24" value="<%= IPNetAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnetaddress.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.type.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Type==null||Type.trim().equals("")) {
                                                  selValue="${field.listOfValueSelected}";
                        } else {
                          selValue=Type.toString();
                        }    
                    %>

                    <html:select  property="type" value="<%= selValue %>" onclick="<%=onChangeMethod%>">
                	<%if(typeStr.equals("LSP")){%>
                                            <html:option value="LSP" >LSP</html:option>
                    <%}else{%>
                                            <html:option value="IPNet" >IPNet</html:option>
                     <%if(iphosts == null || (ipv4Host || ipv6Host) || (typeStr.equals("LSP"))){%>
                                            <html:option value="IPHost" >IPHost</html:option>
                    <%}%>
                    <%if(mdtDefaults == null && !typeStr.equals("LSP")){%>
                                            <html:option value="MDT Default" >MDT Default</html:option>
                    <%}%>
                    <%if(nats == null && !typeStr.equals("LSP")){%>
                    <html:option value="NAT">NAT</html:option>
                    <%}%>
                    <%if(mdtDatas == null && !typeStr.equals("LSP")){%>
                                            <html:option value="MDT Data" >MDT Data</html:option>
                    <%}%>
                    <%if(multicastLoopbacks == null && !typeStr.equals("LSP")){%>
                                            <html:option value="Multicast loopback" >Multicast loopback</html:option>
                    <%}%>
						<html:option value="Multicast Source" >Multicast Source</html:option>
						<html:option value="Multicast Group" >Multicast Group</html:option>
						<html:option value="Multicast RP" >Multicast RP</html:option>
						<html:option value="Multicast MSDP" >Multicast MSDP</html:option>
                    <%}%>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.addressfamily.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(AddressFamily==null||AddressFamily.trim().equals("")) {
                          selValue="IPv4";
                        } else {
                          selValue=AddressFamily.toString();
                        }    
                    %>

                    <html:select  property="addressfamily" value="<%= selValue %>" onfocus="<%=onChangeMethod%>">
                                            <html:option value="IPv4" >IPv4</html:option>
                                            <html:option value="IPv6" >IPv6</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources" key="field.addressfamily.description"/>
                              </table:cell>
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
