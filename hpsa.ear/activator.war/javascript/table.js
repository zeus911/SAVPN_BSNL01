/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

var selectedRow=null;
var rowClass=null;

var interactPerm = 1;
var stopPerm= 2;
var fullPerm= 3;

function mouseOver(row) {
    if (row.className == "tableRowWarning" || row.className == "tableRowError") {
        return false;
    }
    row.style.backgroundColor='#afafaf';
    row.style.cursor='hand';
}

function mouseOut(row) {
    if (row.className == "tableRowWarning" || row.className == "tableRowError") {
        return false;
    }

    if (row != selectedRow) {
        row.style.backgroundColor= (row.className=="tableEvenRow") ? "#cccccc":"#e6e6e6";
        row.style.cursor='hand';
    }
}

function isInteractWinOpen () {

   // if win and win.open exist and win.closed isn't true -- the window is still open
   var win = window.top.interactWindow;
   if (win && win.open && !win.closed) {
        return true;
   }
   else {
        return false;
   }
}


function isJobSelected() {
    return window.top.jobIsSelected;
}

function checkInteractJob(selectMsg, permMsg) {
   if (!isJobSelected()) {
    alert(selectMsg);
        return false;
   }

   var jobPerms = window.top.jobPermissions;
   if (jobPerms == "1" || jobPerms == "3" ) { 
        return true;
    }
    else {
    alert(permMsg);
        return false;
    }
}

function checkStopJob(selectMsg, permMsg) {
   if (!isJobSelected()) {
    alert(selectMsg);
        return false;
   }

   var jobPerms = window.top.jobPermissions;
   if (jobPerms == "3" || jobPerms == "2" ) { 
        return true;
    }
    else {
    alert(permMsg);
        return false;
    }
}

function resetJobSelection() {
     window.top.jobIsSelected = false;
}

function rowSelectPerm(callingRow, jobPerm) 
{
    window.top.jobPermissions = jobPerm;
    rowSelect(callingRow);
}

function isRowSelected (rowObj) {
    if (rowObj.id == window.top.selectedRow.id) { 
        return true;
    }
    return false;
}
 
function rowSelect(callingElement) {
    
    rowUnSelect();
     
    var tmpRowClass = callingElement.className;
    callingElement.style.backgroundColor='#afafaf';
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

function rowUnSelect(){
    if (selectedRow != null) {
        selectedRow.style.backgroundColor= (rowClass=="tableEvenRow") ? "#cccccc":"#E6E6E6";
        selectedRow.className = rowClass;
        selectedRow.style.width = "100%";
        selectedRow = null;
    }
}

function saveScrollPos()
{
   if ( document != null && 
        document.body != null &&
        document.body.scrollLeft != null ) {
     window.top.scrollX = document.body.scrollLeft;
     window.top.scrollY = document.body.scrollTop;
   }
   return true;
}

function saveMsgScrollPos()
{
   if ( document != null &&
        document.body != null &&
        document.body.scrollLeft != null ) {
        window.top.msgScrollX = document.body.scrollLeft;
        window.top.msgScrollY = document.body.scrollTop;
   }
   return true;
}
