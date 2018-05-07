<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
				 java.sql.*,
				 java.net.*,
				 javax.sql.DataSource,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
				 com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
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
String datasource = (String) request.getParameter(IPNetConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitIPNetAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                                                                    _location_ = "parentipnetaddr";
                                    }
%>
<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.IPAddrPool" />
<%
	if(request.getParameter("name") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("name"), "UTF-8"));
    }
	else{
		bean.setPrimaryKey(URLDecoder.decode(request.getParameter("poolname"), "UTF-8"));
	}
	DataSource dbp = (DataSource) InventoryTreeServlet.getDatasource(request.getParameter(IPNetConstants.DATASOURCE));
    Connection con = null;
	String addressFamily =  null;
	String poolName = null;
	
    try {
        con = (Connection)dbp.getConnection();
		bean = (com.hp.ov.activator.vpn.inventory.IPAddrPool)com.hp.ov.activator.vpn.inventory.IPAddrPool.findByPrimaryKey( con, bean.getPrimaryKey());
		addressFamily = bean.getAddressfamily();
		poolName = bean.getName();
	}catch(Exception e){%>
		<script>
			alert("Error retrieving information for: Address pool" + "\n" +"<%= e.getMessage()%>" );
		</script>
<%
	}
	finally{
		try{
            con.close();
        }catch(Throwable th){
            // don't matter
        }
	}
	if ( bean == null || con == null){%>
		<script>
			alert("Unable to display for creation: Address pool " + "\n" +
			"Potential reasons for failure are: "
			 + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
			 + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
			 + "\n" + " - The requested data may have previously been deleted.");
		</script>
	<%}%>


<html>
  <head>
    <title><bean:message bundle="IPNetApplicationResources" key="<%= IPNetConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.IPNetForm.action = '/activator<%=moduleConfig%>/CreationFormIPNetAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.IPNetForm.submit();
    }
    function performCommit()
    {
      window.document.IPNetForm.action = '/activator<%=moduleConfig%>/CreationCommitIPNetAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.IPNetForm.submit();
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

com.hp.ov.activator.vpn.inventory.IPNet beanIPNet = (com.hp.ov.activator.vpn.inventory.IPNet) request.getAttribute(IPNetConstants.IPNET_BEAN);

            String IPNetAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getIpnetaddr());
      
      
                  String PE1_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getPe1_ipaddr());
      
      
                  String CE1_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getCe1_ipaddr());
      
      
                  String PE2_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getPe2_ipaddr());
      
      
                  String CE2_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getCe2_ipaddr());
      
      
                  String Netmask = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getNetmask());
      
      
                  String Hostmask = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getHostmask());
      
      
                  String PoolName = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getPoolname());
      
      
                  String IPNetAddrStr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getIpnetaddrstr());
      
      
                  String ParentIPNetAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getParentipnetaddr());
      
      
                  String StartAddress = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getStartaddress());
      
      
                  String NumberOfEntries = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getNumberofentries());
      
      
                  String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getAddressfamily());
      
				  IPNetAddr = "value";
				  PE1_IPAddr = "value";
				  CE1_IPAddr = "value";
				  Netmask = "value";
				  Hostmask = "value";
				  PoolName = poolName;
				  AddressFamily = addressFamily;
      
            
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPNetApplicationResources" key="jsp.creation.title"/>
</h2> 


<H1>
      <html:errors bundle="IPNetApplicationResources" property="IPNetAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="PE1_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="CE1_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="PE2_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="CE2_IPAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="Netmask"/>
        <html:errors bundle="IPNetApplicationResources" property="Hostmask"/>
        <html:errors bundle="IPNetApplicationResources" property="PoolName"/>
        <html:errors bundle="IPNetApplicationResources" property="IPNetAddrStr"/>
        <html:errors bundle="IPNetApplicationResources" property="ParentIPNetAddr"/>
        <html:errors bundle="IPNetApplicationResources" property="StartAddress"/>
        <html:errors bundle="IPNetApplicationResources" property="NumberOfEntries"/>
        <html:errors bundle="IPNetApplicationResources" property="AddressFamily"/>
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
      
                                                  <html:hidden property="ipnetaddr" value="<%= IPNetAddr %>"/>            
                                                                                <html:hidden property="pe1_ipaddr" value="<%= PE1_IPAddr %>"/>            
                                                                                <html:hidden property="ce1_ipaddr" value="<%= CE1_IPAddr %>"/>            
                                                                                <html:hidden property="pe2_ipaddr" value="<%= PE2_IPAddr %>"/>            
                                                                                <html:hidden property="ce2_ipaddr" value="<%= CE2_IPAddr %>"/>            
                                                                                <html:hidden property="netmask" value="<%= Netmask %>"/>            
                                                                                <html:hidden property="hostmask" value="<%= Hostmask %>"/>            
                                                                                <html:hidden property="poolname" value="<%= PoolName %>"/>            
                                                                                <html:hidden property="ipnetaddrstr" value="<%= IPNetAddrStr %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.parentipnetaddr.alias"/>
                              </table:cell>
              <table:cell>
					<%= bean.getIpnet() %>/<%= bean.getMask() %>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.parentipnetaddr.description"/>
                              </table:cell>
            </table:row>
			<input type="hidden" name="parentipnetaddr" value="<%= bean.getIpnet() == null ? "" : bean.getIpnet() %>/<%= bean.getMask() == null ? "" : bean.getMask() %>">
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.startaddress.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="startaddress" size="24" value="<%= StartAddress %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.startaddress.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="IPNetApplicationResources" key="field.numberofentries.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="numberofentries" size="24" value="<%= NumberOfEntries %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="IPNetApplicationResources" key="field.numberofentries.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="addressfamily" value="<%= AddressFamily %>"/>            
                                                        
      
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
