/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/


function mouseOverBtn(elem) {
        elem.className="hdrTabSelected";
}

function mouseOutBtn(elem) {
        elem.className="hdrTabUnSelected";
}

function highlightMenuItem(item) {
    item.className="menuItemSelected";
}

function unhighlightMenuItem(item) {
    item.className="menuItemUnselected";
} 

function popUpAbout() {
    var win;
    win=window.open('about.jsp','about','width=550,height=350,resizeable=yes');
    win.focus();
}

