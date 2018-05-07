/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

function moveVertList( srcList, isMoveUp){
  if (( srcList.selectedIndex == -1 )){
    // Do nothing if nothing is selected
    return;
  } else{
      var selected = srcList.selectedIndex;
      if ( srcList.length == 0 ) {
        // If there's only one in the list
        return;
      }else {
        if ( (selected == srcList.length-1 && !isMoveUp) ||
        (selected == 0 && isMoveUp) ){
            //if we want to move first record up or last record down
            return;
        }else{
            var shifter = 0;
            if(isMoveUp){
                shifter = -1;
            }else{
                shifter = 1;
            }
            var moveText1 = srcList[selected+shifter].text;
            var moveText2 = srcList[selected].text;
            var moveValue1 = srcList[selected+shifter].value;
            var moveValue2 = srcList[selected].value;
            srcList[selected].text = moveText1;
            srcList[selected].value = moveValue1;
            srcList[selected+shifter].text = moveText2;
            srcList[selected+shifter].value = moveValue2;
            srcList.selectedIndex = selected+shifter;
        }
      }
  }
}

function moveDualList( srcList, destList, sortOff ) 
{
  // Do nothing if nothing is selected
  if (( srcList.selectedIndex == -1 )){
    return;
  }
  var newDestList = new Array( destList.options.length );
  var len = 0;
  for( len = 0; len < destList.options.length; len++ ){
   if ( destList.options[ len ] != null ){
      newDestList[ len ] = new Option( destList.options[ len ].text, destList.options[ len ].value, destList.options[ len ].defaultSelected, destList.options[ len ].selected );
    }
  }
  for( var i = 0; i < srcList.options.length; i++ ){ 
    if ( srcList.options[i] != null && srcList.options[i].selected == true ){
       // Statements to perform if option is selected
       // Incorporate into new list
       newDestList[ len ] = new Option( srcList.options[i].text, srcList.options[i].value, false, false );
       len++;
    }
  }


  // Sort out the new destination list
  if ( !sortOff ){
    sorter( newDestList ); 
  }

  // Populate the destination with the items from the new array
  for ( var j = 0; j < newDestList.length; j++ ){
    if ( newDestList[ j ] != null ){
      destList.options[ j ] = newDestList[ j ];
    }
  }



  // Erase source list selected elements
  for( var i = srcList.options.length - 1; i >= 0; i-- ){ 
    if ( srcList.options[i] != null && srcList.options[i].selected == true ){
       // Erase Source
       //srcList.options[i].value = "";
       //srcList.options[i].text  = "";
       srcList.options[i]       = null;
    }
  }
} // End of moveDualList()

function sorter(array) {
  for (var i=0; i<(array.length-1); i++){
    for (var j=i+1; j<array.length; j++){
      if (array[j].value < array[i].value) {
        var dummy = array[i];
        array[i] = array[j];
        array[j] = dummy;
      }
    }
  }
}

function sortList(array) {
  for (var i=0; i<(array.length-1); i++){
    for (var j=i+1; j<array.length; j++){
      if (array.options[j].value < array.options[i].value) {
        var dummy_val = array.options[i].value;
        var dummy_text = array.options[i].text;
        array.options[i].value = array.options[j].value;
        array.options[i].text = array.options[j].text;
        array.options[j].value = dummy_val;
        array.options[j].text = dummy_text;
      }
    }
  }
}
