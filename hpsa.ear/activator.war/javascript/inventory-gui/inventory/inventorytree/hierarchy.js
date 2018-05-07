
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
			document.getElementById(OPERATOR).checked = true;
			document.getElementById(OPERATOR).disabled = true;
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
			var html = "<select id=\"" + id + "\" name=\"" + id + "\" style=\"width:300;\" ";
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
		document.getElementById(id).fsObj = this;
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
	html += "style=\"position:relative; top:-1; left:0; width:125;\"/>";
	for (var i = 0; i < this.options.getLength(); i++) {
		html += "<option value=\"" + this.options.get(i).value + "\">" + this.options.get(i).name + "</option>";
	}
	html += "</select>";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/go.gif\" ";
	html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
	html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
	html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	html += " style=\"position:relative; top:-1; left:0; width:125;\"/>";
	html += "</select>";
	html += "&nbsp;";
	html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/kill.gif\" ";
	html += "id=eraser onclick=\"this.fsObj.removeFromIn();\" ";
	html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
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
		html += " style=\"position:relative; top:-1; left:0; width:300;\"/>";
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
	html = "<span style=\"position:relative; top:-3;\">][From: </span>";
	html += "<input type=text id=" + VALUES + " name=" + VALUES;
	html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	html += " style=\"position:relative; top:-1; left:0; width:110;\"/>";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<span style=\"position:relative; top:-3;\">][To: </span>";
	html += "<input type=text id=" + VALUES + "2 name=" + VALUES + "2";
	html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	html += " style=\"position:relative; top:-1; left:0; width:110;\"/>";
	document.getElementById("svalues").innerHTML = html;
	document.getElementById(VALUES).fsObj = this;
	document.getElementById("adjuster").style.height = 20;
}

function showInFFT() {
	html = "<input type=text id=" + VALUES + "prev name=" + VALUES + "prev ";
	html += " onkeypress=\"if (event.keyCode == 13) this.fsObj.addToIn(true);\"";
	html += " style=\"position:relative; top:-16; left:0; width:125;\"/>";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/go.gif\" ";
	html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
	html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
	html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	html += " style=\"position:relative; top:-1; left:0; width:125;\"/>";
	html += "</select>";
	html += "&nbsp;";
	html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/kill.gif\" ";
	html += "onclick=\"removeFromIn();\" ";
	html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
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
			var fa = new HPSAAlert(
				"][Error",
				"][Advancedsearch.parameter.empty");
			fa.setBounds(500, 100);
			fa.setButtonText("][confirm.operation.button.accept");
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
		removeFromIn();
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
		html += " style=\"position:relative; top:-1; left:0; width:300;\"/>";
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
	html = "<span style=\"position:relative; top:-3;\">][From: </span>";
	html += "<input type=text id=" + VALUES + " name=" + VALUES;
	html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	html += " style=\"position:relative; top:-1; left:0; width:110;\"/>";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<span style=\"position:relative; top:-3;\">][To: </span>";
	html += "<input type=text id=" + VALUES + "2 name=" + VALUES + "2";
	html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	html += " style=\"position:relative; top:-1; left:0; width:110;\"/>";
	document.getElementById("svalues").innerHTML = html;
	document.getElementById(VALUES).fsObj = this;
	document.getElementById("adjuster").style.height = 20;
}

function showInFIT() {
	html = "<input type=text id=" + VALUES + "prev name=" + VALUES + "prev ";
	html += " onkeypress=\"if (event.keyCode == 13) this.fsObj.addToIn(true);\"";
	html += " style=\"position:relative; top:-16; left:0; width:125;\"/>";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/go.gif\" ";
	html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
	html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	html += "&nbsp;&nbsp;&nbsp;";
	html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
	html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
	html += " style=\"position:relative; top:-1; left:0; width:125;\"/>";
	html += "</select>";
	html += "&nbsp;";
	html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/kill.gif\" ";
	html += "onclick=\"removeFromIn();\" ";
	html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
	document.getElementById("svalues").innerHTML = html;
	document.getElementById(VALUES).fsObj = this;
	document.getElementById(VALUES + "prev").fsObj = this;
	document.getElementById("adder").fsObj = this;
	document.getElementById("adjuster").style.height = 20;
}

function addToInFIT(addFromKey) {
	var v = document.getElementById(VALUES + "prev").value;
	if (v == "") {
		if (addFromKey) {
			addToSearch();
		} else {
			var fa = new HPSAAlert(
				"][Error",
				"][advancedsearch.parameter.empty");
			fa.setBounds(500, 100);
			fa.setButtonText("][confirm.operation.button.accept");
			fa.show();
		}
	} else if (isNaN(v)) {
		var fa = new HPSAAlert(
			"][Error",
			"][advancedsearch.parameter.nan");
		fa.setBounds(500, 100);
		fa.setButtonText("][confirm.operation.button.accept");
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
			html += " style=\"position:relative; top:-1; left:0; width:380;\"/>";
			html += " <img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\"";
			html += " onclick=\"NewCal('" + VALUES + "','ddmmyyyy',false,24," + mainColor + ");\" style=\"cursor:hand\">";
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
		html = "<span style=\"position:relative; top:-3;\">][From: </span>";
		html += "<input type=text id=" + VALUES + " name=" + VALUES;
		html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
		html += " style=\"position:relative; top:-1; left:0; width:90;\"/>";
		html += " <img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\"";
		html += " onclick=\"NewCal('" + VALUES + "','ddmmyyyy',false,24," + mainColor + ");\" style=\"cursor:hand\">";
		html += "&nbsp;&nbsp;&nbsp;";
		html += "<span style=\"position:relative; top:-3;\">][To: </span>";
		html += "<input type=text id=" + VALUES + "2 name=" + VALUES + "2";
		html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
		html += " style=\"position:relative; top:-1; left:0; width:90;\"/>";
		html += " <img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\"";
		html += " onclick=\"NewCal('" + VALUES + "2','ddmmyyyy',false,24," + mainColor + ");\" style=\"cursor:hand\">";
		document.getElementById("svalues").innerHTML = html;
		document.getElementById(VALUES).fsObj = this;
		document.getElementById("adjuster").style.height = 20;
	}
	
	this.showIn = function showInFDF() {
		html = "<input type=text id=" + VALUES + "prev name=" + VALUES + "prev ";
		html += " onkeypress=\"if (event.keyCode == 13) this.fsObj.addToIn(true);\"";
		html += " style=\"position:relative; top:-16; left:0; width:105;\"/>";
		html += "&nbsp;";
		html += "<img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\" ";
		html += "onclick=\"NewCal('" + VALUES + "prev','ddmmyyyy',false,24," + mainColor + ");\" ";
		html += "style=\"position:relative; top:-15; left:0; cursor:hand;\">";
		html += "&nbsp;&nbsp;&nbsp;";
		html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/go.gif\" ";
		html += "id=adder onclick=\"this.fsObj.addToIn(false);\" ";
		html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
		html += "&nbsp;&nbsp;&nbsp;";
		html += "<select multiple=\"true\" size=3 id=" + VALUES + " name=" + VALUES;
		html += " onkeypress=\"if (event.keyCode == 13) addToSearch();\"";
		html += " style=\"position:relative; top:-1; left:0; width:125;\"/>";
		html += "</select>";
		html += "&nbsp;";
		html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/kill.gif\" ";
		html += "onclick=\"removeFromIn();\" ";
		html += "style=\"position:relative; top:-16; left:0; cursor:hand;\">";
		document.getElementById("svalues").innerHTML = html;
		document.getElementById(VALUES).fsObj = this;
		document.getElementById(VALUES + "prev").fsObj = this;
		document.getElementById("adder").fsObj = this;
		document.getElementById("adjuster").style.height = 20;
	}
	
	this.addToIn = function addToInFDF(addFromKey) {
		var v = document.getElementById(VALUES + "prev").value;
		if (v == "") {
			if (addFromKey) {
				addToSearch();
			} else {
				var fa = new HPSAAlert(
					"][Error",
					"][advancedsearch.parameter.empty");
				fa.setBounds(500, 100);
				fa.setButtonText("][confirm.operation.button.accept");
				fa.show();
			}
		} else {
			document.getElementById(VALUES).options[document.getElementById(VALUES).options.length] = new Option(v, v);
			document.getElementById(VALUES + "prev").value = "";
			document.getElementById(VALUES + "prev").focus();
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
	var html = "<span style=\"position:relative; top:0; left:0; width:100%; height:112; overflow-x:hidden; overflow-y:auto;\">";
	html += "<table border=0 cellpadding=2 cellspacing=0>";
	var field = null;
	for (var i = 0; i < this.fields.size(); i++) {
		field = this.fields.get(i);
		var bg = this.selectedFieldIndex == i ? "#f6f6f6" : "transparent";
		html += "<tr style=\"font-family:Arial; font-size:12; color:#003366; cursor:default; background-color:" + bg + "\" ";
		html += "onmouseover=\"this.style.backgroundColor='#e3e3e3';\" onmouseout=\"this.style.backgroundColor='" + bg + "';\">";
		html += "<td width=60 align=center>";
		html += "<img border=0 src=\"/activator/images/future-gui/inventory/futuretree/kill.gif\" style=\"cursor:hand\" onclick=\"delAS(" + i + ")\">";
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
	html += "</table></span>";
	document.getElementById("actsrch").innerHTML = html;
	document.getElementById("actsrch").style.backgroundColor = "transparent";
	document.getElementById("actsrch").scrollTop = this.selectedFieldIndex != null ? 20 * this.selectedFieldIndex : document.getElementById("actsrch").scrollHeight;
}

function removeActualSearchOption(i) {
	this.fields.remove(i);
	this.show();
}