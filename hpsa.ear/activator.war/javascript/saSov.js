/*******************************************************************************
 * hp OpenView service activator (c) Copyright 2010 Hewlett-Packard Development
 * Company, L.P.
 * 
 ******************************************************************************/

function interactWithJob(queue, job, interactionType, queryString) 
{
  var winLink = "/activator/jsp/saInteractWithJob.jsp?queueName=" + queue + "&jobId=" + job + "&interactionType=" + interactionType;
  if (queryString != null && queryString != "") {
	  winLink += "&" + queryString;
  }
  window.open(winLink,'interact','resizable=yes,status=yes,width=750,height=300,scrollbars=yes');
  return true;
}

function changeRoles(job, queue)
{
  var url="/activator/jsp/saChangeRoles.jsp?callState=initialize&queueName="+queue+"&jobId="+job;
  var win=window.open(url,'changeRolesWindow','resizable=no,status=yes,width=400,height=250');
  window.top.changeRolesWindow = win;
  win.focus();
  return true;
}

function stopJobConfirm(job, stopMsg)
{
  if (confirm(stopMsg + job)) {
    return true;
  }
  return false;
}

function changePriority(job)
{
   var win=window.open('/activator/jsp/saChangePriority.jsp?jobId='+job,'changePriorityWindow','resizable=no,status=yes,width=400,height=250');
   win.focus();
   return true;
}

function modifyScheduledJob(job, queryString) 
{
  var winLink = "/activator/jsp/saShowScheduledJob.jsp?jobId=" + job + "&operation=edit";
  if (queryString != null && queryString != "") {
	  winLink += "&" + queryString;
  }
  window.open(winLink,'schedule','resizable=yes,status=yes,width=500,height=545,scrollbars=yes');
  return true;
}

function deleteMessageConfirm(msg)
{
  if (confirm(msg)) {
    return true;
  }
  return false;
}

function openNewAuditInstance(auditId) 
{
   var win;
   win=window.open('/activator/jsp/saShowAuditMsgInfo.jsp?id='+auditId,'','resizable=yes,status=no,width=500,height=424,scrollbars=yes');
   win.focus();
   if(window.top.auditWindowsArray == null){
      window.top.auditWindowsArray = new Array();
    }
    window.top.auditWindowsArray.push(win);
}

function displayAuditInstances(auditId) 
{
  var win = null;
  if(window.top.auditWindowsArray == null) {
     window.top.auditWindowsArray = new Array();
  }
  for(var i=0; i<window.top.auditWindowsArray.length; i++) {
    if(!window.top.auditWindowsArray[i].closed){
        win = window.top.auditWindowsArray[i];
        break;
    }
  }
  if(win==null) {
    win = window.open('/activator/jsp/saShowAuditMsgInfo.jsp?id='+auditId,'','resizable=yes,status=no,width=500,height=424,scrollbars=yes');
    window.top.auditWindowsArray.push(win);
  } else {
    win.document.location = '/activator/jsp/saShowAuditMsgInfo.jsp?id='+auditId;
  }
  win.focus();
}

function viewActivationDetails(txSeq) 
{
    var winLink = "/activator/jsp/saActivationDetails.jsp?transactionSeqId=" + txSeq;
    window.open(winLink,'','resizable=yes,status=yes,width=750,height=300,scrollbars=yes');
}

function setQueryParams(jobId, serviceId, orderId, type, state, tabIndex, jobsTabIndex)
{
/* alert('Indexes (tabIndex/jobsTabIndex): ' + tabIndex + '/' + jobsTabIndex); */
  alert('Indexes (tabIndex/jobsTabIndex): ' + document.getElementById('resultsTabForm:selectedTabIndex').value + '/' + document.getElementById('resultsTabForm:selectedJobsTabIndex').value);
	if (jobId != null) {
		document.getElementById('servicesQueryForm:jobId').value = jobId;
	}
	if (serviceId != null) {
		document.getElementById('servicesQueryForm:serviceId').value = serviceId;
	}
	if (orderId != null) {
		document.getElementById('servicesQueryForm:orderId').value = orderId;
	}
	if (type != null) {
		document.getElementById('servicesQueryForm:type').value = type;
	}
	if (state != null) {
		document.getElementById('servicesQueryForm:state').value = state;
	}
	document.getElementById('servicesQueryForm:tabIndex').value = document.getElementById('resultsTabForm:selectedTabIndex').value;
	document.getElementById('servicesQueryForm:jobsTabIndex').value = jobsTabIndex;
	document.getElementById('servicesQueryForm:submit').click();
}

function checkForURLParameters() 
{
	var urlParam = new Array();
	var query = window.location.search.substring(1);
	if (query == "") {
		return false;
	}
	query = decodeURI(query);
	var parms = query.split('&');
	var submitNeeded = false;
	for (var i=0; i<parms.length; i++) {
		var pos = parms[i].indexOf('=');
		if (pos > 0) {
			var key = parms[i].substring(0,pos);
			var val = parms[i].substring(pos+1);
			urlParam[key] = val;
			submitNeeded = true;
		}
	}
	if (!submitNeeded) {
		return false;
	}
	var errMsg = "Unrecognized parameters : ";
	var invalidParam = false;
	
	for (var j in urlParam) {	
		var temp = unescape(urlParam[j]);
		if (j == "jobId") {
			document.getElementById('servicesQueryForm:jobId').value = temp;
		} else {
			if (j == "serviceId") {
				document.getElementById('servicesQueryForm:serviceId').value = temp;
			} else if (j == "orderId") {
				document.getElementById('servicesQueryForm:orderId').value = temp;
			} else if (j == "type") {
				document.getElementById('servicesQueryForm:type').value = temp;
			} else if (j == "state") {
				document.getElementById('servicesQueryForm:state').value = temp;
			} else if (j == "resultsTab") {
				document.getElementById('servicesQueryForm:resultsTab').value = temp;
			} else if (j == "jobsTab") {
				document.getElementById('servicesQueryForm:jobsTab').value = temp;
			} else {
				errMsg += j + ";";
				invalidParam = true;
			}
		}
	}
	if (invalidParam) {
		alert(errMsg);
		return false;
	}
	if (submitNeeded) {
	  document.getElementById('servicesQueryForm:submit').click();
	}
	return true;
}

function setSelectedTabIndex(tabIndex)
{
  document.getElementById('servicesQueryForm:tabIndex').value = tabIndex;
  return tabIndex;
}
