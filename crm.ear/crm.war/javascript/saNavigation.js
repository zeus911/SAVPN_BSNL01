/**********************************************************************

©(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 


   Functions for the Left Navigational Pane
**********************************************************************/

var tabSelected;

function displayInventory() {

  var win;
  win = window.open('./inventory/invFrame.jsp?displayType=inventory','','resizable=yes,status= yes,width=700,height=600');
  win.focus();
}

function displayInstances() {

  var win;
  win=window.open('./inventory/invFrame.jsp?displayType=instance','','resizable=yes,status=yes,width=700,height=600');
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


function highlightMenu(menuElem) {
    menuElem.className="menuSelected";
}

function unhighlightMenu(menuElem) {
    menuElem.className = (top.selectedMenu == menuElem) ? "execMenu" : "menuUnselected";
}


//var selectedMenu; - placed to the higher level, e.g. to saMain.html

function menuSelect(callingElement) {
    //callingElement.style.backgroundColor = "#cccccc";
    //callingElement.style.width = "100%";	
    if(top.selectedMenu != callingElement){
    callingElement.className="execMenu";

    if (top.selectedMenu != null) {
      
        top.selectedMenu.className = "menuUnselected";
    }

    top.selectedMenu = callingElement;}	
}
