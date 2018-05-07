/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

// This function performs form validation and should be called from 
// the onSubmit() event handler.  Currently, this validation is only
// done for String fields that are not optional.

function verify(vForm, message)
{
    var emptyFields="";

    for (var i=0; i<vForm.length; i++) {
      if (vForm.elements[i].type == "text" && !vForm.elements[i].optional ) {
         // if the value is empty add to the empty list
         if (vForm.elements[i].value == null || vForm.elements[i].value == "") {
	     emptyFields += vForm.elements[i].name;
             continue;
         }
       }
    }

    // If we have required fields that are empty - post a message
    if (!emptyFields) {
       return true;
    } 

    alert("hp service activator\n\n" + message + "\n" + emptyFields);

    return false;
}

    
