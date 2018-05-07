/**********************************************************************

     (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

var selectedMain=null;
var selectedAction=null;
var selectedRow=null;
var selectedFile= "mwfm_active.log.xml";


var rowClass=null;

var interactPerm = 1;
var stopPerm= 2;
var fullPerm= 3;

function selectFile(name) {
	selectedFile=  name;
}

function getSelectedFile(ruta) {
	return (ruta+ selectedFile);   
}




function mouseOver(row) {
    row.style.backgroundColor='#8cbdde';
    row.style.cursor='hand';
}

function mouseOut(row) {
    if (row != selectedRow) {
        row.style.backgroundColor= (row.className=="tableEvenRow") ? "#cccccc":"#e6e6e6";
        row.style.cursor='hand';
    }
}


function menuUnSelect(callingElement) {
    if (!callingElement.contains(event.toElement)) {
	callingElement.style.backgroundColor = "#E6E6E6";
	callingElement.style.width = "100%";
    }
}


function actionSelect(callingElement) {
    if (!callingElement.contains(event.fromElement)) {
	callingElement.style.backgroundColor = "#cccccc";
	callingElement.style.width = "100%";
    }

    if (selectedAction != null) {
        selectedAction.style.backgroundColor = "#E6E6E6";
        selectedAction.style.width = "100%";
    }

    selectedAction = callingElement;
}

function rowSelect(callingElement) {

 
     callingElement.style.backgroundColor='#8cbdde';
     var tmpRowClass = callingElement.className;

     callingElement.className = "tableRowSelect";
     callingElement.style.width = "100%";

    //reset the selected row for next time
    if (selectedRow != null) {
            selectedRow.style.backgroundColor= (rowClass=="tableEvenRow") ? "#cccccc":"#E6E6E6";
    	selectedRow.className = rowClass;
    	selectedRow.style.width = "100%";
        }
    
        if (callingElement == selectedRow) {
             selectedRow = null;
             rowClass = null;
    	 window.top.jobIsSelected = false;
        } 
        else {
             selectedRow = callingElement;
             rowClass=tmpRowClass;
    	 window.top.jobIsSelected = true;
    }
    
    window.top.selectedRow = selectedRow;
    return false;
}



var menuName;
var lastMenuName = '';

function setMenuName (name) {
  menuName = name;  
}

function setLastMenuName (name) {  
  lastMenuName = name;
}





