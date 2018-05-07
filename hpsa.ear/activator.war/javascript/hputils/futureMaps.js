	/**
	 * PROTECTED FINAL STATIC
	 * The begining of each Network Element String identifier.
	 * @see NetworkElement
	 */
	var NETWORK_ELEMENT = "ne";
	/**
	 * PROTECTED FINAL STATIC
	 * The map String identifier.
	 * @see Map
	 */
	var MAP = "map";
	/**
	 * PROTECTED FINAL STATIC
	 * The scaled map String identifier.
	 * @see Minimap
	 */
	var MINIMAP = "minimap";
	/**
	 * PROTECTED FINAL STATIC
	 * The scaled map window String identifier.
	 * @see Minimap
	 */
	var MINIWINDOW = "miniwdw";
	/**
	 * PROTECTED FINAL STATIC
	 * The default scaled map side length, in pixels.
	 * @
	 */
	var MINIMAP_SIDE = 200;
	/**
	 * PROTECTED FINAL STATIC
	 * The begining of each Port String identifier.
	 * @see Port
	 */
	var PORT = "port";
	/**
	 * PROTECTED FINAL STATIC
	 * The port allocation at the top side of the Network Element.
	 * @see Port
	 */
	var TOP = "top";
	/**
	 * PROTECTED FINAL STATIC
	 * The port allocation at the left side of the Network Element.
	 * @see Port
	 */
	var LEFT = "left";
	/**
	 * PROTECTED FINAL STATIC
	 * The port allocation at the right side of the Network Element.
	 * @see Port
	 */
	var RIGHT = "right";
	/**
	 * PROTECTED FINAL STATIC
	 * The port allocation at the bottom side of the Network Element.
	 * @see Port
	 */
	var BOTTOM = "bottom";
	/**
	 * PROTECTED FINAL STATIC
	 * The begining of each Connection String identifier.
	 * @see Connection
	 */
	var CONNECTION = "con";
	/**
	 * PROTECTED FINAL STATIC
	 * The begining of each dotted network element String identifier of the performed selection.
	 * @see DottedNetworkElement
	 */
	var DOTTED_NE = "dotne";
	/**
	 * PROTECTED FINAL STATIC
	 * The whole dotted selection String identifier.
	 * @see DottedSelection
	 */
	var DOTTED_SEL = "dotsel";
	/**
	 * PROTECTED FINAL STATIC
	 * The eventual selection String identifier.
	 * @see Selection
	 */
	var SELECTION = "sel";
	/**
	 * PROTECTED FINAL STATIC
	 * The default border width and height of the map and the minimap.
	 */
	var BORDER_WH = 4;
	/**
	 * PROTECTED FINAL STATIC
	 * The base URL String of the images.
	 */
	var URL_IMAGES = "images/";
	/**
	 * PROTECTED FINAL STATIC
	 * A connections counter used to compose each Connection String identifier.
	 * @see Connection
	 */
	var connectionsCounter = 0;
	
	/**
	 * PROTECTED FINAL STATIC
	 * Indicates that the user is actually selecting Network Elements.
	 */
	var SELECT_MODE = "select_mode";
	/**
	 * PROTECTED FINAL STATIC
	 * Indicates that the user is actually moving the Miniwindow.
	 */
	var SCROLL_MODE = "scroll_mode";
	
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element has a round rect as background.
	 * @see NetworkElement
	 */
	var ROUNDRECT = "roundrect";
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element has a round romboid as background.
	 * @see NetworkElement
	 */
	var ROMBO = "rombo";
	
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element has no background attached.
	 * @see NetworkElement
	 */
	var BG_NONE = "none";
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element has a solid (not gradient) background attached.
	 * @see NetworkElement
	 */
	var BG_SOLID = "solid";
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element has a gradient (not solid) background attached.
	 * @see NetworkElement
	 */
	var BG_GRADIENT = "gradient";
	
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element name is allocated at the top side and over the attached image.
	 * @see NetworkElement
	 */
	var NAME_UP = "top";
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element name is allocated at the bottom side and below the attached image.
	 * @see NetworkElement
	 */
	var NAME_DOWN = "bottom";
	/**
	 * PROTECTED FINAL STATIC
	 * The Network Element name is allocated in the middle and inside the attached image.
	 * @see NetworkElement
	 */
	var NAME_CENTER = "center";
	
	/**
	 * PUBLIC FINAL STATIC
	 * Indicates that a connection must have a middle point at the left side.
	 * @see Connection
	 */
	var LEFT_CORNER = "lc";
	/**
	 * PUBLIC FINAL STATIC
	 * Indicates that a connection must have a middle point at the left side.
	 * @see Connection
	 */
	var RIGHT_CORNER = "rc";
	/**
	 * PUBLIC FINAL STATIC
	 * Indicates that a connection must not have a middle point at any side. In this case, the
	 * connection is a single line between two ports.
	 * @see Connection
	 */
	var NO_CORNER = null;



/****************************************************************************************************/	
/*                                       Connection object                                          */
/****************************************************************************************************/
	/*
	 * PUBLIC
	 * The Connection element constructor. A connection joins two Network Elements Ports with a single line.
	 * This line can be a rect between two ports or can have a middle point which describes a right or left angle.
	 * Initially a connection has no middle point.
	 * The connection implementation is made using the VML polyline element, which allows control over the weight
	 * and the color of the line. By default, the connection's color is a dark blue (#003366) and the weight is 1.
	 * Each connection can have an action attached to the click event. If so, this event fires the execution of
	 * a specified function.
	 * As other elements of the map, a connection can also have a popup menu associated. This menu is displayed
	 * when the connection is clicked with the right button of the mouse. By default, the popup menu has two of
	 * these possible entries: set an angle at the left side, set an angle at the right side or set no angle at all.
	 * Each connection has a unique identifier to search them inside the whole map. This identifier is composed
	 * by the CONNECTION constant and the number asociated to this connection when it was created. This means that
	 * every connection has an identifier similar to "con0", "con1", and so on.
	 * @param (Port) port1 the origin or destination port of this connection.
	 * @param (Port) port2 the origin or destination port of this connection.
	 * @see CONNECTION
	 */
	function Connection(port1, port2) {
		if (port1.ne.id > port2.ne.id) {
			this.originPort = port2;
			this.destinationPort = port1;
		} else {
			this.originPort = port1;
			this.destinationPort = port2;
		}
		this.originPort.setConnection(this);
		this.destinationPort.setConnection(this);
		this.originX = null;
		this.originY = null;
		this.destinationX = null;
		this.destinationY = null;
		this.color = "#003366";
		this.weight = 1;
		this.points = null;
		this.middlePoint = null;
		this.onClickAction = null;
		this.popupListItems = new List();
		this.id = CONNECTION + connectionsCounter++;
		this.allocateOrigin = allocateOrigin;
		this.allocateDestination = allocateDestination;
		this.allocate = allocateConnection;
		this.setMiddlePoint = setConnectionMiddlePoint;
		this.write = writeConnection;
		this.setColor = setConnectionColor;
		this.setWeight = setConnectionWeight;
		this.setClickAction = setConnectionClickAction;
		this.addPopupListItem = addConnectionPopupListItem;
		this.showPopupMenuAt = showConnectionPopupMenu;
		this.updatePopupMenu = updateConnectionPopupMenu;
		this.executeAction = executeActionOnRightClickedConnection;
		this.remove = removeConnection;
		this.addPopupListItem(null, "Angle to the left", LEFT_CORNER);
		this.addPopupListItem(null, "Angle to the right", RIGHT_CORNER);
	}
	/**
	 * PRIVATE
	 * Allocates the origin coordenates of the connection at the middle point of the origin port.
	 */
	function allocateOrigin() {
		this.originX = this.originPort.x + 3 + this.originPort.ne.x;
		this.originY = this.originPort.y + 3 + this.originPort.ne.y;
		if (this.destinationX != null && this.destinationY != null) {
			this.allocate();
		}
	}
	/**
	 * PRIVATE
	 * Allocates the destination coordenates of the connection at the middle point of the destination port.
	 */
	function allocateDestination() {
		this.destinationX = this.destinationPort.x + 3 + this.destinationPort.ne.x;
		this.destinationY = this.destinationPort.y + 3 + this.destinationPort.ne.y;
		if (this.originX != null && this.originY != null) {
			this.allocate();
		}
	}
	/**
	 * PUBLIC
	 * Indicates whether this connection has a middle point at the left side, a middle point at the right
	 * side or no middle point at all.
	 * @param (String) middlePoint indicates the middle point type for this connection. This could be NO_ANGLE,
	 * RIGHT_ANGLE or LEFT_ANGLE. Any other String value is allowed.
	 */
	function setConnectionMiddlePoint(middlePoint) {
		this.middlePoint = middlePoint;
		this.updatePopupMenu();
	}
	/**
	 * PROTECTED
	 * Allocates the origin point, the middle point and the destination point of the connection.
	 * Every time this method is invoked, the connection is removed and rewrited.
	 */
	function allocateConnection() {
		if (document.getElementById(this.id) != null) {
			document.getElementById(MAP).removeChild(document.getElementById(this.id));
		}
		this.points = this.originX + "," + this.originY + " ";
		if (this.middlePoint == LEFT_CORNER) {
			var x = Math.min(this.originX, this.destinationX);
			var y = x == this.originX ? this.destinationY : this.originY;
			this.points += x + "," + y + " ";
		} else if (this.middlePoint == RIGHT_CORNER) {
			var x = Math.max(this.originX, this.destinationX);
			var y = x == this.originX ? this.destinationY : this.originY;
			this.points += x + "," + y + " ";
		}
		this.points += this.destinationX + "," + this.destinationY;
		this.write();
	}
	/**
	 * PROTECTED
	 * Writes the connection inside the map.
	 */
	function writeConnection() {
		if (this.points != null) {
			var line = document.createElement("v:polyline");
			line.setAttribute("id", this.id);
			line.setAttribute("points", this.points);
			var elem = document.getElementById(MAP).appendChild(line);
			elem.style.pixelTop = 0;
			elem.style.pixelLeft = 0;
			elem.style.position = "absolute";
			elem.style.zIndex = 3;
			elem.filled = "false";
			elem.strokeColor = this.color;
			elem.strokeWeight = this.weight;
			if (this.onClickAction != null) {
				elem.attachEvent("onclick", this.onClickAction);
				elem.style.cursor = "hand";
			}
			elem.connection = this;
		}
	}
	/**
	 * PUBLIC
	 * Sets the connection's color. The default value for each connection is "#003366".
	 * @param (String) color the connection color. This color can be either a hexadecimal
	 * representation such as "#E3E3E3" or a color name such as "White" or "Yellow".
	 */
	function setConnectionColor(color) {
		this.color = color;
		if (document.getElementById(this.id) != null) {
			document.getElementById(this.id).strokeColor = color;
		}
	}
	/**
	 * PUBLIC
	 * Sets the connection's weight. The default value for each connection is 1.
	 * @param (String or int) weight the weight of the connection.
	 */
	function setConnectionWeight(weight) {
		this.weight = eval(weight);
		if (document.getElementById(this.id) != null) {
			document.getElementById(this.id).strokeWeight = eval(weight);
		}
	}
	/**
	 * PUBLIC
	 * Attaches an action to the click event of this connection. The action must be the name of
	 * a javascript function without brackets and parameters.
	 * @param (String) action the name of the javascript function which must be invoked when this
	 * connection is clicked.
	 */
	function setConnectionClickAction(action) {
		this.onClickAction = eval(action);
	}
	/**
	 * PUBLIC
	 * Adds an item to the popup list associated to this connection. By default, every connection
	 * has two items added (see the Connection constructor).
	 * @param (String) img the url of an image associated to this item. Can be null. In this case
	 * no image is displayed for this item when the popup menu is showed.
	 * @param (String) text the text of this item inside the popup menu. It is showed after the
	 * image (when an image is specified) and at the same line.
	 * @param (String) action the action name which must be performed when this item is clicked.
	 */
	function addConnectionPopupListItem(img, text, action) {
		this.popupListItems.add(new PopupMenuItem(img, text, action), false);
	}
	/**
	 * PROTECTED
	 * Makes visible the popup menu associated to this connection.
	 */
	function showConnectionPopupMenu(x, y) {
		if (this.popupListItems.getLength() > 0) {
			document.getElementById(MAP).map.setPopupMenu(this.popupListItems, x, y);
		}
	}
	/**
	 * PROTECTED
	 * Changes the "Angle to the right side", "Angle to the left side" or "No angle" items of the
	 * popup menu associated to this connection to prevent the apparition of the actual middlePoint
	 * value as an option inside the popup menu.
	 */
	function updateConnectionPopupMenu() {
		var action = null;
		var i = 0;
		for (var found = false; i < this.popupListItems.getLength() && !found; i++) {
			action = this.popupListItems.get(i).action;
			if (action == LEFT_CORNER || action == RIGHT_CORNER || action == NO_CORNER || action == "null") {
				found = true;
				if (this.middlePoint == NO_CORNER || this.middlePoint == "null") {
					this.popupListItems.get(i).action = LEFT_CORNER;
					this.popupListItems.get(i).text = "Angle to the left";
				} else {
					this.popupListItems.get(i).action = NO_CORNER;
					this.popupListItems.get(i).text = "No angle";
				}
			}
		}
		for (var found = false; i < this.popupListItems.getLength() && !found; i++) {
			action = this.popupListItems.get(i).action;
			if (action == LEFT_CORNER || action == RIGHT_CORNER || action == NO_CORNER || action == "null") {
				found = true;
				if (this.middlePoint == NO_CORNER || this.middlePoint == "null" || this.middlePoint == LEFT_CORNER) {
					this.popupListItems.get(i).action = RIGHT_CORNER;
					this.popupListItems.get(i).text = "Angle to the right";
				} else {
					this.popupListItems.get(i).action = LEFT_CORNER;
					this.popupListItems.get(i).text = "Angle to the left";
				}
			}
		}
	}
	/**
	 * PROTECTED
	 * Executes the selected action of the popup menu.
	 * @param (String) action the action selected of the popup menu associated to this connection.
	 */
	function executeActionOnRightClickedConnection(action) {
		if (action == LEFT_CORNER || action == RIGHT_CORNER || action == "null") {
			this.setMiddlePoint(action);
			this.updatePopupMenu();
			this.originPort.ne.updatePorts();
			this.destinationPort.ne.updatePorts();
			this.allocate();
		} else {
			eval(action + "()");
		}
		rightClickedElementId = null;
		document.getElementById(MAP).map.hidePopupMenu();
	}
	/**
	 * PUBLIC
	 * Removes this connection from the map.
	 */
	function removeConnection() {
		this.originPort.remove();
		this.destinationPort.remove();
		document.getElementById(MAP).removeChild(document.getElementById(this.id));
	}



/****************************************************************************************************/	
/*                                              Port object                                         */
/****************************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * A port is a yellow circle allocated at a side of its network element owner. The position
	 * of the each port is calculated automatically, what menas that this object has any method
	 * prepared to do such things. To calculate the correct position of the port, to avoid the
	 * overlapping of ports and to space them simetrically along the network element side the
	 * automatic calculation of each port position is done in two steps. The first one checks
	 * the type of connection and the location of the other network element of that connection.
	 * With this it is very simple to know the network element side where the port has to be
	 * allocated: TOP, LEFT, RIGHT or BOTTOM. When all the ports of a single network element are
	 * set at the different sides, the second step sets their coordenates to separate them
	 * simetrically.
	 * Really, this structure is very simple. It has a pointer to the network element which owns
	 * the port and another pointer to the connection which has this port as its origin or
	 * destination.
	 * @name (String) name the name of the port.
	 */
	function Port(name) {
		this.name = name;
		this.ne = null;
		this.connection = null;
		this.id = null;
		this.x = 0;
		this.y = 0;
		this.side = null;
		this.color = "Yellow";
		this.setId = setPortId;
		this.setNetworkElement = setPortNetworkElement;
		this.setConnection = setPortConnection;
		this.setColor = setPortColor;
		this.allocate = allocatePort;
		this.calculateCoords = calculateCoords;
		this.write = writePort;
		this.remove = removePort;
	}
	/**
	 * PROTECTED
	 * Sets the port id. Each port has an identifier similar to "port0", "port1", and so on. This
	 * identifier is used to find the HTML element inside de map.
	 * @param (String or int) id the number associated to the identifier of this port.
	 */
	function setPortId(id) {
		this.id = PORT + id + this.ne.id;
	}
	/**
	 * PROTECTED
	 * Sets a pointer to the Network Element which is the owner of this port.
	 * @param (NetworkElement) ne the network element owner of this port.
	 */
	function setPortNetworkElement(ne) {
		this.ne = ne;
	}
	/**
	 * PROTECTED
	 * Sets a pointer the connection that has this port as its origin or destination.
	 * @param (Connection) con the connection.
	 */
	function setPortConnection(con) {
		this.connection = con;
	}
	/**
	 * PUBLIC
	 * Sets the new port's color. The default color is yellow.
	 * @param (String) color the new port's color.
	 */
	function setPortColor(color) {
		this.color = color;
	}
	/**
	 * PROTECTED
	 * Automatically allocates the port at the correct coordenates and at the correct side of
	 * the network element which is its owner.
	 * @param (String or int) numberOfPortsAtSameSide the number of ports at the same side of
	 * this one.
	 * @param (String) position the number of this port between all the ports allocated at the
	 * same side.
	 */
	function allocatePort(numberOfPortsAtSameSide, position) {
		var n = eval(numberOfPortsAtSameSide);
		var pos = eval(position);
		if (this.side == TOP) {
			this.x = Math.floor(this.ne.width / (n + 1) * pos);
			this.y = -3;
		} else if (this.side == LEFT) {
			this.x = -3;
			this.y = Math.floor(this.ne.height / (n + 1) * pos);
		} else if (this.side == RIGHT) {
			this.x = this.ne.width - 2;
			this.y = Math.floor(this.ne.height / (n + 1) * pos);
		} else if (this.side == BOTTOM) {
			this.x = Math.floor(this.ne.width / (n + 1) * pos);
			this.y = this.ne.height - 2;
		}
		document.getElementById(this.id).style.left = this.x;
		document.getElementById(this.id).style.top = this.y;
		if (this.connection.originPort == this) {
			this.connection.allocateOrigin();
		} else {
			this.connection.allocateDestination();
		}
	}
	/**
	 * PROTECTED
	 * Calculates the correct side of the network element where the port has to be located.
	 */
	function calculateCoords() {
		var localNE = this.ne;
		var remoteNE = this.connection.originPort == this ? this.connection.destinationPort.ne : this.connection.originPort.ne;
		if (remoteNE.x == localNE.x) {
			this.side = remoteNE.y > localNE.y ? BOTTOM : TOP;
		} else {
			if (this.connection.middlePoint == LEFT_CORNER) {
				if (localNE.x > remoteNE.x) {
					this.side = LEFT;
				} else {
					this.side = localNE.y > remoteNE.y ? TOP : BOTTOM;
				}
			} else if (this.connection.middlePoint == RIGHT_CORNER) {
				if (localNE.x > remoteNE.x) {
					this.side = localNE.y > remoteNE.y ? TOP : BOTTOM;
				} else {
					this.side = RIGHT;
				}
			} else {
				var slope = (remoteNE.y - localNE.y) / (remoteNE.x - localNE.x);
				if (slope < 1 && slope > -1) {
					this.side = localNE.x > remoteNE.x ? LEFT : RIGHT;
				} else {
					this.side = localNE.y > remoteNE.y ? TOP : BOTTOM;
				}
			}
		}
	}
	/**
	 * PROTECTED
	 * Writes the port's HTML code inside the map.
	 */
	function writePort() {
		var oval = document.createElement("v:oval");
		oval.setAttribute("id", this.id);
		var elem = document.getElementById(this.ne.id).appendChild(oval);
		elem.style.position = "absolute";
		elem.style.width = 5;
		elem.style.height = 5;
		elem.style.zIndex = 10;
		elem.fill.color = this.color;
		elem.port = this;
		if (this.connection.originPort == this) {
			this.connection.write();
		}
	}
	/**
	 * PUBLIC
	 * Removes this port from the network element which owned it;
	 */
	function removePort() {
		this.ne.removePort(this);
		document.getElementById(this.ne.id).removeChild(document.getElementById(this.id));
	}



/****************************************************************************************************/	
/*                                       NetworkElement object                                      */
/****************************************************************************************************/
	/**
	 * PUBLIC Constructor
	 * The network elements are the nodes of the map. There is a predefined shape and dimension
	 * for each network element, but there are a lot of parameters which can be cofigured to give
	 * the network element different looks and change these initial shape and dimension.
	 * By default, a network element has a width of 100px and a height of 50px, no image attached,
	 * the text color is white and the background is a gradient form "#003366" (dark blue) at the
	 * bottom to "#e3e3e3" (light blue-grey) at the top, the shape is a rectangle with straight
	 * corners, the name is allocated at the bottom of the rectangle and the border color is "#003366".
	 * Every network element is identified by a String that begins with the NETWORK_ELEMENT constant
	 * followed by a unique number.
	 * @param (String) name the name of the network element.
	 * @param (String or int) xPos the x coordinate of the network element inside the map from the
	 * left top corner of the screen. If null, the default value is 0.
	 * @param (String or int) yPos the y coordinate of the network element inside the map from the
	 * left top corner of the screen. If null, the default value is 0.
	 * @see NETWORK_ELEMENT
	 */
	function NetworkElement(name, xPos, yPos) {
		this.name = name == null || name == "null" ? "noName" : name;
		this.id = null;
		this.extendedInformation = null;
		this.rectid = null;
		this.x = xPos == null || xPos == "null" ? 0 : eval(xPos);
		this.y = yPos == null || yPos == "null" ? 0 : eval(yPos);
		this.height = 50;
		this.width = 100;
		this.textColor = "#ffffff";
		this.image = null;
		this.selected = false;
		this.miniNE = null;
		this.borderColor = "#003366";
		this.bgForm = ROUNDRECT;
		this.bgType = BG_GRADIENT;
		this.bgColor1 = "#003366";
		this.bgColor2 = "#e3e3e3";
		this.roundCornerPercentage = "0%";
		this.onClicked = null;
		this.ports = new List();
		this.popupListItems = new List();
		this.nameLocation = NAME_DOWN;
		this.setId = setNeId;
		this.setExtendedInformation = setExtendedInformationNE;
		this.allocate = allocateNE;
		this.addPort = addPortToNe;
		this.removePort = removePortFromNE;
		this.write = writeNE;
		this.writeMainSpan = writeMainSpanNE;
		this.writeBg = writeBgNE;
		this.writeName = writeNameNE;
		this.writeImage = writeImageNE;
		this.writeOverglass = writeOverglass;
		this.allocatePorts = allocateNePorts;
		this.updatePorts = updateNePorts;
		this.select = selectNE;
		this.unselect = unselectNE;
		this.isSelected = isSelectedNE;
		this.setBounds = setBoundsNE;
		this.setTextColor = setTextColorNE;
		this.setBorder = setBorderNE;
		this.setClickAction = setClickActionNE;
		this.setBackgroundForm = setBackgroundFormNE;
		this.setBackgroundStyle = setBackgroundStyleNE;
		this.setBackgroundColor = setBackgroundColorNE;
		this.setRoundCornersPercentage = setRoundCornersPercentageNE;
		this.setBorderColor = setBorderColorNE;
		this.setNameLocation = setNameLocationNE;
		this.setImage = setImageNE;
		this.addPopupListItem = addPopupListItemNE;
		this.showPopupMenuAt = showPopupMenuNE;
		this.executeAction = executeActionOnRightClickedNE;
		this.remove = removeNE;
	}
	/**
	 * PROTECTED
	 * Sets the network element's identifier.
	 * @param (String or int) id the number of this network element.
	 */
	function setNeId(id) {
		this.id = NETWORK_ELEMENT + id;
		this.rectid = NETWORK_ELEMENT + id + "rect";
	}
	/**
	 * PUBLIC
	 * Attaches an object to this NetworkElement as extended information.
	 * @param (Object of any type) eiObj the extended information object.
	 */
	function setExtendedInformationNE(eiObj) {
		this.extendedInformation = eiObj;
	}
	/**
	 * PUBLIC
	 * Sets the name location inside the network element's rectangle.
	 * @param (String) location the name location. It can be one of these three: NAME_UP,
	 * NAME_DOWN, NAME_CENTER.
	 * @see NAME_UP
	 * @see NAME_DOWN
	 * @see NAME_CENTER
	 */
	function setNameLocationNE(location) {
		this.nameLocation = location;
	}
	/**
	 * PUBLIC
	 * Attaches an action to the click event of this network element.
	 * @param (String) functionName the name of the javascript function which is going to be
	 * called when the click event is fired.
	 */
	function setClickActionNE(functionName) {
		this.onClicked = eval(functionName);
	}
	/**
	 * PUBLIC
	 * Sets the background form of the network element.
	 * @param (String) bgForm the network element's type. This can be one of these: BG_NONE,
	 * BG_SOLID, BG_GRADIENT.
	 * @see ROUNDRECT
	 * @see ROMBO
	 */
	function setBackgroundFormNE(bgForm) {
		this.bgForm = bgForm;
	}
	/**
	 * PUBLIC
	 * Sets the background type of the network element.
	 * @param (String) bgType the network element's type. This can be one of these: BG_NONE,
	 * BG_SOLID, BG_GRADIENT.
	 * @see BG_NONE
	 * @see BG_SOLID
	 * @see BG_GRADIENT
	 */
	function setBackgroundStyleNE(bgType) {
		this.bgType = bgType;
	}
	/**
	 * PUBLIC
	 * Sets the background colors. If the background type is set to BG_SOLID, only the color1 is
	 * mandatory. If the background type is set to BG_NONE, these colors are irrelevant.
	 * This colors can be the hexadecimal representation or the name of the color, such as
	 * "#ffffff" and "white".
	 * @param (String) color1 the first background color. If the background type is set to
	 * BG_SOLID, this is the selected color. If the background type is set to BG_GRADIENT, this is
	 * the bottom color which will turn gradually to the top color.
	 * @param (String) color2 the second background color. If the background type is set to
	 * BG_SOLID, this color is irrelevant and can be null. If the background type is set to
	 * BG_GRADIENT, this is the top color which will turn gradually to the bottom color.
	 * @see setBackgroundTypeNE
	 */
	function setBackgroundColorNE(color1, color2) {
		this.bgColor1 = color1;
		this.bgColor2 = color2;
		if (document.getElementById(this.rectid) != null && this.bgType != BG_NONE) {
			document.getElementById(this.rectid).fill.color = this.bgColor1;
			document.getElementById(this.rectid).fill.color2 = this.bgColor2;
		}
	}
	/**
	 * PUBLIC
	 * Sets the roundness of the network element's corners.
	 * @param (String or float) rate the roundness percentage of the corners. A value of "0%" means
	 * straight rectangle, no roundness. A percentage of "100%" means the maximum percentage of
	 * roundness, which depends on the length of the rectangle sides. If the length of these sides
	 * is allways the same (the network element is a square) and the roundness percentage is "100%",
	 * the result is a circle. Otherway, the result is a rectangle with round corners.
	 */
	function setRoundCornersPercentageNE(rate) {
		this.roundCornerPercentage = rate;
		if (document.getElementById(this.rectid) != null && this.bgForm == ROUNDRECT) {
			document.getElementById(this.id).removeChild(document.getElementById(this.rectid));
			this.writeBg();
		}
	}
	/**
	 * PUBLIC
	 * Sets the inner image of this network element.
	 * The image appears in order to the name's location of the network element. When the name location
	 * is NAME_UP, the image is displayed below the name; when it is NAME_DOWN, the image is displayed
	 * at the top; and when it is NAME_CENTER, the image is displayed centered behind the name.
	 * @param (String) img the url of the image. It can be either the name of the image or the complete
	 * url of it.
	 */
	function setImageNE(img) {
		if (img.indexOf("/") != -1) {
			this.image = img;
		} else {
			this.image = URL_IMAGES + img;
		}
	}
	/**
	 * PUBLIC
	 * Sets the color of the network element's name.
	 * @param (String) color the color of the name. This color can be the hexadecimal representation
	 * or the name of the color, such as "#ffffff" and "white".
	 */
	function setTextColorNE(color) {
		this.textColor = color;
	}
	/**
	 * PUBLIC
	 * Sets whether the network element has border or not.
	 * @param (boolean) hasBorder indicates whether the network element has border or not.
	 */
	function setBorderNE(hasBorder) {
		if (!eval(hasBorder)) {
			this.borderColor = null;
		}
	}
	/**
	 * PUBLIC
	 * Sets the color of the border.
	 * @param (String) color the border's color. This color can be the hexadecimal representation
	 * or the name of the color, such as "#ffffff" and "white".
	 */
	function setBorderColorNE(color) {
		this.borderColor = color;
	}
	/**
	 * PUBLIC
	 * Sets the width and height of the network element rectagle. The minimum values are 20x20 pixels.
	 * @param (String or int) width the width of the rectangle in pixels.
	 * @param (String or int) height the height of the rectangle in pixels.
	 */
	function setBoundsNE(width, height) {
		var w = eval(width);
		var h = eval(height);
		this.width = w < 20 ? 20 : w;
		this.height = h < 20 ? 20 : h;
	}
	/**
	 * PROTECTED
	 * Allocates the network element at the specified coordenates inside the map.
	 * @param (String or int) x the x coordenate from the left top corner of the map.
	 * @param (String or int) y the y coordenate from the left top corner of the map.
	 */
	function allocateNE(x, y) {
		if (x != null && y != null) {
			this.x = x;
			this.y = y;
		}
		document.getElementById(this.id).style.pixelLeft = this.x;
		document.getElementById(this.id).style.pixelTop = this.y;
	}
	/**
	 * PUBLIC
	 * Adds a port to this network element.
	 * @param (Port) port the port which has to be added.
	 */
	function addPortToNe(port) {
		port.setNetworkElement(this);
		this.ports.add(port, true);
	}
	/**
	 * PUBLIC
	 * Removes a port from this network element.
	 * @param (Port) port the port which is going to be removed.
	 */
	function removePortFromNE(port) {
		this.ports.remove(this.ports.indexOf(port));
	}
	/**
	 * PROTECTED
	 * Writes the HTML code for this network element. A network element is created in five steps:
	 * the main span writing, the background writing, the background image writing, the name writing
	 * and the overglass writing. The overglass is an invisible layer set over all the previous
	 * layers.
	 */
	function writeNE() {
		this.writeMainSpan();
		this.writeBg();
		if (this.image != null) {
			this.writeImage();
		}
		this.writeName();
		this.writeOverglass();
		this.allocate();
	}
	/**
	 * PRIVATE
	 * Writes the main span. This is only the HTML space where the network element's elements will
	 * be written.
	 */
	function writeMainSpanNE() {
		var mainnesp = document.createElement("span");
		mainnesp.setAttribute("id", this.id);
		var elem = document.getElementById(MAP).appendChild(mainnesp);
		elem.style.position = "absolute";
		elem.style.width = this.width;
		elem.style.height = this.height;
		elem.style.zIndex = 5;
		elem.parentObj = this;
	}
	/**
	 * PRIVATE
	 * Writes the network element's background inside the main span of the network element.
	 */
	function writeBgNE() {
		if (this.bgForm == ROUNDRECT) {
			var rect = document.createElement("v:roundrect");
			rect.setAttribute("id", this.rectid);
			rect.setAttribute("arcSize", this.roundCornerPercentage);
			var elem = document.getElementById(this.id).appendChild(rect);
			elem.style.position = "absolute";
			elem.style.top = 0;
			elem.style.left = 0;
			elem.style.width = this.width;
			elem.style.height = this.height;
			elem.style.zIndex = 5;
			elem.style.cursor = "move";
			if (this.bgType == BG_NONE) {
				elem.fill.type = BG_SOLID;
				elem.fill.opacity = "0%";
			} else {
				elem.fill.type = this.bgType;
				elem.fill.color = this.bgColor1;
				elem.fill.color2 = this.bgColor2;
				elem.fill.angle = 0;
				elem.shadow.on = "t";
				elem.shadow.type = "single";
				elem.shadow.color = "Gray";
				elem.shadow.offset = "(2pt,2pt)";
			}
			elem.stroked = this.borderColor != null ? "true" : "false";
			if (this.borderColor != null) {
				elem.strokeColor = this.borderColor;
			}
			elem.parentObj = this;
		} else if (this.bgForm == ROMBO) {
			var rombo = document.createElement("v:polyline");
			rombo.setAttribute("id", this.rectid);
			var midWidth = Math.round(this.width/2);
			var midHeight = Math.round(this.height/2);
			var points = midWidth + ",0 " + this.width + "," + midHeight + " " + midWidth + "," + this.height + " 0," + midHeight + " " + midWidth + ",0";
			rombo.setAttribute("points", points);
			var elem = document.getElementById(this.id).appendChild(rombo);
			elem.style.position = "absolute";
			elem.style.top = 0;
			elem.style.left = 0;
			elem.style.width = this.width;
			elem.style.height = this.height;
			elem.style.zIndex = 5;
			elem.style.cursor = "move";
			if (this.bgType == BG_NONE) {
				elem.fill.type = BG_SOLID;
				elem.fill.opacity = "0%";
			} else {
				elem.fill.type = this.bgType;
				elem.fill.color = this.bgColor1;
				elem.fill.color2 = this.bgColor2;
				elem.fill.angle = 0;
				elem.shadow.on = "t";
				elem.shadow.type = "single";
				elem.shadow.color = "Gray";
				elem.shadow.offset = "(2pt,2pt)";
			}
			elem.stroked = this.borderColor != null ? "true" : "false";
			if (this.borderColor != null) {
				elem.strokeColor = this.borderColor;
			}
			elem.parentObj = this;
		}
	}
	/**
	 * PRIVATE
	 * Writes the background image iside the network element's main span.
	 */
	function writeImageNE() {
		var elem = document.getElementById(this.id).appendChild(document.createElement("span"));
		elem.style.position = "absolute";
		elem.style.left = 0;
		elem.style.width = this.width;
		elem.style.backgroundImage = "url(" + this.image + ")";
		var pos = NAME_CENTER;
		if (this.nameLocation == NAME_UP) {
			elem.style.top = 12;
			elem.style.height = this.height - 12;
			pos = NAME_DOWN;
		} else if (this.nameLocation == NAME_DOWN) {
			elem.style.top = 2;
			elem.style.height = this.height - 12;
			pos = NAME_UP;
		} else if (this.nameLocation == NAME_CENTER) {
			elem.style.top = 0;
			elem.style.height = this.height;
		}
		elem.style.backgroundPosition = pos;
		elem.style.backgroundRepeat = "no-repeat";
		elem.style.zIndex = 6;
	}
	/**
	 * PRIVATE
	 * Writes the name of the network element inside its main span and at the specified location.
	 */
	function writeNameNE() {
		var namesp = document.createElement("span");
		namesp.setAttribute("id", this.id + "name");
		var elem = document.getElementById(this.id).appendChild(namesp);
		elem.style.position = "absolute";
		if (this.nameLocation == NAME_UP) {
			elem.style.top = 0;
			elem.style.paddingTop = "1px";
		} else if (this.nameLocation == NAME_DOWN) {
			elem.style.top = this.height - 20;
			elem.style.paddingTop = "7px";
		} else if (this.nameLocation == NAME_CENTER) {
			elem.style.top = this.height / 2 - 10;
			elem.style.paddingTop = "5px";
		}
		elem.style.left = 0;
		elem.style.width = this.width;
		elem.style.height = 20;
		elem.style.zIndex = 7;
		elem.style.cursor = "move";
		elem.style.color = this.textColor;
		elem.style.textAlign = "center";
		elem.style.fontFamily = "Arial";
		elem.style.fontSize = "10px";
		elem.innerText = this.name;
		elem.parentObj = this;
	}
	/**
	 * PRIVATE
	 * Write the network element's overglass.
	 */
	function writeOverglass() {
		var rect = document.createElement("v:rect");
		rect.setAttribute("id", this.id + "og");
		var elem = document.getElementById(this.id).appendChild(rect);
		elem.style.position = "absolute";
		elem.style.top = 0;
		elem.style.left = 0;
		elem.style.width = this.width;
		elem.style.height = this.height;
		elem.style.zIndex = 8;
		elem.fill.type = "solid";
		elem.fill.color = "white";
		elem.fill.opacity = "0%";
		elem.stroked = "false";
		elem.style.cursor = "move";
		if (this.onClicked != null) {
			elem.attachEvent("onclick", this.onClicked);
		}
		elem.parentObj = this;
	}
	/**
	 * PROTECTED
	 * Allocates the network element's ports at the correct postions.
	 */
	function allocateNePorts() {
		var topPortList = new List();
		var leftPortList = new List();
		var rightPortList = new List();
		var bottomPortList = new List();
		for (var i = 0; i < this.ports.getLength(); i++) {
			var port = this.ports.get(i);
			port.calculateCoords();
			if (port.side == TOP) {
				topPortList.add(port, false);
			} else if (port.side == LEFT) {
				leftPortList.add(port, false);
			} else if (port.side == RIGHT) {
				rightPortList.add(port, false);
			} else if (port.side == BOTTOM) {
				bottomPortList.add(port, false);
			}
		}
		for (var i = 0; i < topPortList.getLength(); i++) {
			topPortList.get(i).allocate(topPortList.getLength(), i+1);
		}
		for (var i = 0; i < leftPortList.getLength(); i++) {
			leftPortList.get(i).allocate(leftPortList.getLength(), i+1);
		}
		for (var i = 0; i < rightPortList.getLength(); i++) {
			rightPortList.get(i).allocate(rightPortList.getLength(), i+1);
		}
		for (var i = 0; i < bottomPortList.getLength(); i++) {
			bottomPortList.get(i).allocate(bottomPortList.getLength(), i+1);
		}
	}
	/**
	 * PROTECTED
	 * Updates all the ports position. This method also updates the port's position at the other
	 * side of the connection, because this method is invoked when the network element changes
	 * its position and this could affect to the whole connection.
	 */
	function updateNePorts() {
		var updatedNesList = new List();
		this.allocatePorts();
		for (var i = 0; i < this.ports.getLength(); i++) {
			var port = this.ports.get(i);
			var ne = port.connection.originPort == port ? port.connection.destinationPort.ne : port.connection.originPort.ne;
			if (!updatedNesList.contains(ne)) {
				updatedNesList.add(ne, false);
				ne.allocatePorts();
			}
		}
	}
	/**
	 * PROTECTED
	 * Sets this network element as selected and changes the needful properties, such as
	 * the background color.
	 */
	function selectNE() {
		var ne = document.getElementById(this.rectid);
		ne.fill.color = "#FF5500";
		ne.fill.color2 = "#FFDDCC";
		if (this.bgType == BG_NONE) {
			ne.fill.opacity = "30%";
		}
		this.selected = true;
		if (this.miniNE != null) {
			this.miniNE.writeMiniNetworkElement(this);
		}
	}
	/**
	 * PROTECTED
	 * Sets this network element as unselected and reverts the changes maked when selected.
	 */
	function unselectNE() {
		var ne = document.getElementById(this.rectid);
		ne.fill.color = this.bgColor1;
		ne.fill.color2 = this.bgColor2;
		if (this.bgType == BG_NONE) {
			ne.fill.opacity = "0%";
		}
		this.selected = false;
		if (this.miniNE != null) {
			this.miniNE.writeMiniNetworkElement(this);
		}
	}
	/**
	 * PROTECTED
	 * Checks if this network element is selected or not.
	 * @return (boolean) true if this network element is selected. False other way.
	 */
	function isSelectedNE() {
		return this.selected;
	}
	/**
	 * PUBLIC
	 * Adds an item to the popup menu associated to this network element.
	 * @param (String) img the url or name of the image which will be displayed at the begining
	 * of the line where this item is set inside the popup menu. Can be null.
	 * @param (String) text the text of the item.
	 * @param (String) action the name of the action which will be performed when this item is
	 * selected. This action can be either a predefined action (such as LEFT_ANGLE and other) or
	 * the name of a javascript function.
	 */
	function addPopupListItemNE(img, text, action) {
		this.popupListItems.add(new PopupMenuItem(img, text, action), false);
	}
	/**
	 * PROTECTED
	 * Shows at the specified coordenates the popup menu associated to this network element.
	 * @param (String or int) x the x coordenate of the popup menu inside the map.
	 * @param (String or int) y the y coordenate of the popup menu inside the map.
	 */
	function showPopupMenuNE(x, y) {
		if (this.popupListItems.getLength() > 0) {
			document.getElementById(MAP).map.setPopupMenu(this.popupListItems, x, y);
		}
	}
	/**
	 * PROTECTED
	 * Executes the selected action of the popup menu.
	 * @param (String) action the action selected of the popup menu associated to this connection.
	 */
	function executeActionOnRightClickedNE(action) {
		document.getElementById(MAP).map.hidePopupMenu();
		eval(action + "()");
		rightClickedElementId = null;
	}
	/**
	 * PUBLIC
	 * Removes this NetworkElement from the map.
	 */
	function removeNE() {
		var cont = 0;
		while (this.ports.getLength() > 0) {
			this.ports.get(0).connection.remove();
		}
		document.getElementById(MAP).map.removeNetworkElement(this);
		document.getElementById(MAP).removeChild(document.getElementById(this.id));
	}



/****************************************************************************************************/	
/*                                              Map object                                          */
/****************************************************************************************************/
	/**
	 * PUBLIC
	 * The map is the main object which controls every other objects. Both network elements, ports
	 * and connections are displayed inside the map, but allthough the minimap and the extended
	 * information are not displayed inside, they at least are controlled by this.
	 * There is only allowed a single map for a web page. There could be more, but it is not
	 * necessary to trash our time, the result will be some kind of disaster.
	 * There are some configurable parameters for a map, such as the border visibility, the border
	 * color, the background color, the background image, the extended information visibility and
	 * availability or the moveness of the different elements.
	 * The map is identified by the MAP constant.
	 * @see MAP
	 */
	function Map() {
		this.dragEnabled = true;
		this.tagName = null;
		this.tagNameXPos = 0;
		this.tagNameYPos = 0;
		this.networkElements = new List();
		this.selectedNetworkElements = null;
		this.selection = null;
		this.dottedSelection = null;
		this.mapWidth = 0;
		this.mapHeight = 0;
		this.fixedWidth = null;
		this.fixedHeight = null;
		this.minimapWidth = MINIMAP_SIDE;
		this.bgImage = null;
		this.bgImageXCoord = null;
		this.bgImageYCoord = null;
		this.borderColor = "#003366";
		this.bgColor = "#e3e3e3";
		this.hasExtendedInformation = true;
		this.minimap = new MiniMap();
		this.addNetworkElement = addNeToMap;
		this.popupMenu = new PopupMenu();
		this.popupListItems = new List();
		this.write = writeMap;
		this.setSelection = setMapSelection;
		this.setDottedSelection = setMapDottedSelection;
		this.releaseSelection = releaseMapSelection;
		this.addToSelection = addNeToMapSelection;
		this.allocateSelection = updateSelectedNes;
		this.writeMiniMap = writeMiniMapOnMap;
		this.storeMapBounds = storeMapBounds;
		this.updateMiniMap = updateMiniMapCoords;
		this.setBounds = setMapBounds;
		this.setBackgroundImage = setMapBackgroundImage;
		this.setBackgroundColor = setMapBackgroundColor;
		this.setBorder = setMapBorder;
		this.setBorderColor = setMapBorderColor;
		this.setExtendedInformation = setMapExtendedInformation;
		this.setExtendedInformationWidth = setMapExtendedInformationWidth;
		this.setFixedBounds = setMapFixedBounds;
		this.scrollTo = scrollMapTo;
		this.setPopupMenu = setMapPopupMenu;
		this.showPopupMenuAt = showMapPopupMenu;
		this.hidePopupMenu = hideMapPopupMenu;
		this.setTagName = setMapTagName;
		this.setDragEnabled = setDragEnabled;
		this.addPopupListItem = addMapPopupListItem;
		this.executeAction = executeActionOnRightClickedMap;
		this.removeNetworkElement = removeNetworkElementFromMap;
		this.findNetworkElement = findNetworkElementInsideMap;
		init();
	}
	/**
	 * PUBLIC
	 * Sets whether the map has extended information or not.
	 * @param (boolean) hasExtInfo indicates whether the map has extended information or not.
	 */
	function setMapExtendedInformation(hasExtInfo) {
		this.hasExtendedInformation = eval(hasExtInfo);
	}
	/**
	 * PUBLIC
	 * Sets the extended information width.
	 * @param (String or int) width the extended information width.
	 */
	function setMapExtendedInformationWidth(width) {
		this.minimapWidth = eval(width);
		this.minimap.setSide(this.minimapWidth);
	}
	/**
	 * PUBLIC
	 * Adds a network element to the map.
	 * @param (NetworkElement) ne the network element which is going to be added.
	 */
	function addNeToMap(ne) {
		this.networkElements.add(ne, true);
	}
	/**
	 * PUBLIC
	 * Sets the visibility of the border. The border is allways present, but it can be visible
	 * or not. When the visibility is set to "hidden", the border is not showed but the map is
	 * surrounded by a white space of 4 pixels.
	 * @param (boolean) hasBorder indicates the visibility of the border.
	 */
	function setMapBorder(hasBorder) {
		if (!eval(hasBorder)) {
			this.borderColor = "#ffffff";
		}
		if (this.hasExtendedInformation) {
			this.minimap.setBorder(hasBorder);
		}
	}
	/**
	 * PUBLIC
	 * Sets the border's color.
	 * @param (String) color the new color of the border.
	 */
	function setMapBorderColor(color) {
		if (this.borderColor != "#ffffff") {
			this.borderColor = color;
			this.minimap.borderColor = color;
		}
	}
	/**
	 * PUBLIC
	 * Sets the map's background color.
	 * @param (String) color the background color. This color can be the hexadecimal representation
	 * or the name of the color, such as "#ffffff" and "white".
	 */
	function setMapBackgroundColor(color) {
		this.bgColor = color;
		if (this.hasExtendedInformation) {
			this.minimap.setBackgroundColor(color);
		}
	}
	/**
	 * PUBLIC
	 * Sets the background image of the map and allocates it at the specified coordenates from the
	 * upper left corner of the map.
	 * @param (String) img the background image.
	 * @param (String or int) x the x coordenate of the background image from the upper left corner
	 * of the map.
	 * @param (String or int) y the y coordenate of the background image from the upper left corner
	 * of the map.
	 */
	function setMapBackgroundImage(img, x, y) {
		if (img.indexOf("/") != -1) {
			this.bgImage = img;
		} else {
			this.bgImage = URL_IMAGES + img;
		}
		this.bgImageXCoord = x != null ? eval(x) : 0;
		this.bgImageYCoord = y != null ? eval(y) : 0;
		if (this.hasExtendedInformation) {
			this.minimap.setBackgroundImage(this.bgImage, this.bgImageXCoord, this.bgImageYCoord);
		}
	}
	/**
	 * PRIVATE
	 * Sets or updates the actual map's width and height. These parameters may change when an onResize
	 * event is fired.
	 */
	function setMapBounds() {
		var mapStyle = document.getElementById(MAP).style;
		var extendedInformationWidth = this.hasExtendedInformation ? this.minimapWidth : 0;
		mapStyle.width = this.fixedWidth == null ? document.body.clientWidth - extendedInformationWidth : this.fixedWidth;
		mapStyle.height = this.fixedHeight == null ? document.body.clientHeight : this.fixedHeight;
	}
	/**
	 * PUBLIC
	 * Sets the map's border width and height. This are the maximum width and height which can be seen
	 * at a time, but the map's real limits can be bigger and seen using the scroll bars.
	 * @param (String/int) width the fixed width.
	 * @param (String/int) height the fixed height.
	 */
	function setMapFixedBounds(width, height) {
		this.fixedWidth = width == null ? null : eval(width);
		this.fixedHeight = height == null ? null : eval(height);
	}
	/**
	 * PUBLIC
	 * Sets the map's name and its coordenates.
	 * @param (String) tag the tag name of the map.
	 * @param (String or int) x the x coordenate of the map's tag name.
	 * @param (String or int) y the y coordenate of the map's tag name.
	 */
	function setMapTagName(tag, x, y) {
		this.tagName = tag;
		this.tagNameXPos = x == null ? 0 : eval(x);
		this.tagNameYPos = y == null ? 0 : eval(y);
	}
	/**
	 * PUBLIC
	 * Writes the map's HTML code. This writing process involves the creation of every other object
	 * present inside the map: network elements, ports, connections, minimap and extended information.
	 */
	function writeMap() {
		var map = document.createElement("span");
		map.setAttribute("id", MAP);
		var mapsp = document.body.appendChild(map);
		mapsp.style.position = "absolute";
		mapsp.style.top = 0;
		mapsp.style.left = 0;
		mapsp.style.border = "medium double " + this.borderColor;
		mapsp.style.backgroundColor = this.bgColor;
		mapsp.style.overflow = "auto";
		mapsp.attachEvent("onscroll", updMiniMap);
		mapsp.map = this;
		this.setBounds();
		if (this.bgImage != null) {
			var image = new Image();
			image.src = this.bgImage;
			var img = document.createElement("img");
			img.setAttribute("border", "0");
			img.setAttribute("src", image.src);
			var imgsp = document.getElementById(MAP).appendChild(img);
			imgsp.style.position = "absolute";
			imgsp.style.left = this.bgImageXCoord;
			imgsp.style.top = this.bgImageYCoord;
			var ntw = 200;
			var nth = 50;
			if (this.tagName != null) {
				var nametagsp = document.getElementById(MAP).appendChild(document.createElement("span"));
				nametagsp.style.position = "absolute";
				nametagsp.style.left = this.tagNameXPos;
				nametagsp.style.top = this.tagNameYPos;
				nametagsp.style.width = ntw;
				nametagsp.style.height = nth;
				nametagsp.style.color = "#003366";
				nametagsp.style.fontFamily = "Arial";
				nametagsp.style.fontSize = "12px";
				nametagsp.style.fontWeight = "bold";
				nametagsp.innerText = this.tagName;
			}
			var cover = document.createElement("v:rect");
			cover.setAttribute("id", MAP);
			bgImgCover = document.getElementById(MAP).appendChild(cover);
			bgImgCover.style.position = "absolute";
			bgImgCover.style.left = 0;
			bgImgCover.style.top = 0;
			bgImgCover.style.width = this.bgImageXCoord + image.width > this.tagNameXPos + ntw ? this.bgImageXCoord + image.width : this.tagNameXPos + ntw;
			bgImgCover.style.height = this.bgImageYCoord + image.height > this.tagNameYPos + nth ? this.bgImageYCoord + image.height : this.tagNameYPos + nth;
			bgImgCover.fill.opacity = "0%";
			bgImgCover.stroked = "false";
		}
		for (var i = 0; i < this.networkElements.getLength(); i++) {
			var ne = this.networkElements.get(i);
			ne.write();
			for (var j = 0; j < ne.ports.getLength(); j++) {
				ne.ports.get(j).write();
			}
			ne.allocatePorts();
		}
		this.selection = new Selection();
		this.selection.setMinimapSide(this.minimapWidth);
		this.selection.write();
		this.storeMapBounds();
		if (this.hasExtendedInformation) {
			this.writeMiniMap();
		}
	}
	/**
	 * PROTECTED
	 * Sets a map selection, that is, selects every network elements inside the actual selection bounds.
	 * @see Selection
	 */
	function setMapSelection() {
		this.selectedNetworkElements = new List();
		var oX = this.selection.getOriginX();
		var oY = this.selection.getOriginY();
		var fX = oX + this.selection.getFinalX();
		var fY = oY + this.selection.getFinalY();
		for (var i = 0; i < this.networkElements.getLength(); i++) {
			var ne = this.networkElements.get(i);
			if (ne.x >= oX && ne.y >= oY && ne.x + ne.width <= fX && ne.y + ne.height <= fY) {
				this.selectedNetworkElements.add(ne);
				ne.select();
			}
		}
	}
	/**
	 * PROTECTED
	 * Sets a new map's dotted selection and writes it inside the map with all the dotted network elements
	 * it involves. Initially the dotted selection is not visible. It will only turn to visible while dragged.
	 */
	function setMapDottedSelection() {
		this.dottedSelection = new DottedSelection();
		this.dottedSelection.write();
		for (var i = 0; i < this.selectedNetworkElements.getLength(); i++) {
			this.dottedSelection.addDottedNe(this.selectedNetworkElements.get(i));
		}
	}
	/**
	 * PROTECTED
	 * Adds a network element to the current selection. If the current selection is null, a new one is created.
	 * @param (NetworkElement) ne the network element which is going to be selected.
	 */
	function addNeToMapSelection(ne) {
		if (this.selectedNetworkElements == null) {
			this.selectedNetworkElements = new List();
		}
		if (this.dottedSelection == null) {
			this.dottedSelection = new DottedSelection();
			this.dottedSelection.write();
		}
		this.selectedNetworkElements.add(ne);
		ne.select();
		this.dottedSelection.addDottedNe(ne);
	}
	/**
	 * PROTECTED
	 * Releases the current map selection and unselects the currently selected network elements.
	 */
	function releaseMapSelection() {
		if (this.selectedNetworkElements != null) {
			for (var i = 0; i < this.selectedNetworkElements.getLength(); i++) {
				this.selectedNetworkElements.get(i).unselect();
			}
		}
		if (this.dottedSelection != null) {
			this.dottedSelection.release();
		}
		this.selectedNetworkElements = null;
		this.selection.release();
		this.dottedSelection = null;
	}
	/**
	 * PROTECTED
	 * Updates the position of all the selected network elements and their ports.
	 */
	function updateSelectedNes() {
		if (this.dottedSelection.x != 0 && this.dottedSelection.y != 0) {
			var mapScL = document.getElementById("MAP").scrollLeft;
			var mapScT = document.getElementById("MAP").scrollTop;
			for (var i = 0; i < this.selectedNetworkElements.getLength(); i++) {
				var ne = this.selectedNetworkElements.get(i);
				if (this.dottedSelection.isHidden()) {
					ne.allocate(ne.x + this.dottedSelection.x + mapScL, ne.y + this.dottedSelection.y + mapScT);
				} else {
					ne.allocate(ne.x + this.dottedSelection.x - BORDER_WH + mapScL, ne.y + this.dottedSelection.y - BORDER_WH + mapScT);
				}
				if (ne.miniNE != null) {
					ne.miniNE.writeMiniNetworkElement(ne);
				}
			}
			for (var i = 0; i < this.selectedNetworkElements.getLength(); i++) {
				this.selectedNetworkElements.get(i).updatePorts();
			}
		}
		this.dottedSelection.release();
		this.setDottedSelection();
	}
	/**
	 * PROTECTED
	 * Writes the minimap and all its minielements if the map has the extended information enabled.
	 * Other way it does anything.
	 * @param (boolean) onResizingProcess indicates whether the writing process is called from an
	 * onresize event or not. This is necessary in order to rewrite the miniwindow.
	 */
	function writeMiniMapOnMap(onResizingProcess) {
		if (this.hasExtendedInformation) {
			var orp = onResizingProcess != null ? onResizingProcess : false;
			this.minimap.release();
			this.minimap.write(this.fixedWidth, this.fixedHeight);
			this.minimap.setBounds(orp);
			this.minimap.writeBackground();
			for (var i = 0; i < this.networkElements.getLength(); i++) {
				window.status = "Cargando vista a escala: " + ((i+1) * 100 / this.networkElements.getLength()) + "%";
				this.minimap.addMiniNetworkElement(this.networkElements.get(i));
			}
			this.minimap.writeMiniWindow(this.mapWidth, this.mapHeight, orp);
		}
	}
	/**
	 * PROTECTED
	 * Stores the current map's real bounds. These could change when one or more network elements
	 * are dragged.
	 */
	function storeMapBounds() {
		this.mapWidth = document.getElementById(MAP).scrollWidth;
		this.mapHeight = document.getElementById(MAP).scrollHeight;
	}
	/**
	 * PROTECTED
	 * Updates the miniwindow coordenates inside the minimap.
	 */
	function updateMiniMapCoords() {
		if (this.hasExtendedInformation) {
			this.minimap.updateMiniWindow();
		}
	}
	/**
	 * PROTECTED
	 * Scrolls the map to the specified coordenates once changed the aspect ratio. This method is
	 * invoked when the miniwindow is dragged and the map's scroll bars have to change their position
	 * to keep the current one determined by the miniwindow.
	 * @param (String or int) x the current miniwindow x coordenate inside the minimap.
	 * @param (String or int) y the current miniwindow y coordenate inside the minimap.
	 */
	function scrollMapTo(x, y) {
		var scl = eval(x) / this.minimap.xRate;
		var sct = eval(y) / this.minimap.yRate;
		document.getElementById(MAP).scrollLeft = scl;
		document.getElementById(MAP).scrollTop = sct;
	}
	/**
	 * PROTECTED
	 * Inside the map there is only one popup menu. It is initially empty and has no items inside. When
	 * a popup menu of any element (either the map or a network element or a connection) is called to be
	 * displayed, the popup menu of the main map attaches the element's popup menu items to itself and
	 * shows them at the specified coordenates inside the map.
	 * @param (List) items the current array of items of the element's popup menu.
	 * @param (String or int) x the x coordenate inside the map where the popup menu must be displayed.
	 * @param (String or int) y the y coordenate inside the map where the popup menu must be displayed.
	 * @see List
	 */
	function setMapPopupMenu(items, x, y) {
		this.popupMenu.attachListItems(items);
		this.popupMenu.write();
		this.popupMenu.allocate(x, y);
		this.popupMenu.show();
	}
	/**
	 * PROTECTED
	 * Makes visible the current popup menu.
	 * @param (String or int) x the x coordenate inside the map where the popup menu must be displayed.
	 * @param (String or int) y the y coordenate inside the map where the popup menu must be displayed.
	 */
	function showMapPopupMenu(x, y) {
		if (this.popupListItems.getLength() > 0) {
			this.setPopupMenu(this.popupListItems, x, y);
		}
	}
	/**
	 * PROTECTED
	 * Hides the current popup menu.
	 */
	function hideMapPopupMenu() {
		this.popupMenu.hide();
	}
	/**
	 * PUBLIC
	 * Sets whether the map's network elements can be dragged over the map or not.
	 * @param (boolean) dragEnabled indicates whether the map's network elements can be dragged over the map or not.
	 */
	function setDragEnabled(dragEnabled) {
		this.dragEnabled = eval(dragEnabled);
	}
	/**
	 * PUBLIC
	 * Removes a network element from the map.
	 * @param (NetworkElement) ne the network element which is going to be removed.
	 */
	function removeNetworkElementFromMap(ne) {
		this.releaseSelection();
		this.networkElements.remove(this.networkElements.indexOf(ne));
		if (this.hasExtendedInformation) {
			document.getElementById(MINIMAP).removeChild(document.getElementById("mini" + ne.id));
			var oldMapWidth = this.mapWidth;
			var oldMapHeight = this.mapHeight;
			this.storeMapBounds();
			if (oldMapWidth != document.getElementById(MAP).map.mapWidth || oldMapHeight != document.getElementById(MAP).map.mapHeight) {
				this.writeMiniMap();
			}
		}
	}
	/**
	 * PUBLIC
	 * Adds an item to the popup menu associated to this map.
	 * @param (String) img the url or name of the image which will be displayed at the begining
	 * of the line where this item is set inside the popup menu. Can be null.
	 * @param (String) text the text of the item.
	 * @param (String) action the name of the action which will be performed when this item is
	 * selected. This action can be either a predefined action (such as LEFT_ANGLE and other) or
	 * the name of a javascript function.
	 */
	function addMapPopupListItem(img, text, action) {
		this.popupListItems.add(new PopupMenuItem(img, text, action), false);
	}
	/**
	 * PROTECTED
	 * Executes the selected action of the popup menu.
	 * @param (String) action the action selected of the popup menu associated to this connection.
	 */
	function executeActionOnRightClickedMap(action) {
		this.hidePopupMenu();
		eval(action + "()");
		rightClickedElementId = null;
	}
	/**
	 * PUBLIC
	 * Finds a network element inside the map positioning it at the center of the map and highlighting
	 * it three times.
	 * @param (NetworkElement) ne the network element object which is going to be searched.
	 */
	function findNetworkElementInsideMap(ne) {
		document.getElementById(MAP).scrollTop = ne.y - 100;
		document.getElementById(MAP).scrollLeft = ne.x - 250;
		var nodeNumber = this.networkElements.indexOf(ne);
		var bgc1 = ne.bgColor1;
		var bgc2 = ne.bgColor2;
		var bgColor1 = ne.isSelected() ? "#FF5500" : bgc1;
		var bgColor2 = ne.isSelected() ? "#FFDDCC" : bgc2;
		ne.setBackgroundColor("#22cc00", "#aaff99");
		var fnc = "highlightFoundNetworkElement(" + nodeNumber + ", '" + bgColor1 + "', '" + bgColor2 + "')";
		setTimeout(fnc, 100);
		fnc = "highlightFoundNetworkElement(" + nodeNumber + ", '#22cc00', '#aaff99')";
		setTimeout(fnc, 200);
		fnc = "highlightFoundNetworkElement(" + nodeNumber + ", '" + bgColor1 + "', '" + bgColor2 + "')";
		setTimeout(fnc, 300);
		fnc = "highlightFoundNetworkElement(" + nodeNumber + ", '#22cc00', '#aaff99')";
		setTimeout(fnc, 400);
		fnc = "highlightFoundNetworkElement(" + nodeNumber + ", '" + bgColor1 + "', '" + bgColor2 + "')";
		setTimeout(fnc, 500);
		fnc = "highlightFoundNetworkElement(" + nodeNumber + ", '#22cc00', '#aaff99')";
		setTimeout(fnc, 600);
		fnc = "highlightFoundNetworkElement(" + nodeNumber + ", '" + bgColor1 + "', '" + bgColor2 + "')";
		setTimeout(fnc, 700);
		fnc = "resetFoundNetworkElement(" + nodeNumber + ", '" + bgc1 + "', '" + bgc2 + "')";
		setTimeout(fnc, 800);
	}
	/**
	 * PRIVATE
	 * This method ends the highlighting of a found network element resetting its background colors.
	 * @param (int) neNumber the position of the network element inside the network elements list of the map.
	 * @param (String) bgc1 the color1 of the background.
	 * @param (String) bgc2 the color2 of the background.
	 */
	function resetFoundNetworkElement(neNumber, bgc1, bgc2) {
		var ne = document.getElementById(MAP).map.networkElements.get(neNumber);
		ne.bgColor1 = bgc1;
		ne.bgColor2 = bgc2;
	}
	/**
	 * PRIVATE
	 * Changes the background colors of a network element.
	 * @param (int) neNumber the position of the network element inside the network elements list of the map.
	 * @param (String) color1 the color1 of the background.
	 * @param (String) color2 the color2 of the background.
	 */
	function highlightFoundNetworkElement(neNumber, color1, color2) {
		document.getElementById(MAP).map.networkElements.get(neNumber).setBackgroundColor(color1, color2);
	}
	
	
	
	
/****************************************************************************************************/	
/*                                          Minimap object                                          */
/****************************************************************************************************/
	/**
	 * PROTECTED Constructor
	 * The minimap is the scaled map displayed at the right side. It is a simple view of the
	 * whole map and provides an easier way for moving along the map when it has a big size.
	 * The minimap always maintains the aspect ratio with the map, even when the IE window is
	 * resized or the map's elements are dragged.
	 * There are some configurable parameters for this object, but they are never configured
	 * by the user but by the Map object, which is the only one who knows the existence of this
	 * Minimap object and controls it. The changes upon this configurable parameters are a
	 * consecuence of the same changes performed on the map, such as the border appearance or
	 * the background color and some others.
	 * By default the side's measures of the minimap are 200 pixels by side. It is always a
	 * square.
	 */
	function MiniMap() {
		this.xRate = null;
		this.yRate = null;
		this.side = MINIMAP_SIDE;
		this.borderColor = "#003366";
		this.bgColor = "#e3e3e3";
		this.bgImage = null;
		this.bgImageXCoord = null;
		this.bgImageYCoord = null;
		this.write = writeMiniMap;
		this.release = releaseMiniMap;
		this.setBounds = setMiniMapBounds;
		this.addMiniNetworkElement = addMiniNetworkElement;
		this.writeMiniNetworkElement = writeMiniNetworkElement;
		this.writeMiniWindow = writeMiniWindow;
		this.writeBackground = writeMinimapBackground;
		this.updateMiniWindow = updateMiniWindowCoords;
		this.setBorder = setMinimapBorder;
		this.setBackgroundColor = setMinimapBackgroundColor;
		this.setBackgroundImage = setMinimapBackgroundImage;
		this.setSide = setMinimapSide;
	}
	/**
	 * PROTECTED
	 * Sets the size of the minimap's side.
	 * @param (String or int) side the new minimap's side.
	 */
	function setMinimapSide(side) {
		this.side = eval(side);
	}
	/**
	 * PROTECTED
	 * Sets whether the visibility of the border is "visible" or "hidden". Allthough the border
	 * can be hidden, the minimap will have a white space of 4 pixels at each side surrounding it.
	 * The border width is always of 4 pixels.
	 * @param (boolean) hasBorder indicates whether the border must be visible or not.
	 */
	function setMinimapBorder(hasBorder) {
		if (!eval(hasBorder)) {
			this.borderColor = "#ffffff";
		}
	}
	/**
	 * PROTECTED
	 * Sets the minimap's background color.
	 * @param (String) color the new minimap's background color. This color can be the hexadecimal
	 * representation or the name of the color, such as "#ffffff" and "white".
	 */
	function setMinimapBackgroundColor(color) {
		this.bgColor = color;
	}
	/**
	 * Sets the new minimap's background image and allocates it at the scaled specified position.
	 * @param (String) img the url or name of the image.
	 * @param (String or int) x the x coordenate of the background image from the upper left corner
	 * of the minimap.
	 * @param (String or int) y the y coordenate of the background image from the upper left corner
	 * of the minimap.
	 */
	function setMinimapBackgroundImage(img, x, y) {
		this.bgImage = img;
		this.bgImageXCoord = eval(x);
		this.bgImageYCoord = eval(y);
	}
	/**
	 * PROTECTED
	 * Writes the minimap's HTML code.
	 * @param (String or int) mapFixedWidth the main map fixed width. Can be null when the main map
	 * has not been fixed to any bounds.
	 * @param (String or int) mapFixedHeight the main map fixed height. Can be null when the main map
	 * has not been fixed to any bounds.
	 */
	function writeMiniMap(mapFixedWidth, mapFixedHeight) {
		var mm = document.createElement("span");
		mm.setAttribute("id", MINIMAP);
		var mmsp = document.body.appendChild(mm);
		mmsp.style.position = "absolute";
		mmsp.style.top = mapFixedHeight == null ? document.body.clientHeight - this.side : mapFixedHeight - this.side;
		mmsp.style.left = mapFixedWidth == null ? document.body.clientWidth - this.side : mapFixedWidth;
		mmsp.style.width = this.side;
		mmsp.style.height = this.side;
		mmsp.style.border = "medium double " + this.borderColor;
		mmsp.style.backgroundColor = this.bgColor;
		mmsp.style.overflow = "hidden";
		mmsp.style.zIndex = 100;
	}
	/**
	 * PRIVATE
	 * Writes the minimap's background image.
	 */
	function writeMinimapBackground() {
		if (this.bgImage != null) {
			var image = new Image();
			image.src = this.bgImage;
			var img = document.createElement("img");
			img.setAttribute("border", "0");
			img.setAttribute("src", image.src);
			var imgsp = document.getElementById(MINIMAP).appendChild(img);
			imgsp.style.position = "absolute";
			imgsp.style.left = this.bgImageXCoord * this.xRate;
			imgsp.style.top = this.bgImageYCoord * this.yRate;
			imgsp.style.width = image.width * this.xRate;
			imgsp.style.height = image.height * this.yRate;
		}
	}
	/**
	 * PROTECTED
	 * Removes the minimap from the web page.
	 */
	function releaseMiniMap() {
		if (document.getElementById(MINIMAP) != null) {
			document.body.removeChild(document.getElementById(MINIMAP));
		}
	}
	/**
	 * PROTECTED
	 * Sets the minimap bounds and updates the current scale rates. This method is useful
	 * when a resize event is fired or a network element is dragged and changes the current
	 * map's bounds.
	 * @param (boolean) onResizingProcess indicates whether the invoking of this method comes
	 * from a resize event or not.
	 */
	function setMiniMapBounds(onResizingProcess) {
		var mapClientWidth = document.getElementById(MAP).clientWidth;
		var mapClientHeight = document.getElementById(MAP).clientHeight;
		if (onResizingProcess) {
			mapClientWidth -= document.getElementById(MAP).map.mapHeight > document.getElementById(MAP).clientHeight ? 17 : 0;
			mapClientHeight -= document.getElementById(MAP).map.mapWidth > mapClientWidth ? 17 : 0;
		}
		var mapWidth = mapClientWidth > document.getElementById(MAP).map.mapWidth ? mapClientWidth : document.getElementById(MAP).map.mapWidth;
		var mapHeight = mapClientHeight > document.getElementById(MAP).map.mapHeight ? mapClientHeight : document.getElementById(MAP).map.mapHeight;
		this.xRate = document.getElementById(MINIMAP).clientWidth / mapWidth;
		this.yRate = document.getElementById(MINIMAP).clientHeight / mapHeight;
	}
	/**
	 * PROTECTED
	 * Adds a mini netork element to the minimap.
	 * @param (NetworkElement) ne the real network element of the map which has to be inserted
	 * inside the minimap.
	 */
	function addMiniNetworkElement(ne) {
		if (ne.bgForm == ROUNDRECT) {
			var mne = document.createElement("v:roundrect");
			mne.setAttribute("arcSize", ne.roundCornerPercentage);
			mne.setAttribute("id", "mini" + ne.id);
			document.getElementById(MINIMAP).appendChild(mne);
		} else if (ne.bgForm == ROMBO) {
			var mne = document.createElement("v:polyline");
			var midWidth = Math.round(ne.width*this.xRate/2);
			var midHeight = Math.round(ne.height*this.yRate/2);
			var width = Math.round(ne.width * this.xRate);
			var height = Math.round(ne.height * this.yRate);
			var points = midWidth + ",0 " + width + "," + midHeight + " " + midWidth + "," + height + " 0," + midHeight + " " + midWidth + ",0";
			mne.setAttribute("points", points);
			mne.setAttribute("id", "mini" + ne.id);
			document.getElementById(MINIMAP).appendChild(mne);
		}
		this.writeMiniNetworkElement(ne);
		ne.miniNE = this;
	}
	/**
	 * PROTECTED
	 * Writes the mini network element with the same appearance of it's associated network element.
	 * @param (NetworkElement) the associated network element.
	 */
	function writeMiniNetworkElement(ne) {
		var mnesp = document.getElementById("mini" + ne.id);
		mnesp.style.position = "absolute";
		mnesp.style.left = eval(ne.x) * this.xRate;
		mnesp.style.top = eval(ne.y) * this.yRate;
		mnesp.style.width = ne.width * this.xRate;
		mnesp.style.height = ne.height * this.yRate;
		if (ne.bgType != BG_NONE) {
			mnesp.fill.type = ne.bgType;
			mnesp.fill.angle = 0;
			mnesp.shadow.on = "t";
			mnesp.shadow.type = "single";
			mnesp.shadow.color = "Gray";
			mnesp.shadow.offset = "(2pt,2pt)";
		} else {
			mnesp.fill.type = BG_SOLID;
			mnesp.fill.opacity = "15%";
		}
		if (ne.selected) {
			mnesp.fill.color = "#FF5500";
			mnesp.fill.color2 = "#FFDDCC";
		} else {
			mnesp.fill.color = ne.bgColor1;
			mnesp.fill.color2 = ne.bgColor2;
		}
		if (ne.borderColor != null) {
			mnesp.strokeColor = ne.borderColor;
		} else {
			mnesp.stroked = "false";
		}
		if (ne.nameLocation == NAME_CENTER && ne.image != null) {
			var mneimg = document.createElement("img");
			mneimg.setAttribute("border", "0");
			mneimg.setAttribute("src", ne.image);
			var mneimgsp = document.getElementById(MINIMAP).appendChild(mneimg);
			mneimgsp.style.position = "absolute";
			mneimgsp.style.left = eval(ne.x) * this.xRate;
			mneimgsp.style.top = eval(ne.y) * this.yRate;
			mneimgsp.style.width = ne.width * this.xRate;
			mneimgsp.style.height = ne.height * this.yRate;
		}
	}
	/**
	 * PROTECTED
	 * Writes the miniwindow. The miniwindow is the current view of the map scaled inside the minimap.
	 * It can be dragged to scroll over the main map. The outer zones of the miniwindow are displayed
	 * under a semitransparent film.
	 */
	function writeMiniWindow() {
		var mapWidth = document.getElementById(MAP).clientWidth * this.xRate;
		var mapHeight = document.getElementById(MAP).clientHeight * this.yRate;
		var scl = document.getElementById(MAP).scrollLeft * this.xRate;
		var sct = document.getElementById(MAP).scrollTop * this.yRate;
		var mw = document.createElement("v:rect");
		mw.setAttribute("id", MINIWINDOW + "_up");
		var mwsp = document.getElementById(MINIMAP).appendChild(mw);
		mwsp.style.position = "absolute";
		mwsp.style.left = 0;
		mwsp.style.top = 0;
		mwsp.style.width = this.side;
		mwsp.style.height = sct;
		mwsp.fill.type = "solid";
		mwsp.fill.color = "#003366";
		mwsp.fill.opacity = "20%";
		mwsp.stroked = "false";
		mw = document.createElement("v:rect");
		mw.setAttribute("id", MINIWINDOW + "_left");
		mwsp = document.getElementById(MINIMAP).appendChild(mw);
		mwsp.style.position = "absolute";
		mwsp.style.left = 0;
		mwsp.style.top = sct;
		mwsp.style.width = scl;
		mwsp.style.height = this.side;
		mwsp.fill.type = "solid";
		mwsp.fill.color = "#003366";
		mwsp.fill.opacity = "20%";
		mwsp.stroked = "false";
		mw = document.createElement("v:rect");
		mw.setAttribute("id", MINIWINDOW + "_right");
		mwsp = document.getElementById(MINIMAP).appendChild(mw);
		mwsp.style.position = "absolute";
		mwsp.style.left = scl + mapWidth;
		mwsp.style.top = sct;
		mwsp.style.width = this.side;
		mwsp.style.height = this.side;
		mwsp.fill.type = "solid";
		mwsp.fill.color = "#003366";
		mwsp.fill.opacity = "20%";
		mwsp.stroked = "false";
		mw = document.createElement("v:rect");
		mw.setAttribute("id", MINIWINDOW + "_bottom");
		mwsp = document.getElementById(MINIMAP).appendChild(mw);
		mwsp.style.position = "absolute";
		mwsp.style.left = scl;
		mwsp.style.top = sct + mapHeight;
		mwsp.style.width = mapWidth;
		mwsp.style.height = this.side;
		mwsp.fill.type = "solid";
		mwsp.fill.color = "#003366";
		mwsp.fill.opacity = "20%";
		mwsp.stroked = "false";
		mw = document.createElement("v:rect");
		mw.setAttribute("id", MINIWINDOW);
		mwsp = document.getElementById(MINIMAP).appendChild(mw);
		mwsp.style.position = "absolute";
		mwsp.style.left = scl;
		mwsp.style.top = sct;
		mwsp.style.cursor = "move";
		var maxWidth = this.side - 9;
		mwsp.style.width = mapWidth > maxWidth ? maxWidth : mapWidth;
		mwsp.style.height = mapHeight > maxWidth ? maxWidth : mapHeight;
		mwsp.fill.type = "solid";
		mwsp.fill.color = "#003366";
		mwsp.fill.opacity = "0%";
		mwsp.strokeColor = "#003366";
	}
	/**
	 * PROTECTED
	 * Updates the miniwindow coordenates.
	 */
	function updateMiniWindowCoords() {
		var scl = document.getElementById(MAP).scrollLeft * this.xRate;
		var sct = document.getElementById(MAP).scrollTop * this.yRate;
		document.getElementById(MINIWINDOW + "_up").style.height = sct;
		document.getElementById(MINIWINDOW + "_left").style.top = sct;
		document.getElementById(MINIWINDOW + "_left").style.width = scl;
		document.getElementById(MINIWINDOW + "_right").style.left = scl + document.getElementById(MINIWINDOW).clientWidth - 3;
		document.getElementById(MINIWINDOW + "_right").style.top = sct;
		document.getElementById(MINIWINDOW + "_bottom").style.left = scl;
		document.getElementById(MINIWINDOW + "_bottom").style.top = sct + document.getElementById(MINIWINDOW).clientHeight - 4;
		document.getElementById(MINIWINDOW).style.left = scl;
		document.getElementById(MINIWINDOW).style.top = sct;
	}
	
	/**
	 * PROTECTED Constructor
	 * A dotted network element is the transparent dotted representation of each network element
	 * which is involved into a dotted selection. It is represented as a dotted rectangle whti the
	 * same measures as the real network element.
	 */
	function DottedNetworkElement() {
		this.x = null;
		this.y = null;
		this.width = null;
		this.height = null;
		this.write = writeDottedNE;
		this.allocate = allocateDottedNE;
		this.setBounds = setBoundsDottedNE;
	}
	/**
	 * PROTECTED
	 * Writes the dotted network element inside the dottes selection.
	 */
	function writeDottedNE() {
		var dotsp = document.createElement("span");
		var elem = document.getElementById(DOTTED_SEL).appendChild(dotsp);
		elem.style.position = "absolute";
		elem.style.left = this.x;
		elem.style.top = this.y;
		elem.style.width = this.width;
		elem.style.height = this.height;
		elem.style.zIndex = 6;
		elem.style.borderWidth = "thin";
		elem.style.borderStyle = "dotted";
		elem.style.borderColor = "#003366";
		elem.style.cursor = "move";
	}
	/**
	 * PROTECTED
	 * Allocates the dotted network element inside the dotted selection.
	 * @param (String or int) x the x coordenate of the dotted network element.
	 * @param (String or int) y the y coordenate of the dotted network element.
	 */
	function allocateDottedNE(x, y) {
		this.x = eval(x);
		this.y = eval(y);
	}
	/**
	 * PROTECTED
	 * Sets the width and height of the dotted network element.
	 * @param (String or int) width the width of the dotted network element.
	 * @param (String or int) height the height of the dotted network element.
	 */
	function setBoundsDottedNE(width, height) {
		this.width = eval(width);
		this.height = eval(height);
	}
	
	/**
	 * PROTECTED Constructor
	 * The dotted selection is the result of each selection process. When the selection process ends
	 * a new DottedSelection object is created. For each network element involved inside the selection
	 * a DottedNetworkElement is created inside this object.
	 * The sense of this object's existence is that it is more expensive to drag multiple HTML objects
	 * than the dragging process of a single HTML element which has multiple elements inside it. When
	 * a selection of network elements is dragged, what is really being dragged is the dotted selection,
	 * which has all the dotted network elements allocated inside it, but this trick is transparent for
	 * the user.
	 */
	function DottedSelection() {
		this.id = DOTTED_SEL;
		this.x = 0;
		this.y = 0;
		this.minimumDottedX = null;
		this.minimumDottedY = null;
		this.write = writeDottedSelection;
		this.writeMainSpan = writeDottedMainSpan;
		this.list = new List();
		this.addDottedNe = addDottedNeToList;
		this.hide = hideDottedSelection;
		this.show = showDottedSelection;
		this.isHidden = isDottedSelectionHidden;
		this.allocate = allocateDottedSelection;
		this.release = releaseDottedSelection;
	}
	/**
	 * PROTECTED
	 * Adds a dotted network element to the dotted selection.
	 * @param (NetworkElement) ne the entwork element object which is going to be added as a
	 * DottedNetworkElement.
	 */
	function addDottedNeToList(ne) {
		var dot = new DottedNetworkElement();
		if (ne.x < this.minimumDottedX || this.minimumDottedX == null) {
			this.minimumDottedX = ne.x
		}
		if (ne.y < this.minimumDottedY || this.minimumDottedY == null) {
			this.minimumDottedY = ne.y
		}
		dot.allocate(ne.x, ne.y);
		dot.setBounds(ne.width, ne.height);
		dot.write();
	}
	/**
	 * PROTECTED
	 * Launches the dotted selection HTML code writing process.
	 */
	function writeDottedSelection() {
		this.writeMainSpan();
	}
	/**
	 * PROTECTED
	 * Writes the main span of the dotted selection.
	 */
	function writeDottedMainSpan() {
		var dotsp = document.createElement("span");
		dotsp.setAttribute("id", this.id);
		var elem = document.body.appendChild(dotsp);
		elem.style.position = "absolute";
		elem.style.top = 0;
		elem.style.left = 0;
		elem.style.width = document.body.clientWidth;
		elem.style.height = document.body.clientHeight;
		elem.style.zIndex = 20;
		elem.style.visibility = "hidden";
	}
	/**
	 * PROTECTED
	 * Hides the current dotted selection.
	 */
	function hideDottedSelection() {
		document.getElementById(this.id).style.visibility = "hidden";
	}
	/**
	 * PROTECTED
	 * Shows the current dotted selection.
	 */
	function showDottedSelection() {
		document.getElementById(this.id).style.visibility = "visible";
	}
	/**
	 * PROTECTED
	 * Checks whether the current dotted selection is visible or hidden.
	 * @return true if the current dotted selection is hidden. False if it is visible.
	 */
	function isDottedSelectionHidden() {
		return document.getElementById(this.id).style.visibility == "hidden";
	}
	/**
	 * PROTECTED
	 * Allocates the dotted selection at the specified coordenates.
	 * @param (String or int) x the x coordenate of the dotted selection.
	 * @param (String or int) y the y coordenate of the dotted selection.
	 */
	function allocateDottedSelection(x, y) {
		var minX = this.minimumDottedX * (-1) + BORDER_WH - document.getElementById(MAP).scrollLeft;
		var minY = this.minimumDottedY * (-1) + BORDER_WH - document.getElementById(MAP).scrollTop;
		this.x = eval(x) < minX ? minX : eval(x);
		this.y = eval(y) < minY ? minY : eval(y);
		document.getElementById(this.id).style.pixelLeft = this.x;
		document.getElementById(this.id).style.pixelTop = this.y;
	}
	/**
	 * PROTECTED
	 * Releases the current dotted selection.
	 */
	function releaseDottedSelection() {
		document.body.removeChild(document.getElementById(this.id));
	}
	
	/**
	 * PROTECTED Constructor
	 * This object allows the selection of one or more network elements of the map for dragging
	 * them. A selection is represented by a semitransparent rectangle only visible while the
	 * mouse down - mouse drag - mouse up process is active. In fact, each time the selection
	 * begins (with the mouse down event) a new Select object HTML representation is created, and
	 * when the mouse up event is detected the Selection object representation is released.
	 * When released it generates a new DottedSelection object which controls every network
	 * elements involved inside the selection limits, creating a DottedNetworkElement for each
	 * selected network element.
	 */
	function Selection() {
		this.originX = null;
		this.originY = null;
		this.finalX = null;
		this.finalY = null;
		this.minimapSide = MINIMAP_SIDE;
		this.setOrigin = setOriginCoords;
		this.setFinal = setFinalCoords;
		this.getOriginX = getOriginX;
		this.getFinalX = getFinalX;
		this.getOriginY = getOriginY;
		this.getFinalY = getFinalY;
		this.show = showSelection;
		this.hide = hideSelection;
		this.write = writeSelection;
		this.allocate = allocateSelection;
		this.release = releaseSelection;
		this.setMinimapSide = setMinimapSideSelection;
	}
	/**
	 * PROTECTED
	 * Stores the current minimap's length of the side: This is used to set the Selection object
	 * measures.
	 * @param (String or int) side the minimap's length.
	 */
	function setMinimapSideSelection(side) {
		this.minimapSide = eval(side);
	}
	/**
	 * PROTECTED
	 * Writes the selection. While the selecting process the extended information is covered with
	 * a transparent rectangle to prevent the mouse over event on any other extended information
	 * element.
	 */
	function writeSelection() {
		var rect = document.createElement("v:rect");
		rect.setAttribute("id", SELECTION);
		var elem = document.getElementById(MAP).appendChild(rect);
		elem.style.position = "absolute";
		elem.style.zIndex = 15;
		elem.style.visibility = "hidden";
		elem.style.cursor = "crosshair";
		elem.fill.type = "solid";
		elem.fill.color = "#003366";
		elem.fill.opacity = "20%";
		elem.strokeColor = "#003366";
		rect = document.createElement("v:rect");
		rect.setAttribute("id", "overglass");
		var elem = document.body.appendChild(rect);
		elem.style.position = "absolute";
		elem.style.top = 0;
		elem.style.left = document.body.clientWidth - this.minimapSide;
		elem.style.width = this.minimapSide;
		elem.style.height = document.body.clientHeight;
		elem.style.zIndex = 150;
		elem.style.visibility = "hidden";
		elem.style.cursor = "crosshair";
		elem.fill.type = "solid";
		elem.fill.color = "#003366";
		elem.fill.opacity = "0%";
		elem.stroked = "false";
	}
	/**
	 * PROTECTED
	 * Allocates the current selection by setting the top, left, width and height of the
	 * rectangle.
	 */
	function allocateSelection() {
		document.getElementById(SELECTION).style.left = this.getOriginX();
		document.getElementById(SELECTION).style.top = this.getOriginY();
		document.getElementById(SELECTION).style.width = this.getFinalX();
		document.getElementById(SELECTION).style.height = this.getFinalY();
	}
	/**
	 * PROTECTED
	 * Sets the origin coordenates, or at least the coordenates where the selection process began.
	 * @param (String or int) x the x coordenate where the selection process began.
	 * @param (String or int) y the y coordenate where the selection process began.
	 */
	function setOriginCoords(x, y) {
		this.originX = eval(x);
		this.originY = eval(y);
	}
	/**
	 * PROTECTED
	 * Sets the final coordenates, or at least the coordenates where the selection process is currently.
	 * @param (String or int) x the x coordenate where the selection process is currently.
	 * @param (String or int) y the y coordenate where the selection process is currently.
	 */
	function setFinalCoords(x, y) {
		this.finalX = eval(x);
		this.finalY = eval(y);
	}
	/**
	 * PROTECTED
	 * Makes visible the selection. This happens when the mouse move event is fired.
	 */
	function showSelection() {
		document.getElementById(SELECTION).style.visibility = "visible";
		document.getElementById("overglass").style.visibility = "visible";
	}
	/**
	 * PROTECTED
	 * Hides the selection and releases it.
	 */
	function hideSelection() {
		document.getElementById(SELECTION).style.visibility = "hidden";
		document.getElementById("overglass").style.visibility = "hidden";
		document.getElementById(SELECTION).style.left = 0;
		document.getElementById(SELECTION).style.top = 0;
		document.getElementById(SELECTION).style.width = 1;
		document.getElementById(SELECTION).style.height = 1;
	}
	/**
	 * PROTECTED
	 * Gets the upper left x coordenate of the rectangle, which is given by the minimum value
	 * between the initial and final x coordenates of the selection process.
	 */
	function getOriginX() {
		return Math.min(this.originX, this.finalX);
	}
	/**
	 * PROTECTED
	 * Gets the upper left y coordenate of the rectangle, which is given by the minimum value
	 * between the initial and final y coordenates of the selection process.
	 */
	function getOriginY() {
		return Math.min(this.originY, this.finalY);
	}
	/**
	 * PROTECTED
	 * Gets the width of the selection rectangle.
	 */
	function getFinalX() {
		return Math.abs(this.finalX - this.originX);
	}
	/**
	 * PROTECTED
	 * Gets height of the selection rectangle.
	 */
	function getFinalY() {
		return Math.abs(this.finalY - this.originY);
	}
	/**
	 * PROTECTED
	 * Releases the selection.
	 */
	function releaseSelection() {
		try {
			this.setOrigin(window.event.offsetX, window.event.offsetY);
			this.setFinal(window.event.offsetX + 1, window.event.offsetX + 1);
		} catch (e) {
		}
	}
	
	/**
	 * PROTECTED Constructor
	 * Each popup menu item is displayed in a single line inside the popup menu and is composed
	 * by three elements: an eventual image (can be null if this item has no image attached), the
	 * text which will be displayed and the action which will be invoked when clicked.
	 * @param (String) img the url or the name of the image. Can be null.
	 * @param (String) text the text which will be displayed.
	 * @param (String) action the action which will be invoked when clicked. This can be either the
	 * name of any predefined action or a javascript function name.
	 */
	function PopupMenuItem(img, text, action) {
		this.img = img;
		this.text = text;
		this.action = action;
	}
	
	/**
	 * PROTECTED Constructor
	 * The popup menu owned by the Map object. Since this popup menu is displayed only when a right
	 * click is detected over any element of the map that has a popup menu items list attached, by
	 * default this object has no items list to display. This list is inherited from the richt
	 * clicked object.
	 * The identifier of the popup menu is "popupmenu". It is unique because there is no other
	 * popup menu.
	 */
	function PopupMenu() {
		this.id = "popupmenu";
		this.items = null;
		this.attachListItems = attachListItemsToPopupMenu;
		this.write = writePopupMenu;
		this.show = showPopupMenu;
		this.hide = hidePopupMenu;
		this.allocate = allocatePopupMenu;
	}
	/**
	 * PROTECTED
	 * Attaches the currently selected List of items to this popup menu object.
	 * @param (List) list the currently selected List of items.
	 */
	function attachListItemsToPopupMenu(list) {
		this.items = list;
	}
	/**
	 * PROTECTED
	 * Writes a popup menu with the current List of items temporarily hidden.
	 */
	function writePopupMenu() {
		if (document.getElementById(this.id) == null) {
			var pum = document.createElement("span");
			pum.setAttribute("id", this.id);
			var pumsp = document.getElementById(MAP).appendChild(pum);
			pumsp.style.position = "absolute";
			pumsp.style.top = 0;
			pumsp.style.left = -1;
			pumsp.style.width = 220;
			pumsp.style.zIndex = 500;
			pumsp.style.backgroundColor = "White";
			pumsp.style.paddingTop = 2;
			pumsp.style.paddingRight = 10;
			pumsp.style.paddingLeft = 5;
			pumsp.style.visibility = "hidden";
			pumsp.style.borderBottomStyle = "groove";
			pumsp.style.borderBottomColor = "Gray";
			pumsp.style.borderBottomWidth = 3;
			pumsp.style.borderRightColor = "Gray";
			pumsp.style.borderRightStyle = "groove";
			pumsp.style.borderRightWidth = 3;
			pumsp.style.borderLeftColor = "Gray";
			pumsp.style.borderLeftStyle = "solid";
			pumsp.style.borderLeftWidth = 1;
			pumsp.style.borderTopColor = "Gray";
			pumsp.style.borderTopStyle = "solid";
			pumsp.style.borderTopWidth = 1;
		}
		var popupMenuItem = null;
		var html = "";
		for (var i=0; i < this.items.getLength(); i++) {
			popupMenuItem = this.items.get(i);
			html += "<p style=\"font-family:Arial,Helvetica,sans-serif; font-size:12px; color:#003366; ";
			html += "margin-top:0px; margin-bottom:0px; cursor:hand; \" ";
			html += "onmouseover=\"this.style.textDecoration = 'underline';\" onmouseout=\"this.style.textDecoration = 'none';\">";
			if (rightClickedElementId.indexOf(CONNECTION) == 0) {
				html += "<nobr onclick=\"document.getElementById(rightClickedElementId).connection.executeAction('" + popupMenuItem.action + "');\">";
			} else if (rightClickedElementId.indexOf(NETWORK_ELEMENT) == 0) {
				html += "<nobr onclick=\"document.getElementById(rightClickedElementId).parentObj.executeAction('" + popupMenuItem.action + "');\">";
			} else if (rightClickedElementId.indexOf(MAP) == 0) {
				html += "<nobr onclick=\"document.getElementById(rightClickedElementId).map.executeAction('" + popupMenuItem.action + "');\">";
			}
			html += "&raquo;&nbsp;";
			if (popupMenuItem.img != null) {
				html += "<img border=0 src=\"" + popupMenuItem.img + "\">&nbsp;";
			}
			html += popupMenuItem.text;
			html += "</nobr></p>";
		}
		document.getElementById(this.id).innerHTML = html;
	}
	/**
	 * PROTECTED
	 * Makes visible the popup menu.
	 */
	function showPopupMenu() {
		if (document.getElementById(this.id) != null) {
			document.getElementById(this.id).style.visibility = "visible";
		}
	}
	/**
	 * PROTECTED
	 * Hides the popup menu.
	 */
	function hidePopupMenu() {
		if (document.getElementById(this.id) != null) {
			document.getElementById(this.id).style.visibility = "hidden";
		}
	}
	/**
	 * PROTECTED
	 * Allocates the popup menu at the specified coordenates inside the map.
	 * @param (String or int) x the x coordenate of the popup menu inside the map.
	 * @param (String or int) y the y coordenate of the popup menu inside the map.
	 */ 
	function allocatePopupMenu(x, y) {
		if (document.getElementById(this.id) != null) {
			document.getElementById(this.id).style.pixelLeft = eval(x);
			document.getElementById(this.id).style.pixelTop = eval(y);
		}
	}
	
	var leftClickedElementId = null;
	var rightClickedElementId = null;
	var offsetX, offsetY;
	var action = null;
	function setSelectedElementId(evt) {
		if (document.getElementById(MAP).map.dragEnabled) {
			var parentObj = window.event.srcElement.parentObj;
			if (parentObj != null) {
				leftClickedElementId = parentObj.id;
			}
		}
		return;
	}
	function scrollClicked(x, y) {
		var scrClkd = false;
		if (document.getElementById(MAP).map.mapWidth > document.getElementById(MAP).clientWidth) {
			if (y > document.getElementById(MAP).scrollTop + document.getElementById(MAP).clientHeight) {
				scrClkd = true;
			}
		}
		if (!scrClkd && document.getElementById(MAP).map.mapHeight > document.getElementById(MAP).clientHeight) {
			if (x > document.getElementById(MAP).scrollLeft + document.getElementById(MAP).clientWidth) {
				scrClkd = true;
			}
		}
		return scrClkd;
	}
	function mouseDown(evt) {
		if (event.button == 1) {
			setSelectedElementId(evt);
			if (leftClickedElementId != null) {
				rightClickedElementId = null;
				document.getElementById(MAP).map.hidePopupMenu();
				offsetX = window.event.offsetX;
				offsetY = window.event.offsetY;
				if (!document.getElementById(leftClickedElementId).parentObj.isSelected()) {
					document.getElementById(MAP).map.releaseSelection();
					document.getElementById(MAP).map.addToSelection(document.getElementById(leftClickedElementId).parentObj);
				}
			} else if (window.event.srcElement.id == MAP && document.getElementById(MAP).map.dragEnabled) {
				rightClickedElementId = null;
				document.getElementById(MAP).map.hidePopupMenu();
				if(!scrollClicked(window.event.offsetX, window.event.offsetY)) {
					var mapWidth = Math.max(document.getElementById(MAP).map.mapWidth, document.getElementById(MAP).clientWidth);
					var mapHeight = Math.max(document.getElementById(MAP).map.mapHeight, document.getElementById(MAP).clientHeight);
					if (window.event.offsetX < mapWidth && window.event.offsetY < mapHeight) {
						document.getElementById(MAP).map.releaseSelection();
						action = SELECT_MODE;
						document.getElementById(MAP).map.selection.setOrigin(window.event.offsetX, window.event.offsetY);
					}
				}
			} else if (window.event.srcElement.id == MINIWINDOW) {
				rightClickedElementId = null;
				document.getElementById(MAP).map.hidePopupMenu();
				offsetX = window.event.offsetX;
				offsetY = window.event.offsetY;
				action = SCROLL_MODE;
			}
		} else {
			rightClickedElementId = null;
			document.getElementById(MAP).map.hidePopupMenu();
			rightClickedElementId = window.event.srcElement.id;
			offsetX = window.event.offsetX;
			offsetY = window.event.offsetY;
		}
		return false;
	}
	function mouseDrag(evt) {
		if (leftClickedElementId != null) {
			var x = window.event.clientX - offsetX - document.getElementById(leftClickedElementId).parentObj.x;
			var y = window.event.clientY - offsetY - document.getElementById(leftClickedElementId).parentObj.y;
			document.getElementById(MAP).map.dottedSelection.show();
			document.getElementById(MAP).map.dottedSelection.allocate(x, y);
		} else if (action == SELECT_MODE) {
			document.getElementById(MAP).map.selection.show();
			if (window.event.srcElement.id == MAP) {					// draging over the map
				document.getElementById(MAP).map.selection.setFinal(window.event.offsetX, window.event.offsetY);
			} else if (window.event.srcElement.parentObj != null) {		// draging over a network element
				var x = window.event.srcElement.parentObj.x + window.event.offsetX;
				var y = window.event.srcElement.parentObj.y + window.event.offsetY;
				document.getElementById(MAP).map.selection.setFinal(x, y);
			} else if (window.event.srcElement.connection != null) {	// draging over a connection
				var x = Math.min(window.event.srcElement.connection.originX, window.event.srcElement.connection.destinationX);
				var y = Math.min(window.event.srcElement.connection.originY, window.event.srcElement.connection.destinationY);
				document.getElementById(MAP).map.selection.setFinal(x + window.event.offsetX, y + window.event.offsetY);
			} else if (window.event.srcElement.port != null) {			// draging over a port
				var x = window.event.srcElement.port.ne.x + window.event.srcElement.port.x + window.event.offsetX;
				var y = window.event.srcElement.port.ne.y + window.event.srcElement.port.y + window.event.offsetY;
				document.getElementById(MAP).map.selection.setFinal(x, y);
			} else {													// draging over the selection
				var x = window.event.srcElement.style.pixelLeft + window.event.offsetX;
				var y = window.event.srcElement.style.pixelTop + window.event.offsetY;
				document.getElementById(MAP).map.selection.setFinal(x, y);
			}
			document.getElementById(MAP).map.selection.allocate();
		} else if (action == SCROLL_MODE) {
			var x = window.event.clientX - offsetX - minimap.style.pixelLeft - BORDER_WH;
			var y = window.event.clientY - offsetY - minimap.style.pixelTop - BORDER_WH;
			document.getElementById(MAP).map.scrollTo(x, y);
		}
	}
	function mouseUp(evt) {
		if (leftClickedElementId != null) {
			var oldMapWidth = document.getElementById(MAP).map.mapWidth;
			var oldMapHeight = document.getElementById(MAP).map.mapHeight;
			document.getElementById(MAP).map.allocateSelection();
			document.getElementById(MAP).map.dottedSelection.hide();
			document.getElementById(MAP).map.storeMapBounds();
			if (oldMapWidth != document.getElementById(MAP).map.mapWidth || oldMapHeight != document.getElementById(MAP).map.mapHeight) {
				document.getElementById(MAP).map.writeMiniMap();
			}
		} else if (action == SELECT_MODE) {
			document.getElementById(MAP).map.selection.hide();
			action = null;
			document.getElementById(MAP).map.setSelection();
			document.getElementById(MAP).map.setDottedSelection();
		} else if (action == SCROLL_MODE) {
			action = null;
		} else if (rightClickedElementId != null) {
			if (window.event.srcElement.id == rightClickedElementId) {
				var x = null;
				var y = null;
				if (rightClickedElementId.indexOf(CONNECTION) == 0) {
					x = Math.min(window.event.srcElement.connection.originX, window.event.srcElement.connection.destinationX);
					y = Math.min(window.event.srcElement.connection.originY, window.event.srcElement.connection.destinationY);
					window.event.srcElement.connection.showPopupMenuAt(x + offsetX, y + offsetY);
				} else if (rightClickedElementId.indexOf(NETWORK_ELEMENT) == 0) {
					x = window.event.srcElement.parentObj.x;
					y = window.event.srcElement.parentObj.y
					window.event.srcElement.parentObj.showPopupMenuAt(x + offsetX, y + offsetY);
				} else if (rightClickedElementId.indexOf(MAP) == 0) {
					document.getElementById(MAP).map.showPopupMenuAt(offsetX, offsetY);
				}
			}
		}
		leftClickedElementId = null;
		return false;
	}
	function init() {
		document.onmousedown = mouseDown;
		document.onmousemove = mouseDrag;
		document.onmouseup = mouseUp;
		document.body.onresize = resize;
		document.body.onselectstart = cancelDefaultEventAction;
		document.body.oncontextmenu = cancelDefaultEventAction;
	}
	function cancelDefaultEventAction() {
		return false;
	}
	function resize() {
		document.getElementById(MAP).map.setBounds();
		document.getElementById(MAP).map.writeMiniMap(true);
		rightClickedElementId = null;
		document.getElementById(MAP).map.hidePopupMenu();
		return true;
	}
	function updMiniMap() {
		document.getElementById(MAP).map.updateMiniMap();
	}