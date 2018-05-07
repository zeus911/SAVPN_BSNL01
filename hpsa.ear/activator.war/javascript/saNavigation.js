/**********************************************************************
   hp OpenView service activator
   (c) Copyright 2013 Hewlett-Packard Development Company, L.P.

   Functions for the Left Navigational Pane
**********************************************************************/

var tabSelected;
var inventoryWindowsArray = new Array();
var serviceWindowsArray   = new Array();

function openPool() {
  var win;
  win = window.open('/activator/jsf/resmgr/pools/poolcreate.jsf','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=950,height=500');
  win.focus();
}

function setSelectedTab(tabElem) {
  tabSelected = tabElem;
}

function highlightTab(tabElem) {
  // if tab is already selected leave it alone
  if ((tabSelected != tabElem) && (tabElem.className != "tabSelected")) {
    tabElem.className="tabMouseOver";
  }
}

function unHighlightTab(tabElem) {
  // if option is selected - leave it alone!
  if ((tabSelected != tabElem) && (tabElem.className != "tabSelected")){
    tabElem.className="tabUnSelected";
  }
}

function selectTab(tabElem) {
  // If the user has never selected a tab, the first tab is always selected for them
  if (tabSelected == null) {
    document.getElementById("tab0").className="tabUnselected";
  } 
  else { 
    tabSelected.className="tabUnselected";
  }
  tabElem.className="tabSelected";
  tabSelected=tabElem;
}

function unselectTabs(count){
  for(var i=0; i< count; i++ ){
    var tabElem = document.getElementById("tab"+i);
    tabElem.className="tabUnselected";
  }
}

function highlightMenu(menuElem) {
  menuElem.className="menuSelected";
}

function unhighlightMenu(menuElem) {
  menuElem.className = (selectedMenu == menuElem) ? "execMenu" : "menuUnselected";
}

var selectedMenu;

function menuSelect(callingElement) {
  callingElement.className="execMenu";
  if (selectedMenu != null) {
      selectedMenu.className = "menuUnselected";
  }
  selectedMenu = callingElement;
}

function menuUnSelect() {
  if (selectedMenu != null) {
    selectedMenu.className = "menuUnselected";
    selectedMenu = null;
  }
}

var logFileSelected;

function highlightLogFile(logElem) {
  if (logElem.className != "fileSelected"){
    logElem.className="fileMouseOver";
  }
}

function unhighlightLogFile(logElem) {
  if (logElem.className != "fileSelected"){
    logElem.className = (selectedMenu == logElem) ? "fileMouseOver" : "fileUnSelected";
  }
}

function activeLogFile(logElem){
  logFileSelected.className = "fileUnSelected";
  logElem.className = "fileSelected";
  setSelectedLogFile(logElem);
}

function setSelectedLogFile(logElem) {
  logFileSelected = logElem;
}

function updateScrollBar(trElem){
  var divElem = document.getElementById('file_div');
  divElem.scrollTop = trElem.offsetTop;
}

function Map()
{
  // members
  this.keyArray = new Array(); // Keys
  this.valArray = new Array(); // Values
  // methods
  this.put = put;
  this.get = get;
  this.remove = remove;
}

function findIt( key )
{
  var result = (-1);
  if (this.keyArray) {
    for( var i = 0; i < this.keyArray.length; i++ )
    {
      if( this.keyArray[ i ] == key )
      {
        result = i;
        break;
      }
    }
  }
  return result;
}

function put( key, val )
{
  var elementIndex = this.findIt( key );
  if( elementIndex == (-1) )
  {
    this.keyArray.push( key );
    this.valArray.push( val );
  }
  else
  {
    this.valArray[ elementIndex ] = val;
  }
}

function get( key )
{
  var result = null;
  var elementIndex = this.findIt( key );
  if( elementIndex != (-1) )
  {
    result = this.valArray[ elementIndex ];
  }
  return result;
}

function remove( key )
{
  var result = null;
  var elementIndex = this.findIt( key );
  if( elementIndex != (-1) )
  {
    this.keyArray = this.keyArray.removeAt(elementIndex);
    this.valArray = this.valArray.removeAt(elementIndex);
  }
  return;
}

