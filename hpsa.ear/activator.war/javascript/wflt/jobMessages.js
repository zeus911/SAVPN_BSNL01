/**********************************************************************

   hp OpenView  service activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/

function JobMessage(message, date, stepName, queue) {
	this.message = message;
	this.date = date;
	this.stepName = stepName;
	this.queue = queue;
}
function JobMessages(jobName) {
	var jobName = jobName;
	var jobId = null;
	var serviceName = null;
	var servicePk = null;
	var messages = new Array();
	this.addMessage = function addJobMessage(message, date, stepName, queue) {
		messages[messages.length] = new JobMessage(message, date, stepName, queue);
	}
	this.setJobId = function setJId(jid) {
		jobId = jid;
	}
	this.setServiceName = function setSN(sname) {
		serviceName = sname;
	}
	this.setServicePk = function setSPK(spk) {
		servicePk = spk;
	}
	this.show = function showMessages() {
		if (messages.length > 0) {
			var html = "<table border=0 cellpadding=0 cellspacing=0 width=100%>";
			html += "<tr class=tableTitle>";
			html += "<td>" + jobName + "</td>";
			var onclk = rid == null ? "" : "parent.refreshParentRimTree(4, " + rid + ");";
			var params = "";
			if (jobId != null) {
				params += "?__wfJobId=" + jobId;
			}
			if (serviceName != null) {
				params += (jobId == null ? "?" : "&") + "__wfServiceName=" + serviceName;
			}
			if (servicePk != null) {
				params += (params.indexOf("?") < 0 ? "?" : "&") + "__wfServicePk=" + serviceName;
			}
			html += "<td align=\"right\"><input type=button class=buttonA style=\"border:double #333333; height:25;\" value=\"&raquo;&nbsp;Borrar\" onclick=\"" + onclk + "window.location.href='DeleteMessagesWFLT.do" + params + "';\"></td>";
			html += "</tr>";
			html += "<tr><td class=tableHeading height=3 colspan=2></td></tr>";
			html += "<tr style=\"width:100%;\"><td colspan=2>";
			html += "<span style=\"width:100%; height:expression(document.body.clientHeight > 50 ? document.body.clientHeight - 50 : 50); overflow:auto;\">";
			html += "<table border=0 cellpadding=0 cellspacing=0 width=100%>";
			for (var i = 0; i < messages.length; i++) {
				var className = i % 2 == 0 ? "tableOddRow" : "tableEvenRow";
				html += "<tr class=" + className + ">";
				html += "<td class=tableCell width=\"10%\"><b>&raquo;&nbsp;" + messages[i].queue + "</b></td>";
				html += "<td class=tableCell colspan=3><nobr>" + messages[i].date + "</nobr></td>";
				html += "</tr>";
				html += "<tr class=" + className + ">";
				html += "<td class=tableCell width=\"10%\">&nbsp;</td>";
				html += "<td class=tableCell width=\"10%\"><nobr><b>" + messages[i].stepName + "</b></nobr></td>";
				html += "<td class=tableCell colspan=2>" + messages[i].message + "</td>";
				html += "</tr>";
			}
			html += "</table></span></td></tr>";
			html += "</table>";
			var wm = document.createElement("span");
			wm.setAttribute("id", "_wfmsg_");
			var wmo = document.body.appendChild(wm);
			wmo.style.position = "absolute";
			wmo.style.top = 10;
			wmo.style.left = 10;
			wmo.innerHTML = html;
		}
	}
}