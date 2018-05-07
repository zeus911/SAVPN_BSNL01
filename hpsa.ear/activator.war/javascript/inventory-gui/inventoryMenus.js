	/**
	 * PROTECTED
	 * An ordered list of elements. These elements can belong to any type. This structure is
	 * very similar to the Java Iterator object.
	 */
	function List() {
		this.list = new Array();
		this.add = addObjToList;
		this.get = getObjFromList;
		this.getLength = getNumberOfObjs;
		this.contains = containsObj;
	}
	/**
	 * PUBLIC
	 * Adds an object to the List. If the setId parameter is true, the object's setId method is
	 * invoked with the numeric position of this object inside the List.
	 * @param (any object type) obj the object to allocate.
	 * @param (String or boolean) setId indicates whether the object's setId method must be incoked.
	 */
	function addObjToList(obj, setId) {
		if (eval(setId)) {
			obj.setId(this.list.length);
		}
		this.list[this.list.length] = obj;
	}
	/**
	 * PUBLIC
	 * Gets the object allocated at the specified position.
	 * @param (String or int) i the position of the desired object.
	 * @return (any object type) the object at the specified position.
	 */
	function getObjFromList(i) {
		if(i>=this.list.length) return null;
		return this.list[i];
	}
	/**
	 * PUBLIC
	 * Gets the length of the list. In other words, the number of objects allocated inside the List.
	 * @return (int) the length of the List.
	 */
	function getNumberOfObjs() {
		return this.list.length;
	}
	/**
	 * PUBLIC
	 * Checks whether the List contains the specified object or not.
	 * @param (any object type) obj the object which is needed to search.
	 * @return (boolean) true if the object is allocated inside the List. False other way.
	 */
	function containsObj(obj) {
		var found = false;
		for (var i = 0; i < this.list.length && !found; i++) {
			found = (this.list[i] == obj);
		}
		return found;
	}


	
	
	/**
	 * PUBLIC Constructor
	 * Creates an entry of any menu. This could be one of those inside the menu bar or one of those
	 * inside the popup menus which are displayed when the mouse gets over an entry of the menu bar.
	 * Allthough this constructor has some parameters with clear names, this names are not always
	 * the real meaning of the parameter. See the parameters description for more details.
	 * @param (String) name the text which is going to be displayed as an entry inside the menu bar
	 * or the popup menu. Can't be null.
	 * @param (String) url the url which is going to be called when a click event is fired over this
	 * entry. Can be null. If this item has child items this paramter is ignored.
	 * @param (String) target the place where the called click event action will be displayed. Can be
	 * null. If null, the default value is "_self" and the action refreshes the screen. If this item
	 * has child items this parameter is ignored.
	 * @param (String) openOptions this can be the selected options of the ne window which is going to
	 * be opened to display the click event action, but other times it is the string value which is
	 * going to be assigned to the selectedOption variable.
	 * @param (FutureMenuItem) parentItem the parent item of this item. It is null when this item
	 * belongs to the menu bar.
	 * @param (String) bdId the identifier of this item obtained from data base. This is needed to
	 * access this item from different locations and enable or disable it. The item's identifier can't
	 * be used for this because it is only known by the FutureMenu object, but not by the JSP
	 * programmer who has to invoke it.
	 * @param (String or boolean) enabled indicates whether this item is enabled or disabled. If null, it
	 * is set to true.
	 */
	function FutureMenuItem(solutionName, name, url, target, openOptions, parentItem, bdId, enabled) {
		this.solutionName=   (solutionName == null || solutionName == "") ? "" : solutionName + "/";
		this.name = name;
		this.url = url;
		this.target = (target == null || target == "") ? "container" : target;
		if (this.url != null && this.target != PERFORM_JS_FUNCTION) {
			this.url += (url.indexOf("?") == -1 ? "?" : "&") + "rmn=" + this.target;
		}
		this.openOptions = openOptions;
		this.parentItem = parentItem;
		this.id = null;
		this.menu = null;
		this.childs = null;
		this.leftposition=0;
		this.bdId = bdId;
		this.enabled = enabled == null ? true : eval(enabled);
		this.setChilds = setItemChilds;
		this.setMenu = setItemMenu;
		this.setId = setFutureItemId;
		this.setEnabled = setItemEnabled;
		this.write = writeFutureItem;
	}
	/**
	 * PROTECTED
	 * Sets the item's identifier.
	 * @param (String or int) idNumber the number of this item.
	 */
	function setFutureItemId(idNumber) {
		this.id = "futureitem" + idNumber;
	}
	/**
	 * PROTECTED
	 * Sets the items childs.
	 * @param (List) childList the List of child items.
	 */
	function setItemChilds(childList) {
		this.childs = childList;
	}
	/**
	 * PROTECTED
	 * Sets a pointer to the FutureMenu object which owns this item.
	 * @param (FutureMenu) menu the FutureMenu object which owns this item.
	 */
	function setItemMenu(menu) {
		this.menu = menu;
	}
	/**
	 * PUBLIC
	 * Enables or disables this menu item.
	 * @param (String or boolean) enabled indicates whether this item is enabled or disabled. If null, it
	 * is set to true.
	 */
	function setItemEnabled(enabled) {
		this.enabled = enabled == null ? true : eval(enabled);
	}
	/**
	 * PROTECTED
	 * Composes the HTML code which will generate an entry for this item inside the menu bar or inside a
	 * popup menu. Also the child items are writed.
	 * @param (String or int) iPos the position of this item inside the menu bar or the popup menu.
	 * @return the HTML code.
	 */
	function writeFutureItem(iPos) {
		var menuitemWidth="216";
		  	if(navigator.userAgent.indexOf("MSIE")>0) { 
			     menuitemWidth="200";
			}
		var html = "";
		if (this.parentItem == null) {
			if (!this.enabled) {
				html += "<span class=menuButtonA style=\"color:Gray;\" id=" + this.id + ">&raquo; " + this.name + "</span>";
			} else {
				html += "<span class=menuButtonA id=" + this.id + " ";
				html += " style =\"position:absolute; top:0 ; left :"+   (eval(this.leftposition))+ "px\" ";
				html += "onmouseover=\"this.className='menuButtonB';"  + " document.getElementById('" + this.id + "sp').style.visibility='visible';this.style.zIndex=10000;document.getElementById('" + this.id + "ifr').style.visibility='visible';\" ";
				html += "onmouseout=\"this.className='menuButtonA';"  + " document.getElementById('" + this.id + "sp').style.visibility='hidden';this.style.zIndex=0;document.getElementById('" + this.id + "ifr').style.visibility='hidden';\">";
				html += "<nobr>" + this.name + "</nobr>";
				html += "<iframe id=" + this.id + "ifr name=" + this.id + "ifr frameborder=\"0\" scrolling=\"No\" class=popupMenu ";
				html += "style=\"z-index:6; height:" + (20 * this.childs.getLength() ) + "\"></iframe>";
				html += "<span id=" + this.id + "sp class=popupMenu ";
				html += "style=\"z-index:10;height:" + (20 * this.childs.getLength()  ) + "\" ";
				html += "onmouseout=\"this.style.visibility='hidden';\">";
				var item = null;
				for (var i = 0; i < this.childs.getLength(); i++) {
					item = this.childs.get(i);
					item.setChilds(this.menu.getChilds(item));
					html += item.write(i);
				}
				html += "</span>";
				html += "</span>";
			}
		} else {
			if (!this.enabled) {
				html += "<span style=\"position:absolute; top:" + (eval(iPos) * 20) + "; left:0; width:"+menuitemWidth+"; height:20; ";
				html += "font-family:Arial,Helvetica,sans-serif; font-size:13px; color:Gray; cursor:default; text-decoration:none;\" ";
				html += "onselectstart=\"return false;\">";
				html += "&nbsp;&raquo; " + this.name;
				if (this.childs.getLength() > 0) {
					html += "<span class=popupMenuTextA style=\"position:absolute; top:0; left:" +menuitemWidth +"; color:Gray;\">&raquo;</span>";
				}
				html += "</span>";
			} else {
				html += "<span style=\"background-color:#E6E6E6 ; position:absolute; top:" + (eval(iPos) * 20) + "; left:0; width: "+menuitemWidth+"; height:20; ";
				html += "font-family:Arial,Helvetica,sans-serif; font-size:13px; color:black; cursor:hand; text-decoration:none;\" ";
				html += "onselectstart=\"return false;\" ";
				html += "onmouseover=\"this.style.backgroundColor='#AFAFAF';";
				if (this.childs.getLength() > 0) {
					html += "document.getElementById('" + this.id + "sp').style.visibility='visible';document.getElementById('" + this.id + "ifr').style.visibility='visible';";
				}
				html += "\" ";
				html += "onmouseout=\"this.style.backgroundColor='#E6E6E6';";
				if (this.childs.getLength() > 0) {
					html += "document.getElementById('" + this.id + "sp').style.visibility='hidden';document.getElementById('" + this.id + "ifr').style.visibility='hidden';";
				}
				html += "\" ";
				if (this.childs.getLength() == 0) {
					if (this.target == "container" ) {
						
					} else if (this.target == CLOSE_INVENTORY) {
						html += "onclick=\"closeInventory();\"";
					} else if (this.menu.type == INVENTORY && this.target != PERFORM_JS_FUNCTION) {
						html += "onclick=\"document.getElementById('rimMenu" + this.target +"').menu.closeNotPin(); document.getElementById('menu').menu.hideMenus(); addRimToMenu('" + this.target + "','" + this.solutionName + this.name + "',true,'" + this.url + "');";
					} else if (this.target == PERFORM_JS_FUNCTION) {
						html += "onclick=\"document.frames['fjsp'].changeStatus('" + this.url + "','" + this.openOptions + "');";
					} else if (this.target == ADD_TO_FAVORITES) {
						html += "onclick=\"addToFavorites();";
					} else if (this.openOptions == "") {
						html += "onclick=\"window.open('" + this.url + "','" + this.target + "');";
					} else {
						html += "onclick=\"window.open('" + this.url + "','" + this.target + "','" + this.openOptions + "');";
					}
					if (this.target == "container" ) {
						
					} else if (this.menu.type == "root" || this.menu.type == INVENTORY) {
						html += "document.getElementById('menu').menu.hideMenus();\"";
					} else {
						html += "document.getElementById('menuBarInfo').menu.hideMenus();\"";
					}
				}
				html += ">";
				html += "&nbsp;" + this.name;
				if (this.childs.getLength() > 0) {
					html += "<span class=popupMenuTextA style=\"position:absolute; top:0; left:"+(menuitemWidth-10)+";\">&raquo;</span>";
					html += "<iframe id=" + this.id + "ifr name=" + this.id + "ifr frameborder=\"0\" scrolling=\"No\" class=popupMenu2 ";
					html += "style=\"z-index:6;height:" + (20 * this.childs.getLength()) + ";left:"+menuitemWidth+";\"></iframe>";
					html += "<span class=popupMenu2 id=" + this.id + "sp ";
					html += "style=\"z-index:10;height:" + (20 * this.childs.getLength()  ) + ";left:"+menuitemWidth+"; \" ";
					html += "onmouseout=\"" + this.id + "sp.style.visibility='visible';\">";
					var item = null;
					for (var i = 0; i < this.childs.getLength(); i++) {
						item = this.childs.get(i);
						item.setChilds(this.menu.getChilds(item));
						html += item.write(i);
					}
					html += "</span>";
				}
				html += "</span>";
			}
		}
		//alert(html);
		return html;
	}


	
	
	/**
	 * PUBLIC Constructor
	 * The object which controlls and generates the menu.
	 * @param (String) view the view which this menu belongs to. The default value is "root".
	 */
	function FutureMenu(view) {
		FutureMenu.ID = "futuremenuId";
		this.color = null;
		this.items = new List();
		this.type = view == null ? "root" : view;
		this.add = addItem;
		this.getChilds = getChildItems;
		this.setItemLeftPos=setFutureItemLeftPos;
		this.write = writeFutureMenu;
		this.getFutureItem = getFutureItemFromMenu;
		this.setEnabledItem = setEnabledItemOfMenu;
		this.hideMenus = hideMenus;
		
	}
	/**
	 * PUBLIC
	 * Adds an item to the menu.
	 * @param (FutureMenuItem) futureMenuItem the item which is going to be added.
	 */
	function addItem(futureMenuItem) {
		futureMenuItem.setMenu(this);
		this.items.add(futureMenuItem, true);
	}
	/**
	 * PRIVATE
	 * Gets the child items of the specified item. If any item is specified, all the parent items
	 * (those allocated inside the menu bar) are returned.
	 * @param (FutureMenuItem) fItem the item whose childs are going to be searched.
	 * @return the List of childs.
	 */
	function getChildItems(fItem) {
		var item = (fItem == null) ? null : fItem;
		var list = new List();
		for (var i = 0; i < this.items.getLength(); i++) {
			if (this.items.get(i).parentItem == item) {
				list.add(this.items.get(i));
			}
		}
		return list;
	}
	function setFutureItemLeftPos() {
		var item = null;
		var preitem = null;
		var parentItems = this.getChilds(null);
		for (var i = 0; i < parentItems.getLength(); i++) {
			item = parentItems.get(i);
			if (i!=0)
			{
				item.leftposition=eval(preitem.leftposition+preitem.name.length*5.72+30);
			}
			preitem=item;
		}
	}
	/**
	 * PUBLIC
	 * Writes the HTML code of the menu.
	 * @param (String or int) color the actual random color of the future GUI.
	 */
	function writeFutureMenu(color) {
		this.color = useRandomColor ? color : "";
		var html = "<span id=menuBar class=menuBar></span>";
		if (this.type == "root" || this.type == INVENTORY) {
			html += "<span id=logohp><img border=0 src='/activator/images/inventory-gui/hp-logo-inventory" + this.color + ".gif'></span>";
			//html += "<span id=logohp><img border=0 src='/activator/images/HPInvent-small" + this.color + ".jpg'></span>";		
		}
		html += "<span class=menuButtons>";
		var item = null;
		var parentItems = this.getChilds(null);
		for (var i = 0; i < parentItems.getLength(); i++) {
			item = parentItems.get(i);
			item.setChilds(this.getChilds(item));
			html += item.write();
		}
		html += "</span>";
		//alert(html);
		if (this.type == "root" || this.type == INVENTORY) {
			document.getElementById("menu").innerHTML = html;
			document.getElementById("menu").menu = this;
		} else {
			document.getElementById("menuBarInfo").innerHTML = html;
			document.getElementById("menuBarInfo").menu = this;
		}
		return html;
	}
	/**
	 * PRIVATE
	 * Returns the FutureMenuItem object which bdId attribute is equal to the bdId parameter of
	 * this method. If any object is found, the result is null.
	 * @param (String) bdId the FutureMenuItem's bdId to be found.
	 * @return the FutureMenuItem found or null if any object is found.
	 */
	function getFutureItemFromMenu(bdId) {
		var fmi = null;
		var fmiLoop = null;
		var i = 0;
		while (fmi == null && i < this.items.getLength()) {
			fmiLoop = this.items.get(i++);
			if (fmiLoop.bdId == bdId) {
				fmi = fmiLoop;
			}
		}
		return fmi;
	}
	/**
	 * PUBLIC
	 * Enables or disables the menu item identified by the bdId. If the item already was enabled
	 * or disabled nothing happens. If the item is disabled, all it's eventual children are never
	 * more showed until this item is enabled again.
	 * A change the enable attribute implies to rewrite the whole menu.
	 * @param (String) bdId the menu item bdId attribute.
	 * @param (String or boolean) enabled indicates whether the item is going to be enabled (true)
	 * or disabled (false).
	 */
	function setEnabledItemOfMenu(bdId, enabled) {
		var item = this.getFutureItem(bdId);
		if (item != null) {
			item.setEnabled(enabled);
			this.write(this.color);
		}
	}
	function hideMenus() {
		var item = null;
		var parentItems = this.getChilds(null);
		for (var i = 0; i < parentItems.getLength(); i++) {
			item = parentItems.get(i);
			document.getElementById(item.id).className = "menuButtonA";
			document.getElementById(item.id + "sp").style.visibility = "hidden";
			var children = new List();
			var k = 0;
			do {
				if (item.childs != null) {
					for (var j = 0; j < item.childs.getLength(); j++) {
						children.add(item.childs.get(j));
					}
				}
				item = children.get(k++);
				if (item != null && document.getElementById(item.id + "sp") != null) {
					document.getElementById(item.id + "sp").style.visibility = "hidden";
				}
			} while (k <= children.getLength());
		}
	}
	