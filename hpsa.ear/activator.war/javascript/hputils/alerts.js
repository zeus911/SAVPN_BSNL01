
/***********************************************************************************************/
/*                                                                                             */
/*                                          HPSAAlert                                        */
/*                                                                                             */
/***********************************************************************************************/
function HPSAAlert(title, message, jsFunction) {
	var ttl = title == null ? "" : title;
	var msg = message == null ? "" : message;
	var width = 300;
	var height = 120;
	var takeup = 0;
	var buttonText = "Accept";
	var buttonFunction = jsFunction == null ? "" : jsFunction;
	var blockPage = true;
	var id = "_bp_";
	while (document.getElementById(id)) {
		id += "_";
	}
	this.setMessage = function (message) {
		msg = message == null ? "" : message;
	}
	this.setTitle = function (title) {
		ttl = title == null ? "" : title;
	}
	this.setBounds = function (wdth, hght) {
		width = wdth == null ? 300 : wdth;
		height = hght == null ? 120 : hght;
	}
	this.setButtonText = function (txt) {
		buttonText = txt == null ? "Accept" : txt;
	}
	this.setBlockingAlert = function (blck) {
		blockPage = blck;
	}
	this.takeUp = function (lngth) {
		takeup = lngth;
	}
	this.setButtonFunction = function (jsFunction) {
		buttonFunction = jsFunction == null ? "" : jsFunction;
	}
	this.show = function () {
		var html = "";
    if (document.getElementById(id) == null) {
      var bp = document.createElement("div");
      bp.setAttribute("id", id);
      bp = document.body.appendChild(bp);
      bp.className = "hpsa_alert";
      bp.style.position = "fixed";
      bp.style.top = "0px";
      bp.style.left = "0px";
      bp.style.width = "100%";
      bp.style.height = "100%";
      bp.style.display = "none";
    }
		if (blockPage) {
			html += "<div class=\"overglass\" style=\"position:fixed; top:0px; left:0px; z-index:1000; width:100%; height:100%;\">&nbsp;</div>";
		}
    html += "<div class=\"box\" style=\"position:relative; top:100px; margin:0 auto; z-index:1001; width:" + width + "px; padding:2px\">";
    html += "<div class=\"header\" style=\"position:relative; top:0px; left:0px; width:100%; height:20px; padding-top:2px;\">";
    html += "<span style=\"margin-left:5px;\">" + title + "</span>";
    html += "</div>";
    html += "<div class=\"message\" style=\"position:relative; top:0px; left:0px; width:100%; margin-top:20px;\">" + msg + "</div>";
    html += "<div style=\"position:relative; top:0px; left:0px; width:100%; margin-top:20px; text-align:center;\">";
    html += "<input id=\"" + id + "btn\" class=\"btn\" type=\"button\" value=\"" + buttonText + "\" onclick=\"this.ba.hide();" + buttonFunction + "\">";
    html += "</div>";
    html += "</div>";
		document.getElementById(id).innerHTML = html;
		document.getElementById(id + "btn").ba = this;
		document.getElementById(id).style.display = "block";
	}
	this.hide = function () {
		if (document.getElementById(id)) {
			document.getElementById(id).style.display = "none";
		}
	}
}

/***********************************************************************************************/
/*                                                                                             */
/*                                        HPSAConfirm                                        */
/*                                                                                             */
/***********************************************************************************************/
function HPSAConfirm(title, message, fncAccept, fncCancel) {
	var ttl = title == null ? "" : title;
	var msg = message == null ? "" : message;
	var width = 320;
	var height = 80;
	var takeup = 0;
	var acceptButtonText = "Accept";
	var cancelButtonText = "Cancel";
	var acceptButtonFunction = fncAccept == null ? "" : fncAccept;
	var cancelButtonFunction = fncCancel == null ? "" : fncCancel;
	var blockPage = false;
	var escapeQuotes = function escapeQuotes(txt) {
		var str = txt;
		for (var i = str.indexOf("\""); i != -1; i = str.indexOf("\"")) {
			str = str.substring(0, i) + "&quot;" + str.substring(i + 1);
		}
		return str;
	}
	var id = "_bp_";
	while (document.getElementById(id)) {
		id += "_";
	}
	this.setMessage = function (message) {
		msg = message == null ? "" : message;
	}
	this.setTitle = function (title) {
		ttl = title == null ? "" : title;
	}
	this.setBounds = function (wdth, hght) {
		width = wdth == null ? 300 : wdth;
		height = hght == null ? 120 : hght;
	}
	this.takeUp = function (lngth) {
		takeup = lngth;
	}
	this.setAcceptButtonText = function (txt) {
		acceptButtonText = txt == null ? "Accept" : txt;
	}
	this.setCancelButtonText = function (txt) {
		cancelButtonText = txt == null ? "Cancel" : txt;
	}
	this.setAcceptButtonFunction = function (fnc) {
		acceptButtonFunction = fnc == null ? "" : escapeQuotes(fnc);
	}
	this.setCancelButtonFunction = function (fnc) {
		cancelButtonFunction = fnc == null ? "" : escapeQuotes(fnc);
	}
	this.setBlockingConfirm = function (blck) {
		blockPage = blck;
	}
	this.show = function () {
    var html = "";
    if (document.getElementById(id) == null) {
      var bp = document.createElement("div");
      bp.setAttribute("id", id);
      bp = document.body.appendChild(bp);
      bp.className = "hpsa_alert";
      bp.style.position = "fixed";
      bp.style.top = "0px";
      bp.style.left = "0px";
      bp.style.width = "100%";
      bp.style.height = "100%";
      bp.style.display = "none";
    }
		if (blockPage) {
			html += "<div class=\"overglass\" style=\"position:fixed; top:0px; left:0px; z-index:1000; width:100%; height:100%;\">&nbsp;</div>";
		}
    html += "<div class=\"box\" style=\"position:relative; top:100px; margin:0 auto; z-index:1001; width:" + width + "px; padding:2px\">";
    html += "<div class=\"header\" style=\"position:relative; top:0px; left:0px; width:100%; height:20px; padding-top:2px;\">";
    html += "<span style=\"margin-left:5px;\">" + title + "</span>";
    html += "</div>";
    html += "<div class=\"message\" style=\"position:relative; top:0px; left:0px; width:100%; margin-top:20px;\">" + msg + "</div>";
    html += "<div style=\"position:relative; top:0px; left:0px; width:100%; margin-top:20px; text-align:center;\">";
    html += "<input id=\"" + id + "abtn\" class=\"btn\" type=\"button\" value=\"" + acceptButtonText + "\" onclick=\"this.ba.hide();" + acceptButtonFunction + "\">";
    html += "<input id=\"" + id + "cbtn\" class=\"btn\" type=\"button\" value=\"" + cancelButtonText + "\" onclick=\"this.ba.hide();" + cancelButtonFunction + "\">";
    html += "</div>";
    html += "</div>";
		document.getElementById(id).innerHTML = html;
 		document.getElementById(id + "abtn").ba = this;
		document.getElementById(id + "cbtn").ba = this;
		document.getElementById(id).style.display = "block";
	}
	this.hide = function () {
		if (document.getElementById(id)) {
			document.getElementById(id).style.display = "none";
		}
	}
}