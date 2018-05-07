/*****************************************************************************************/
/**                                      List Object                                    **/
/*****************************************************************************************/
/**
 * PROTECTED
 * An ordered list of elements. These elements can belong to any type. This structure is
 * very similar to the Java Iterator object.
 */
function List() {
  this.counter = 0;
  this.list = new Array();
  this.add = addObjToList;
  this.get = getObjFromList;
  this.getLength = getNumberOfObjs;
  this.contains = containsObj;
  this.remove = removeObjFromList;
  this.insertAt = insertObjIntoListAt;
  this.indexOf = getIndexOf;
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
    obj.setId(this.counter++);
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
 * PUBLIC
 * Removes an object of the List.
 * @param (String or int) i the index of the object which is going to be removed.
 * @return the removed object.
 */
function removeObjFromList(i) {
  return this.list.splice(eval(i), 1);
}
/**
 * PUBLIC
 * Inserts an object into the List at the specified position. Any other subsequent objects of
 * the List are displaced a position.
 * @param (String or int) i the index where the object must be inserted.
 * @param (Object) obj the object which is going to be inserted.
 * @param (String or boolean) setId indicates whether the object's setId method must be incoked.
 */
function insertObjIntoListAt(i, obj, setId) {
  if (eval(setId)) {
    obj.setId(this.counter++);
  }
  this.list.splice(eval(i), 0, obj);
}
/**
 * PUBLIC
 * Returns the index of an object inside the List.
 * @param (Object) obj the object which index is looked for.
 * @return the object's index inside the List.
 */
function getIndexOf(obj) {
  var i = 0;
  var found = false;
  var length = this.getLength();
  while (i < length && !found) {
    if (this.get(i) == obj) {
      found = true;
    } else {
      i++;
    }
  }
  return i == length ? null : i;
}



/*****************************************************************************************/
/**                                       Expand Object                                 **/
/*****************************************************************************************/
function Expand() {
  this.expandedNodeIndex = null;
  this.nextNodeIndexWithSameLevel = null;
  this.setExpandedNodeIndex = setExpandedNodeIndex;
  this.setNextNodeIndexWithSameLevel = setNextNodeIndexWithSameLevel;
  this.show = showExpandedNodesChild;
}
function setExpandedNodeIndex(index) {
  this.expandedNodeIndex = eval(index);
}
function setNextNodeIndexWithSameLevel(index) {
  this.nextNodeIndexWithSameLevel = eval(index);
}
function showExpandedNodesChild(node) {
  node.show();
}




/*****************************************************************************************/
/**                                     Field Object                                    **/
/*****************************************************************************************/
/**
 * PROTECTED Constructor
 * Represents one of the multiple text blocks which may fix a branch of the future tree.
 * @param (String) text the main text of this block of text.
 * @param (String or boolean) isBold indicates whether this block of text is bold or not.
 * @param (String or boolean) isItalic indicates whether this block of text is italic or not.
 * @param (String or boolean) color the color of this block of text. The default color is a
 * dark blue (#336699).
 */
function Field(text, isBold, isItalic, color) {
  this.text = text;
  this.isBold = isBold == null ? false : eval(isBold);
  this.isItalic = isItalic == null ? false : eval(isItalic);
  this.color = color == null ? "#336699" : color;
}



/*****************************************************************************************/
/**                                  TreeItem Object                                    **/
/*****************************************************************************************/
/**
 * PROTECTED
 * A counter of branches. It is used to calculate the top position of each branch.
 */
var treeItemsCounter = 0;
var menuDisplayedTreeItemObj = null;
/**
 * PROTECTED
 * An ordered List with every treeItem object.
 */
var treeItemsList = new List();
/**
 * PROTECTED
 * The global Expand object.
 */
var expandedNode = new Expand();
/**
 * PROTECTED
 * The actually selected node. If null, no node is actually selected.
 */
var selectedNode = null;
/**
 * PROTECTED
 * Set to true while a branch is being collapsed or expanded. Otherwise it's value is set to false.
 */
var waitingResult = false;

/**
 * PUBLIC Constructor
 * A branch of the future tee.
 * @param (String or int) level the number of parent branches of this branch. The level indicates the
 * left white space which must be set before the branch. If null, the default value is 0.
 * @param (String or boolean) isSelected indicates whether this branch is selected or not. When selected,
 * the branch has a different background color. If null, the default value is false.
 * @param (String or boolean) isCollapsed indicates whether this branch is collapsed or expanded. The
 * true value indicates that it is collapsed. False indicates that it is expanded. When null, this branch
 * can never be collapsed or expanded.
 * @param (String) type the type of this branch. This is only used in the communication with the future
 * tree servlet.
 * @param (String or int) idNumber the number which identifies this branch for the future tree servlet.
 * @param (String) icon the icon name for this branch. Can be null.
 */
function TreeItem(parentid, level, isSelected, isCollapsed, type, idNumber, icon, rmn, rid, pagecount, pk) {
  this.PADDING_LEFT = 10;
  this.TAB = 15;
  this.isCollapsed = isCollapsed == null ? null : eval(isCollapsed);
  this.type = type == null ? null : type;
  this.idNumber = idNumber == null ? null : eval(idNumber);
  this.fields = new Array();
  this.level = level == null ? 0 : eval(level);
  this.isSelected = false;
  this.selectedOperation = null;
  this.icon = icon == null ? null : icon;
  this.id = this.idNumber == null ? "notDefinedYet" : "ti" + this.idNumber;
  this.menu = new Array();
  this.setCollapsed = function (c)
  {
    this.isCollapsed = c;
  }
  this.setType = function (t)
  {
    this.type = t;
  }
  this.setNumber = function (n)
  {
    this.idNumber = n;
    this.id = this.idNumber == null ? "notDefinedYet" : "ti" + this.idNumber;
  }
  this.addText = function (text, isBold, isItalic, color)
  {
    this.fields[this.fields.length] = new Field(text, isBold, isItalic, color);
  }
  this.setLevel = function setLevelTI(level)
  {
    this.level = level == null ? 0 : level;
  }
  this.setSelected = function (s)
  {
    this.isSelected = s == null ? false : s;
    if (this.isSelected) {
      if (document.getElementById(this.id) != null) {
        document.getElementById(this.id).className = "branch selected";
      }
      if (selectedNode != null && selectedNode != this) {
        selectedNode.setSelected(false);
      }
      selectedNode = this;
    } else {
      if (document.getElementById(this.id) != null) {
        document.getElementById(this.id).className = "branch";
      }
      if (selectedNode == this) {
        selectedNode = null;
      }
    }
  }
  this.setSelectedOperation = function (operation)
  {
    this.selectedOperation = operation;
  }
  this.setIcon = function (i)
  {
    this.icon = i;
  }
  this.show = function ()
  {
    var imgDir = "/activator/images/inventory-gui/tree/";
    var oSpan = document.createElement("div");
    oSpan.setAttribute("id", this.id);
    oSpan.className = "branch" + (this.isSelected ? " selected" : "");
    var oSp;
    if (expandedNode.nextNodeIndexWithSameLevel == null) {
      oSp = document.body.appendChild(oSpan);
    } else {
      var node = treeItemsList.get(expandedNode.nextNodeIndexWithSameLevel);
      oSp = document.body.insertBefore(oSpan, document.getElementById(node.id));
    }
    oSp.style.whiteSpace = "nowrap";
    oSp.style.width = "100%";
    oSp.style.height = "16px";
    oSp.style.padding = "0px";
    oSp.style.margin = "0px";
    oSp.style.display = "block";
    var html = "<div id=\"titem" + this.idNumber + "\" style=\"margin-left:" + (this.TAB * this.level) + "px; height:16px;\" ";
    html += "onmousedown=\"searchtransferaction(this.treeObject.menu);this.treeObject.setSelected(true);\">";
    html += "<img id=\"ecimg" + this.idNumber + "\" align=\"top\" ";
    if (this.isCollapsed == null) {
      html += "src=\"" + imgDir + "leaf.gif\" style=\"cursor:default; width:16px; height:16px;\"";
    } else {
      html += "src=\"" + imgDir + (this.isCollapsed ? "collapsed.gif" : "expanded.gif") + "\" style=\"cursor:pointer; width:16px; height:16px;\" ";
      html += "onclick=\"this.treeObject.expandOrCollapse();\"";
    }
    html += "oncontextMenu=\"return false;\">";
    if (this.icon != null) {
      html += "<img id=\"icon" + this.idNumber + "\" src=\"" + imgDir + this.icon + "\" align=\"top\" style=\"cursor:default; width:16px; height:16px;\" ";
      html += "oncontextMenu=\"return false;\">";
    }
    html += "<span style=\"position:relative; top:1px;\">";
    for (var i = 0; i < this.fields.length; i++) {
      html += "&nbsp;<span style=\"cursor:pointer; ";
      if (this.fields[i].color != null) {
        html += "color:" + this.fields[i].color + "; ";
      } 
      if (this.fields[i].isBold) {
        html += "font-Weight:bold; ";
      }
      if (this.fields[i].isItalic) {
        html += "font-Style:italic;";
      }
      html += "\">" + this.fields[i].text + "</span>";
    }
    html += "</span>";
    if (this.hasOperations) {
      html += "<img id=\"cm" + this.idNumber + "\" src=\"/activator/images/inventory-gui/tree/down.gif\" align=\"top\" style=\"cursor:pointer; margin-left:5px;\" ",
      html += "onclick=\"this.treeObject.showMenu(event,1,false);\">";
    }
    html += "</div>";
    document.getElementById(this.id).innerHTML = html;
    document.getElementById(this.id).treeObject = this;
    document.getElementById("titem" + this.idNumber).treeObject = this;
    document.getElementById("ecimg" + this.idNumber).treeObject = this;
    if (document.getElementById("cm" + this.idNumber)) {
      document.getElementById("cm" + this.idNumber).treeObject = this;
    }
    if (this.isSelected) {
      searchtransferaction(this.menu, this.selectedOperation);
    }
    var elms = document.getElementsByClassName("branch");
    for (var i = 0; i < elms.length; i++) {
      $("#" + elms[i].id).width(document.body.scrollWidth + "px");
    }
  }
  this.addMenuItem = function (img, text, mn, rt, irs, rurl, hasWarning, isDefault)
  {
    this.menu[this.menu.length] = new InvMenuItem(img, text, mn, rt, irs, rurl, hasWarning, this.menu.length,isDefault);
    this.hasOperations = true;
  }
  this.showMenu = function (event, pagenum, oldpos)
  {
    var html = "";
    if (this.menu.length > 0) {
      for (var i = 0; i < this.menu.length ; i++) {
        html += this.menu[i].getCode();
      }
      parent.showContextMenu(html, event.clientX, event.clientY, rmn);
    }
  }
  this.expandOrCollapse = function ()
  {
    if (!waitingResult) {
      waitingResult = true;
      var scrLeft = $(document).scrollLeft();
      var scrTop = $(document).scrollTop();
      hideFlyingMenu();
      this.removeChidren();
      this.setSelected(true);
      var url = "/activator/OpenBranchAction.do?expand=" + this.isCollapsed;
      url += "&name=" + this.idNumber + "&type=" + this.type + "&rmn=" + rmn+"&rimid=" + rid;
      url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance + "&view=" + view;
      window.open(url, "treeResult");
      var imgDir = "/activator/images/inventory-gui/tree/";
      this.isCollapsed = !this.isCollapsed;
      document.getElementById("ecimg" + this.idNumber).src = imgDir + (this.isCollapsed ? "collapsed" : "expanded") + ".gif";
    }
  }
  this.remove = function ()
  {
    document.body.removeChild(document.getElementById(this.id));
  }
  this.removeChidren = function ()
  {
    expandedNode.setExpandedNodeIndex(treeItemsList.indexOf(this));
    var lastChildNodeIndex = expandedNode.expandedNodeIndex + 1;
    while (lastChildNodeIndex < treeItemsList.getLength() && treeItemsList.get(lastChildNodeIndex).level > this.level) {
      lastChildNodeIndex++;
    }
    lastChildNodeIndex--;
    for (; expandedNode.expandedNodeIndex < lastChildNodeIndex; lastChildNodeIndex--) {
      treeItemsList.get(lastChildNodeIndex).remove();
      treeItemsList.remove(lastChildNodeIndex);
    }
    var nextNodeIndexWithSameLevel = lastChildNodeIndex + 1 == treeItemsList.getLength() ? null : lastChildNodeIndex + 1;
    expandedNode.setNextNodeIndexWithSameLevel(nextNodeIndexWithSameLevel);
  }
  if (expandedNode.expandedNodeIndex == null || expandedNode.nextNodeIndexWithSameLevel == null) {
    treeItemsList.add(this);
  } else {
    treeItemsList.insertAt(expandedNode.nextNodeIndexWithSameLevel, this);
    expandedNode.nextNodeIndexWithSameLevel++;
  }
  this.setSelected(isSelected);
  this.parentid = parentid;
  this.hasOperations =false;
  this.rmn=rmn;
  this.rid=rid;
  this.pagecount=pagecount;
  this.pk=pk;
}



var invInitSearchArray = new Array();

/*****************************************************************************************/
/**                                 InvEndSearch Object                                 **/
/*****************************************************************************************/
/**
 * PROTECTED Constructor
 * The end of a branch with scroll inside. This item allows to travel along the children
 * of a branch from the actual position to the bottom, and allows to look for any child.
 * @param (String) name the name of the branch which is the parent of this children.
 * @param (String) type the type of the branch which is the parent of this children.
 */
function InvEndSearch(name, type, lastSearchedText,filtertext) {
  this.PADDING_LEFT = 10;
  this.TAB = 15;
  this.number = name == null ? "" : name;
  this.type = type == null ? "" : type;
  this.lastSearchedText = lastSearchedText;
  this.filtertext=filtertext;
  this.id = this.number == null ? "notDefinedYet" : "es" + this.number;
  this.lastWaySearch = "down";
  this.counter = treeItemsCounter++;
  this.show = function ()
  {
    if (document.getElementById(this.id) == null) {
      var imgDir = "/activator/images/inventory-gui/tree/";
      var oSpan = document.createElement("div");
      oSpan.setAttribute("id", this.id);
      oSpan.className = "scroll_branch";
      var oSp;
      if (expandedNode.nextNodeIndexWithSameLevel == null) {
        oSp = document.body.appendChild(oSpan);
      } else {
        var node = treeItemsList.get(expandedNode.nextNodeIndexWithSameLevel);
        oSp = document.body.insertBefore(oSpan, document.getElementById(node.id));
      }
      oSp.style.whiteSpace = "nowrap";
      oSp.style.width = "100%";
      oSp.style.height = "16px";
      oSp.style.padding = "0px";
      oSp.style.margin = "0px";
      var html = "<div style=\"margin-left:" + (this.TAB * this.level) + "px;\">";
      html += "<img id=\"ascr" + this.id + "\" src=\"" + imgDir + "bottom.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
      html += "oncontextMenu=\"return false;\" onclick=\"this.treeObject.scrollTo('bottom');\">";
      html += "<img id=\"rscr" + this.id + "\" src=\"" + imgDir + "bottomscroll.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
      html += "oncontextMenu=\"return false;\" onclick=\"this.treeObject.scrollTo('next');\">";
      html += "<input type=\"text\" name=\"in" + this.id + "\" id=\"in" + this.id + "\" size=\"10\" value=\"" + this.lastSearchedText + "\" ";
      html += "style=\"font-family:Verdana,Helvetica,Arial,Sans-serif; font-size:8pt; position:relative; top:0px; height:10px;\">";
      html += "<img id=\"esupimg" + this.number + "\" src=\"" + imgDir + "goto.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
      html += "onclick=\"this.treeObject.scrollTo();\">";
      if (this.filtertext == "null"){
        html += "<img id=\"essearchimg" + this.number + "\" src=\"" + imgDir + "searchbutton.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
        html += "onclick=\"this.treeObject.searchScroll();\">";
      }
      html += "<img id=\"esfilterimg" + this.number + "\" src=\"" + imgDir + "filterbutton.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
      html += "onclick=\"this.treeObject.filter();\">";
      if (this.filtertext != "null"){
        html += "<img id=\"esresetimg" + this.number + "\" src=\"" + imgDir + "filterreset.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
        html += "onclick=\"this.treeObject.filterReset();\">";
      }
      html += "</div>";
      document.getElementById(this.id).innerHTML = html;
      document.getElementById("in" + this.id).treeObject = this;
      document.getElementById("esupimg" + this.number).treeObject = this;
      document.getElementById("ascr" + this.id).treeObject = this;
      document.getElementById("rscr" + this.id).treeObject = this;
      if (this.filtertext=="null"){
        document.getElementById("essearchimg" + this.number).treeObject = this;
      }
      document.getElementById("esfilterimg" + this.number).treeObject = this;
      if (this.filtertext!="null"){
        document.getElementById("esresetimg" + this.number).treeObject = this;
      }
    }
  }
  this.search = function (way)
  {
    var scrLeft = $(document).scrollLeft();
    var scrTop = $(document).scrollTop();
    hideFlyingMenu();
    this.lastWaySearch = way;
    var inputValue = document.getElementById("in" + this.id).value;
    var url = "/activator/SearchBranchAction.do?search=" + inputValue + "&way=" + way;
    url += "&name=" + this.number + "&type=" + this.type + "&rmn=" + rmn+"&rimid=" + rid;
    url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance;
    this.parentTreeItem.removeChidren();
    window.open(url, "treeResult");
  }
  this.ifsearch = function ()
  {
    hideFlyingMenu();
    if (window.event && window.event.keyCode == 13) {
      this.search(this.lastWaySearch);
    }
  }
  this.scrollTo = function (scroll)
  {
    var scrLeft = $(document).scrollLeft();
    var scrTop = $(document).scrollTop();
    if(scroll == null){
      scroll = document.getElementById("in" + this.id).value;
      if (!checkNum(scroll)) {
        alert("Invalid integer value for field '" + scroll + "'.");
        return false;
      }
    }
    hideFlyingMenu();
    this.parentTreeItem.removeChidren();
    var url = "/activator/ScrollBranchAction.do?scroll=" + scroll;
    url += "&name=" + this.number + "&type=" + this.type + "&rmn=" + rmn+"&rimid=" + rid;
    url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance;
    window.open(url, "treeResult");
    return true;
  }
  this.remove = function ()
  {
    document.body.removeChild(document.getElementById(this.id));
  }
  this.searchScroll = function ()
  {
    var scrLeft = $(document).scrollLeft();
    var scrTop = $(document).scrollTop();
    var searchtext = document.getElementById("in" + this.id).value;
    searchtext = searchtext.replace(/\%/g, "*");
    if (isEmpty(searchtext)) {
      alert ("Please input search text");
      return false;
    }
    if (isAllstart(searchtext)) {
      alert ("Cannot input text which only has '*' !");
      return false;
    }
    hideFlyingMenu();
    this.parentTreeItem.removeChidren();
    var url = "/activator/ScrollBranchAction.do?scroll=1" ;
    url += "&searchScroll=" + searchtext;
    url += "&name=" + this.number + "&type=" + this.type + "&rmn=" + rmn+"&rimid=" + rid;
    url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance;
    window.open(url, "treeResult");
    return true;
  }
  this.filter = function ()
  {
    var scrLeft = $(document).scrollLeft();
    var scrTop = $(document).scrollTop();
    var filtertext=document.getElementById("in" + this.id).value;
    filtertext=filtertext.replace(/\%/g, "*");
    if (isEmpty(filtertext)) {
      return false;
    }
    if (isAllstart(filtertext)) {
      alert ("Cannot input text which only has '*' !");
      return false;
    }
    hideFlyingMenu();
    this.parentTreeItem.removeChidren();
    var url = "/activator/ScrollBranchAction.do?scroll=1";
    url += "&filterText=" + escape(filtertext);
    url += "&name=" + this.number + "&type=" + this.type + "&rmn=" + rmn+"&rimid=" + rid;
    url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance;
    window.open(url, "treeResult");
    return true;
  }
  this.filterReset = function	()
  {
    var scrLeft = $(document).scrollLeft();
    var scrTop = $(document).scrollTop();
    hideFlyingMenu();
    this.parentTreeItem.removeChidren();
    var url = "/activator/ScrollBranchAction.do?scroll=1"  ;
    url += "&filterReset=true" ;
    url += "&name=" + this.number + "&type=" + this.type + "&rmn=" + rmn+"&rimid=" + rid;
    url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance;
    window.open(url, "treeResult");
    return true;
  }
  if (expandedNode.expandedNodeIndex == null || expandedNode.nextNodeIndexWithSameLevel == null) {
    treeItemsList.add(this);
  } else {
    treeItemsList.insertAt(expandedNode.nextNodeIndexWithSameLevel, this);
    expandedNode.nextNodeIndexWithSameLevel++;
  }
  this.parentTreeItem = treeItemsList.get(treeItemsList.indexOf(invInitSearchArray[invInitSearchArray.length - 1]) - 1);
  invInitSearchArray.splice(invInitSearchArray.length - 1, 1);
  this.level = this.parentTreeItem.level + 1;
}




/*****************************************************************************************/
/**                                InvInitSearch Object                                 **/
/*****************************************************************************************/
/**
 * PROTECTED Constructor
 * The start of a branch with scroll inside. This item allows to travel along the children
 * of a branch from the actual position to the top.
 * @param (String) name the name of the branch which is the parent of this children.
 * @param (String) type the type of the branch which is the parent of this children.
 * @param (String) text the text which must appear inside this item. Typically it is composed
 * by the actual position, the last position in view and the total of children.
 */
function InvInitSearch(name, type, text,filtertext) {
  this.PADDING_LEFT = 10;
  this.TAB = 15;
  this.number = name == null ? "" : name;
  this.type = type == null ? "" : type;
  this.text = text == null ? "" : text;
  this.filtertext= filtertext;
  this.id = this.number == null ? "notDefinedYet" : "is" + this.number;
  this.counter = treeItemsCounter++;
  this.show = function ()
  {
    if (document.getElementById(this.id) == null) {
      var imgDir = "/activator/images/inventory-gui/tree/";
      var oSpan = document.createElement("div");
      oSpan.setAttribute("id", this.id);
      oSpan.className = "scroll_branch";
      var oSp;
      if (expandedNode.nextNodeIndexWithSameLevel == null) {
        oSp = document.body.appendChild(oSpan);
      } else {
        var node = treeItemsList.get(expandedNode.nextNodeIndexWithSameLevel);
        oSp = document.body.insertBefore(oSpan, document.getElementById(node.id));
      }
      oSp.style.whiteSpace = "nowrap";
      oSp.style.width = "100%";
      oSp.style.height = "16px";
      oSp.style.padding = "0px";
      oSp.style.margin = "0px";
      var html = "<div style=\"margin-left:" + (this.TAB * this.level) + "px;\">";
      html += "<img id=\"ascr" + this.id + "\" src=\"" + imgDir + "top.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
      html += "oncontextMenu=\"return false;\" onclick=\"this.treeObject.scrollTo('top');\">";
      html += "<img id=\"rscr" + this.id + "\" src=\"" + imgDir + "topscroll.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
      html += "oncontextMenu=\"return false;\" onclick=\"this.treeObject.scrollTo('previous');\">";
      html += "<span style=\"position:relative; top:1px;\">&nbsp;" + this.text + "</span>";
      if (this.filtertext != "null") {
        html += "<img id=\"fscr" + this.id + "\" src=\"" + imgDir + "filterhint.gif\" align=\"top\" style=\"cursor:pointer; width:16px; height:16px;\" ";
        html += "title=\"filter " + this.filtertext + "\" ";
        html += "oncontextMenu=\"return false;\" onclick=\"this.treeObject.fillinputtext(\'" + this.filtertext + "\');\">";
      }
      html += "</div>";
      html += "</span>";
      document.getElementById(this.id).innerHTML = html;
      document.getElementById("ascr" + this.id).treeObject = this;
      document.getElementById("rscr" + this.id).treeObject = this;
      if (this.filtertext!="null"){
        document.getElementById("fscr" + this.id).treeObject = this;
      }
    }
  }
  this.fillinputtext = function (filtertext)
  {
    if (document.getElementById("ines" + this.number) != null) {
      document.getElementById("ines" + this.number).value = filtertext;
    }
  }
  this.getParent = function ()
  {
    var i = treeItemsList.indexOf(this) - 1;
    return treeItemsList.get(i);
  }
  this.scrollTo = function (scroll)
  {
    var scrLeft = $(document).scrollLeft();
    var scrTop = $(document).scrollTop();
    hideFlyingMenu();
    this.getParent().removeChidren();
    var url = "/activator/ScrollBranchAction.do?scroll=" + scroll;
    url += "&name=" + this.number + "&type=" + this.type + "&rmn=" + rmn+"&rimid=" + rid;
    url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance;
    window.open(url, "treeResult");
  }
  this.remove = function ()
  {
    document.body.removeChild(document.getElementById(this.id));
  }
  if (expandedNode.expandedNodeIndex == null || expandedNode.nextNodeIndexWithSameLevel == null) {
    treeItemsList.add(this);
  } else {
    treeItemsList.insertAt(expandedNode.nextNodeIndexWithSameLevel, this);
    expandedNode.nextNodeIndexWithSameLevel++;
  }
  this.level = this.getParent().level + 1;
  invInitSearchArray[invInitSearchArray.length] = this;
}




/*****************************************************************************************/
/**                               InvMenuItemTree Object                                    **/
/*****************************************************************************************/
/*
function InvMenuItemTree(img, text, action, number) {
  this.img = img;
  this.text = text;
  this.action = action;
  this.number = number;
  this.getCode = function() {
    var imgDir = "/activator/images/inventory-gui/tree/";
    var html = "<div class=\"row\" onmousedown=\"" + this.action + "\">";
    html += "<img src=\"" + imgDir + this.img + "\">&nbsp;" + this.text;
    html += "</div>";
    return html;
  }
}
*/



/*****************************************************************************************/
/**                               InvMenuItem Object                                    **/
/*****************************************************************************************/
function InvMenuItem(img, text, mn, rt, irs, rurl, hasWarning, number,isDefault) {
  this.img = img;
  this.text = text;
  this.mn = mn;
  this.rt=rt;
  this.irs=irs; 
  this.rurl = rurl;
  this.hasWarning=hasWarning;
  this.newtab = rurl.indexOf("newtab=true") >= 0;
  this.action = rurl.indexOf("GetFullTreeInstanceAction.do") < 0 ?
      "addRimToMenu(" + mn + ", '" + rt + "' ," + irs + ", '" + rurl + "', " + hasWarning + ");return false;" :
      "switchView(3, '" + rt + "', " + irs + ", '"+ this.rurl + "', " + hasWarning + ", " + this.newtab + ");return false;";
  this.number = number;
  this.isDefault=isDefault;
  this.getCode = function () {
    var imgDir = "/activator/images/inventory-gui/tree/";
    var html = "<div class=\"row branch\" onmousedown=\"" + this.action + "\">";
    html += "<img src=\"" + imgDir + this.img + "\" style=\"width:12px; height:12px;\" align=\"top\">&nbsp;" + this.text;
    html += "</div>";
    return html;
  }
}


function searchtransferaction(menu, selectedOperation){
  var menuopt = null;
  var haswarning;
  if (selectedOperation) {
    for (var i = 0; i < menu.length && menuopt == null; i++) {
      if(!menu[i].text.toUpperCase().indexOf(selectedOperation.toUpperCase())) {
        menuopt = menu[i];
      }
    }
  }
  if (menuopt == null) {
    for (var i = 0; i < menu.length && menuopt == null; i++) {
      if(!menu[i].isDefault.indexOf("true")){
        menuopt = menu[i];
      }
    }
  }
  if (menuopt != null) {
    haswarning = !menuopt.hasWarning.indexOf("true");
    if (menuopt.rurl.indexOf("GetFullTreeInstanceAction.do") < 0) {
      parent.addRimToMenu(menuopt.mn, menuopt.rt, menuopt.irs, menuopt.rurl, haswarning);
    } else {
      parent.switchView(3, menuopt.rt, menuopt.irs, menuopt.rurl, haswarning, menuopt.newtab);
    }
  }
}
function trim(str)
{
 return str.replace(/(^\s*)|(\s*$)/g, "");
}
function ltrim(str)
{
 return str.replace(/(^\s*)/g,"");
}
function rtrim(str)
{
 return str.replace(/(\s*$)/g,"");
}
function isEmpty(s)
{
  return ((s == null)||(s.length == 0));
}
function isAllstart(str)
{
  str=str.replace(/\*/g, "");
  return str == null || str.length == 0;
}
function isCharsInBag(s, bag)
{
  var i;
  for (i = 0; i < s.length; i++)
  {
    var c = s.charAt(i);
    if (bag.indexOf(c) == -1) return false;
  }
  return true;
}

function checkNum(s)
{
  if (isEmpty(s))
  {
    return false;
  };
  if(!isCharsInBag (s.charAt(0), "123456789"))
  {
    return false;
  };
  if(!isCharsInBag (s.substring(1, s.length), "0123456789"))
  {
    return false;
  };
  return true;
}


/*****************************************************************************************/
/**                                    FILTER Object                                    **/
/*****************************************************************************************/
function Criterias () {
  var criterias = new Array();
  this.addCriteria = function (criteriaName, criteriaKey) {
    if (!existsCriteria(criteriaKey)) {
      criterias[criterias.length] = new CriteriaFilters(criteriaName, criteriaKey);
    }
  }
  var existsCriteria = function (criteriaKey) {
    var found = false;
    for (var i = 0; i < criterias.length && !found; i++) {
      found = criterias[i].getKey() == criteriaKey;
    }
    return found;
  }
  this.isEmpty = function () {
    return criterias.length == 0;
  }
  this.getCriteriaNames = function () {
    var names = new Array();
    for (var i = 0; i < criterias.length; i++) {
      names[names.length] = criterias[i].getName();
    }
    return names;
  }
  this.getCriteria = function (criteriaKey) {
    var criteria = null;
    for (var i = 0; i < criterias.length && criteria == null; i++) {
      if (criterias[i].getKey() == criteriaKey) {
        criteria = criterias[i];
      }
    }
    return criteria;
  }
  this.getCriteriaKey = function (criteriaName) {
    var criteria = null;
    for (var i = 0; i < criterias.length && criteria == null; i++) {
      if (criterias[i].getName() == criteriaName) {
        criteria = criterias[i];
      }
    }
    return criteria.getKey();
  }
  var getCriteriaByName = function (criteriaName) {
    var criteria = null;
    for (var i = 0; i < criterias.length && criteria == null; i++) {
      if (criterias[i].getName() == criteriaName) {
        criteria = criterias[i];
      }
    }
    return criteria;
  }
  this.addFilterIdToCriteria = function (criteriaKey, filterId) {
    this.getCriteria(criteriaKey).addFilterId(filterId);
  }
  this.getCriteriaFilterIds = function (criteriaName) {
    var criteria = getCriteriaByName(criteriaName);
    return criteria == null ? null : criteria.getFilterIds();
  }
  function CriteriaFilters (criteriaName, criteriaKey) {
    var filterIds = new Array();
    this.addFilterId = function (filterId) {
      if (!contains(filterId)) {
        filterIds[filterIds.length] = filterId;
      }
    }
    this.getName = function () {
      return criteriaName;
    }
    this.getKey = function () {
      return criteriaKey;
    }
    this.getFilterIds = function () {
      return filterIds;
    }
    var contains = function (filterId) {
      var found = false;
      for (var i = 0; i < filterIds.length && !found; i++) {
        found = filterIds[i] == filterId;
      }
      return found;
    }
  }
}


function UserFilter (id, name) {
  this.getId = function () {
    return id;
  }
  this.getName = function () {
    return name;
  }
}
/**
 * PROTECTED
 * This object stores each option of each select of the filter.
 * @param (String) sName the name of the option. This is the text that will be displayed as an option inside the select.
 * @param (String) sValue the value of the option. This is the value that will be set when the filter gets active.
 */
function FieldOption(sName, sValue) {
  this.name = sName;
  this.value = sValue;
}
/**
 * PROTECTED
 * This object stores each field of the filter.
 * @param (String) pVariable the variable tag of this field in the XML definition of the inventory view. This is the
 * name of the variable for this field along the definition.
 * @param (String) pAlias the alias tag of this field in the XML definition of the inventory view. This is the text to
 * describe this field in the JSP. If no alias is set, the variable itself is showed.
 * @param (String) pType the type of this field. It can take four values: "text", "date", "checkbox" or "listofvalues".
 * @param (String) group the group of this field. Fields can be grouped as a way to generate different filters.
 * @param (String) groupKey the key for the internationalization of the group name.
 * @param (Array) listOfValues the array of options. This is only used when the pType is set to "listofvalues".
 * @param (String) pValue the initial value of this field.
 */
function FilterField(pVariable, pAlias, pType, pGroup, pGroupKey, pLOV, pValue, mandatory) {
  this.variable = pVariable;
  this.alias = pAlias;
  this.type = pType;
  this.group = pGroup;
  this.groupKey = pGroupKey;
  this.listOfValues = pLOV;
  this.value = pValue;
  this.mandatory = mandatory;
}
/**
 * PUBLIC
 * The filter object.
 * @param (String) viewTitle the title of the filter.
 */
function Filter(viewTitle) {
  var viewName = viewTitle;
  var fields = new Array();
  var treeFiltered = false;
  var criterias = new Criterias();
  var selectedCriteria = null;
  var mandatoryCriteria = null;
  var name = null;
  var actualFilterName = null;
  var description = null;
  var userFilters = new Array();
  var mandatoryUserFilter = null;
  var scrollTop = null;
  this.resetUserFilters = function () {
    userFilters = new Array();
  }
  this.addUserFilter = function (id, name) {
    userFilters[userFilters.length] = new UserFilter(id, name);
  }
  this.getUserFilters = function () {
    return userFilters;
  }
  this.hasUserFilters = function () {
    return userFilters.length > 0;
  }
  /**
   * PUBLIC
   * Adds a new field to the filter.
   * @see FilterField for parameters descriptions.
   */
  this.addField = function (pVariable, pAlias, pType, pGroup, pGroupKey, pLOV, pValue, mandatory) {
    fields[fields.length] = new FilterField(pVariable, pAlias, pType, pGroup, pGroupKey, pLOV, pValue, mandatory);
    if (pGroup != null) {
      this.addCriteria(pGroup, pGroupKey, mandatory);
    }
  }
  this.updateFieldValue = function (pVariable, pValue) {
    var field;
    var updated = null;
    for (var i = 0; i < fields.length; i++) {
      field = fields[i];
      if (field.variable == pVariable) {
        if (!field.mandatory) {
          field.value = pValue;
          updated = true;
        } else {
          updated = field.value == pValue;
          alert("el campo " + field.variable + " actualizado es mandatory " + field.mandatory);
        }
        i = fields.length;
      }
    }
    return updated;
  }
  /**
   * PROTECTED
   * Returns the fields of this filter.
   * @return (Array) the fields of the filter.
   */
  this.getFields = function getFilterFields() {
    return fields;
  }
  /**
   * PROTECTED
   * Sets the fields of this filter if they are not set yet.
   */
  this.setFields = function (filterId) {
    var url = "/activator/GetFilterFieldsAction.do?instance=" + instance + "&view=" + view;
    if (filterId != null) {
      url += "&filterName=" + filterId;
    }
    window.open(url, "treeResult");
  }
  this.resetFields = function () {
    fields = new Array();
  }
  this.getName = function () {
    return name;
  }
  this.setName = function (filtername, mandatory) {
    name = filtername;
    if (mandatory != null && mandatory == true) {
      mandatoryUserFilter = filtername;
    }
  }
  this.setActualFilterName = function (afn) {
    actualFilterName = afn;
  }
  this.getActualFilterName = function () {
    return actualFilterName;
  }
  this.getMandatoryFilterName = function () {
    return mandatoryUserFilter;
  }
  this.getDescription = function () {
    return description
  }
  this.setDescription = function (dsc) {
    description = dsc;
  }
  /**
   * PUBLIC
   * Returns the name of the view this filter belongs to.
   * @return (String) the name of the view.
   */
  this.getViewName = function () {
    return viewName;
  }
  this.getViewInstanceId = function () {
    return "instance" + instance;
  }
  /**
   * PUBLIC
   * Sets the FilterPrinter object for this filter. The FilterPrinter object is used to show the filter
   * above the inventory JSP.
   * @see FilterPrinter in inventory.jsp for more information.
   */
  this.setFilterPrinter = function () {
    parent.filterPrinter.setFilter(this);
  }
  /**
   * PUBLIC
   * Checks if the tree is filtered or not.
   * @return (boolean) true if the tree is filtered; false otherwise.
   */
  this.isTreeFiltered = function () {
    return treeFiltered;
  }
  /**
   * PROTECTED
   * Activates or deactivates the filter, refreshing afterwords the tree if necessary.
   * @param (boolean) pIsTreeFiltered indicates if the filter must be active (true) or not (false).
   * @param (boolean) doRefresh indicates if the tree must be refreshed or not.
   */
  this.setTreeFiltered = function (pIsTreeFiltered, doRefresh) {
    treeFiltered = eval(pIsTreeFiltered);
    document.body.onselectstart = cancelEvent;
    if (doRefresh) {
      checkRefresh(true);
    }
  }
  /**
   * PROTECTED
   * Activates or deactivates the filter, refreshing afterwords the tree if necessary.
   * @param (boolean) pIsTreeFiltered indicates if the filter must be active (true) or not (false).
   * @param (boolean) doRefresh indicates if the tree must be refreshed or not.
   */
  this.SaveFilter = function () {
    SaveFilterAction();
  }
  /**
   * PROTECTED
   * Calls the FilterPrinter to show this filter.
   */
  this.show = function () {
    parent.filterPrinter.cancel();
    this.setFilterPrinter();
    parent.filterPrinter.show();
  }
  /**
   * PROTECTED
   * Adds a new criteria of fields.
   * @param (String) pCriteria the name of the criteria.
   * @param (String) pCriteriaKey the key for the interationalized name of the criteria.
   * @param (boolean) mandatory indicates if the criteria is mandatory.
   */
  this.addCriteria = function (pCriteria, pCriteriaKey, mandatory) {
    criterias.addCriteria(pCriteria, pCriteriaKey);
    if (mandatory) {
      mandatoryCriteria = pCriteria;
    }
  }
  this.addFilterIdToCriteria = function (criteriaName, filterId) {
    criterias.addFilterIdToCriteria(criteriaName, filterId);
  }
  /**
   * PROTECTED
   * Indicates if this filter has criterias or not.
   * @return (boolean) true if this filter has criterias; false otherwise.
   */
  this.hasCriterias = function () {
    var retval = !criterias.isEmpty();
    if (retval) {
      var cNames = this.getCriteriaNames();
      retval = !(cNames.length == 1 && cNames[0] == "");
    }
    return retval;
  }
  /**
   * PROTECTED
   * Returns the groups of this filter.
   * @return (Array) the names of the groups of this filter.
   */
  this.getCriteriaNames = function () {
    return criterias.getCriteriaNames();
  }
  this.getCriteriaFilters = function (criteriaName) {
    var filters = new Array();
    var filterIds = criterias.getCriteriaFilterIds(criteriaName);
    if (filterIds != null) {
      var filterId;
      var found;
      for (var i = 0; i < filterIds.length; i++) {
        filterId = filterIds[i];
        found = false;
        for (var j = 0; j < userFilters.length && !found; j++) {
          if (userFilters[j].getId() == filterId) {
            filters[filters.length] = userFilters[j];
            found = true;
          }
        }
      }
    }
    return filters;
  }
  this.getMandatoryCriteria = function () {
    return mandatoryCriteria;
  }
  /**
   * PROTECTED
   * Gets the active criteria key of the filter.
   * @return (String) the key of the active criteria whose fields are being used to filter the tree.
   */
  this.getSelectedCriteria = function () {
    return selectedCriteria;
  }
  /**
   * Changes the value of selectedCriteria if its actual value is the key of the selected criteria.
   */
  this.updateSelectedCriteria = function () {
    if (selectedCriteria != null) {
      var criteria = criterias.getCriteria(selectedCriteria);
      if (criteria != null) {
        selectedCriteria = criteria.getName();
      }
    }
  }
  this.getSelectedCriteriaKey = function () {
    return criterias.getCriteriaKey(selectedCriteria);
  }
  /**
   * PROTECTED
   * Sets the active criteria of the filter.
   * @param (String) sGroup the name of the criteria which will be set to active.
   */
  this.setSelectedCriteria = function (sGroup) {
    selectedCriteria = sGroup;
  }
  this.setScroll = function (scr) {
    scrollTop = scr;
  }
  this.getScroll = function () {
    return scrollTop;
  }
}

function cancelEvent() {
  return false;
}