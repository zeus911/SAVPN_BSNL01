<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ taglib uri="/WEB-INF/xmaps-taglib.tld" prefix="xmaps" %>

<%@ page import="com.hp.ov.activator.xmaps.model.XDiagram" %>
<%@ page import="com.hp.ov.activator.xmaps.model.XLayer" %>
<%@ page import="com.hp.ov.activator.xmaps.model.XLayer.XDiagramReference" %>
<%@ page import="com.hp.ov.activator.xmaps.utils.SessionManager" %>

<%
String pnext = request.getParameter("next");
boolean isNext = pnext == null ? false : Boolean.parseBoolean(pnext);
String sessionKey = request.getParameter("sessionKey");
XDiagram xdiagram = SessionManager.getDiagram(session, sessionKey);
XLayer xlayer;
XDiagramReference ref;
if (xdiagram == null) {
  System.out.println("No diagram found in session manager with the key " + sessionKey);
} else if (!xdiagram.isLayer()) {
  System.out.println("No layered diagram found in session manager with the key " + sessionKey);
} else {
  xlayer = (XLayer)xdiagram;
  if (isNext) { 
    if (!xlayer.hasNextReference()) {
      System.out.println("Layered diagram does not have a next diagram reference");
    } else {
      System.out.println("Switching to next diagram reference...");
      ref = xlayer.nextReference();
      if (ref == null) {
        System.out.println("No next diagram reference found in layered diagram");
      } else {
        System.out.println("Next diagram reference has name " + ref.getName() + " and solution name " + ref.getSolution());
      }
    }
  } else {
    if (!xlayer.hasPreviousReference()) {
      System.out.println("Layered diagram does not have a previous diagram reference");
    } else {
      System.out.println("Switching to previous diagram reference...");
      ref = xlayer.previousReference();
      if (ref == null) {
        System.out.println("No previous diagram reference found in layered diagram");
      } else {
        System.out.println("Previous diagram reference has name " + ref.getName() + " and solution name " + ref.getSolution());
      }
    }
  }
}
%>

<html>
<head>

</head>
<body>

<xmaps:update scope="session_manager" id="<%= sessionKey %>" />

</body>
</html>