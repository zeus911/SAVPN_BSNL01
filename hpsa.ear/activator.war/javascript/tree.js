/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

function saveCurrentScrollPos()
{
   if ( document != null && 
	    document.body != null &&
	    document.body.scrollLeft != null ) {
	top.scrollX = document.body.scrollLeft;
	top.scrollY = document.body.scrollTop;
   }
   return true;
}

function blank()
{
    return "<html></html>";
}
