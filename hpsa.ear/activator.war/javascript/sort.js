/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

function ieOrFireFox(ob)
   {
       if (ob.textContent != null)
       return ob.textContent;
       var s = ob.innerText;
       return s.substring(0, s.length);
   }

   // tableId: table's id; iCol: column count ??dataType??column data type
   function sortAble(tableId, iCol, dataType) {
       var table = document.getElementById(tableId);
       var imgObj = document.getElementById("sortCol_"+iCol);
       if(imgObj){

       if (imgObj.getAttribute("src").indexOf("up")>0){
table.rows[0].cells[iCol].innerHTML = ieOrFireFox(table.rows[0].cells[iCol]) + "<img id=sortCol_"+ iCol +" src='../images/down.gif' align='absmiddle' border='0'/>"
       }else{
table.rows[0].cells[iCol].innerHTML = ieOrFireFox(table.rows[0].cells[iCol]) + "<img id=sortCol_"+ iCol +" src='../images/up.gif' align='absmiddle' border='0'/>"
       }}
       var tbody = table.tBodies[0];
       var colRows = tbody.rows;
       var aTrs = new Array;
        //put all rows into array, except the head row
       for (var i=0; i < colRows.length; i++) {
             aTrs[i] = colRows[i];
       }

       //check if sort the same column,if true, make the reverse sequence
       if (table.sortCol == iCol) {
          aTrs.reverse();
       } else {
       //if not the same column, sort the new column
           aTrs.sort(compareEle(iCol, dataType));
           table.rows[0].cells[iCol].innerHTML = ieOrFireFox(table.rows[0].cells[iCol]) + "<img id=sortCol_"+ iCol +" src='../images/up.gif' align='absmiddle' border='0'/>"
       }

       var oFragment = document.createDocumentFragment();

       for (var i=0; i < aTrs.length; i++) {
           oFragment.appendChild(aTrs[i]);
       }
       tbody.appendChild(oFragment);
       // record the sorted column last time
       table.sortCol = iCol;

       
       sortBackGround(tableId);

   }
   // check the data type and return the type in JavaScript
   function convert(sValue, dataType) {
       switch(dataType) {
       case "int":
           return parseInt(sValue);
       case "float":
           return parseFloat(sValue);
       case "date":
           return new Date(Date.parse(sValue));
       default:
           return sValue.toString();
       }
   }

   // compare the data between different rows, use the bubble algorithm
   function compareEle(iCol, dataType) {
       return  function (oTR1, oTR2) {
           var vValue1 = convert(ieOrFireFox(oTR1.cells[iCol]), dataType);
           var vValue2 = convert(ieOrFireFox(oTR2.cells[iCol]), dataType);
           if (vValue1 < vValue2) {
               return -1;
           } else if (vValue1 > vValue2) {
               return 1;
           } else {
               return 0;
           }
          };
   }
   
   function mOver(obj){
      obj.style.cursor="hand";
   }
   
   function sortBackGround(tid){
     var allRows = document.getElementById(tid).rows;
     
     var rowNum = 1;
     for(var i=0;i<allRows.length;i++){
        var classType = (rowNum%2 == 0) ? "tableOddRow" : "tableEvenRow";
        allRows[i].className = classType;
        rowNum++;
     }

   }
