<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%
String error = (String) request.getAttribute("error");
boolean showErrorTitle = request.getAttribute("advise") == null;
%>

<html>

<head>
	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
	<script src="/activator/javascript/hputils/alerts.js"></script>
</head>

<body>
	<script>
	var fa = new HPSAAlert(
<%
if (showErrorTitle) {
%>
		"<bean:message bundle="CompareDL_CRApplicationResources" key="error"/>",
<%
} else {
%>
		"",
<%
}
%>
		"<bean:message bundle="CompareDL_CRApplicationResources" key="<%= error %>" />");
	fa.setBounds(500, 100);
	fa.setButtonText("<bean:message bundle="InventoryResources" key="confirm.ok_button.label" />");
	fa.show();
	</script>
</body>

</html>