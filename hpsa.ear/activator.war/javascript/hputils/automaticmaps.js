
	var CM = "cm";
	var EDC = "edc";
	var TLF = "tlf";
	var NET = "net";
	var CONNECTED = "connected";
	var WARNING = "warning";
	var LOST_CONNECTION = "lost_connection";
	var BROKEN_DOWN = "broken down";
	var UNREACHABLE = "unreachable";
	var UP = "up";
	var DOWN = "down";
	var LEFT = "left";
	var RIGHT = "right";
	var MIDDLE = "middle";


	/**
	 * PUBLIC
	 * The AutomaticConnection constructor.
	 * @param (AutomaticNetworkElement) aenOrigin the AutomaticNetworkElement which is the origin
	 * of this AutomaticConnection
	 * @param (AutomaticNetworkElement) aenDestination the AutomaticNetworkElement which is the
	 * destination of this AutomaticConnection
	 * @param (String) status the AutomaticConnection status. It can be CONNECTED, WARNING or BROKEN_DOWN.
	 * @param (String) dataEvent the name of the javascript function which is going to be called when this
	 * connection is clicked.
	 */
	function AutomaticConnection(aenOrigin, aenDestination, status, dataEvent) {
		this.origin = aenOrigin;
		this.destination = aenDestination;
		this.status = status;
		this.dataEvent = eval(dataEvent);
		this.id = null;
		this.imagesRoot = "";
		this.write = writeConnection;
		this.setId = setACId;
		this.addCross = addCrossToConnection;
		this.removeCross = removeCrossFromConnection;
		this.updateStatus = updateConnectionStatus;
		this.updateClickEvent = updateConnectionClickEvent;
		this.setImagesRoot = setConnectionImagesRoot;
	}
	/**
	 * PROTECTED
	 * Sets the identifier of this AutomaticConnection.
	 * @param (String or int) id the identifier.
	 */
	function setACId(id) {
		this.id = id;
	}
	/**
	 * PROTECTED
	 * Paints the AutomaticConnection into the AutomaticNetwork. If the AutomaticConnection's
	 * status is CONNECTED, it is painted in light blue; if the status is WARNING it is painted
	 * in orange; and if the status is BROKEN_DOWN it is painted in red.
	 */
	function writeConnection() {
		var ac = document.createElement("v:Line");
		ac.setAttribute("id", this.id);
		var acsp = document.getElementById("cloud").appendChild(ac);
		acsp.style.position = "absolute";
		acsp.style.top = 0;
		acsp.style.left = 0;
		acsp.style.zIndex = 95;
		var oX = this.origin.type == NET ? this.origin.left + 40 : this.origin.left + 18;
		var oY = this.origin.type == NET ? this.origin.top + 27 : this.origin.top + 13;
		acsp.from = oX + "," + oY;
		var fX = this.destination.type == NET ? this.destination.left + 40 : this.destination.left + 18;
		var fY = this.destination.type == NET ? this.destination.top + 27 : this.destination.top + 13;
		acsp.to = fX + "," + fY;
		if (this.status == CONNECTED) {
			acsp.strokeColor = "#99CCCC";
		} else if(this.status == WARNING) {
			acsp.strokeColor = "#FF8800";
		} else if(this.status == LOST_CONNECTION) {
			acsp.strokeColor = "#EE1111";
		} else if(this.status == BROKEN_DOWN) {
			acsp.strokeColor = "#EE1111";
			var left = eval(Math.min(fX, oX)) + Math.abs((fX - oX) / 2) - 8;
			var top = eval(Math.min(fY, oY)) + Math.abs((fY - oY) / 2) - 8;
			this.addCross(left, top);
		} else if(this.status == UNREACHABLE) {
			acsp.strokeColor = "#767676";
		}
		acsp.strokeWeight = "2pt";
		if (this.dataEvent != null) {
			acsp.attachEvent("onclick", this.dataEvent);
			acsp.style.cursor = "hand";
		}
	}
	/**
	 * PRIVATE
	 * Adds a cross to the connection at the specified coordenates.
	 */
	function addCrossToConnection(left, top) {
		var crss = document.createElement("img");
		crss.setAttribute("id", this.id + "cross");
		crss.setAttribute("border", "0");
		crss.setAttribute("src", this.imagesRoot + "cross.gif");
		var crssp = document.getElementById("cloud").appendChild(crss);
		crssp.style.position = "absolute";
		crssp.style.left = eval(left);
		crssp.style.top = eval(top);
		crssp.style.zIndex = 95;
		if (this.dataEvent != null) {
			crssp.attachEvent("onclick", this.dataEvent);
			crssp.style.cursor = "hand";
		}
	}
	/**
	 * PRIVATE
	 * Removes the cross from the connection.
	 */
	function removeCrossFromConnection() {
		document.getElementById("cloud").removeChild(document.getElementById(this.id + "cross"));
	}
	/**
	 * PUBLIC
	 * Updates the connection status and changes its color.
	 * @param (String) newStatus the new status of the connection.
	 */
	function updateConnectionStatus(newStatus) {
		if (this.status == BROKEN_DOWN) {
			this.removeCross();
		}
		this.status = newStatus;
		if (this.status == CONNECTED) {
			document.getElementById(this.id).strokeColor = "#99CCCC";
		} else if (this.status == WARNING) {
			document.getElementById(this.id).strokeColor = "#FF8800";
		} else if (this.status == LOST_CONNECTION) {
			document.getElementById(this.id).strokeColor = "#EE1111";
		} else if (this.status == BROKEN_DOWN) {
			document.getElementById(this.id).strokeColor = "#EE1111";
			var oX = this.origin.type == NET ? this.origin.left + 40 : this.origin.left + 18;
			var oY = this.origin.type == NET ? this.origin.top + 27 : this.origin.top + 13;
			var fX = this.destination.type == NET ? this.destination.left + 40 : this.destination.left + 18;
			var fY = this.destination.type == NET ? this.destination.top + 27 : this.destination.top + 13;
			var left = eval(Math.min(fX, oX)) + Math.abs((fX - oX) / 2) - 8;
			var top = eval(Math.min(fY, oY)) + Math.abs((fY - oY) / 2) - 8;
			this.addCross(left, top);
		} else if (this.status == UNREACHABLE) {
			document.getElementById(this.id).strokeColor = "#767676";
		}
	}
	/**
	 * PUBLIC
	 * Updates the click event attached to this connection.
	 * @param (String) dataEvent the name of the javascript function which is going to be called when this
	 * connection is clicked.
	 */
	function updateConnectionClickEvent(dataEvent) {
		this.dataEvent = eval(dataEvent);
		document.getElementById(this.id).attachEvent("onclick", this.dataEvent);
		document.getElementById(this.id).style.cursor = "hand";
	}
	/**
	 * PROTECTED
	 * Sets the images' root for this connection.
	 * @param (String) root the images' root.
	 */
	function setConnectionImagesRoot(root) {
		this.imagesRoot = root;
	}


	/**
	 * PUBLIC
	 * The AutomaticNetworkElement's constructor.
	 * @param (String or int) left the x or left coordenate of this AutomaticNetworkElement inside
	 * the AutomaticNetwork map. It's value is relative to the x=0 coordenate of the map.
	 * @param (String or int) top the y or top coordenate of this AutomaticNetworkElement inside
	 * the AutomaticNetwork map. It's value is relative to the y=0 coordenate of the map.
	 * @param (String) name the AutomaticNetworkElement's name.
	 * @param (String) name the AutomaticNetworkElement's type. It can be CM or EDC.
	 * @param (String) namepos the AutomaticNetworkElement's name position.
	 * @param (String) dataEvent the name of the javascript function which is going to be called when this
	 * connection is clicked. If this parameter is null there is no function calling when the onclick
	 * event is detected.
	 */
	function AutomaticNetworkElement(left, top, name, type, namepos, dataEvent) {
		this.top = eval(top);
		this.left = eval(left);
		this.name = name;
		this.nameFontSize = "8pt";
		this.type = type;
		this.namepos = this.type == NET ? MIDDLE : namepos;
		this.id = null;
		this.visible = "visible";
		this.imagesRoot = "";
		this.dataEvent = eval(dataEvent);
		this.setId = setANEId;
		this.write = writeANE;
		this.writeName = writeNameANE;
		this.updateClickEvent = updateClickEventANE;
		this.setImagesRoot = setImagesRootANE;
		this.setFontSize = setFontSizeANE;
		this.setVisible = setVisibleANE;
	}
	/**
	 * PROTECTED
	 * Sets the identifier of this AutomaticNetworkElement.
	 * @param (String or int) id the identifier.
	 */
	function setANEId(id) {
		this.id = id;
	}
	/**
	 * PROTECTED
	 * Paints the AutomaticNetworkElement into the AutomaticNetwork. If the dataEvent
	 * is not null an onclick event is attached to this AutomaticNetworkElement.
	 */
	function writeANE() {
		var ne = document.createElement("img");
		ne.setAttribute("id", this.id);
		ne.setAttribute("border", "0");
		var width = 36;
		var height = 25;
		if (this.type == EDC) {
			ne.setAttribute("src", this.imagesRoot + "edc.gif");
		} else if (this.type == CM) {
			ne.setAttribute("src", this.imagesRoot + "cm.gif");
		} else if (this.type == TLF) {
			ne.setAttribute("src", this.imagesRoot + "tlf.gif");
		} else if (this.type == NET) {
			ne.setAttribute("src", this.imagesRoot + "net.gif");
			width = 80;
			height = 54;
		}
		if (this.dataEvent != null) {
			ne.attachEvent("onclick", this.dataEvent);
			ne.style.cursor = "hand";
		}
		var neimg = document.getElementById("cloud").appendChild(ne);
		neimg.style.position = "absolute";
		neimg.style.top = this.top;
		neimg.style.left = this.left;
		neimg.style.width = width;
		neimg.style.height = height;
		neimg.style.zIndex = 100;
		neimg.style.visibility = this.visible;
		neimg.ane = this;
		this.writeName();
	}
	/**
	 * PRIVATE
	 * Paints the AutomaticNetworkElement name at the selected position.
	 */
	function writeNameANE() {
		var top = null;
		var left = null;
		var width = this.type == NET ? 80 : 150;
		var align = null;
		if (this.namepos == UP) {
			top = this.top - 15;
			left = this.left - 57;
			align = "center";
		} else if (this.namepos == DOWN) {
			top = this.top + 25;
			left = this.left - 57;
			align = "center";
		} else if (this.namepos == LEFT) {
			top = this.top + 5;
			left = this.left - 155;
			align = "right";
		} else if (this.namepos == RIGHT) {
			top = this.top + 5;
			left = this.left + 40;
			align = "left";
		} else {
			top = this.top + 20;
			left = this.left;
			align = "center";
		}
		var namesp = document.getElementById("cloud").appendChild(document.createElement("span"));
		namesp.style.position = "absolute";
		namesp.style.top = top;
		namesp.style.left = left;
		namesp.style.width = width;
		namesp.style.height = 20;
		namesp.style.color = "#003366";
		namesp.style.fontFamily = "Arial";
		namesp.style.fontSize = this.nameFontSize;
		namesp.style.textAlign = align;
		namesp.style.cursor = "default";
		namesp.style.zIndex = 100;
		namesp.innerText = this.name;
	}
	/**
	 * PUBLIC
	 * Updates the click event attached to this network element.
	 * @param (String) dataEvent the name of the javascript function which is going to be called when this
	 * connection is clicked.
	 */
	function updateClickEventANE(dataEvent) {
		this.dataEvent = eval(dataEvent);
		document.getElementById(this.id).attachEvent("onclick", this.dataEvent);
		document.getElementById(this.id).style.cursor = "hand";
	}
	/**
	 * PROTECTED
	 * Sets the images' root for this connection.
	 * @param (String) root the images' root.
	 */
	function setImagesRootANE(root) {
		this.imagesRoot = root;
	}
	/**
	 * PUBLIC
	 * Sets the font size of the Network Element's name. The default value is "8pt".
	 * @param (String or int) size the new font size.
	 */
	function setFontSizeANE(size) {
		this.nameFontSize = size;
	}
	/** 
	 * PUBLIC
	 * Sets the network element's visibility. By default the network element is visible.
	 * @param (String or boolean) isVisible the network element's new visibility. If true, the
	 * element is visible. If false, it is hidden.
	 */
	function setVisibleANE(isVisible) {
		this.visible = eval(isVisible) ? "visible" : "hidden";
	}


	/**
	 * PUBLIC
	 * The AutomaticNetworkElementList's constructor. It is an array implementation of the
	 * AutomaticNetworkElements present in the AutomaticNetwork map.
	 */
	function AutomaticNetworkElementList() {
		this.aneList = new Array();
		this.getNumberOfAutomaticNetworkElements = getNumberOfANE;
		this.addAutomaticNetworkElement = addANEL;
		this.getAutomaticNetworkElement = getANEL;
	}
	function addANEL(ane) {
		ane.setId("ane" + this.aneList.length);
		this.aneList[this.aneList.length] = ane;
	}
	function getANEL(number) {
		return this.aneList[eval(number)];
	}
	function getNumberOfANE() {
		return this.aneList.length;
	}


	function AutomaticConnectionList() {
		this.acList = new Array();
		this.getNumberOfAutomaticConnections = getNumberOfAC;
		this.addAutomaticConnection = addACL;
		this.getAutomaticConnection = getACL;
	}
	function addACL(ac) {
		ac.setId("ac" + this.acList.length);
		this.acList[this.acList.length] = ac;
	}
	function getACL(number) {
		return this.acList[eval(number)];
	}
	function getNumberOfAC() {
		return this.acList.length;
	}


	function AutomaticNetwork(name, nameXpos, nameYpos, imagesRoot) {
		this.x = 200;
		this.y = 20;
		this.name = name;
		this.nameXpos = eval(nameXpos);
		this.nameYpos = eval(nameYpos);
		this.imagesRoot = imagesRoot;
		this.spanId = null;
		this.aneList = new AutomaticNetworkElementList();
		this.acList = new AutomaticConnectionList();
		this.addAutomaticNetworkElement = addANE;
		this.addAutomaticConnection = addAC;
		this.write = writeNetwork;
		this.writeName = writeNetworkName;
		this.setImagesRoot = setImagesRootAN;
		this.setCoordenates = setANECoordenates;
		this.setSpan = setMapSpan;
	}
	function addANE(ane) {
		ane.setImagesRoot(this.imagesRoot);
		this.aneList.addAutomaticNetworkElement(ane);
	}
	function addAC(con) {
		con.setImagesRoot(this.imagesRoot);
		this.acList.addAutomaticConnection(con);
	}
	function setANECoordenates(leftDifference, top) {
		this.x = eval(leftDifference);
		this.y = eval(top);
	}
	function writeNetwork() {
		var nw = document.createElement("span");
		nw.setAttribute("id", "network");
		if (this.spanId == null) {
			document.body.appendChild(nw);
		} else {
			document.getElementById(this.spanId).appendChild(nw);
		}
		html = "<span id=cloud style=\"position:absolute; ";
		html += "top:" + this.y + "; ";
		html += "left:expression((document.body.clientWidth - this.clientWidth - " + this.x + ")/2);\">";
		html += "<img border=0 src=\"" + this.imagesRoot + "cloud.gif\"></span>";
		document.getElementById("network").innerHTML = html;
		for (var i=0; i < this.aneList.getNumberOfAutomaticNetworkElements(); i++) {
			this.aneList.getAutomaticNetworkElement(i).write();
		}
		for (var i=0; i < this.acList.getNumberOfAutomaticConnections(); i++) {
			this.acList.getAutomaticConnection(i).write();
		}
		this.writeName();
	}
	function writeNetworkName() {
		var nnmsp = document.getElementById("cloud").appendChild(document.createElement("span"));
		nnmsp.style.position = "absolute";
		nnmsp.style.top = this.nameXpos;
		nnmsp.style.left = this.nameYpos;
		nnmsp.style.color = "#003366";
		nnmsp.style.fontFamily = "Arial";
		nnmsp.style.fontSize = "8pt";
		nnmsp.style.fontWeight = "bold";
		nnmsp.style.cursor = "default";
		nnmsp.innerText = this.name;
	}
	function setImagesRootAN(root) {
		this.imagesRoot = root;
	}
	function setMapSpan(spanId) {
		this.spanId = spanId;
	}