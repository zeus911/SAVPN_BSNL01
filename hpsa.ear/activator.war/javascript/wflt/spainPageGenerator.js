/**********************************************************************

   hp OpenView  service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

function checkIP(param, name){
        var IPSeparator= ".";

//0. Skip validation if empty field
        if (param == null || param.length < 1) {
                return true;
                
        }

//1. Check first Byte
        var pos1=param.indexOf(IPSeparator) 
        if (pos1==-1) {
                alert ("Field '" + name + "' is not valid. IP must have 4 numbers (between 0 and 255) separated by dots."); 
                return false
        }
        var Byte=param.substring(0,pos1)
        var restOfString=param.substring(pos1+1)

        if ((Byte == null || Byte.length < 1) ||  !isInteger(Byte) || Byte<0 || Byte>255 ) {
                alert ("Field '" + name + "' is not valid. IP must have 4 numbers (between 0 and 255) separated by dots."); 
                return false
        }

//2. Check second Byte
        var pos2=restOfString.indexOf(IPSeparator) 
        if (pos2==-1) {
                alert ("Field '" + name + "' is not valid. IP must have 4 numbers (between 0 and 255) separated by dots."); 
                return false
        }
        Byte=restOfString.substring(0,pos2)
        restOfString=restOfString.substring(pos2+1)

        if ((Byte == null || Byte.length < 1) ||  !isInteger(Byte) || Byte<0 || Byte>255 ) {
                alert ("Field '" + name + "' is not valid. IP must have 4 numbers (between 0 and 255) separated by dots."); 
                return false
        }
        
//3. Check third Byte
        var pos3=restOfString.indexOf(IPSeparator) 
        if (pos3==-1) {
                alert ("Field '" + name + "' is not valid. IP must have 4 numbers (between 0 and 255) separated by dots."); 
                return false
        }
        Byte=restOfString.substring(0,pos3)
        restOfString=restOfString.substring(pos3+1)

        if ((Byte == null || Byte.length < 1) ||  !isInteger(Byte) || Byte<0 || Byte>255 ) {
                alert ("Field '" + name + "' is not valid. IP must have 4 numbers (between 0 and 255) separated by dots."); 
                return false
        }       
//4. Check 4rd Byte
        Byte=restOfString
        
        if ((Byte == null || Byte.length < 1) ||  !isInteger(Byte) || Byte<0 || Byte>255 ) {
                alert ("Field '" + name + "' is not valid. IP must have 4 numbers (between 0 and 255) separated by dots."); 
                return false
        }               
        return true;
}

function checkNull(param, name) 
{

	if (param == null || param.length < 1) {
    	alert ('Field "'+ name +'" must not be null.');
    	return false;
    } else
     	return true;
    
}


function trim(inputString) {
   // Removes leading and trailing spaces from the passed string. Also removes
   // consecutive spaces and replaces it with one space. If something besides
   // a string is passed in (null, custom object, etc.) then return the input.
   if (typeof inputString != "string") { return inputString; }
   var retValue = inputString;
   var ch = retValue.substring(0, 1);
   while (ch == " ") { // Check for spaces at the beginning of the string
      retValue = retValue.substring(1, retValue.length);
      ch = retValue.substring(0, 1);
   }
   ch = retValue.substring(retValue.length-1, retValue.length);
   while (ch == " ") { // Check for spaces at the end of the string
      retValue = retValue.substring(0, retValue.length-1);
      ch = retValue.substring(retValue.length-1, retValue.length);
   }
//   while (retValue.indexOf("  ") != -1) { // Note that there are two spaces in the string - look for multiple spaces within the string
//      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length); // Again, there are two spaces in each of the strings
//   }
   return retValue; // Return the trimmed string back to the user
} // Ends the "trim" function

function isInteger(s){
        var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}