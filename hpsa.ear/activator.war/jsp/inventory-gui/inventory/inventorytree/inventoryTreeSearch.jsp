<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import = "com.hp.ov.activator.mwfm.servlet.Constants"%>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.actions.DefinitionSearchBean" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.actions.DefinitionSearchMethod" %>
<%@ page import = "java.net.URLDecoder" %>
<%@ page import = "com.hp.ov.activator.inventory.facilities.StringFacility" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.util.Locale" %>
<%@ page import = "java.util.ResourceBundle" %>

<%@ taglib uri = "/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri = "/WEB-INF/button-taglib.tld" prefix="btn" %>
<%@ taglib uri = "/WEB-INF/struts-html.tld" prefix="html" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%!
  //I18n strings
final static String advancedsearch_parameters=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1000", "Search Parameters");
final static String advancedsearch_parameter_bean=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1001", "Bean");
final static String advancedsearch_parameter_attribute=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1002", "Attribute");
final static String advancedsearch_parameter_value=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("96", "Value");
final static String advancedsearch_parameter_equal=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1003", "Equal");
final static String advancedsearch_parameter_exact=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1004", "Exact");
final static String advancedsearch_parameter_empty = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1284", "Please, insert a valid value for the attribute");
final static String advancedsearch_parameter_nan = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1285", "Please, insert a numerical value for the attribute");
final static String advancedsearch_current=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1005", "Current search");
final static String advancedsearch_results=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1006", "Results");
final static String advancedsearch_button_add=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1007", "Add");
final static String advancedsearch_button_search=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("119", "Search");
final static String advancedsearch_button_save=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1286", "Save");
final static String advancedsearch_notapply = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1287", "This operator cannot be applied to this class of attribute");
final static String menu_fiction_entry=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1008", "Fiction option");
final static String input_format_error=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1009", "Warning: Format is wrong!");
final static String input_format_error_date1_later_date2=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1010", "Warning: To Date must be later than From Date!");
final static String button_accept = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("508", "Accept");
final static String button_cancel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("509", "Cancel");
final static String error = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("504", "Error");
final static String storedsearch_save = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1288", "Save advanced search");
final static String storedsearch_name = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("95", "Name");
final static String storedsearch_description = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("9", "Description");
final static String storedsearch_empty_name = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1289", "Search name cannot be empty");
final static String storedsearch_empty_description = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1290", "Search description cannot be empty");
final static String operator_from = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "From");
final static String operator_to = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "To");
final static String content_values = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1011", "The content of the values field is null or empty");
final static String content_atts = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1012", "The content of the atts field is null or empty");
final static String content_beans = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1013", "The content of the beans field is null or empty");
%>

<%
Vector beans = (Vector) request.getAttribute(ConstantsFTStruts.ADVANCED_SEARCHED_BEANS);
String definedSearch = (String)request.getParameter("definedSearch");
String searchAction = (definedSearch == null) ? "AdvancedSearchCommitAction" : "/inventory/toModule.do";
String hpsa_inventory_switch_struts_prefix = (definedSearch == null) ? null : (String)request.getParameter("hpsa_inventory_switch_struts_prefix");
String mainColor = "1";
%>

<html>
<head>
	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<script src="/activator/javascript/saUtilities.js"></script>
  <script src="/activator/javascript/hputils/combotext.js"></script>
	<script src="/activator/javascript/hputils/list.js"></script>
	<script src="/activator/javascript/hputils/vector.js"></script>
  <script src="/activator/javascript/hputils/alerts.js"></script>
  <script src="/activator/javascript/hputils/datetimepicker.js"></script>
	<!-- 
	<script src="/activator/javascript/inventory-gui/inventory/inventorytree/hierarchy.js"></script>
	 -->
	<script src="/activator/javascript/inventory-gui/inventory/inventorytree/check.js"></script>
    <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
	<script>
	/**
	* hierarchy.js file included here to add string internationalization.
	*/ 

	/*****************************************************************************************/
	/**                             FutureSelectOption Object                               **/
	/*****************************************************************************************/
	var updatingFSO = null;
	var BEANS = "beans";
	var ATTRIBUTES = "attributes";
	var VALUES = "values";
	var OPERATOR = "operator";
	var FSELECT = "futureselect";
	var FTEXT = "futuretextbox";
	var FINT = "futureint";
	var FDATE = "futuredate";
	var FCHECKBOX = "futurecheckbox";
	var FRADIO = "futureradio";
	var COMBOTEXT = "combotext";
	
	/**
	 * PROTECTED Constructor
	 * The object associated to each option of s select.
	 * @param (String) name the name of the option. This is the text which will be showed.
	 * @param (String) value the value of the option.
	 * @param (String or boolean) selected indicates whether this option is selected or not.
	 * @param (FutureSelect, FutureTextField, FutureCheckbox) child the child object of this option.
	 */
	function FutureSelectOption(name, value, selected, child, parentSelect, beanClass, listOfValues, beanPosition) {
	  this.name = name;
	  this.value = value;
	  this.child = null;
	  this.parentSelect = parentSelect;
	  this.selected = selected == null ? false : eval(selected);
	  this.beanClass = beanClass;
	  this.listOfValues = listOfValues;
	  this.position = beanPosition;
	  this.setChild = setChildFSO;
	  this.getChild = getChildFSO;
	  this.setParentSelect = setParentSelectFSO;
	  this.getParentSelect = getParentSelectFSO;
	  this.setSelected = setSelectedFSO;
	  this.isSelected = isSelectedFSO;
	  this.setChild(child);
	}
	/**
	 * PUBLIC
	 * Sets the child object of this option. The child object could be either a Select,
	 * a Text field or a Checkbox. It is null when any child is attached.
	 * @param (FutureSelect, FutureTextField, FutureCheckbox) child the child object of this option.
	 */
	function setChildFSO(child) {
	  this.child = child;
	  if (this.child != null) {
	    this.child.setParentOption(this);
	  }
	}
	/**
	 * PROTECTED
	 * Gets the child of this option.
	 * @return (FutureSelect, FutureTextField, FutureCheckbox) the child of this option.
	 */
	function getChildFSO() {
	  return this.child;
	}
	/**
	 * PUBLIC
	 * Sets the parent FutureSelect object of this option. Can be null if no parent is attached.
	 * @param (FutureSelect) parentSelect the parent FutureSelect object of this option.
	 */
	function setParentSelectFSO(parentSelect) {
	  this.parentSelect = parentSelect;
	}
	/**
	 * PROTECTED
	 * Gets the parent FutureSelect object of this option.
	 * @return (FutureSelect) the parent FutureSelect object of this option.
	 */
	function getParentSelectFSO() {
	  return this.parentSelect;
	}
	/**
	 * PROTECTED
	 * Sets this option as selected or non selected.
	 * @param (String or boolean) selected indicates whether this option is selected or not.
	 * If true, it is selected. If false, it is not.
	 */
	function setSelectedFSO(selected) {
	  this.selected = selected;
	}
	/**
	 * PROTECTED
	 * Checks whether this option is selected or not.
	 * @return (boolean) true if this option is selected; false other way.
	 */
	function isSelectedFSO() {
	  return this.selected;
	}




	/*****************************************************************************************/
	/**                                  FutureSelect Object                                **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The object associated to the select.
	 */
	function FutureSelect() {
	  this.type = FSELECT;
	  this.options = new List();
	  this.level = 0;
	  this.parentOption = null;
	  this.addOption = addOptionFS;
	  this.setParentOption = setParentOptionFS;
	  this.setLevel = setLevelFS;
	  this.getLevel = getLevelFS;
	  this.hasSelectedOption = hasSelectedOptionFS;
	  this.getSelectedOption = getSelectedOptionFS;
	  this.updateSelectedOption = updateSelectedOptionFS;
	  this.show = showFS;
	  this.showIn = showInFS;
	  this.addToIn = addToInFS;
	  this.removeFromIn = removeFromInFS;
	}
	/**
	 * PUBLIC
	 * Adds an option to the select.
	 * @param (String) name the name of the option. This is the text which will be showed.
	 * @param (String) value the value of the option.
	 * @param (String or boolean) selected indicates whether this option is selected or not.
	 * @param (FutureSelect, FutureTextField, FutureCheckbox) child the child object of this option.
	 */
	function addOptionFS(name, value, selected, child, beanClass, listOfValues, beanPosition) {
	  var opt = new FutureSelectOption(name, value, selected, child, this, beanClass, listOfValues, beanPosition);
	  this.options.add(opt);
	}
	/**
	 * PUBLIC
	 * Sets the parent FutureSelectOption object of this select. It can be null.
	 * @param (FutureOption) parentOption parent FutureSelectOption object of this select.
	 */
	function setParentOptionFS(parentOption) {
	  this.parentOption = parentOption;
	  this.setLevel();
	}
	/**
	 * PROTECTED
	 * Sets the level of this object and the levels of every children objects, if any.
	 */
	function setLevelFS() {
	  this.level = this.parentOption.getParentSelect().getLevel() + 1;
	  for (var i = 0; i < this.options.getLength(); i++) {
	    var child = this.options.get(i).getChild();
	    if (child != null) {
	      child.setLevel();
	    }
	  }
	}
	/**
	 * PROTECTED
	 * Gets the level of this object.
	 * @return (int) the level of this object.
	 */
	function getLevelFS() {
	  return this.level;
	}
	/**
	 * PROTECTED
	 * Checks whether this FutureSelect object has any FutureSelectOption object marked as selected.
	 * @return (boolean) true if this object has any FutureSelectOption object marked as selected;
	 * false other way.
	 */
	function hasSelectedOptionFS() {
	  var hasSelected = false;
	  for (var i = 0; i < this.options.getLength() && !hasSelected; i++) {
	    hasSelected = this.options.get(i).isSelected();
	  }
	  return hasSelected;
	}
	/**
	 * PROTECTED
	 * Gets the FutureSelectOption object marked as selected.
	 * @return (FutureSelectOption) the FutureSelectOption object marked as selected.
	 */
	function getSelectedOptionFS() {
	  var i = 0;
	  var selectedOption;
	  do {
	    selectedOption = this.options.get(i++);
	  } while (i < this.options.getLength() && !selectedOption.isSelected());
	  return selectedOption;
	}
	/**
	 * PROTECTED
	 * Checks the web to get the selected option of the select associated to this FufureSelect
	 * object and marks the FutureSelectoption associated to this selected option as selected.
	 */
	function updateSelectedOptionFS(selectId) {
	  this.getSelectedOption().setSelected(false);
	  var selectedValue = document.getElementById(selectId).value;
	  var i = 0;
	  var selectedOption;
	  do {
	    selectedOption = this.options.get(i++);
	  } while (i < this.options.getLength() && selectedOption.value != selectedValue);
	  selectedOption.setSelected(true);
	  var child = selectedOption.getChild();
	  if (child != null) {
	    child.show();
	  } else {
	    if (this.level < 2) {
	      updatingFSO = selectedOption;
	      var url = "/activator/AdvancedSearchGetValuesAction.do";
	      url += "?beanclass=" + updatingFSO.beanClass;
	      url += "&listofvalues=" + updatingFSO.listOfValues;
	      url += "&dsn=" + advancedSearchDatasourceName;
	      //alert(url);
	      window.open(url, "resgetter");
<!--	      document.getElementById(OPERATOR).checked = true;-->
<!--	      document.getElementById(OPERATOR).disabled = true;-->
	    }
	  }
	}
	/**
	 * PUBLIC
	 * Inserts the select into the web page.
	 */
	function showFS() {
	  if (document.getElementById(OPERATOR).value == "BETWEEN") {
	    document.getElementById(OPERATOR).value = "==";
	  } else if (document.getElementById(OPERATOR).value == "IN") {
	    this.showIn();
	  } else if (document.getElementById(OPERATOR).value == "NOT IN") {
	    this.showIn();
	  } else {
	    if (!this.hasSelectedOption()) {
	      this.options.get(0).setSelected(true);
	    }
	    var id = "beans";
	    switch(this.level) {
	      case 0: id = BEANS; break;
	      case 1: id = ATTRIBUTES; break;
	      case 2: id = VALUES; break;
	      default: alert("inventory Select level not valid: " + this.level); id = BEANS; break;
	    } 
	    if (this.level != 2) {
	      var html = "<select id=\"" + id + "\" name=\"" + id + "\" style=\"width:100%;\" ";
	      if (this.level == 2) {
	        html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	      }
	      html += "onchange=\"this.fsObj.updateSelectedOption('" + id + "');\">";
	      for (var i = 0; i < this.options.getLength(); i++) {
	        var selected = this.options.get(i).isSelected() ? "selected" : "";
	        html += "<option value=\"" + this.options.get(i).value + "\" " + selected + ">" + this.options.get(i).name + "</option>";
	      }
	      html += "</select>";
	      switch(this.level) {
	        case 0: document.getElementById("sbeans").innerHTML = html; break;
	        case 1: document.getElementById("sattrs").innerHTML = html; break;
	        case 2: document.getElementById("svalues").innerHTML = html; document.getElementById("adjuster").style.height = 28; break;
	        default: alert("inventory Select level not valid: " + this.level); break;
	      }
	    }
        else {
            //WE CREATE A COMBO-TEXT FOR THE "VALUES" OPTIONS (this.level == 2) INSTEAD OF A FUTURE-SELECT
            
          document.getElementById("svalues").innerHTML = "<span id='span_for_comboText' style='position:absolute; margin:0px; padding:0px; margin-top:-13px;' />";
            ct7009 = new ComboText("name_notNecessary", "span_for_comboText");
            ct7009.setWidth(260);
            ct7009.setInitialValue("");
            ct7009.setMaxOptionsHeight("80");
            ct7009.setId(VALUES);

            for (var i = 0; i < this.options.getLength(); i++) {
             
                ct7009.addOption(this.options.get(i).value);
            }
          
            ct7009.show();document.getElementById("adjuster").style.height = 28;
                        
        }   
	    document.getElementById(id).fsObj = this;
	      if (this.level == 2) {
	          //WE CREATE A COMBO-TEXT FOR THE "VALUES" OPTIONS (this.level == 2) INSTEAD OF A FUTURE-SELECT. 
	            //NOTICE THAT A COMBO-TEXT IS ACTUALLY A INPUT-TEXT (SO A FUTURE INPUT TEXT)
	          document.getElementById(id).fsObj.type=COMBOTEXT;
	        }
	    var nextObject = this.getSelectedOption().getChild();
	    if (nextObject != null) {
	      nextObject.show();
	    } else {
	      switch(this.level) {
	        case 0: document.getElementById("sattrs").innerHTML = ""; break;
	        case 1: document.getElementById("svalues").innerHTML = ""; break;
	        case 2: break;
	        default: alert("inventory Select level not valid: " + this.level); break;
	      }
	    }
	  }
	}

	/**
	 * PUBLIC
	 * Inserts the select into the web page when the selected operator is IN.
	 */
	function showInFS() {
	  html = "<select multiple=\"true\" size=3 id=" + VALUES + "prev name=" + VALUES + "prev ";
	  html += "onkeypress=\"if (event.keyCode == 13) this.fsObj.addToIn(true);\"";
	  html += "style=\"position:relative; top:-1; left:0; width:40%;\"/>";
	  for (var i = 0; i < this.options.getLength(); i++) {
	    html += "<option value=\"" + this.options.get(i).value + "\">" + this.options.get(i).name + "</option>";
	  }
	  html += "</select>";
    html += "<div class='centered' width='10%'>";
	  html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/go.gif\" ";
	  html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
	  html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
    html += "</div>";
	  html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
	  html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	  html += " style=\"position:relative; top:-1; left:0; width:40%;\"/>";
	  html += "</select>";
	  html += "<div class='centered' width='10%'>";
	  html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/kill.gif\" ";
	  html += "id=eraser onclick=\"this.fsObj.removeFromIn();\" ";
	  html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	  html += "</div>";
	  document.getElementById("svalues").innerHTML = html;
	  document.getElementById(VALUES).fsObj = this;
	  document.getElementById(VALUES + "prev").fsObj = this;
	  document.getElementById("adder").fsObj = this;
	  document.getElementById("eraser").fsObj = this;
	  document.getElementById("adjuster").style.height = 20;
	}

	/**
	 * PUBLIC
	 * Adds an item to the select when the IN operator is selected.
	 */
	function addToInFS(addFromKey) {
	  for (var i = 0; i < document.getElementById(VALUES + "prev").options.length; i++) {
	    if (document.getElementById(VALUES + "prev").options[i].selected) {
	      document.getElementById(VALUES).options[document.getElementById(VALUES).options.length] =
	        new Option(document.getElementById(VALUES + "prev").options[i].text, document.getElementById(VALUES + "prev").options[i].value);
	      document.getElementById(VALUES + "prev").options[i] = null;
	      i--;
	    }
	  }
	}

	/**
	 * PUBLIC
	 * Removes an item of the select when the IN operator is selected.
	 */
	function removeFromInFS() {
	  for (var i = 0; i < document.getElementById(VALUES).options.length; i++) {
	    if (document.getElementById(VALUES).options[i].selected) {
	      document.getElementById(VALUES + "prev").options[document.getElementById(VALUES + "prev").options.length] =
	        new Option(document.getElementById(VALUES).options[i].text, document.getElementById(VALUES).options[i].value);
	      document.getElementById(VALUES).options[i] = null;
	      i--;
	    }
	  }
	}




	/*****************************************************************************************/
	/**                                FutureTextField Object                               **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The object associated to the text field.
	 */
	function FutureTextField() {
	  this.type = FTEXT;
	  this.level = 2;
	  this.parentOption = null;
	  this.setParentOption = setParentOptionFFT;
	  this.setLevel = setLevelFFT;
	  this.getLevel = getLevelFFT;
	  this.show = showFFT;
	  this.showBetween = showBetweenFFT;
	  this.showIn = showInFFT;
	  this.addToIn = addToInFFT;
	  this.removeFromIn = removeFromInFFT;
	}
	/**
	 * PUBLIC
	 * Sets the parent FutureSelectOption object of this text field. It can be null.
	 * @param (FutureOption) parentOption parent FutureSelectOption object of this text field.
	 */
	function setParentOptionFFT(parentOption) {
	  this.parentOption = parentOption;
	}
	/**
	 * PROTECTED
	 * Sets the level of this object to 2. This object can only be showed inside the "values"
	 * span of the web page.
	 */
	function setLevelFFT() {
	  this.level = 2;
	}
	/**
	 * PROTECTED
	 * Gets the level of this object, always 2.
	 * @return (int) the level of this object, always 2.
	 */
	function getLevelFFT() {
	  return this.level;
	}

	/**
	 * PUBLIC
	 * Inserts a text field into the web page.
	 */
	function showFFT() {
	  if (document.getElementById(OPERATOR).value == "BETWEEN") {
	    this.showBetween();
	  } else if (document.getElementById(OPERATOR).value == "IN") {
	    this.showIn();
	  } else if (document.getElementById(OPERATOR).value == "NOT IN") {
	    this.showIn();
	  } else {
	    var previousValue = null;
	    if (document.getElementById(VALUES) && document.getElementById(VALUES).type == "text") {
	      previousValue = document.getElementById(VALUES).value;
	    }
	    html = "<input type=text id=" + VALUES + " name=" + VALUES;
	    html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	    html += " style=\"position:relative; top:-1; left:0; width:100%;\"/>";
	    document.getElementById("svalues").innerHTML = html;
	    document.getElementById(VALUES).fsObj = this;
	    document.getElementById("adjuster").style.height = 20;
	    if (previousValue != null) {
	      document.getElementById(VALUES).value = previousValue;
	    }
	  }
	}
	/**
	 * PUBLIC
	 * Inserts the two text fields into the web page.
	 */
	function showBetweenFFT() {
	    html = "<div class='right' width='15%'><%= operator_from %>: </div>";
	  html += "<input type=text id=" + VALUES + " name=" + VALUES;
	  html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	  html += " style=\"position:relative; top:-1; left:0; width:35%;\"/>";
	  html += "<div class='right' width='15%'><%= operator_to %>: </div>";
	  html += "<input type=text id=" + VALUES + "2 name=" + VALUES + "2";
	  html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	  html += " style=\"position:relative; top:-1; left:0; width:35%;\"/>";
	  document.getElementById("svalues").innerHTML = html;
	  document.getElementById(VALUES).fsObj = this;
	  document.getElementById("adjuster").style.height = 20;
	}

	function showInFFT() {
	  html = "<input type=text id=" + VALUES + "prev name=" + VALUES + "prev ";
	  html += " onkeypress=\"if (event.keyCode == 13) this.fsObj.addToIn(true);\"";
	  html += " style=\"position:relative; top:-16; left:0; width:40%;\"/>";
	  html += "<div class='centered' style='width:10%;'>";
	  html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/go.gif\" ";
	  html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
	  html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	  html += "</div>";
	  html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
	  html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	  html += " style=\"position:relative; top:-1; left:0; width:40%;\"/>";
	  html += "</select>";
	  html += "<div class='centered' style='width:10%;'>";
	  html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/kill.gif\" ";
	  html += "onclick=\"removeFromInFFT();\" ";
	  html += "style=\"position:relative; top:-16; left:0; cursor:hand; \">";
	  html += "</div>"
	  document.getElementById("svalues").innerHTML = html;
	  document.getElementById(VALUES).fsObj = this;
	  document.getElementById(VALUES + "prev").fsObj = this;
	  document.getElementById("adder").fsObj = this;
	  document.getElementById("adjuster").style.height = 20;
	}

	function addToInFFT(addFromKey) {
	  var v = document.getElementById(VALUES + "prev").value;
	  if (v == "") {
	    if (addFromKey) {
	      addToSearch();
	    } else {
	      var fa = new HPSAAlert("<%= error %>","<%= advancedsearch_parameter_empty %>");
	      fa.setBounds(500, 100);
	      fa.setButtonText("<%= button_accept %>");
	      fa.show();
	    }
	  } else {
	    document.getElementById(VALUES).options[document.getElementById(VALUES).options.length] = new Option(v, v);
	    document.getElementById(VALUES + "prev").value = "";
	    document.getElementById(VALUES + "prev").focus();
	  }
	}

	function removeFromInFFT() {
	  if (document.getElementById(VALUES).selectedIndex >= 0) {
	    document.getElementById(VALUES).options[document.getElementById(VALUES).selectedIndex] = null;
	    removeFromInFFT();
	  }
	}




	/*****************************************************************************************/
	/**                                FutureIntField Object                                **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The object associated to the int field.
	 */
	function FutureIntField() {
	  this.type = FINT;
	  this.level = 2;
	  this.parentOption = null;
	  this.setParentOption = setParentOptionFIT;
	  this.setLevel = setLevelFIT;
	  this.getLevel = getLevelFIT;
	  this.show = showFIT;
	  this.showBetween = showBetweenFIT;
	  this.showIn = showInFIT;
	  this.addToIn = addToInFIT;
	}


	/**
	 * PUBLIC
	 * Sets the parent FutureSelectOption object of this int field. It can be null.
	 * @param (FutureOption) parentOption parent FutureSelectOption object of this int field.
	 */
	function setParentOptionFIT(parentOption) {
	  this.parentOption = parentOption;
	}
	/**
	 * PROTECTED
	 * Sets the level of this object to 2. This object can only be showed inside the "values"
	 * span of the web page.
	 */
	function setLevelFIT() {
	  this.level = 2;
	}
	/**
	 * PROTECTED
	 * Gets the level of this object, always 2.
	 * @return (int) the level of this object, always 2.
	 */
	function getLevelFIT() {
	  return this.level;
	}

	/**
	 * PUBLIC
	 * Inserts a text field into the web page.
	 */
	function showFIT() {
	  if (document.getElementById(OPERATOR).value == "BETWEEN") {
	    this.showBetween();
	  } else if (document.getElementById(OPERATOR).value == "IN") {
	    this.showIn();
	  } else if (document.getElementById(OPERATOR).value == "NOT IN") {
	    this.showIn();
	  } else {
	    var previousValue = null;
	    if (document.getElementById(VALUES) && document.getElementById(VALUES).type == "text") {
	      previousValue = document.getElementById(VALUES).value;
	    }
	    html = "<input type=text id=" + VALUES + " name=" + VALUES;
	    html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	    html += " style=\"position:relative; top:-1; left:0; width:100%;\"/>";
	    document.getElementById("svalues").innerHTML = html;
	    document.getElementById(VALUES).fsObj = this;
	    document.getElementById("adjuster").style.height = 20;
	    if (previousValue != null) {
	      document.getElementById(VALUES).value = previousValue;
	    }
	  }
	}
	/**
	 * PUBLIC
	 * Inserts two text fields into the web page.
	 */
	function showBetweenFIT() {
	  html = "<div class='right' width='15%'><%= operator_from %>: </div>";
	  html += "<input type=text id=" + VALUES + " name=" + VALUES;
	  html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	  html += " style=\"position:relative; top:-1; left:0; width:35%;\"/>";
	  html += "<div class='right' width='15%'><%= operator_to %>: </div>";
	  html += "<input type=text id=" + VALUES + "2 name=" + VALUES + "2";
	  html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	  html += " style=\"position:relative; top:-1; left:0; width:35%;\"/>";
	  document.getElementById("svalues").innerHTML = html;
	  document.getElementById(VALUES).fsObj = this;
	  document.getElementById("adjuster").style.height = 20;
	}

	function showInFIT() {
	  html = "<input type=text id=" + VALUES + "prev name=" + VALUES + "prev ";
	  html += " onkeypress=\"if (event.keyCode == 13) this.fsObj.addToIn(true);\"";
	  html += " style=\"position:relative; top:-16; left:0; width:40%;\"/>";
	  html += "<div class='centered' width='10%'>";
	  html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/go.gif\" ";
	  html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
	  html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	  html += "</div>";
	  html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
	  html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	  html += " style=\"position:relative; top:-1; left:0; width:40%;\"/>";
	  html += "</select>";
	  html += "<div class='centered' width='10%'>";
	  html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/kill.gif\" ";
	  html += "id=eraser onclick=\"this.fsObj.removeFromIn();\" ";
	  html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	  html += "</div>";
	  document.getElementById("svalues").innerHTML = html;
	  document.getElementById(VALUES).fsObj = this;
	  document.getElementById(VALUES + "prev").fsObj = this;
	    document.getElementById("adder").fsObj = this;
	    document.getElementById("eraser").fsObj = this;
	  document.getElementById("adjuster").style.height = 20;
	}

	function addToInFIT(addFromKey) {
	  var v = document.getElementById(VALUES + "prev").value;
	  if (v == "") {
	    if (addFromKey) {
	      addToSearch();
	    } else {
	      var fa = new HPSAAlert("<%= error %>","<%= advancedsearch_parameter_empty %>");
	      fa.setBounds(500, 100);
	      fa.setButtonText("<%= button_accept %>");
	      fa.show();
	    }
	  } else if (isNaN(v)) {
	    var fa = new HPSAAlert("<%= error %>","<%= advancedsearch_parameter_nan %>");
	    fa.setBounds(500, 100);
	    fa.setButtonText("<%= button_accept %>");
	    fa.show();
	  } else {
	    document.getElementById(VALUES).options[document.getElementById(VALUES).options.length] = new Option(v, v);
	    document.getElementById(VALUES + "prev").value = "";
	    document.getElementById(VALUES + "prev").focus();
	  }
	}




	/*****************************************************************************************/
	/**                                FutureDateField Object                               **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The object associated to the date field.
	 */
	function FutureDateField() {
	  this.type = FDATE;
	  this.level = 2;
	  this.parentOption = null;
	  /**
	   * PUBLIC
	   * Sets the parent FutureSelectOption object of this int field. It can be null.
	   * @param (FutureOption) parentOption parent FutureSelectOption object of this int field.
	   */
	  this.setParentOption = function setParentOptionFDF(parentOption) {
	    this.parentOption = parentOption;
	  }
	  /**
	   * PROTECTED
	   * Sets the level of this object to 2. This object can only be showed inside the "values"
	   * span of the web page.
	   */
	  this.setLevel = function setLevelFDF() {
	    this.level = 2;
	  }
	  /**
	   * PROTECTED
	   * Gets the level of this object, always 2.
	   * @return (int) the level of this object, always 2.
	   */
	  this.getLevel = function getLevelFDF() {
	    return this.level;
	  }
	  /**
	   * PUBLIC
	   * Inserts the select into the web page.
	   */
	  this.show = function showFDF() {
	    if (document.getElementById(OPERATOR).value == "BETWEEN") {
	      this.showBetween();
	    } else if (document.getElementById(OPERATOR).value == "IN") {
	      this.showIn();
	    } else if (document.getElementById(OPERATOR).value == "NOT IN") {
	      this.showIn();
	    } else {
	      var previousValue = null;
	      if (document.getElementById(VALUES) && document.getElementById(VALUES).type == "text") {
	        previousValue = document.getElementById(VALUES).value;
	      }
	      html = "<input type=text id=" + VALUES + " name=" + VALUES;
	      html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	      html += " style=\"position:relative; top:-1; left:0; width:85%;\"/>";
	      html += "<div class='centered' width='15%'><img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\"";
	      html += " onclick=\"NewCal('" + VALUES + "','yyyymmdd',false,24," + <%= mainColor %> + ");\" style=\"cursor:hand\"></div>";
	      document.getElementById("svalues").innerHTML = html;
	      document.getElementById(VALUES).fsObj = this;
	      document.getElementById("adjuster").style.height = 20;
	      if (previousValue != null) {
	        document.getElementById(VALUES).value = previousValue;
	      }
	    }
	  }
	  
	  /**
	   * PUBLIC
	   * Inserts two text fields into the web page.
	   */
	  this.showBetween = function showBetweenFDF() {
	    html = "<div class='right' width='15%'><%= operator_from %>: </div>";
	    html += "<input type=text id=" + VALUES + " name=" + VALUES;
	    html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	    html += " style=\"position:relative; top:-1; left:0; width:30%;\"/>";
	    html += " <img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\"";
	    html += " onclick=\"NewCal('" + VALUES + "','yyyymmdd',false,24," + <%= mainColor %> + ");\" style=\"cursor:hand\">";
	    html += "<div class='right' width='15%'><%= operator_to %>: </div>";
	    html += "<input type=text id=" + VALUES + "2 name=" + VALUES + "2";
	    html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	    html += " style=\"position:relative; top:-1; left:0; width:30%;\"/>";
	    html += " <img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\"";
	    html += " onclick=\"NewCal('" + VALUES + "2','yyyymmdd',false,24," + <%= mainColor %> + ");\" style=\"cursor:hand\">";
	    document.getElementById("svalues").innerHTML = html;
	    document.getElementById(VALUES).fsObj = this;
	    document.getElementById("adjuster").style.height = 20;
	  }
	  
	  this.showIn = function showInFDF() {
	    html = "<input type=text id=" + VALUES + "prev name=" + VALUES + "prev ";
	    html += " onkeypress=\"if (event.keyCode == 13) this.fsObj.addToIn(true);\"";
	    html += " style=\"position:relative; top:-16; left:0; width:35%;\"/>";
	    html += "&nbsp;";
	    html += "<img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\" ";
	    html += "onclick=\"NewCal('" + VALUES + "prev','yyyymmdd',false,24," + <%= mainColor %> + ");\" ";
	    html += "style=\"position:relative; top:-15; left:0; cursor:hand;\">";
	    html += "&nbsp;&nbsp;&nbsp;";
	    html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/go.gif\" ";
	    html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
	    html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	    html += "&nbsp;&nbsp;&nbsp;";
	    html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
	    html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	    html += " style=\"position:relative; top:-1; left:0; width:40%;\"/>";
	    html += "</select>";
	    html += "&nbsp;";
	    html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/kill.gif\" ";
	    html += "id=eraser onclick=\"this.fsObj.removeFromIn();\" ";
	    html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	    document.getElementById("svalues").innerHTML = html;
	    document.getElementById(VALUES).fsObj = this;
	    document.getElementById(VALUES + "prev").fsObj = this;
	      document.getElementById("adder").fsObj = this;
	      document.getElementById("eraser").fsObj = this;
	    document.getElementById("adjuster").style.height = 20;
	  }
	  
	  this.addToIn = function addToInFDF(addFromKey) {
	    var v = document.getElementById(VALUES + "prev").value;
	    if (v == "") {
	      if (addFromKey) {
	        addToSearch();
	      } else {
	        var fa = new HPSAAlert("<%= error %>","<%= advancedsearch_parameter_empty %>");
	        fa.setBounds(500, 100);
	        fa.setButtonText("<%= button_accept %>");
	        fa.show();
	      }
	    } else {
	      document.getElementById(VALUES).options[document.getElementById(VALUES).options.length] = new Option(v, v);
	      document.getElementById(VALUES + "prev").value = "";
	      document.getElementById(VALUES + "prev").focus();
	    }
	  }

	  /**
	   * PUBLIC
	   * Removes an item of the select when the IN operator is selected.
	   */
	   this.removeFromIn = function removeFromInFDF() {
		    if (document.getElementById(VALUES).selectedIndex >= 0) {
		        document.getElementById(VALUES).options[document.getElementById(VALUES).selectedIndex] = null;
		        removeFromInFFT();
		      }
	  }
		  
	}






	/*****************************************************************************************/
	/**                                 FutureCheckbox Object                               **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The object associated to the text field.
	 */
	function FutureCheckbox() {
	  this.type = FCHECKBOX;
	  this.level = 2;
	  this.parentOption = null;
	  this.setParentOption = setParentOptionFCB;
	  this.setLevel = setLevelFCB;
	  this.getLevel = getLevelFCB;
	  this.updateValue = updateValueFCB;
	  this.show = showFCB;
	}
	/**
	 * PUBLIC
	 * Sets the parent FutureSelectOption object of this checkbox. It can be null.
	 * @param (FutureOption) parentOption parent FutureSelectOption object of this checkbox.
	 */
	function setParentOptionFCB(parentOption) {
	  this.parentOption = parentOption;
	}
	/**
	 * PROTECTED
	 * Sets the level of this object to 2. This object can only be showed inside the "values"
	 * span of the web page.
	 */
	function setLevelFCB() {
	  this.level = 2;
	}
	/**
	 * PROTECTED
	 * Gets the level of this object, always 2.
	 * @return (int) the level of this object, always 2.
	 */
	function getLevelFCB() {
	  return this.level;
	}
	function updateValueFCB() {
	  var checkboxValue = document.getElementById("ffcb").checked;
	  document.getElementById(VALUES).value = checkboxValue;
	}
	/**
	 * PUBLIC
	 * Inserts the select into the web page.
	 */
	function showFCB() {
	  if (document.getElementById(OPERATOR).value == "BETWEEN" || document.getElementById(OPERATOR).value == "IN" || document.getElementById(OPERATOR).value == "NOT IN") {
	    document.getElementById(OPERATOR).value = "==";
	  } else {
	    html = "<input type=checkbox id=ffcb name=ffcb onclick=\"this.fcbObj.updateValue();\"";
	    html += " style=\"position:relative;\"/> Verdadero";
	    html += "<input type=hidden id=" + VALUES + " name=" + VALUES + "/>";
	    document.getElementById("svalues").innerHTML = html;
	    document.getElementById("ffcb").fcbObj = this;
	    document.getElementById(VALUES).fsObj = this;
	    document.getElementById("adjuster").style.height = 25;
	  }
	}




	/*****************************************************************************************/
	/**                                 FutureRadio Object                                  **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The object associated to the radio button.
	 */
	function FutureRadio() {
	  this.type = FRADIO;
	  this.level = 2;
	  this.parentOption = null;
	  this.setParentOption = setParentOptionFR;
	  this.setLevel = setLevelFR;
	  this.getLevel = getLevelFR;
	  this.updateValue = updateValueFR;
	  this.show = showFR;
	}
	/**
	 * PUBLIC
	 * Sets the parent FutureSelectOption object of this radio. It can be null.
	 * @param (FutureOption) parentOption parent FutureSelectOption object of this checkbox.
	 */
	function setParentOptionFR(parentOption) {
	  this.parentOption = parentOption;
	}
	/**
	 * PROTECTED
	 * Sets the level of this object to 2. This object can only be showed inside the "values"
	 * span of the web page.
	 */
	function setLevelFR() {
	  this.level = 2;
	}
	/**
	 * PROTECTED
	 * Gets the level of this object, always 2.
	 * @return (int) the level of this object, always 2.
	 */
	function getLevelFR() {
	  return this.level;
	}
	function updateValueFR(newValue) {
	  document.getElementById(VALUES).value = newValue;
	}
	/**
	 * PUBLIC
	 * Inserts the radio into the web page.
	 */
	function showFR() {
	  if (document.getElementById(OPERATOR).value == "BETWEEN" || document.getElementById(OPERATOR).value == "IN" || document.getElementById(OPERATOR).value == "NOT IN") {
	    document.getElementById(OPERATOR).value = "==";
	  } else {
	    html = "<nobr>";
	    html += "<input type=radio id=ffra name=ffr onclick=\"this.frObj.updateValue(this.value);\"";
	    html += " value=\"true\" style=\"position:relative; border:none;\" checked/> True";
	    html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	    html += "<input type=radio id=ffrb name=ffr onclick=\"this.frObj.updateValue(this.value);\"";
	    html += " value=\"false\" style=\"position:relative; border:none;\"/> False";
	    html += "</nobr>";
	    html += "<input type=hidden id=" + VALUES + " name=" + VALUES + "/ value=\"true\">";
	    document.getElementById("svalues").innerHTML = html;
	    document.getElementById("ffra").frObj = this;
	    document.getElementById("ffrb").frObj = this;
	    document.getElementById(VALUES).fsObj = this;
	    document.getElementById("adjuster").style.height = 25;
	  }
	}




	/*****************************************************************************************/
	/**                              ActualSearchField Object                               **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * Each actually selected searching option. A searching option has this form: bean.attribute = value.
	 * The operation may be different, such as LIKE.
	 * @param (String) bean the name of this searching option's bean.
	 * @param (String) attributeName the attribute's name of this searching option.
	 * @param (String) attributeValue the value's name of this searching option.
	 */
	function ActualSearchOption(bean, beanclass, attributeName, attributeValue, valueName, valueValue, valueValue2, composedValue, operator, type, beanPosition) {
	  this.bean = bean;
	  this.beanclass = beanclass;
	  this.attributeName = attributeName;
	  this.attributeValue = attributeValue;
	  this.valueName = valueName;
	  this.valueValue = valueValue;
	  this.valueValue2 = valueValue2;
	  this.composedValue = composedValue;
	  this.operator = operator;
	  this.type = type;
	  this.beanPosition = beanPosition;
	}




	/*****************************************************************************************/
	/**                                   ActualSearch Object                               **/
	/*****************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The actually selected options list.
	 */
	function ActualSearch() {
	  this.fields = new Vector();
	  this.selectedFieldIndex = null;
	  this.addSearchOption = addActualSearchOption;
	  this.show = showAS;
	  this.removeActualSearchOption = removeActualSearchOption;
	}
	/**
	 * PUBLIC
	 * Adds a new searching option to the list and refreshes the showed list.
	 * @param (String) bean the name of the bean of this searching option.
	 * @param (String) attribute the attribute of the bean of this searching option.
	 * @param (String) bean the name of the bean of this searching option.
	 */
	function addActualSearchOption(bean, beanclass, attributeName, attributeValue, valueName, valueValue, valueValue2, composedValue, operator, type, beanPosition) {
	  var i = 0;
	  for (i = 0; i < this.fields.size(); i++) {
	    var opt = this.fields.get(i);
	    if (opt.bean == bean && opt.attributeName == attributeName) {
	      opt.valueName = valueName;
	      opt.valueValue = valueValue;
	      opt.valueValue2 = valueValue2;
	      opt.composedValue = composedValue;
	      opt.operator = operator;
	      opt.beanPosition = beanPosition;
	      this.selectedFieldIndex = i;
	      break;
	    }
	  }
	  if (i == this.fields.size()) {
	    this.fields.add(new ActualSearchOption(bean, beanclass, attributeName, attributeValue, valueName, valueValue, valueValue2, composedValue, operator, type, beanPosition));
	    this.selectedFieldIndex = null;
	  }
	  this.show();
	}

	/**
	 * PRIVATE
	 * Shows all the selected searching options.
	 */
	function showAS() {
	  var html = "<div style=\"position:relative; top:0; left:0; width:100%; height:105px; overflow-x:hidden; overflow-y:auto; background-color: #ffffff\">";
	  html += "<table border=0 cellpadding=2 cellspacing=0>";
	  var field = null;
	  for (var i = 0; i < this.fields.size(); i++) {
	    field = this.fields.get(i);
	    var bg = (this.selectedFieldIndex != i) ? "#ffffff" : "#f6f6f6";
	    html += "<tr style=\"font-family:Arial; font-size:12; color:#003366; cursor:default; background-color:" + bg + "\" ";
	    html += "onmouseover=\"this.style.backgroundColor='#e3e3e3';\" onmouseout=\"this.style.backgroundColor='" + bg + "';\">";
	    html += "<td width=60 align=center>";
	    html += "<img border=0 src=\"/activator/images/inventory-gui/inventory/kill.gif\" style=\"cursor:hand\" onclick=\"delAS(" + i + ")\">";
	    html += "</td>";
	    html += "<td width=80><nobr>" + field.bean + "</nobr></td>";
	    html += "<td width=10 align=center>.</td>";
	    html += "<td width=80>" + field.attributeName + "</td>";
	    html += "<td width=60 align=center><nobr>" + (field.operator.indexOf("LIKE") >= 0 ? "LIKE" : field.operator) + "</nobr></td>";
	    if (field.valueValue2 == "") {
	      var likePreffix = field.operator.indexOf("%") == 0 ? "%" : "";
	      var likeSuffix = field.operator.lastIndexOf("%") == field.operator.length - 1 ? "%" : "";
	      html += "<td width=100% colspan=3><nobr>" + likePreffix + field.valueName + likeSuffix + "</nobr></td>";
	    } else {
	      html += "<td width=50><nobr>" + field.valueName + "</nobr></td>";
	      html += "<td width=20 align=center>AND</td>";
	      html += "<td width=100%><nobr>" + field.valueValue2 + "</nobr></td>";
	    }
	    html += "</tr>";
	  }
	  html += "</table></div>";
	  document.getElementById("actsrch").innerHTML = html;
	  document.getElementById("actsrch").style.backgroundColor = "#ffffff";
	  document.getElementById("actsrch").scrollTop = (this.selectedFieldIndex != null) ? 20 * this.selectedFieldIndex : document.getElementById("actsrch").scrollHeight;
	}

	function removeActualSearchOption(i) {
	  this.fields.remove(i);
	  this.show();
	}	
	</script>
	<script>
		/**
		 * Object used when an advanced search is going to be saved. This object
		 * shows a text field to enter the search name and another one for the
		 * description. Both are mandatory.
		 * The space for this two text fields locks the whole page and is shown
		 * obove it.
		 * Once the text fields have been filled, their values are copied to the
		 * main form and the search is saved.
		 */
		function SaveMessage() {
		    var width = 400;
		    var height = 150;
		    var takeup = 0;
		    var blockPage = false;
		    var id = "_sm_";
		    if (!document.getElementById(id)) {
		        var bp = document.createElement("span");
		        bp.setAttribute("id", id);
		        document.body.appendChild(bp);
		    }
		    /**
		     * PUBLIC
		     * Shows a space where the user can enter the name and description
		     * for the advanced search he is performing.
		     */
		    this.show = function () {
		    	  var top= (parseInt(document.body.clientHeight,10)-height )/2 - takeup;
    	      var left= (parseInt(document.body.clientWidth,10) -width)/2 ;
		        var html = "";
		        if (blockPage) {
		            html += "<span style=\"position:absolute; top:0; left:0; z-index:1000; width:100%; height: 100%; ";
		            html += "width:expression(document.body.clientWidth); height:expression(document.body.clientHeight); ";
		            html += "background-color:Blue; filter:Alpha(Opacity=0, Style=0);\"></span>";
		        }
		        html += "<iframe class=confirmationMenu style=\"visibility:visible; ";
		        html += "width:" + (width-10) + "; height:" + (height-10) + "; position:absolute; z-index:1000; ";
		        html += "top: "+top+"px; ";
            html += "left: "+left+"px; ";
	          html += "top:expression(((document.body.clientHeight - " + height + ") / 2) - (" + takeup + ")); ";
		        html += "left:expression((document.body.clientWidth - " + width + ") / 2); \" id=" + id + "ifr></iframe>";
		        html += "<span class=confirmationMenu style=\"visibility:visible; color:#003366; text-align:left; ";
		        html += "width:" + width + "; height:" + height + "; position:absolute; z-index:1001; ";
            html += "top: "+top+"px; ";
            html += "left: "+left+"px; ";
		        html += "top:expression(((document.body.clientHeight - " + height + ") / 2) - (" + takeup + ")); ";
		        html += "left:expression((document.body.clientWidth - " + width + ") / 2); \" id=" + id + "cm>";
		        html += "<div style=\"width:" + (width - 5) + "; text-align:center; font-weight:bold; font-size:14; ";
		        html += "font-family:Arial; height:30;\"><%= storedsearch_save%></div>";
		        html += "<table border=0 style=\"width:" + (width - 5) + ";\">";
		        html += "<tr class=p1>";
		        html += "<td width=20><%= storedsearch_name%>:</td>";
		        html += "<td><input type=text id=ssname style=\"width:100%\" value=\"" + document.forms[0].store_search_name.value + "\"></td>";
		        html += "</tr>";
		        html += "<tr class=p1>";
		        html += "<td width=20><%= storedsearch_description%>:</td>";
		        html += "<td><input type=text id=ssdesc style=\"width:100%\" value=\"" + document.forms[0].store_search_description.value + "\"></td>";
		        html += "</tr>";
		        html += "</table>";
		        html += "<span style=\"position:relative; top:0; width:" + (width - 5) + "; ";
		        html += "text-align:center; left:0;\"><br>";
		        html += "<input type=button class=buttonSumbit value=\"<%= button_accept%>\" ";
		        html += "onclick=\"this.ba.save();\" id=" + id + "btnac>";
		        html += "&nbsp;&nbsp;&nbsp;";
		        html += "<input type=button class=buttonReset value=\"<%= button_cancel%>\" ";
		        html += "onclick=\"this.ba.hide();\" id=" + id + "btnca>";
		        html += "</span>";
		        if (blockPage) {
		            html += "</span>";
		        }
		        document.getElementById(id).innerHTML = html;
		        document.getElementById(id + "btnac").ba = this;
		        document.getElementById(id + "btnca").ba = this;
		        document.getElementById(id).style.visibility = "visible";
		        document.getElementById(id + "btnac").focus();
		    }
		    /**
		     * PUBLIC
		     * Saves the current advanced search. This can be only done if the
		     * name and description are not empty.
		     */
		    this.save = function () {
		        if (document.getElementById(id)) {
		            var ssname = document.getElementById("ssname").value;
		            var ssdesc = document.getElementById("ssdesc").value;
		            if (ssname != "" && ssdesc != "") {
		                document.forms[0].store_search_name.value = ssname;
		                document.forms[0].store_search_description.value = ssdesc;
		                this.hide();
		                var act = document.forms[0].action;
		                var tgt = document.forms[0].target;
		                document.forms[0].action = "/activator/SaveAdvancedSearchCommitAction.do";
//		                document.forms[0].target = "resgetter";
		                search();
		                document.forms[0].action = act;
		                document.forms[0].target = tgt;
		            } else if (ssname == "") {
		                var fa = new HPSAAlert("<%= error%>","<%= storedsearch_empty_name%>");
		                fa.setBounds(500, 100);
		                fa.setButtonText("<%= button_accept%>");
		                fa.show();
		            } else if (ssdesc == "") {
		                var fa = new HPSAAlert("<%= error%>","<%= storedsearch_empty_description%>");
		                fa.setBounds(500, 100);
		                fa.setButtonText("<%= button_accept%>");
		                fa.show();
		            }
		        }
		    }
		    /**
		     * PUBLIC
		     * Hides the space for the search name and description.
		     */
		    this.hide = function () {
		        if (document.getElementById(id)) {
		            document.getElementById(id).innerHTML = "";
		            document.getElementById(id).style.visibility = "hidden";
		        }
		    }
		}
	</script>
	
	<script>
	var advancedSearchDatasourceName = "<%= (String) request.getAttribute(ConstantsFTStruts.ADVANCED_SEARCHED_DATASOURCE) %>";
	var rid = eval(<%= request.getParameter("rimid") %>);
	var as=null;
	function init() {
		var s0 = new FutureSelect();
<%
String text;
String alias;
for (int i = 0; i < beans.size(); i++) {
	DefinitionSearchBean dsb = (DefinitionSearchBean) beans.get(i);
	text = StringFacility.replaceAllByHTMLCharacter(dsb.name);
%>
		var sop<%= i %> = new FutureSelect();
		
		s0.addOption("<%= text %>", "<%= text %>", false, sop<%= i %>, null, null, "<%= dsb.position %>");
<%
	for (int j = 0; j < dsb.methods.size(); j++) {
		DefinitionSearchMethod dsm = (DefinitionSearchMethod) dsb.methods.get(j);
		if (dsm.islistofvalues) {
%>
		var sop<%= i %>_<%= j %> = null;
<%
		} else if (dsm.type.equalsIgnoreCase("String")) {
%>
		var sop<%= i %>_<%= j %> = new FutureTextField();
<%
		} else if (dsm.type.equalsIgnoreCase("Boolean")) {
%>
		var sop<%= i %>_<%= j %> = new FutureRadio();
<%
		} else if (dsm.type.equalsIgnoreCase("Int")) {
%>
		var sop<%= i %>_<%= j %> = new FutureIntField("Int");
<%
		} else if (dsm.type.equalsIgnoreCase("Long")) {
%>
		var sop<%= i %>_<%= j %> = new FutureIntField("Long");
<%
		} else if (dsm.type.equalsIgnoreCase("Float")) {
%>
		var sop<%= i %>_<%= j %> = new FutureIntField("Float");
<%
		} else if (dsm.type.equalsIgnoreCase("Double")) {
%>
		var sop<%= i %>_<%= j %> = new FutureIntField("Double");
<%
		} else if (dsm.type.equalsIgnoreCase("Date")) {
%>
		var sop<%= i %>_<%= j %> = new FutureDateField();
<%
		} else if (dsm.type.equalsIgnoreCase("Listofvalues")) {
%>
		var sop<%= i %>_<%= j %> = null;
<%
		} else {
%>
		var sop<%= i %>_<%= j %> = null;
		
<%
		}
		text = StringFacility.replaceAllByHTMLCharacter(dsm.name);
	    alias = StringFacility.replaceAllByHTMLCharacter(dsm.alias);
%>
		sop<%= i %>.addOption("<%= alias %>", "<%= text %>", false, sop<%= i %>_<%= j %>, "<%= dsb.beanclass %>", "<%= dsm.listofvalues %>");
<%
		if (i == beans.size() - 1) {
%>
		document.forms[0].allfsattributes.options[document.forms[0].allfsattributes.options.length] = new Option("", "<%= text %>");
<%
		}

	}
}
%>
		s0.show();
		as = new ActualSearch();
		as.show();

        document.getElementById(ATTRIBUTES).fsObj.updateSelectedOption(ATTRIBUTES);
        
        <%= (String) request.getAttribute("storedSearchJS") %>
	}
	</script>
	<script>
    /**
     * Checks if the selected operator is compatible with the type of the attribute.
     */
    function checkOperator() {
        if (document.getElementById(OPERATOR).value == "BETWEEN") {
            if (document.getElementById(VALUES).fsObj.type == FSELECT ||
                    document.getElementById(VALUES).fsObj.type == FCHECKBOX ||
                    document.getElementById(VALUES).fsObj.type == FRADIO ||
                    document.getElementById(VALUES).fsObj.type == COMBOTEXT) {
                var fa = new HPSAAlert("<%= error %>","<%= advancedsearch_notapply %>");
                fa.setBounds(500, 100);
                fa.setButtonText("<%= button_accept %>");
                fa.show();
                document.getElementById(OPERATOR).value = "==";
                document.getElementById(VALUES).fsObj.show();
            } else {
                document.getElementById(VALUES).fsObj.showBetween();
            }
        } else if (document.getElementById(OPERATOR).value == "IN" || document.getElementById(OPERATOR).value == "NOT IN") {
            if (document.getElementById(VALUES).fsObj.type == FCHECKBOX ||
                    document.getElementById(VALUES).fsObj.type == FRADIO) {
                var fa = new HPSAAlert("<%= button_accept %>","<%= advancedsearch_notapply %> ");
                fa.setBounds(500, 100);
                fa.setButtonText("<%= button_accept %>");
                fa.show();
                document.getElementById(OPERATOR).value = "==";
                document.getElementById(VALUES).fsObj.show();
            } else {
                document.getElementById(VALUES).fsObj.showIn();
            }
        } else if (document.getElementById(OPERATOR).value == "%LIKE" ||
            document.getElementById(OPERATOR).value == "%LIKE%" ||
            document.getElementById(OPERATOR).value == "LIKE%") {
            if (document.getElementById(VALUES).fsObj.type == FDATE) {
                var fa = new HPSAAlert("<%= button_accept %>","<%= advancedsearch_notapply %> ");
                fa.setBounds(500, 100);
                fa.setButtonText("<%= button_accept %>");
                fa.show();
                document.getElementById(OPERATOR).value = "BETWEEN";
            } else if (document.getElementById(VALUES).fsObj.type == FRADIO) {
                var fa = new HPSAAlert("<%= button_accept %>","<%= advancedsearch_notapply %> ");
                fa.setBounds(500, 100);
                fa.setButtonText("<%= button_accept %>");
                fa.show();
                document.getElementById(OPERATOR).value = "==";
            }
            document.getElementById(VALUES).fsObj.show();
        } else if (document.getElementById(OPERATOR).value == ">" || document.getElementById(OPERATOR).value == "&>=" ||
        		document.getElementById(OPERATOR).value == "<" || document.getElementById(OPERATOR).value == "<=") {
            if (document.getElementById(VALUES).fsObj.type == FRADIO) {
                var fa = new HPSAAlert("<%= button_accept %>","<%= advancedsearch_notapply %> ");
                fa.setBounds(500, 100);
                fa.setButtonText("<%= button_accept %>");
                fa.show();
                document.getElementById(OPERATOR).value = "==";
            }
            document.getElementById(VALUES).fsObj.show();
        } else {
            document.getElementById(VALUES).fsObj.show();
        }
    }
	function addToSearch() {
 		if (document.getElementById(BEANS).value != null && document.getElementById(BEANS).value != "") {	
			if (document.getElementById(ATTRIBUTES).value != null && document.getElementById(ATTRIBUTES).value != "") {
				if ((document.getElementById(VALUES).type == "select-multiple" && document.getElementById(VALUES).options.length > 0) ||
						(document.getElementById(VALUES).value != null && document.getElementById(VALUES).value != "")) {
					var bean = document.getElementById(BEANS).value;
					var beanPosition = document.getElementById(BEANS).fsObj.getSelectedOption().position;
					var elm = document.getElementById(ATTRIBUTES).fsObj.getSelectedOption();
					var beanclass = elm.beanClass;
					var attName = elm.name;
					var attValue = elm.value;
					elm = document.getElementById(VALUES).fsObj;
					var valName = "";
					var valValue = "";
					var valValue2 = "";
					// composedValue stores all the values separated by the _;_
                    // It is the value that will be sent to perform the search.
                    var composedValue = "";
                    if (document.getElementById(VALUES).type == "select-multiple") {
                        valName = new Array();
                        valValue = new Array();
                        for (var i = 0; i < document.getElementById(VALUES).options.length; i++) {
                            valName[i] = document.getElementById(VALUES).options[i].text;
                            valValue[i] = document.getElementById(VALUES).options[i].value;
                            composedValue += (i == 0 ? "" : "_;_") + valValue[i];
                        }
                    } else if (elm.type == FSELECT) {
						elm = elm.getSelectedOption();
						valName = elm.name;
						valValue = elm.value;
						composedValue = valValue;
                    } else if (elm.type == FTEXT) {
						valName = document.getElementById(VALUES).value;
						valValue = document.getElementById(VALUES).value;
			            composedValue = valValue;
			            if(document.getElementById(VALUES + "2")!=null){
			                valValue2 = document.getElementById(VALUES + "2").value;
                      composedValue += (i == 0 ? "" : "_;_") + valValue2;
			              }
					} else if (elm.type == FRADIO) {
						valName = document.getElementById(VALUES).value;
						valValue = valName;
            composedValue = valValue;
					} else if (elm.type == FINT) {
						valName = document.getElementById(VALUES).value;
						valValue = valName;
            composedValue = valValue;
						if(document.getElementById(VALUES + "2")!=null){
							valValue2 = document.getElementById(VALUES + "2").value;
							composedValue += (i == 0 ? "" : "_;_") + valValue2;
						}
						//alert(elm.checkType);
						if(elm.checkType == "Int")
						{
							if(!checkInteger(valValue))
							{
								alert("<%=input_format_error%>");
								return;
							}
							if(valValue2 != "")
							{
								if(!checkInteger(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
								if(parseInt(valValue) > parseInt(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
							}
						}
						if(elm.checkType == "Long")
						{
							if(!checkLong(valValue))
							{
								alert("<%=input_format_error%>");
								return;
							}
							if(valValue2 != "")
							{
								if(!checkLong(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
								if(parseInt(valValue) > parseInt(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
							}
						}
						if(elm.checkType == "Float")
						{
							if(!checkFloat(valValue))
							{
								alert("<%=input_format_error%>");
								return;
							}
							if(valValue2 != "")
							{
								if(!checkFloat(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
								if(parseFloat(valValue) > parseFloat(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
							}
						}
						if(elm.checkType == "Double")
						{
							if(!checkDouble(valValue))
							{
								alert("<%=input_format_error%>");
								return;
							}
							if(valValue2 != "")
							{
								if(!checkDouble(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
								if(parseFloat(valValue) > parseFloat(valValue2))
								{
									alert("<%=input_format_error%>");
									return;
								}
							}
						}
					} else if (elm.type == FDATE) {
						valName = document.getElementById(VALUES).value;
						valValue = valName;
						composedValue = valValue;
						if(document.getElementById(VALUES + "2")!=null){
							valValue2 = document.getElementById(VALUES + "2").value;
							composedValue += (i == 0 ? "" : "_;_") + valValue2;
						}
						if(!checkDate(valValue))
						{
							alert("<%=input_format_error%>");
							return;
						}
						if(valValue2 != "")
						{
							if(!checkDate(valValue2))
							{
								alert("<%=input_format_error%>");
								return;
							}
							var d1 = getAdvancedsearchDate(valValue);
							var d2 = getAdvancedsearchDate(valValue2);
							if(d1.getTime() > d2.getTime())
							{
								alert("<%=input_format_error_date1_later_date2%>");
								return;
							}
						}
                    } else {
                        // COMBOTEXT enters in this 'else'
                        valName = document.getElementById(VALUES).value;
                        valValue = document.getElementById(VALUES).value;
                        composedValue = valValue;
                        if (document.getElementById(VALUES + "2")) {
                            valValue2 = document.getElementById(VALUES + "2").value;
                            composedValue += "_;_" + valValue2;
                        }
					}
	                var operator = document.getElementById(OPERATOR).value;
                   if (document.getElementById(VALUES + "2") != null && document.getElementById(VALUES + "2").value == "") {
                        var fa = new HPSAAlert("<%= error %>", "<%= advancedsearch_parameter_empty %>");
                        fa.setBounds(500, 100);
                        fa.setButtonText("<%= button_accept %>");
                        fa.show();
                    } else {
                        as.addSearchOption(bean, beanclass, attName, attValue, valName, valValue, valValue2, composedValue, operator, elm.type, beanPosition);
                    }
				} else {
					var fa = new HPSAAlert("<%= error %>", "<%= content_values %>");
          fa.setBounds(500, 100);
          fa.setButtonText("<%= button_accept %>");
          fa.show();
				}
			} else {
        var fa = new HPSAAlert("<%= error %>", "<%= content_atts %>");
        fa.setBounds(500, 100);
        fa.setButtonText("<%= button_accept %>");
        fa.show();
			}
		} else {
      var fa = new HPSAAlert("<%= error %>", "<%= content_beans %>");
      fa.setBounds(500, 100);
      fa.setButtonText("<%= button_accept %>");
      fa.show();
		}
	}
	function delAS(index) {
		as.removeActualSearchOption(index);
	}
	</script>
	<script>
	function search() {
		if (as.fields.size() == 0) {
			alert("No search parameters have been specified");
		} else {
			clearSelects();
			var field;
			for (var i = 0; i < as.fields.size(); i++) {
				field = as.fields.get(i);
				document.forms[0].fsbeans.options[document.forms[0].fsbeans.options.length] = new Option("", field.bean);
				document.forms[0].fsbeanclasses.options[document.forms[0].fsbeanclasses.options.length] = new Option("", field.beanclass);
				document.forms[0].fsattributes.options[document.forms[0].fsattributes.options.length] = new Option("", field.attributeValue);
				document.forms[0].fsvalues.options[document.forms[0].fsvalues.options.length] = new Option("", field.composedValue);
				document.forms[0].fsoperators.options[document.forms[0].fsoperators.options.length] = new Option("", field.operator);
				document.forms[0].fstype.options[document.forms[0].fstype.options.length] = new Option("", field.type);
				document.forms[0].fsbeanpositions.options[document.forms[0].fsbeanpositions.options.length] = new Option("", field.beanPosition);
			}
			selectAllSelects();
			document.getElementById("searchResult").style.visibility = "visible";
			document.forms[0].submit();
		}
		jsResizer();
	}
	function clearSelects() {
		while (document.forms[0].fsbeans.options.length) {
			document.forms[0].fsbeans.options[0] = null;
			document.forms[0].fsbeanclasses.options[0] = null;
			document.forms[0].fsattributes.options[0] = null;
			document.forms[0].fsvalues.options[0] = null;
			document.forms[0].fsoperators.options[0] = null;
			document.forms[0].fstype.options[0] = null;
			document.forms[0].fsbeanpositions.options[0] = null;
		}
	}
	function selectAllSelects() {
		for (var i = 0; i < document.forms[0].fsbeans.options.length; i++) {
			document.forms[0].fsbeans.options[i].selected = true;
		}
		for (var i = 0; i < document.forms[0].fsbeanclasses.options.length; i++) {
			document.forms[0].fsbeanclasses.options[i].selected = true;
		}
		for (var i = 0; i < document.forms[0].fsattributes.options.length; i++) {
			document.forms[0].fsattributes.options[i].selected = true;
		}
		for (var i = 0; i < document.forms[0].fsvalues.options.length; i++) {
			document.forms[0].fsvalues.options[i].selected = true;
		}
		for (var i = 0; i < document.forms[0].fsoperators.options.length; i++) {
      document.forms[0].fsoperators.options[i].selected = true;
    }
		for (var i = 0; i < document.forms[0].fstype.options.length; i++) {
			document.forms[0].fstype.options[i].selected = true;
		}
		for (var i = 0; i < document.forms[0].allfsattributes.options.length; i++) {
			document.forms[0].allfsattributes.options[i].selected = true;
		}
		for (var i = 0; i < document.forms[0].fsbeanpositions.options.length; i++) {
			document.forms[0].fsbeanpositions.options[i].selected = true;
		}
	}
	</script>
  <script>
  function jsResizer() {
	  // function required to resize dinamically because css 'expression' doesn't work in firefox
    searchResultIfr = document.getElementById("searchResult");
    if (searchResultIfr) {
        height = (document.body.clientHeight > 355 ? document.body.clientHeight - 255 : 100)+'px';
        searchResultIfr.style.height = height;
    }
  }
  </script>
  <style>
    .centered { text-align: center; display: inline; padding-right: 2px; padding-left: 2px; }
    .right { text-align: right; display: inline; padding-right: 2px; padding-left: 2px; }
  </style>
</head>
<body style="overflow-y:hidden; overflow-x:auto;" onload="init();" onresize="jsResizer();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table style='width:100%;'><tr><td style='width:350px;'>
<table:table width="100%" headerAsBody="false" rowsMayBeSelected="false">
	<table:header>
		<table:cell><span style='white-space: nowrap;'><%=advancedsearch_parameters%></span></table:cell>
	</table:header>
	<table:row>
		<tr>
			<table:cell width="20%"><b><%=advancedsearch_parameter_bean%>:</b></table:cell>
			<table:cell id="sbeans" width="80%" colspan="2">&nbsp;</table:cell>
		</tr>
		<tr>
			<table:cell width="20%"><b><%=advancedsearch_parameter_attribute%>:</b></table:cell>
			<table:cell id="sattrs" width="80%" colspan="2">&nbsp;</table:cell>
		</tr>
        <tr height="60">
            <table:cell width="20%"><b><%=advancedsearch_parameter_value%>:</b></table:cell><table:cell id="svalues" colspan="2">&nbsp;</table:cell>
        </tr>
        <tr id=adjuster>
            <table:cell width="20%"><b><%=advancedsearch_parameter_exact%>:</b></table:cell>
            <table:cell id="sexact" width="50%">
            <select id=operator style="width:100%;" onchange="checkOperator()">
            <option value="==">==</option>
            <option value="!=">!=</option>
            <option value="&gt;">&gt;</option>
            <option value="&gt;=">&gt;=</option>
            <option value="&lt;">&lt;</option>
            <option value="&lt;=">&lt;=</option>
            <option value="%LIKE%">%LIKE%</option>
            <option value="LIKE%">LIKE%</option>
            <option value="%LIKE">%LIKE</option>
            <option value="BETWEEN">BETWEEN</option>
            <option value="IN">IN</option>
            <option value="NOT IN">NOT IN</option>
            </select>
            </table:cell>
            <table:cell width="30%" align="right"><input type="button" value="<%=advancedsearch_button_add%>" name="<%=advancedsearch_button_add%>" class="ButtonSubmit" onclick="addToSearch();"></table:cell>
        </tr>
	</table:row>
</table:table>
<div style='width:350px;'></div>
</td>
<td style='width:100%;'>
<div style="width:100%; height:144px; position:relative; top: -6px;">
<table:table width="100%" headerAsBody="false" rowsMayBeSelected="false">
	<table:header>
		<table:cell><span style='white-space: nowrap;'><%=advancedsearch_current%></span></table:cell>
	</table:header>
	<table:row>
		<table:cell id="actsrch" width="100%">&nbsp;</table:cell>
	</table:row>
</table:table>
 </div>
<div style="position:relative; top:1; text-align: right;">
<input type="button" value="<%=advancedsearch_button_search%>" name="<%=advancedsearch_button_search%>" class="ButtonSubmit" onclick="search();">
<%
Boolean sso_session = (Boolean)request.getSession().getAttribute(Constants.SSO_SESSION);
if (searchAction.equals("AdvancedSearchCommitAction") && request.getSession().getAttribute(Constants.UMM) != null && (sso_session == null || !sso_session.booleanValue())) {
%>
&nbsp;&nbsp;&nbsp;
<input type="button" value="<%=advancedsearch_button_save%>" name="<%=advancedsearch_button_save%>" class="ButtonSubmit" onclick="new SaveMessage().show();">
<%
}
%>
</div>
<div style='width:300px;'></div>
</td></tr>
<tr><td colspan="2">
<table:table width="100%" headerAsBody="true" rowsMayBeSelected="false" >
	<table:header>
		<table:cell><span style='white-space: nowrap;'><%=advancedsearch_results%></span></table:cell>
	</table:header>
	<table:row id="g">
		<table:cell width="100%" nobg="true">
			<iframe id='searchResult' name=searchResult width="100%" frameborder="0" scrolling="auto" 
				style="visibility:hidden; height:100%;"></iframe>
		</table:cell>
	</table:row>
</table:table>
</td></tr></table>
<iframe id=resgetter name=resgetter frameborder="0" scrolling="auto" width="1024"
	style="visibility:hidden; height:0; width:0; position:absolute; top:0; left:0;"></iframe>

<html:form action="<%= searchAction %>" target="searchResult" style="position:absolute; top:0; left:0; visibility:hidden;">
<%
if (definedSearch != null) {
%>
   <html:hidden property="hpsa_inventory_switch_struts_prefix" value="<%=hpsa_inventory_switch_struts_prefix%>"></html:hidden>
   <html:hidden property="hpsa_inventory_switch_struts_page" value="<%=URLDecoder.decode(definedSearch, \"UTF-8\")%>"></html:hidden>
<%
}
%>
   <html:select property="fsbeans" multiple="true" style="visibility:hidden;"></html:select>
   <html:select property="fsbeanclasses" multiple="true" style="visibility:hidden;"></html:select>
   <html:select property="fsbeanpositions" multiple="true" style="visibility:hidden;"></html:select>
   <html:select property="fsattributes" multiple="true" style="visibility:hidden;"></html:select>
   <html:select property="fsvalues" multiple="true" style="visibility:hidden;"></html:select>
   <html:select property="fsoperators" multiple="true" style="visibility:hidden;"></html:select>
   <html:select property="fstype" multiple="true" style="visibility:hidden;"></html:select>
   <html:hidden property="ndid" value="<%= request.getParameter(\"ndid\") %>"></html:hidden>
   <html:hidden property="vi" value="<%= request.getParameter(\"vi\") %>"></html:hidden>
   <html:hidden property="tabname" value="<%= request.getParameter(\"tab_name\") %>"></html:hidden>
   <html:hidden property="view" value="<%= request.getParameter(\"view\") %>"></html:hidden>
   <html:select property="allfsattributes" multiple="true" style="visibility:hidden;"></html:select>
   <html:hidden property="storeSearch" value="true"></html:hidden>
   <html:hidden property="store_search_name" value="<%= request.getAttribute(\"storedSearchName\") == null ? \"\" : (String) request.getAttribute(\"storedSearchName\") %>"></html:hidden>
   <html:hidden property="store_search_description" value="<%= request.getAttribute(\"storedSearchDesc\") == null ? \"\" : (String) request.getAttribute(\"storedSearchDesc\") %>"></html:hidden>
</html:form>

</body>
</html>
