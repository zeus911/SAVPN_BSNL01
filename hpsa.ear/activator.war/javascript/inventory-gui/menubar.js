/**
 * PUBLIC Constructor
 * Creates an entry of any menu. This could be one of those inside the menu bar or one of those
 * inside the popup menus which are displayed when the mouse gets over an entry of the menu bar.
 * Allthough this constructor has some parameters with clear names, this names are not always
 * the real meaning of the parameter. See the parameters description for more details.
 * @param (String) label the text which is going to be displayed as an entry inside the menu bar
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
function FutureMenuItem(solutionName, label, url, target, openOptions, parentItem, bdId, enabled) {
  var solution = solutionName == null || solutionName == "" ? "" : solutionName + "/";
  var link = url;
  var tgt = (target == null || target == "") ? "container" : target;
  if (link != null && tgt != PERFORM_JS_FUNCTION) {
    link += (url.indexOf("?") == -1 ? "?" : "&") + "rmn=" + tgt;
  }
  var id = null;
  var menu = null;
  var children = null;
  var enabledItem = enabled;
  this.getParentItem = function ()
  {
    return parentItem;
  }
  this.getBdId = function ()
  {
    return bdId;
  }
  /**
   * PROTECTED
   * Sets the items children.
   * @param (Array) childList the List of child items.
   */
  this.setChilds = function (childList)
  {
    children = childList;
  }
  this.hasChildren = function ()
  {
    return children != null && children.length > 0;
  }
  this.getChildren = function ()
  {
    return children == null ? null : children.slice(0);
  }
  /**
   * PROTECTED
   * Sets a pointer to the FutureMenu object which owns this item.
   * @param (FutureMenu) fm the FutureMenu object which owns this item.
   */
  this.setMenu = function (fm)
  {
    menu = fm;
  }
  /**
   * PROTECTED
   * Sets the item's identifier.
   * @param (String or int) idNumber the number of this item.
   */
  this.setId = function (idNumber)
  {
    id = "futureitem" + idNumber;
  }
  this.getId = function ()
  {
    return id;
  }
  /**
   * PUBLIC
   * Enables or disables this menu item.
   * @param (String or boolean) enabled indicates whether this item is enabled or disabled. If null, it
   * is set to true.
   */
  this.setEnabled = function (enabled)
  {
    enabledItem = enabled;
  }
  /**
   * PROTECTED
   * Composes the HTML code which will generate an entry for this item inside the menu bar or inside a
   * popup menu. Also the child items are writed.
   * @return the HTML code.
   */
  this.write = function ()
  {
    var html = "";
    if (parentItem == null) {
      if (!enabledItem) {
        html += "<div class=\"root_menu_option\" style=\"color:gray;\" id=" + id + ">" + label + "</div>";
      } else {
        html += "<div class=\"root_menu_option\" id=\"" + id + "\" ";
        html += "onmouseover=\"document.getElementById('" + id + "sp').style.visibility='visible';this.style.zIndex=10000;\" ";
        html += "onmouseout=\"document.getElementById('" + id + "sp').style.visibility='hidden';this.style.zIndex=0;\">";
        html += label;
        html += "<div id=" + id + "sp class=\"drop_down_menu\" ";
        html += "style=\"z-index:10; height:" + (20 * children.length) + "px;\" ";
        html += "onmouseout=\"this.style.visibility='hidden';\">";
        var item = null;
        for (var i = 0; i < children.length; i++) {
          item = children[i];
          item.setChilds(menu.getChilds(item));
          html += item.write();
        }
        html += "</div>";
        html += "</div>";
      }
    } else {
      if (!enabledItem) {
        html += "<div class=\"menu_option\" style=\"color:gray; cursor:default;\" onselectstart=\"return false;\">" + label + "</div>";
      } else {
        html += "<div class=\"menu_option " + (children.length > 0 ? "has_children" : "") + "\" onselectstart=\"return false;\" ";
        if (children.length > 0) {
          html += "onmouseover=\"document.getElementById('" + id + "sp').style.visibility='visible';\" ";
          html += "onmouseout=\"document.getElementById('" + id + "sp').style.visibility='hidden';\" ";
        }
        if (children.length == 0) {
          if (tgt == CLOSE_INVENTORY) {
            html += "onclick=\"closeInventory();\"";
          } else {
            html += "onclick=\"document.getElementById('menu_bar').menu.hideMenus();TabBarManager.addTab(" + tgt + ",'" + solution + label + "','" + link + "');";
          }
          html += "document.getElementById('menu_bar').menu.hideMenus();\"";
        }
        html += ">";
        html += "&nbsp;" + label;
        if (children.length > 0) {
          html += "<div class=\"right_side_menu\" id=\"" + id + "sp\" ";
          html += "style=\"z-index:10;\" ";
          html += "onmouseout=\"" + id + "sp.style.visibility='visible';\">";
          var item = null;
          for (var i = 0; i < children.length; i++) {
            item = children[i];
            item.setChilds(menu.getChilds(item));
            html += item.write();
          }
          html += "</div>";
        }
        html += "</div>";
      }
    }
    return html;
  }
  this.getWidth = function ()
  {
    var oDiv = document.getElementById(id);
    return oDiv == null ? 0 : oDiv.clientWidth;
  }
  this.setLeft = function (l)
  {
    var oDiv = document.getElementById(id);
    if (oDiv != null) {
      oDiv.style.left = l + "px";
    }
  }

}


/**
 * PUBLIC Constructor
 * The object which controlls and generates the menu.
 * @param (String) view the view which this menu belongs to. The default value is "root".
 */
function FutureMenu(view)
 {
  FutureMenu.ID = "futuremenuId";
  var items = new Array();
  /**
   * PUBLIC
   * Adds an item to the menu.
   * @param (FutureMenuItem) futureMenuItem the item which is going to be added.
   */
  this.add = function (futureMenuItem)
  {
    futureMenuItem.setMenu(this);
    futureMenuItem.setId(items.length);
    items.push(futureMenuItem);
  }
  /**
   * PRIVATE
   * Gets the child items of the specified item. If any item is specified, all the parent items
   * (those allocated inside the menu bar) are returned.
   * @param (FutureMenuItem) fItem the item whose children are going to be searched.
   * @return the children array.
   */
  this.getChilds = function (fItem)
  {
    var item = (fItem == null) ? null : fItem;
    var list = new Array();
    for (var i = 0; i < items.length; i++) {
      if (items[i].getParentItem() == item) {
        list.push(items[i]);
      }
    }
    return list;
  }
  this.setItemLeftPos = function ()
  {
    // deprecated
  }
  /**
   * PUBLIC
   * Writes the HTML code of the menu.
   */
  this.write = function ()
  {
    var html = "";
    var item = null;
    var parentItems = this.getChilds(null);
    for (var i = 0; i < parentItems.length; i++) {
      item = parentItems[i];
      item.setChilds(this.getChilds(item));
      html += item.write();
    }
    document.getElementById("menu_bar").innerHTML = html;
    document.getElementById("menu_bar").menu = this;
    var l = 0;
    var w;
    for (var i = 0; i < parentItems.length; i++) {
      parentItems[i].setLeft(l);
      l += parentItems[i].getWidth() + 5;
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
  this.getFutureItem = function (bdId)
  {
    var fmi = null;
    var fmiLoop = null;
    for (var i = 0; fmi == null && i < items.length; i++) {
      fmiLoop = items[i];
      if (fmiLoop.getBdId() == bdId) {
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
  this.setEnabledItem = function (bdId, enabled)
  {
    var item = this.getFutureItem(bdId);
    if (item != null) {
      item.setEnabled(enabled);
      this.write();
    }
  }
  this.hideMenus = function ()
  {
    var item = null;
    var itemChildren;
    var parentItems = this.getChilds(null);
    for (var i = 0; i < parentItems.length; i++) {
      item = parentItems[i];
      document.getElementById(item.getId()).className = "root_menu_option";
      document.getElementById(item.getId() + "sp").style.visibility = "hidden";
      var children = new Array();
      var k = 0;
      do {
        if (item.hasChildren() != null) {
          itemChildren = item.getChildren();
          for (var j = 0; j < itemChildren.length; j++) {
            children.push(itemChildren[j]);
          }
        }
        item = children[k++];
        if (item != null && document.getElementById(item.getId() + "sp") != null) {
          document.getElementById(item.getId() + "sp").style.visibility = "hidden";
        }
      } while (k <= children.length);
    }
  }
}