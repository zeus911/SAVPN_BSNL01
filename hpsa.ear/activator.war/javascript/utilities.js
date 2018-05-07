/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

function promptAndInsert (serviceID, fieldName, fieldValue)
{
    clearMessageLine();

    var fieldValue = prompt (serviceID + ":  New value for field '" + fieldName + "'?", fieldValue);

    if (fieldValue != null && fieldValue.length > 0) {
    location = 'UpdateField.jsp?serviceID=' + serviceID + '&fieldName=' + 
        fieldName + '&fieldValue=' + fieldValue;
    }
}

function clearMessageLine()
{
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
}

function writeToMsgLine(msg)
{
    var fPtr = parent.frames['messageLine'].document;
    fPtr.open();
    fPtr.write("<html>");
    fPtr.write("<link rel='stylesheet' type='text/css' href='../css/activator.css'>");
    fPtr.write("<link rel='stylesheet' type='text/css' href='../css/inventory.css'>");
    fPtr.write("<body class=invField>");
    fPtr.write(msg);
    fPtr.write("</body></html>");
    fPtr.close();
}
