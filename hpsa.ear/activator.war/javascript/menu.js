/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

var selectedMain=null;
var selectedAction=null;
var selectedRow=null;

function mouseOver(menuElem) {

        menuElem.style.backgroundColor="#afafaf"
        menuElem.bgColor="#afafaf"
        menuElem.style.cursor="hand";
	menuElem.style.width = "100%";
}

function mouseOut(item) {

        // if option is selected - leave it alone!
        item.style.backgroundColor = (selectedMain == item) ? "#cccccc" : "#E6E6E6";
        item.style.width = "100%";
}


function mClk(src) {
    if (event.srcElement.tagName=='TD')  {
       src.children.tags('a')[0].click();
    }
}


function popUp(URL,title) {
    window.open(URL,title,"toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=400,height=500");
}

function highlight(menuElem) {
        menuElem.style.backgroundColor="#afafaf";
	menuElem.style.width = "100%";
}

function unhighlight(menuElem) {
        // if option is selected - leave it alone!
        menuElem.style.backgroundColor = (selectedMain == menuElem) ? "#cccccc" : "#E6E6E6";
        menuElem.style.width = "100%";
}

function actUnhighlight(callingElement) {
	callingElement.style.backgroundColor = "#E6E6E6";
   	callingElement.style.width = "100%";
}

function actHighlight(callingElement) {
	callingElement.style.backgroundColor = "#afafaf";
   	callingElement.style.width = "100%";
}


function menuSelect(callingElement) {
    callingElement.style.backgroundColor = "#cccccc";
    callingElement.style.width = "100%";

    if (selectedMain != null) {
        selectedMain.style.backgroundColor = "#E6E6E6";
        selectedMain.style.width = "100%";
    }

    selectedMain = callingElement;
}

