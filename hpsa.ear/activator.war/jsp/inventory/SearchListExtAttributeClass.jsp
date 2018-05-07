<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
				com.hp.ov.activator.extAttribute.*,
				com.hp.ov.activator.extAttribute.action.*,
				org.apache.struts.util.LabelValueBean,
				org.apache.struts.action.Action,
				org.displaytag.decorator.TableDecorator,
				org.apache.struts.action.ActionErrors" %>
				
<%@ page import = "java.util.Locale" %>
<%@ page import = "java.util.ResourceBundle" %>
				

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<%@ page buffer="32kb" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

// Check if there is a valid session available.
if (session == null || session.getValue(ExtAttributeClassConstants.USER) == null) {
	response.sendRedirect(ExtAttributeClassConstants.NULL_SESSION);
	return;
}
%>

<%
String beanClassName = (String) request.getParameter("beanClassName");
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ExtAttributeClassConstants.DATASOURCE);
String tabName = ExtAttributeClassConstants.TAB_NAME;
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ExtAttributeClassForm form = (ExtAttributeClassForm) request.getAttribute("ExtAttributeClassForm");
String name___hide;
String description___hide;


StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListExtAttributeClass.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
	name___hide = form.getName___hide();
	description___hide = form.getDescription___hide();


	if ( name___hide != null )
		requestURI.append("name___hide=" + name___hide);
	if ( description___hide != null )
		requestURI.append("description___hide=" + description___hide);
 

} else {

		name___hide = request.getParameter("name___hide");
		description___hide = request.getParameter("description___hide");
 

}


%>
<script>
	function openBranch(pk) {
		var WDW = 3;
		var tabTitle = "<%= viewParameter %>";
		var wdwSelected = true;
		var url = "/activator/GetPartialTreeInstanceAction.do";
		url += "?ndid=<%= ndidParameter %>";
		url += "&vi=<%= viParameter %>";
		url += "&pk=" + pk;
		url += "&view=<%= viewParameter %>";
		url += "&rmn=" + WDW;
		parent.parent.addRimToMenu(WDW, tabTitle, wdwSelected, url);
	}
</script>
<link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    	<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
<script language="JavaScript" src="/activator/javascript/table.js"></script>
<script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
<script language="JavaScript" src="/activator/javascript/saNavigation.js"></script>
<script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
	<script src="/activator/javascript/hputils/alerts.js"></script>

<html>
	<head>
		<title><bean:message bundle="ExtAttributeClassApplicationResources" key="<%= ExtAttributeClassConstants.JSP_RESULTS_TITLE %>"/></title>
 
	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
   <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
		<style type="text/css">
			A.nodec { text-decoration: none; }
		</style>
	</head>
	
	<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">

	<center>




<table:table id="userInfo">
<table:header>
				<table:cell>
					Column Name
				</table:cell>
				<table:cell>
					Description
				</table:cell>
			</table:header>


			
			<%
ArrayList lista = (ArrayList)session.getAttribute("tab_name");
if( lista!=null){
  int listCount = lista.size();
  //System.out.println(lista);
if (listCount>0) {
     for(int i=0; i< listCount; i++){
     ExtAttributeClass ui = (ExtAttributeClass)lista.get(i);
%>

<table:row id="<%=ui.getName()%>">
<table:cell>
<%=ui.getName()%>
  </table:cell>
<table:cell>
<%= ui.getDescription()%>
  </table:cell>

  </table:row>

<%

     }
%>
<%
     }
     }
     
%>

</table:table>


	<!-- This table is hidden until selected for viewing with a right click -->
<div id="extMenu" class="contextMenu" onclick="hideContextMenu(window.menuName);">
      
        <a id="deleteMenu" href="javascript:void"
            class="menuItem"
            onmouseover="toggleHighlight(event)"
            onmouseout="toggleHighlight(event)"><input style="border:0;BACKGROUND:#E6E6E6;width:150" onmouseover="javascript:this.style.background='#CCCCCC'" onmouseout="javascript:this.style.background='#E6E6E6'" type=button value=delete onclick=deleteExt()></a>
</div>
 <script language="JavaScript">


    window.onload = function () {
       window.menuName = "extMenu";
       document.getElementById('userInfo').oncontextmenu = showContextMenu;
       scrollTo(0,top.scrollY);
       //recalculateDiv();
       //scrollToTab();
       if(document.all){
          var tr_header = document.getElementById("header");
          //tr_header.style.position = "relative";
       }
    }

    window.onresize = function () {
        //recalculateDiv();
    }
    
    function deleteExt() {
      //alert(partent.frames.length)
      //document.getElementById("deleteMenu").setAttribute("target","rimElem");
      var name =  getCookie(window.menuName);
      if (name == null)  {
         writeToMsgLine("Please select a ext_attribute.");
         return false;
      }
	  var firstNode=1;
	  if(navigator.userAgent.indexOf("MSIE")>0) {
		  firstNode=0;
	  }
      if (confirm("Do you want to delete ext_attribute " + document.getElementById(name).childNodes[firstNode].firstChild.nodeValue + "?"))
       {
          document.all("ExtAttributeClassForm").action='/activator/inventory/deleteExtAttribute.do?datasource=<%= datasource %>&_pk_=' + name +'&beanClassName=<%=beanClassName%>';
          document.all("ExtAttributeClassForm").submit();
          return true;
      }
      else {
          //top.opener.top.messageLine.location.href = '/activator/jsp/saDisplayMsg.jsp?Msg=' + escape("Ext_attribute \'"+name+"\' deleting is canceled.");
          return false;
      }
     return false;
    }

  </script>


		<%
		
com.hp.ov.activator.extAttribute.ExtAttributeClass beanExtAttributeClass = (com.hp.ov.activator.extAttribute.ExtAttributeClass) request.getAttribute(ExtAttributeClassConstants.EXTATTRIBUTECLASS_BEAN);

					String name = beanExtAttributeClass.getName();
		String errorAction = (String) request.getAttribute("ERROR_ACTION");
  String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
    String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");

					String description = beanExtAttributeClass.getDescription();
			%>

		<%
String rimid = (String) request.getParameter("rimid");

String formAction = "/inventory/creationExtAction.do?datasource=" + datasource + "&rimid=" + rimid +"&beanClassName="+beanClassName;
String location = (String) request.getParameter("_location_");



if ( location == null ) {
							location = "name";
										}

%>
	<script>
	function sendthis(focusthis) {
		window.document.ExtAttributeClassForm.action = '/inventory/creationExtAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
		window.document.ExtAttributeClassForm.submit();
	}
	function performCommit() {
	   //window.document.ExtAttributeClassForm.action = '/inventory/creationExtAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';

	}
</script>
	<html:errors bundle="ExtAttributeClassApplicationResources" property="name"/>
				<html:errors bundle="ExtAttributeClassApplicationResources" property="description"/>
				
				<html:form action="<%= formAction %>">
				
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
								<bean:message bundle="ExtAttributeClassApplicationResources" key="field.name.alias"/>
																	*
															</table:cell>
							<table:cell>
																																				<html:text  property="name" size="24" maxlength="20" value="<%= name %>"/>
																								</table:cell>
							<table:cell>
								<bean:message bundle="ExtAttributeClassApplicationResources" key="field.name.description"/>
							</table:cell>
						</table:row>
							<table:row>
							<table:cell>	
								<bean:message bundle="ExtAttributeClassApplicationResources" key="field.description.alias"/>
																	*
															</table:cell>
							<table:cell>
																																				<html:text  property="description" size="24" value="<%= description %>"/>
																								</table:cell>
							<table:cell>
								<bean:message bundle="ExtAttributeClassApplicationResources" key="field.description.description"/>
							</table:cell>
						</table:row>
																											<table:row>
						
						
						
						</table:row>
															
			
			
			<table:row>
				<table:cell colspan="3" align="center">
				<br>
				</table:cell>
            </table:row>
			<table:row>
				<table:cell colspan="3" align="center">
					<input type="submit" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
					<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
				</table:cell>
            </table:row>
			</table:table>
				</html:form>
	</center>
	</body>

<%	if ( errorMessage != null && !errorMessage.equals("") ) {
%>
		<script>
			var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
			alert.setBounds(400, 120);
			alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
			alert.show();
		</script>
<%
	}
%>
</html>
	
