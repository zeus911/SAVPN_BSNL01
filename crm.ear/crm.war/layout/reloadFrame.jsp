<%--------------------------------------------------------------------------%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.  --%>
<%--------------------------------------------------------------------------%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<html:html>
  <head>
    <title>ReloadApplet</title>
    <script type="text/javascript">
  // Should be called from the page to check for changes
  // i.e. <body onmousemove="parent.reload.setYPos();" onLoad="parent.reload.doScroll();"
  var yIndex    = 0;
  var timeoutId = null;
  var bDoUpdate = true;
  var doReset = '';
  var terminateThread = '';
  var reloadURL = '/ListCustomer.do';
  // variable to lock tracking for the scroll changes 
  var scrollLock = false;
  // variable to control ModifyServiceForm.jsp versions
  var lastPageLoad = '0';

  var customerId ='';
  var checkFrame = '';
  var lastTime;

  var serviceoperation='false';
  //Finds a frame that check for a services changes
  function findInstance(){
    return top.reload.checker;
/*
    if(true == top.reload.checker.test()){
        alert('reloader works ok');
    }
*/
  }
  
  function lockScroll(){
	scrollLock = true;
  }
  function unlockScroll(){
	scrollLock = false;
  }

  /**
  * Sets the YPOS of the page. Called upon a onMouseMove event.
  */  
  function setYPos()
  {
  
	if(scrollLock == true)
		return;
		
    if (''+window.navigator == '') {
      parent.reload.yIndex = parent.main.document.body.scrollTop;
     } else {
      parent.reload.yIndex = parent.main.window.pageYOffset;
    }
  }

  /**
  * Scrolls to the last saved YPOS.
  */
  function doScroll()
  {
    parent.main.window.scroll(1,yIndex);
  }

  /**
  * Reloads frame that checks for a customer's services changes.
  * Frame compares lastTime parameter with the services' last times and finds out if services view need to be refreshed.
  * Hereafter the startReload method is called with false as parameter. The parameter
  * indicates that the lastTime variable should not be reset.
  */
  function checkReload(){
    //findInstance().doTrace('checkReloadApplet called'); 
    checkFrame = findInstance();
    if(checkFrame != '')
		{		
		
		   if(serviceoperation != 'true')
			   {
        checkFrame.location = '/crm/jsp/ShowServiceUpdateTime.jsp?CustomerId='+customerId+'&LastTime='+parent.reload.lastTime;
		 startReload('false'); 
		      }
		
    }
  }

  /**
  * called from the check frame if a diff is found between the lastTime variable and lastTime of customer's services
  */
  function doUpdate(newLastTime) {
    //findInstance().doTrace('doUpdate called'); 
    // Only do update if it has been alowed from the startReload method.
    if (bDoUpdate) {
      checkFrame = findInstance();
      parent.reload.lastTime = newLastTime;

      if(checkFrame != '')
	  {
		  if(serviceoperation != 'true'){
          parent.main.location = reloadURL; }
      }
    }
  }

  /*
  * Called from the onLoad event on the html page. When called from soem page outside the one being 
  * monitored for changes the doReset will typically be true, forcing the reload applet to forget its
  * last page. In this way the applet is forced in sync with the browser view using the doUpdate function.
  * 
  * This function is also called after each timeout, that is from each checkReload call. At aech of these calls 
  * doReset will be false. 
  *
  * The timeout or reload interval is set to 5 sec.
  */
  function startReload(doReset){
    //findInstance().doTrace('startReload doReset = ' + doReset);	
    checkFrame = findInstance();
	//alert("checkFrame =="+checkFrame)
	//alert("doReset =="+doReset)
    if((checkFrame != '')&& (''+doReset == 'true')){
        lastTime = '0';
    }
    bDoUpdate = true;
	
    timeoutId = setTimeout("parent.reload.checkReload();",5000);
  }

  function setURL(url){
    reloadURL = url;
  }

  function setServiceOperation(serviceOperation){
    serviceoperation = serviceOperation;
  }

  function getServiceOperation(){
    return serviceoperation;
  }

  function setCustomerId(id){
    customerId = id;
  }

  /**
  * Called from the onUnLoad event from the browser. It clears the timeout
  * and ensures that no reload can be done before startReload has been called by setting the 
  * bDoReload flag.
  */
  function stopReload(terminateThread)
  {    
    //findInstance().doTrace('stopReload terminateThread = '+terminateThread);    	
    bDoUpdate = false;
    clearTimeout(timeoutId);
  }

</script>
  </head>
<frameset>
  <frame src="jsp/ShowServiceUpdateTime.jsp" name="checker" scrolling="no" noresize />
</frameset>
</html:html>

<!-- vim:softtabstop=4:shiftwidth=4:expandtab
-->
