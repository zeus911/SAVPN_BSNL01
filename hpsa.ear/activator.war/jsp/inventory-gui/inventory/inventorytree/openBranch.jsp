<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.definition.TreeInstance" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.Node" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ShowField" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.Operation" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ScrollBranch" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>
<%@ page import="com.hp.ov.activator.inventory.facilities.StringFacility" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.text.MessageFormat" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html>

<head>
  <script>
  var rmn = eval(<%= request.getParameter("rmn") %>);
  var rid = eval(<%= request.getParameter("rimid") %>);
<%
String rmn = request.getParameter("rmn");
String instance = request.getParameter("instance");
String refreshTreeRimid=request.getParameter("rmn")+"_"+request.getParameter("rimid");
TreeInstance ti = (TreeInstance) request.getSession().getAttribute(ConstantsFTStruts.VIEW + instance);
if (ti == null) {
%>
  window.status = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("543", "Open branch is not possible. View does not exist");
<%
} else {
%>
  function printResult() {
<%
  int i = 0;
  Node node = (Node) ti.getBranch(request.getParameter("name"), request.getParameter("type"));
  if (node == null) {
    String strMsg = MessageFormat.format(com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("544", "No branch exists with name {0} and type {1}."), new Object[]{request.getParameter("name"), request.getParameter("type")});
    System.out.println(strMsg);
  }
  if (node.isExpanded() && node.getChildrenNames() == null && node.getScroll() <= 0) {
    node.setExpanded(false);
%>
    var imgDir = "/activator/images/inventory-gui/tree/";
    var iconItem = parent.document.getElementById("ecimg" + <%= node.getBranchName() %>);
    if (iconItem != null) {
      iconItem.src = imgDir + "leaf.gif";
      iconItem.onclick = "";
      iconItem.style.cursor = "default";
    }
<%
  } else if (node.isExpanded()) {
    String parentItemid = "ti"+node.getBranchName();
    Vector nodes = new Vector();
    Node[] childrenNodes = (Node[]) node.getChildrenInstances();
    if(node.getScroll()!=0){
      int endcount=0;
      if (node.getCacheAllChildren()) {
        endcount = node.getCurrentscroll() - 1 + node.getScroll();
        if(node.getChildrenInstances()!=null){
          endcount = (endcount >= node.getChildrenInstances().length) ? node.getChildrenInstances().length : endcount;
        }
        endcount--;
      } else {
        endcount = node.getCurrentscroll() - 1 + (childrenNodes == null  ? 0:(childrenNodes.length < node.getScroll()) ? childrenNodes.length : node.getScroll());
      }
      if(((node.getCurrentscroll() ==1&&endcount== node.getFindbycount()) || (node.getFindbycount() <= node.getScroll()))&& node.getFiltertext()==null ){
        if (childrenNodes != null) {
          for (int j = childrenNodes.length - 1; j >= 0; j--) {
            nodes.add(0, childrenNodes[j]);
          }
        }
      }else{
        nodes.add(0, new ScrollBranch("Scroll ending", node.getCurrentscroll() , node.getScroll(), node.getType(), node.getBranchName(), node.getFindbycount(),node.getFiltertext()));
          if (childrenNodes != null) {
            if (node.getCacheAllChildren()) {
              for (int j = endcount; j >= node.getCurrentscroll()-1; j--) {
                nodes.add(0, childrenNodes[j]);
              }
            } else {
              for (int j = childrenNodes.length - 1; j >= 0; j--) {
                nodes.add(0, childrenNodes[j]);
              }
            }
          }
          nodes.add(0, new ScrollBranch("Scroll begining", node.getCurrentscroll() , node.getScroll(), node.getType(), node.getBranchName(), node.getFindbycount(),node.getFiltertext()));
        }
      }else{
        if (childrenNodes != null) {
          for (int j = childrenNodes.length - 1; j >= 0; j--) {
            nodes.add(0, childrenNodes[j]);
          }
        }
      }
      boolean selected;
      boolean scroll_branch=false;		// check current node is a scroll branch "ScrollBranch"
      String collapsed;
      while (i < nodes.size()) {
        try {
          ScrollBranch objStr = (ScrollBranch) nodes.elementAt(i);
          if (objStr.getBranchType().equals("Scroll begining")) {
            int endcount=node.getCurrentscroll()+node.getScroll()-1;
            if(endcount>node.getFindbycount()){
              endcount=node.getFindbycount();
            }
            String text = node.getCurrentscroll() + " to " + endcount + " of " + node.getFindbycount();
            if(childrenNodes == null){
              text="no items found";
            }
%>
    var ti = new parent.InvInitSearch('<%=objStr.getName()%>', '<%=objStr.getType()%>', '<%=text%>', '<%=objStr.getFiltertext()%>'  );
    window.parent.expandedNode.show(ti);
<%
          } else if (objStr.getBranchType().equals("Scroll ending")) {
            String lastSearchedText = request.getParameter("search") == null ? "" : request.getParameter("search");
%>
    var ti = new parent.InvEndSearch('<%=objStr.getName()%>', '<%=objStr.getType()%>', '<%=StringFacility.replaceAllByHTMLCharacter(lastSearchedText)%>','<%=objStr.getFiltertext()%>' ); 
    window.parent.expandedNode.show(ti);
<%
          }
          scroll_branch=true;
        } catch (ClassCastException cce) {
          scroll_branch=false;
          node = (Node) nodes.elementAt(i);
          String selStr = (String) request.getAttribute("selectedNode");
          selected = selStr == null ? false : selStr.equals(node.getType()+node.getPrimaryKey());
          if(rmn.equals("1")){
            collapsed = !node.hasChildren() ? "null" : "" + !node.isExpanded();
          } else {
            collapsed = !node.hasChildrenInstances() ? "null" : "" + !node.isExpanded();
          }
%>
    var ti = new parent.TreeItem("<%=parentItemid%>", <%=node.getLevel()%>, <%=selected%>, <%=collapsed%>, "<%=node.getType()%>", "<%=node.getBranchName()%>", "<%=node.getResolvedImage()%>",rmn,rid, parent.parent.operation_scroll,"<%=node.getType()%><%=node.getPrimaryKey()%>" );
<%
          ShowField[] asf = node.getResolvedShowField();
          for (int k = 0; k < asf.length; k++) {
            ShowField sf = asf[k];
            for (int l = 0; l < sf.getShowFieldsCount(); l++) {
            String branchText =sf.getLocalizedText(l)==null?"":sf.getLocalizedText(l);
            branchText = StringFacility.replaceAllByHTMLCharacter(branchText.replace('\n',' ').trim());
%>
    ti.addText("<%=branchText%>", <%=sf.isBold(l)%>, <%=sf.isItalic(l)%>, "<%=sf.getTextColor(l)%>");
<%
          }
        }
        Operation[] op = node.getResolvedOperations();
        if (op != null) {
          for (int k = 0; k < op.length; k++) {
            Operation op1 = op[k];
            String act = op1.getAction();
            String opname = StringFacility.replaceAllByHTMLCharacter(URLDecoder.decode(op1.getName(), "UTF-8"));
%>
    ti.addMenuItem("<%=op1.getImage()%>", "<%=opname%>", parent.rmn + 1,  "<%=opname%>", true, "<%=act%><%=act.indexOf("?") != -1 ? "&" : "?"%>refreshTreeRimid=<%=refreshTreeRimid%>&opname=<%=opname%>&ndid=<%=node.getBranchName()%>&vi=<%=instance%>&datasource=<%=ti.getDataSourceName()%>&view=<%=request.getParameter(ConstantsFTStruts.VIEW)%>", "<%=op1.hasWarning()%>" , "<%=op1.isDefault()%>");
<%
          }
        }
      }
%>
    window.parent.expandedNode.show(ti);
<%
      if(!scroll_branch){
        if (node != null && node.isExpanded() ) {
          childrenNodes = (Node[]) node.getChildrenInstances();
        if(node.getScroll()!=0){
          int startcount=(node.getCurrentscroll()-1)*node.getScroll()+1;
          int endcount = startcount;
          if (node.getCacheAllChildren()) {
            endcount = (node.getCurrentscroll()-1)*node.getScroll() + node.getScroll();
            if(node.getChildrenInstances()!=null){
              endcount = (endcount >= node.getChildrenInstances().length) ? node.getChildrenInstances().length : endcount;
            }
          } else {
            endcount=(node.getCurrentscroll()-1)*node.getScroll()+  (childrenNodes == null  ? 0:childrenNodes.length);
          }
          if(startcount==1&&endcount>= node.getFindbycount()&& node.getFiltertext()==null ){
            if (childrenNodes != null) {
              for (int j = childrenNodes.length - 1; j >= 0; j--) {
                nodes.add(i+1, childrenNodes[j]);
              }
            }
          } else {
            nodes.add(i+1, new ScrollBranch("Scroll ending", node.getCurrentscroll() , node.getScroll(), node.getType(), node.getBranchName(), node.getFindbycount(),node.getFiltertext()));
            if (childrenNodes != null) {
              if (node.getCacheAllChildren()) {
                for (int j = endcount; j >= startcount-1; j--) {
                  nodes.add(i+1, childrenNodes[j]);
                }
              } else {
                for (int j = childrenNodes.length - 1; j >= 0; j--) {
                  nodes.add(i+1, childrenNodes[j]);
                }
              }
            }
            nodes.add(i+1, new ScrollBranch("Scroll begining", node.getCurrentscroll() , node.getScroll(), node.getType(), node.getBranchName(), node.getFindbycount(),node.getFiltertext()));	
          }
        } else {
          if (childrenNodes != null) {
            for (int j = childrenNodes.length - 1; j >= 0; j--) {
              nodes.add(i+1, childrenNodes[j]);
            }
          }
        }
      }
    }
    i++;
    }// end while
  }
%>
    parent.setScroll(<%= request.getParameter("scrTop") == null ? "0" : request.getParameter("scrTop") %>, <%= request.getParameter("scrLeft") == null ? "0" : request.getParameter("scrLeft") %>);
<%
  if (request.getParameter("parentid") != null ) {
%>    
    var parentitem=parent.document.getElementById('<%=request.getParameter("parentid")%>').treeObject;
    parentitem.refreshexpendimage();
<%
  }	
%>
    parent.waitingResult = false;
  }
  var cont = 0;
  var numBranches = <%=i-1%>;
<%
}
%>
</script>
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>

<body onload="printResult();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();"></body>

</html>

<%
String errorMessage = (String) request.getAttribute(ConstantsFTStruts.ERROR_MESSAGE);
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
alert('<%=errorMessage%>');
</script>
<%
}
%>
