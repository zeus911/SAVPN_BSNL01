<!DOCTYPE html>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.Vector" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.hp.ov.activator.inventory.facilities.StringFacility" %>
<%@ page import="com.hp.ov.activator.mwfm.WFManager" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.LoginServlet" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.definition.TreeInstance" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.Field"%>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.Node" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.Operation" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ScrollBranch" %>
<%@ page import="com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ShowField" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%!
//I18n strings
final static String futuretree_ready="Ready";
final static String futuretree_loading="Loading...";
final static String set_filter = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1280", "Set filter");
final static String update_filter = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1281", "Update filter");
final static String remove_filter = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1282", "Unload filter");
%>
<%
WFManager wfmanager = (WFManager) session.getAttribute("mwfm_session");
String instance = request.getParameter("instance");
TreeInstance ti = (TreeInstance) request.getSession().getAttribute(ConstantsFTStruts.VIEW + instance);
if (ti == null) {
%>
<script>window.location.href = "/activator/jsp/inventory-gui/inventory/inventorytree/inventoryTreeError.jsp";</script>
<%
} else {
%>
<html>

<head>
  
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory-gui/inventory.css"/>
  <script src="/activator/javascript/inventory-gui/inventory/inventorytree/inventoryTree.js"></script>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
  <script type="text/javascript" src="/activator/javax.faces.resource/jquery/jquery.js.jsf?ln=primefaces"></script>
  <script type="text/javascript" src="/activator/javax.faces.resource/jquery/jquery-plugins.js.jsf?ln=primefaces"></script>
  <script>
<%
  if (request.getParameter("operation") != null) {
%>
  var selectedOperation = "<%= request.getParameter("operation") %>";
<%
	} else {
%>
  var selectedOperation = null;
<%
  }
%>
  var rmn = <%= request.getParameter("rmn") %>; // tab bar number ( 1..4 ) -- a number
  var rid = <%= request.getParameter("rimid") %>; // tab id -- a number
  var instance = <%= instance %>; // instance number to identify the session attribute where the view is stored ("view" + instance) -- a number
  var view = "<%= request.getParameter(ConstantsFTStruts.VIEW) %>"; // view name
  var scrLeft = <%= request.getParameter("scrLeft") == null ? "0" : request.getParameter("scrLeft") %>; // scroll left
  var scrTop = <%= request.getParameter("scrTop") == null ? "0" : request.getParameter("scrTop") %>; // scroll top
  var treeFilter = null;
  var hasMandatoryFilter = <%= ti.hasFilterMandatory() %>;
  </script>
  <script>
  function init() {
    var viewTitle = "";
<%
  String rmn = request.getParameter("rmn");
  String refreshTreeRimid = rmn + "_" + request.getParameter("rimid");
  String selStr = (String) request.getAttribute("selectedNode");
  int i = 0;
  Node node = (Node) ti.getFirstShown();
  Vector nodes = new Vector();
  nodes.add(0, node);
  Node[] childrenNodes = (Node[]) node.getChildrenInstances();
  boolean selected;
  boolean scroll_branch=false;		// check current node is a scroll branch "ScrollBranch";
  String collapsed;
  while (i < nodes.size()) {
    try {
      ScrollBranch objStr = (ScrollBranch) nodes.elementAt(i);
      if (objStr.getBranchType().equals("Scroll begining")) {
        int endcount=node.getCurrentscroll() + node.getScroll()-1;
        if(endcount>node.getFindbycount()){
          endcount=node.getFindbycount();
        }
        String text = node.getCurrentscroll() + " to " + endcount + " of " + node.getFindbycount();
        if(childrenNodes == null){
          text="no items found";
        }
%>
    var ti = new InvInitSearch('<%=objStr.getName()%>', '<%=objStr.getType()%>', '<%=text%>', '<%=objStr.getFiltertext()%>' );
<%
      } else if (objStr.getBranchType().equals("Scroll ending")) {
        String lastSearchedText = request.getParameter("search") == null ? "" : request.getParameter("search");
%>
    var ti = new InvEndSearch('<%=objStr.getName()%>', '<%=objStr.getType()%>', '<%=StringFacility.replaceAllByHTMLCharacter(lastSearchedText)%>','<%=objStr.getFiltertext()%>');
<%
      }
      scroll_branch=true;
    } catch (ClassCastException cce) {
      scroll_branch=false;
      node = (Node) nodes.elementAt(i);
      selected = selStr == null ? false :selStr.equals(node.getType()+node.getPrimaryKey());
      if (rmn.equals("1")){
        collapsed = !node.hasChildren() ? "null" : "" + !node.isExpanded();
      } else {
        collapsed = !node.hasChildrenInstances() ? "null" : "" + !node.isExpanded();
      }
%>
    var ti = new TreeItem("ti"+"<%=node.getBranchName()%>",<%=node.getLevel()%>, <%=selected%>, <%=collapsed%>, "<%=node.getType()%>", "<%=node.getBranchName()%>", "<%=node.getResolvedImage()%>",rmn,rid, parent.operation_scroll,"<%=node.getType()%><%=node.getPrimaryKey()%>" );
<%
      ShowField[] asf = node.getResolvedShowField();
      for (int k = 0; k < asf.length; k++) {
        ShowField sf = asf[k];
        for (int l = 0; l < sf.getShowFieldsCount(); l++) {
          String branchText = StringFacility.replaceAllByHTMLCharacter(sf.getLocalizedText(l));%>
    ti.addText("<%= branchText %>", <%= sf.isBold(l) %>, <%= sf.isItalic(l) %>, "<%= sf.getTextColor(l) %>");
<%
          if (i == 0 && k == 0) {
            if (ti.getTd().solutionLabel != null) {
%>
    viewTitle = "<%= ti.getTd().solutionLabel+"/"+ti.getTd().getTreeName() %>";
<%
            } else {
%>
    viewTitle = "<%= ti.getTd().getTreeName() %>";
<%
            }
          }
        }
      } // end for
      if (i == 0) {
%>
    parent.TabBarManager.setTabLabel(rmn, viewTitle, rid);
    parent.TabBarManager.setTabFiltered(rmn, <%= ti.isFiltered() %>, rid);
<%
      }
      Operation[] op = node.getResolvedOperations();
      if (op != null) {
        for (int k = 0; k < op.length; k++) {
          Operation op1 = op[k];
          String act = op1.getAction();
          String opname = StringFacility.replaceAllByHTMLCharacter(URLDecoder.decode(op1.getName(), "UTF-8"));
%>
    ti.addMenuItem("<%= op1.getImage() %>", "<%= opname %>", rmn + 1,  "<%= opname %>", true, "<%= act %><%=act.indexOf("?") != -1 ? "&" : "?"%>refreshTreeRimid=<%= refreshTreeRimid %>&opname=<%= opname %>&ndid=<%=node.getBranchName()%>&vi=<%=instance%>&datasource=<%=ti.getDataSourceName()%>&view=<%= request.getParameter(ConstantsFTStruts.VIEW) %>", "<%= op1.hasWarning() %>" , "<%= op1.isDefault() %>");
<%
        }//for
      }//if
    }//end try catch
%>
    if (ti.isSelected && selectedOperation != null) {
      ti.setSelectedOperation(selectedOperation);
    }
    ti.show();
<%
    if(!scroll_branch){
      if (node != null && node.isExpanded() ) {
        childrenNodes = (Node[]) node.getChildrenInstances();
        if(node.getScroll()!=0){
          int startcount=node.getCurrentscroll();
          int endcount = startcount;
          if (node.getCacheAllChildren()) {
            endcount = node.getCurrentscroll() - 1 + node.getScroll();
            int childrenLength = (childrenNodes != null) ? childrenNodes.length : 0;
            endcount = (endcount >= childrenLength) ? childrenLength : endcount;
          } else {
            endcount = node.getCurrentscroll() - 1 + (childrenNodes == null  ? 0:(childrenNodes.length < node.getScroll()) ? childrenNodes.length : node.getScroll());
          }
          if(startcount==1&&endcount== node.getFindbycount() && node.getFiltertext()==null ){
            if (childrenNodes != null) {
              for (int j = childrenNodes.length - 1; j >= 0; j--) {
                nodes.add(i+1, childrenNodes[j]);
              }
            }
          } else {
            nodes.add(i+1, new ScrollBranch("Scroll ending", node.getCurrentscroll() , node.getScroll(), node.getType(), node.getBranchName(), node.getFindbycount(),node.getFiltertext()  ));
            if (childrenNodes != null) {
              if (node.getCacheAllChildren()) {
                for (int j = endcount-1; j >= startcount-1; j--) {
                  nodes.add(i+1, childrenNodes[j]);
                }
              } else {
                for (int j = childrenNodes.length - 1; j >= 0; j--) {
                  nodes.add(i+1, childrenNodes[j]);
                }
              }
            }
            nodes.add(i+1, new ScrollBranch("Scroll begining", node.getCurrentscroll() , node.getScroll(), node.getType(), node.getBranchName(), node.getFindbycount(), node.getFiltertext() ));	
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
  } // while
  if (ti.mayBeFiltered() && !ti.isHierarchyTree()) {
    Field[] fields = ti.getFilter().getFields();
    if (fields != null && fields.length > 0) {
%>
    treeFilter = new Filter(viewTitle);
    treeFilter.setTreeFiltered(<%= ti.isFiltered() %>, false);
<%
      if (request.getAttribute(ConstantsFTStruts.ACTUALFILTERNAME) != null) {
%>
    treeFilter.setActualFilterName("<%= (String) request.getAttribute(ConstantsFTStruts.ACTUALFILTERNAME) %>");
<%
      } else if (request.getParameter(ConstantsFTStruts.ACTUALFILTERNAME) != null) {
%>
    treeFilter.setActualFilterName("<%= request.getParameter(ConstantsFTStruts.ACTUALFILTERNAME) %>");
<%
      }
      if (request.getParameter("selectedGroup") != null) {
%>
    treeFilter.setSelectedCriteria("<%= request.getParameter("selectedGroup") %>");
<%
      }
    }
  }
%>
    if (treeFilter != null) {
      $('#msettings').css({display:'block'});
    }
    $(document).scrollLeft(scrLeft);
    $(document).scrollTop(scrTop);
    //parent.setSessionAttribute(rmn, null, "<%=ConstantsFTStruts.VIEW + instance%>");
    <%= (String) request.getAttribute("openSearchFunction") %>
  }
  var cont = 0;
  var numBranches = <%=i-1%>;
  </script>
  <script>
  //this method used to keep the scroll bar in the middle of window when after refresh
  function initscroll(selectedNode){
    if (selectedNode==null) return;
    var currentNode=document.getElementById("ecimg"+selectedNode.idNumber);
    if (currentNode==null) return;
    var currentNodePos=getDim(currentNode)+5;
    if(document.body.scrollHeight> document.body.clientHeight){
      if(currentNodePos>document.body.clientHeight/2){
        var top=0;
        if(currentNodePos+document.body.clientHeight/2 > document.body.scrollHeight){
          top=document.body.scrollHeight-document.body.clientHeight;
        }else{
          top=currentNodePos-document.body.clientHeight/2;
        }
        $(document).scrollTop(top);
      }
    }
  }
  function getDim(el){   
    for (var lx=0,ly=0;el!=null; lx+=el.offsetLeft,ly+=el.offsetTop,el=el.offsetParent);   
    return	ly;
  }   
  function showRefresh(left, top) {
    var i = 0;
    var html = "";
    if(rmn=="3"){
      if (treeFilter != null) {
        treeFilter.setFilterPrinter();
        if (!treeFilter.isTreeFiltered()) {
          var imisf = new InvMenuItemTree("filterin.gif", "<%= set_filter %>", "filterPrinter.setFields();", "_"+(i++));
          html += imisf.getCode();
        } else {
          var imiuf = new InvMenuItemTree("filterin.gif", "<%= update_filter %>", "filterPrinter.setFields();", "_"+(i++));
          html += imiuf.getCode();
          if (!hasMandatoryFilter) {
            var imirmf = new InvMenuItemTree("filterout.gif", "<%= remove_filter %>", "filterPrinter.revoke();", "_"+(i++));
            html += imirmf.getCode();
          }
        }
      }
    }
    if (html.length > 0) {
      parent.document.getElementById("flyingMenu").innerHTML = html;
      parent.document.getElementById("flyingMenu").style.left = left;
      parent.document.getElementById("flyingMenu").style.top = top;
      parent.document.getElementById("flyingMenu").style.visibility = "visible";
      var t = top;
      while (t + parent.document.getElementById("flyingMenu").clientHeight > parent.document.body.clientHeight) {
        t -= 10;
      }
      var l = left;
      while (l + parent.document.getElementById("flyingMenu").clientWidth > parent.document.body.clientWidth) {
        l -= 10;
      }
      parent.document.getElementById("flyingMenu").style.left = l;
      parent.document.getElementById("flyingMenu").style.top = t;
      parent.document.getElementById("flyingMenu").style.visibility = "visible";
    }
  }
  function checkRefresh(reloadTree) {
    var pName = reloadTree ? "reload=true" : "refresh=true";
    if (rmn == "3"){
      var scrLeft = $(document).scrollLeft();
      var scrTop = $(document).scrollTop();
      var name = selectedNode == null ? "" : selectedNode.pk;
      var isTreeFiltered = hasMandatoryFilter || (treeFilter != null && treeFilter.isTreeFiltered());
      var url = "<%=request.getContextPath()%>/RefreshTreeAction.do?"+pName+"&rmn=" + rmn + "&rimid=" + rid + "&name=" + escape(name);
      url += "&scrLeft=" + scrLeft + "&scrTop=" + scrTop + "&instance=" + instance + "&isFiltered=" + isTreeFiltered;
      url += "&<%=ConstantsFTStruts.VIEW%>=" + escape("<%= request.getParameter(ConstantsFTStruts.VIEW) %>");
      if (isTreeFiltered) {
        var fields = treeFilter.getFields();
        for (var i = 0; i < fields.length; i++) {
          url += "&fieldName" + i + "=" + fields[i].variable;
          url += "&fieldValue" + i + "=" + (fields[i].value ? fields[i].value : "");
        }
        if (treeFilter.hasCriterias()) {
          url += "&selectedGroup=" + treeFilter.getSelectedCriteriaKey();
        }
        if (treeFilter.getName() != null && treeFilter.getName() != "") {
          url += "&<%= ConstantsFTStruts.FILTERNAME %>=" + treeFilter.getName();
        }
        if (treeFilter.getDescription() != null && treeFilter.getDescription() != "") {
          url += "&<%= ConstantsFTStruts.FILTERDESCRIPTION %>=" + treeFilter.getDescription();
        }
        if (treeFilter.getActualFilterName() != null) {
          url += "&<%= ConstantsFTStruts.ACTUALFILTERNAME %>=" + treeFilter.getActualFilterName();
        }
      }
      window.location.href = url;
    }
  }
  function SaveFilterAction() {
    var name = selectedNode == null ? "" : selectedNode.idNumber;
    var isTreeFiltered = hasMandatoryFilter || (treeFilter != null && treeFilter.isTreeFiltered());
    var url = "/activator/SaveFilterAction.do?&name=" + name;
    url += "&instance=" + instance;
    var fields = treeFilter.getFields();
    for (var i = 0; i < fields.length; i++) {
      url += "&fieldName" + i + "=" + fields[i].variable;
      url += "&fieldValue" + i + "=" + fields[i].value;
    }
    if (treeFilter.hasCriterias()) {
      url += "&selectedGroup=" + treeFilter.getSelectedCriteriaKey();
    }
    if (treeFilter.getName() != null && treeFilter.getName() != "") {
      url += "&<%= ConstantsFTStruts.FILTERNAME %>=" + treeFilter.getName();
    }
    if (treeFilter.getDescription() != null && treeFilter.getDescription() != "") {
      url += "&<%= ConstantsFTStruts.FILTERDESCRIPTION %>=" + treeFilter.getDescription();
    }
    if (treeFilter.getActualFilterName() != null) {
      url += "&<%= ConstantsFTStruts.ACTUALFILTERNAME %>=" + treeFilter.getActualFilterName();
    }
    window.open(url, "treeResult");
  }
  </script>
  <script>
  function hideFlyingMenu() {
    parent.hideFlyingMenu();
  }
  function onscrolled() {
    scrLeft=document.documentElement.scrollLeft;
    scrTop=document.documentElement.scrollTop;
    hideFlyingMenu();
  }
  function setScroll(top, left)
  {
    $(document).scrollTop(parseInt(top));
    $(document).scrollLeft(parseInt(left));
  }
  function onResize()
  {
    hideFlyingMenu();
    var elms = document.getElementsByClassName("branch");
    for (var i = 0; i < elms.length; i++) {
      $("#" + elms[i].id).width("100%");
    }
    for (var i = 0; i < elms.length; i++) {
      $("#" + elms[i].id).width(document.body.scrollWidth + "px");
    }
  }
  </script>
  <script>
  var sto = null;
  function fadeInSettings()
  {
    clearSettingsTimeout();
    enableSettings();
    $('#settings').animate({opacity:'1.0', width:treeFilter.isTreeFiltered() ? '50px' : '35px'});
  }
  function fadeOutSettings()
  {
    clearSettingsTimeout();
    sto = setTimeout("$('#settings').animate({opacity:'0.0', width:'0px'})", 5000);
  }
  function hideSettings()
  {
    clearSettingsTimeout();
    $('#settings').css({opacity:'0.0', width:'0px'});
  }
  function clearSettingsTimeout()
  {
    if (sto != null) {
      clearTimeout(sto);
    }
  }
  function enableSettings()
  {
    if (treeFilter != null) {
      $('#fout').css({display:treeFilter.isTreeFiltered() ? "inline-block" : "none"});
    }
  }
  </script>
</head>

<body id="treebody" style="padding:0px; margin:0px; background:#ffffff;"
      onload="init();" onscroll="onscrolled();" onresize="onResize();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
  <div id="msettings" style="position:fixed; right:0px; top:2px; font-size:14px; width:60px; height:13px; margin:0px, padding:0px; white-space:nowrap; z-index:1; display:none;">
    <div id="settings" style="position:absolute; right:0px; top:0px; width:0px; height:16px; overflow:hidden; display:block; opacity:0.0; background:#ffffff; padding:0px; margin:0px;" onmouseout="fadeOutSettings();"> 
      <div id="fin" style="width:14px; height:10px; background:white url(/activator/images/inventory-gui/inventory/filterin.png) no-repeat left top; display:inline-block; padding:0px; margin:0px; cursor:pointer;" onclick="hideSettings();treeFilter.setFilterPrinter();parent.filterPrinter.setFields();">&nbsp;</div>
      <div id="fout" style="width:14px; height:10px; background:white url(/activator/images/inventory-gui/inventory/filterout.png) no-repeat left top; display:inline-block; padding:0px; margin:0px; cursor:pointer;" onclick="hideSettings();treeFilter.setFilterPrinter();parent.filterPrinter.revoke();">&nbsp;</div>
    </div>
    <div style="position:absolute; right:0px; top:0px; width:14px; height:10px; background:white url(/activator/images/inventory-gui/inventory/settings.png) no-repeat left top; display:inline-block; padding:0px; margin:0px; cursor:pointer;" onclick="fadeInSettings();">&nbsp;</div>
  </div>
  <iframe id="treeResult" name="treeResult" style="display:none; height:0px; width:0px;"></iframe>
</body>

</html>

<%
}
%>