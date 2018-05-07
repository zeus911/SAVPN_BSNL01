<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import = "com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.Field" %>
<%@ page import = "java.util.*" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts"%>
<%@ page import="com.hp.ov.activator.inventory.views.TreeViewStructure"%>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.TreeViewStructureCodeWriter"%>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet"%>

<%
String actualFilterName = request.getParameter("actualFilterName");
Field[] fields = (Field[]) request.getAttribute(ConstantsFTStruts.FIELDS);
HashMap fieldsValues = (HashMap) request.getAttribute(ConstantsFTStruts.FIELDSVALUES);
String filtername = (String) request.getAttribute(ConstantsFTStruts.FILTERNAME);
String filterdesc = (String) request.getAttribute(ConstantsFTStruts.FILTERDESCRIPTION);
HashMap userfilters = (HashMap) request.getAttribute(ConstantsFTStruts.USERFILTERS);
HashMap madatoryFields = (HashMap) request.getAttribute(ConstantsFTStruts.MANDATORYFIELDS);
HashMap filterCriteria = (HashMap) request.getAttribute(ConstantsFTStruts.FILTERCRITERIA);
boolean mandatoryFilter = ((Boolean) request.getAttribute(ConstantsFTStruts.MANDATORY)).booleanValue();
boolean validFilter = true;
int color = 0;
boolean classic_inventory_view = ((Boolean) request.getSession().getAttribute("classic_inventory_view")).booleanValue();
TreeViewStructure tvs = (TreeViewStructure) request.getSession().getAttribute("treeView_structure");
String contextPath = request.getContextPath();
boolean hasClassView = InventoryTreeServlet.hasAllowClassView();
String msgFail = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1278", "El filtro que trata de aplicar no es compatible con el filtro obligatorio");
%>

<script>
function reloadGeneralMenu() {
<%
if (tvs != null) {
%>
<%= TreeViewStructureCodeWriter.writeMenus(tvs, contextPath, hasClassView, classic_inventory_view, color) %>
<%
}
%>
}
parent.treeFilter.resetFields();
parent.treeFilter.resetUserFilters();
var vArray = null;
<%
for (int i = 0; i < fields.length; i++) {
	Field field = fields[i];
	if (ConstantsFTStruts.TEXT_VALUE.equals(field.getType()) || ConstantsFTStruts.DATE_VALUE.equals(field.getType())) {
%>
vArray = null;
<%
	} else {
%>
vArray = new Array();
<%
		Map lov = field.getListOfValues();
		Iterator it = lov.keySet().iterator();
		while (it.hasNext()) {
			String valueName = (String) it.next();
			String sValue = (String) lov.get(valueName);
%>
vArray[vArray.length] = new parent.FieldOption("<%= valueName %>", "<%= sValue %>");
<%
		}
	}
	String vble = field.getVariable();
	String alias = field.getLabel() != null && field.getLabel() != "" ? field.getLabel() : field.getVariable();
	String type = field.getType();
	String group = field.getGroup() == null ? "default" : field.getGroup();
	String fv = fieldsValues.get(vble) != null ? "\"" + (String) fieldsValues.get(vble) + "\"" : null;
	boolean isMandatory = false;
	if (madatoryFields != null && madatoryFields.containsKey(vble)) {
		String mandatoryValue = (String) madatoryFields.get(vble);
		isMandatory = mandatoryValue != null;
		if (isMandatory && !("\"" + mandatoryValue + "\"").equals(fv)) {
			validFilter = false;
			fv = "\"" + mandatoryValue + "\"";
		}
	}
%>
parent.treeFilter.addField("<%= vble %>", "<%= alias %>", "<%= type %>", "<%= group %>", "<%= group %>", vArray, <%= fv %>, <%= isMandatory %>);
<%
}
%>
if (<%= validFilter %>) {
	parent.treeFilter.setName(<%= filtername == null ? "null" : "\"" + filtername + "\""%>, <%= mandatoryFilter %>);
	parent.treeFilter.setDescription(<%= filterdesc == null ? "null" : "\"" + filterdesc + "\""%>);
}
<%
if (userfilters != null) {
	Iterator it = userfilters.keySet().iterator();
	while (it.hasNext()) {
		String filterId = (String) it.next();
		String filterName = (String) userfilters.get(filterId);
%>
parent.treeFilter.addUserFilter("<%= filterId %>", "<%= filterName %>");
<%
	}
}
if (filterCriteria != null) {
	Iterator it = filterCriteria.keySet().iterator();
	while (it.hasNext()) {
		String filterId = (String) it.next();
		String criteriaKey = (String) filterCriteria.get(filterId);
%>
parent.treeFilter.addFilterIdToCriteria("<%= criteriaKey %>", "<%= filterId %>");
<%
	}
}
%>
parent.treeFilter.updateSelectedCriteria();
parent.treeFilter.show();
if (<%= !validFilter %>) {
	alert("<%=msgFail%>");
}
reloadGeneralMenu();
</script>