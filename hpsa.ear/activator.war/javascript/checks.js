/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/



// Returns true if the number is a valid integer
function checkInt (param, name)
{
   var foo = parseInt (param);
   if (isNaN (foo)) {
       alert ("Invalid integer value for field '" + name + "'.");
       return false;
   }
   else 
      return true;
}

// Returns true if a value exists
function checkDropDown (param, name)
{
   if (param == -1) {
       alert ("No value to select for field '" + name + "'.");
       return false;
   }
   else 
      return true;
}

function clearMessageLine()
{
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
}

