<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>
<%@ page import = "com.hp.ov.activator.inventory.facilities.StringFacility" %>
<%@ page import = "org.apache.struts.util.LabelValueBean" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "org.apache.commons.beanutils.PropertyUtils" %>


<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<script>
function init() {
	var sopVal = new parent.FutureSelect();
	sopVal.isFromGetvalue=true;
<%
ArrayList values = (ArrayList) request.getAttribute(ConstantsFTStruts.ADVANCED_SEARCHED_VALUES);
//LabelValueBean value;
String value="";
//String text;
for (int i = 0; i < values.size(); i++) {
	//System.out.println("value[i]="+i);
	if(values.get(i)!=null){
		//System.out.println("value[i]="+i);
		Object bean =  values.get(i);
		value = PropertyUtils.getProperty(bean, "label").toString();
	}

	//value=(String[])values.get(i);
	//text="text"+i;
	//text = StringFacility.replaceAllByHTMLCharacter(value.getLabel());
%>
	sopVal.addOption("<%= value  %>", "<%= value %>", false, null, null, null);
<%
}
%>
	parent.updatingFSO.setChild(sopVal);
	parent.updatingFSO.getChild().show();
}
</script>
<html>
<head>
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>

<body onload="init();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
</body>

</head>