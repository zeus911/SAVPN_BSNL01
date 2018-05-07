// CRModel Javascript general utilities

// Checks whether actual browser is Internet Explorer 7.x
// Returns either true or false
function isIE7() {

	var majorVersion;
	var nAgt = navigator.userAgent;

	if ((nAgt.indexOf("MSIE")) != -1) {
		// Is IE

		var fullVersion = nAgt.substring(nAgt.indexOf("MSIE") + 5);
		majorVersion = parseInt('' + fullVersion, 10);

		if (majorVersion == 7)
			return true;
		else
			return false;

	} else
		return false;

}

// Checks whether actual browser is Firefox
// Returns either true or false
function isFirefox() {

	var majorVersion;
	var navegador = navigator.userAgent;

	if ((navegador.indexOf("Firefox")) != -1) {
		// Is Firefox

		/*
		 * version = navegador.substring(navegador.lastIndexOf("/") + 1,
		 * navegador .lastIndexOf("/") + 4);
		 * 
		 * if (version == "3.6") return true; else return false;
		 */
		return true;
	} else
		return false;
}