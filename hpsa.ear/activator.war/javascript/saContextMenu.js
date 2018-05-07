/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/


function hideContextMenu (menuName) {
      var menu = document.getElementById(menuName);
      if(menu!=null)
        menu.style.visibility = "hidden";
      return false;
}


function showContextMenu (evt) {

    var menuName = window.menuName;
    var menu = document.getElementById(menuName);
    var parentRow;

    // get the event regardles of IE or Netscape
    var jobEvent = evt || window.event;

    if (document.all) {
       parentRow = jobEvent.srcElement.parentElement;
       while (parentRow.tagName != "TR") { 
          parentRow = parentRow.parentElement;
       }
    } else {
       // walk the tree until we find a row
       parentRow = jobEvent.target.parentNode;
       while (parentRow.tagName != "TR") { 
          parentRow = parentRow.parentNode;
       }
    }

    // no rightclick menu if the user selected the table headers
    if (parentRow.id == "header" || parentRow.className == "tableRowWarning" || parentRow.className == "tableRowError"
            || parentRow.className == "tableRowInfo" || parentRow.className == "tableOddRowNoPointer" || parentRow.className == "tableEvenRowNoPointer") {
        return false;
    }

    // select the row
    rowSelect(parentRow);

    //Store the data in the cookie
    setCookie(menuName,parentRow.id);

    var posX = 0;
    var posY = 0;
    var menu = document.getElementById(menuName);
    
    //which scroll shuold we use?
    //mainDiv id is used only in job screen
    var scroll_ = document.getElementById("mainDiv");
    if(scroll_ == null){
        scroll_ = document.body; 
    }
    

    if (jobEvent.pageX || jobEvent.pageY) {
        //netscape
        posX = jobEvent.pageX;
        posY = jobEvent.pageY;
    }
    else if (jobEvent.clientX) {
        //IE
        posX = jobEvent.clientX + scroll_.scrollLeft;
        posY = jobEvent.clientY + scroll_.scrollTop;
    }
    
    if(!jobEvent.pageX && document.getElementById("mainDiv") != null){
    //mainDiv id is used only in job screen
        posY = posY - 93;
        posX = posX - 12;
    }

    menu.style.left = posX + "px";
    menu.style.top = posY + "px";
    menu.style.visibility = "visible";

    if(menu.id == "jobsMenu"){
        var temp = parentRow.id;
        var aPosition = temp.indexOf(",");
        if(aPosition>0) {
            var rowInfoArray = new Array();
            rowInfoArray = temp.split(",");
            var jobid=rowInfoArray[0];
            var interactionType=rowInfoArray[1];
            if(interactionType ==2){
                //display debug job menu
                var menuItem = document.getElementById("debugjob");
                if(menuItem){
                    menuItem.style.display="block"
                }
                var menuItem1 = document.getElementById("debugjobhr");
                if(menuItem1){
                    menuItem1.style.display="block";
                }
                
                //hide interact job menu
                menuItem = document.getElementById("interactjob");
                if(menuItem){
                    menuItem.style.display="none";
                }
                menuItem1 = document.getElementById("interactjobhr");
                if(menuItem1){
                    menuItem1.style.display="none";
                }

                //hide change priority menu
                menuItem = document.getElementById("changepriority");
                if(menuItem){
                    menuItem.style.display="none";
                }
                menuItem1 = document.getElementById("changepriorityhr");
                if(menuItem1){
                    menuItem1.style.display="none";
                }

                //hide change role menu
                menuItem = document.getElementById("changerole");
                if(menuItem){
                    menuItem.style.display="none"
                }
                menuItem1 = document.getElementById("changerolehr");
                if(menuItem1){
                    menuItem1.style.display="none";                
                }                
            } else {
                //hide debug job menu
                var menuItem = document.getElementById("debugjob");
                if(menuItem){
                    menuItem.style.display = "none";
                }
                var menuItem1 = document.getElementById("debugjobhr");
                if(menuItem1){
                    menuItem1.style.display="none";   
                }  
                
                //display interact job menu
                menuItem = document.getElementById("interactjob");
                if(menuItem){
                    menuItem.style.display="block";
                }
                menuItem1 = document.getElementById("interactjobhr");
                if(menuItem1){
                    menuItem1.style.display="block";
                }

                //display change priority menu
                menuItem = document.getElementById("changepriority");
                if(menuItem){
                    menuItem.style.display="block";
                }
                menuItem1 = document.getElementById("changepriorityhr");
                if(menuItem1){
                    menuItem1.style.display="block";
                }

                //display change role menu
                menuItem = document.getElementById("changerole");
                if(menuItem){
                    menuItem.style.display="block"
                }
                menuItem1 = document.getElementById("changerolehr");
                if(menuItem1){
                    menuItem1.style.display="block";               
                }                
            }
        }    
    }

    return false;
}

function toggleHighlight (evt) {

    evt = (evt) ? evt : ((event) ? event : null);
    if (evt) {
        var elem = (evt.target) ? evt.target : evt.srcElement;
        if (elem.nodeType == 3)  { // textvalue of the element
            elem = elem.parentNode;
        }
        if (elem.className.indexOf("menuItem") != -1) {
            elem.className = (evt.type == "mouseover") ? "menuItemOn" : "menuItem";
        }
    }
}

