<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<script language="JavaScript">
function find(what) {
    for (var i=0;i<parent.frames.length;i++) {
         if (parent.frames[i].name == what)
             return true;
    }
    return false;
}

function showFrame() {
	var dispUMM = '<%=session.getAttribute("displayUMM")%>';
	var wrapedJsp = '';
	if (dispUMM == 'null') {
		wrapedJsp = '/activator/jsp/saShowUMMManagement.jsp?displayUMM=UI';
	} else {
		wrapedJsp = '/activator/jsp/saShowUMMManagement.jsp?displayUMM='+dispUMM;
	}
	if (find('displayFrame')) {
		parent.displayFrame.location=wrapedJsp;
	} else {
		str = '<frameset rows="100%" frameborder="0" framespacing="0">';
		str += '<frame src="'+wrapedJsp+'" name="displayFrame" topmargin="0" marginwidth="10" marginheight="0"  noresize scrolling="auto">';
		str += '</frameset>';
		document.write(str); 
	}

}

</script>
<body onLoad="showFrame()">	
