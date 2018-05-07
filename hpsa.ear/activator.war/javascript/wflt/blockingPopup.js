/**********************************************************************

   hp OpenView  service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

/*******************************************************************************************************/
/*                                               BPAttribute                                           */
/*******************************************************************************************************/
/**
 * PRIVATE Constructor
 * Stores each name - value pair of the BlockingPopup object.
 * @param (String) name the name of the attribute.
 * @param (String) value the value of the attribute.
 */
function BPAttribute(name, value) {
	this.name = name;
	this.value = value;
}



/*******************************************************************************************************/
/*                                             BlockingPopup                                           */
/*******************************************************************************************************/
/**
 * PUBLIC Constructor
 * This object covers the whole web page with a transparent overglass and shows a
 * future gui's popup which allows to view the current flow's progression.
 * @param (String) title the title of the future gui's popup.
 */
function BlockingPopup(title) {
	this.title = title;
	this.attributes = new Array();
	this.addAttribute = addBPAttribute;
	this.show = showBP;
	this.release = releaseBP;
}
function addBPAttribute(name, value) {
	var i = 0;
	while (i < this.attributes.length && this.attributes[i].name != name) {
		i++;
	}
	if (i == this.attributes.length) {
		this.attributes[this.attributes.length] = new BPAttribute(name, value);
	} else {
		this.attributes.splice(i, 1, new BPAttribute(name, value));
	}
	if (document.getElementById("_bpatt" + i) != null) {
		document.getElementById("_bpatt" + i).innerHTML = "<b> &raquo; " + name + ":</b> " + value;
	}
}
function showBP() {
	var html = "<span style=\"position:absolute; top:0; left:0; z-index:1000; ";
	html += "width:expression(document.body.clientWidth); height:expression(document.body.clientHeight); ";
	html += "background-color:Blue; filter:Alpha(Opacity=0, Style=0);\"></span>";
	html += "<span class=confirmationMenu style=\"left:expression((document.body.clientWidth - this.clientWidth)/2); visibility:visible; color:#003366; text-align:left; height:150\">";
	if (this.title != null) {
		html += "<span style=\"width:295; text-align:center; font-weight:bold; font-family:Arial; height:30;\">" + this.title + "</span>";
	}
	for (var i = 0; i < this.attributes.length; i++) {
		html += "<span id=_bpatt" + i + " class=p1 style=\"width:295;\">";
		html += "<b> &raquo; " + this.attributes[i].name + ":</b> " + this.attributes[i].value;
		html += "</span>";
	}
	html += "<img border=0 src=\"/activator/images/wflt/flujo.gif\" style=\"position:absolute; top:80; left:20;\">";
	html += "</span>";
	var bp = document.createElement("span");
	bp.setAttribute("id", "_bp_");
	document.body.appendChild(bp);
	document.getElementById("_bp_").innerHTML = html;
}
/**
 * PUBLIC
 * Totally removes the blocking popup from the screen. After this, the popup is never more accessible.
 */
function releaseBP() {
	document.body.removeChild(document.getElementById("_bp_"));
}