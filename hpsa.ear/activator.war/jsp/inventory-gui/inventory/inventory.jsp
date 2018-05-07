<!DOCTYPE html>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "javax.sql.DataSource" %>
<%@ page import = "com.hp.ov.activator.inventory.views.TreeViewStructure" %>
<%@ page import = "com.hp.ov.activator.mwfm.UserManagementManager" %>
<%@ page import = "com.hp.ov.activator.mwfm.inventory.TreeViewStructureFactory" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.Constants" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.LoginServlet" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.dtree.InventoryConstants" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.TreeViewStructureCodeWriter" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>
<%@ page import = "com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.TreeDefinition" %>

<%!
//I18n strings
final static String title = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("145", "Inventory");

final static String confirm_operation_button_accept = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("508", "Accept");
final static String confirm_operation_button_cancel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("509", "Cancel");
final static String confirm_operation_title = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("510", "Confirm");
final static String confirm_operation_message = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("511", "Are you sure you want to do this operation?");
final static String confirm_operation = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("513", "OPERATION CONFIRMATION");
final static String confirm_operation_close_inventory = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("514", "Are you sure you want to close the inventory?");

final static String filter_printer_title = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1264", "Filter of view");
final static String filter_personal_criterias = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1265", "Filter criteria and personal filters");
final static String filter_groups = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1266", "Filter criteria");
final static String filter_personal = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1267", "Personal filters");
final static String filter_definition = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1669", "Filter definition");
final static String filter_save = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1268", "Save filter");
final static String button_accept = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1269", "Apply");
final static String button_cancel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("509", "Cancel");
final static String filter_name = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("95", "Name");
final static String filter_description = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("9", "Description");
final static String error = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1270", "ERROR");
final static String filter_name_empty = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1271", "Filter name can't be empty");
final static String filter_name_mandatory = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1272", "Filter name cannot be the same as the mandatory one.");
final static String filter_name_duplicated_title = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1273", "DUPLICATED NAME");
final static String filter_name_duplicated_message = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1670", "The name specified for the filter already exists and it will be overwritten. Do you wish to continue and overwrite it?");
final static String filter_max_limit_error = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1275", "Error found storing filter: Too many stored filters.");
final static String filter_none = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1209", "None");
final static String filter_description_empty = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1276", "Filter description can't be empty");

final static String cross_launch_required_parameters = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1277", "Mandatory parameters couldn't be recovered");
%>

<%
boolean classic_inventory_view = ((Boolean) session.getAttribute(Constants.CLASSIC_INVENTORY_VIEW)).booleanValue();
boolean hasClassView = InventoryTreeServlet.hasAllowClassView();
boolean refreshWhenClicked = InventoryTreeServlet.refreshClickedTab;
String username = (String)session.getAttribute(Constants.USER);
DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE_INVENTORY);
UserManagementManager umm = (UserManagementManager)session.getAttribute(Constants.UMM);
String contextPath = request.getContextPath();
TreeViewStructure vts = null;
Boolean sso_session = (Boolean)session.getAttribute(Constants.SSO_SESSION);
if (umm != null && (sso_session == null || !sso_session.booleanValue())) {
  Map<String, Boolean> parameters = new HashMap<String, Boolean>();
  boolean isSuperuser = (session.getAttribute(Constants.SUPERUSER) != null) ? ((Boolean)session.getAttribute(Constants.SUPERUSER)).booleanValue() : false;
  boolean isSsoSession = (sso_session == null || !sso_session.booleanValue()) ? false : true;
  parameters.put(TreeViewStructureFactory.IS_SUPERUSER, new Boolean(isSuperuser));
  parameters.put(TreeViewStructureFactory.ENABLE_SEARCHES, new Boolean(!isSsoSession));
  parameters.put(TreeViewStructureFactory.ENABLE_FILTERS, new Boolean(!isSsoSession));
  vts = TreeViewStructureFactory.getTreeViewStructure(username, umm, parameters);
} else {
  vts = TreeViewStructureFactory.getTreeViewStructure(username, dataSource);
}
session.setAttribute(Constants.TREEVIEWS_STRUCTURE, vts);
String viewName = request.getParameter(ConstantsFTStruts.VIEW);
String solutionName = request.getParameter(ConstantsFTStruts.SOLUTION);
String branchPath = request.getParameter("branchPath");
String operation = request.getParameter("operation");
String fnt = request.getParameter("fnt");
String pk = request.getParameter("pk");
if (pk != null) { 
  pk = URLEncoder.encode(pk, "UTF-8");
}
String cl = request.getParameter("cl");
%>
<html>

<head>
<title><%= LoginServlet.getMainTitle((String)session.getAttribute(Constants.CUSTOM_UI_ID)) %> - <%= title %></title>
<link rel="stylesheet" type="text/css" href="/activator/css/alerts.css"/>
<link rel="stylesheet" type="text/css" href="/activator/css/inventory-gui/menubar.css"/>
<link rel="stylesheet" type="text/css" href="/activator/css/inventory-gui/inventory.css"/>
<script type="text/javascript" src="/activator/javax.faces.resource/jquery/jquery.js.jsf?ln=primefaces"></script>
<script type="text/javascript" src="/activator/javax.faces.resource/jquery/jquery-plugins.js.jsf?ln=primefaces"></script>
<script type="text/javascript" src="/activator/javascript/inventory-gui/constants.js"></script>
<script type="text/javascript" src="/activator/javascript/inventory-gui/menubar.js"></script>
<script type="text/javascript" src="/activator/javascript/hputils/alerts.js"></script>
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
<script>
function InventorySystem()
{
  var NORMAL_MODE = 0;
  var RESIZE_1_MODE = 1;
  var RESIZE_2_MODE = 2;
  var RESIZE_3_MODE = 3;
  InventorySystem.EMPTY_VIEW_MODE = 0;
  InventorySystem.CLASS_VIEW_MODE = 1;
  InventorySystem.INSTANCE_VIEW_MODE = 2;
  InventorySystem.FULL_VIEW_MODE = 3;
  var resizeMode = NORMAL_MODE;
  var offset;
  var v12Width;
  var v34Width;
  var hHeight;
  var midv12Width;
  var midv34Width;
  var midHeight;
  InventorySystem.init = function ()
  {
    $("#" + CONTEXT_MENU_ID).hide();
    resizeMode = NORMAL_MODE;
    v12Width = $("#s1").width();
    v34Width = $("#s3").width();
    hHeight = parseInt($("#s3").css("top"));
    midHeight = hHeight;
    midv12Width = v12Width;
    midv34Width = v34Width;
    resize();
  }
  InventorySystem.handleMouseDown = function (e)
  {
    if (resizeMode == NORMAL_MODE) {
      if (e.target.id == "r1") {
        resizeMode = RESIZE_1_MODE;
        $("#overglass").css({display:"block"});
        var canvasOffset = $("#r1").offset(); // get r1 relative position
        var offsetX = canvasOffset.left;
        var offsetY = canvasOffset.top;
        var mouseX = parseInt(e.clientX) + $(document).scrollLeft();
        var mouseY = parseInt(e.clientY) + $(document).scrollTop();
        var w = $("#s1").width();
        var h = $("#s1").height();
        offset = {x:mouseX,y:mouseY,ox:e.clientX-offsetX,oy:e.clientY-offsetY,w:w,h:h};
      } else if (e.target.id == "r2") {
        resizeMode = RESIZE_2_MODE;
        $("#overglass").css({display:"block"});
        var canvasOffset = $("#r2").offset(); // get r2 relative position
        var offsetX = canvasOffset.left;
        var offsetY = canvasOffset.top;
        var mouseX = parseInt(e.clientX) + $(document).scrollLeft();
        var mouseY = parseInt(e.clientY) + $(document).scrollTop();
        var w = $("#s1").width();
        var h = $("#s1").height();
        offset = {x:mouseX,y:mouseY,ox:e.clientX-offsetX,oy:e.clientY-offsetY,w:w,h:h};
      } else if (e.target.id == "r3") {
        resizeMode = RESIZE_3_MODE;
        $("#overglass").css({display:"block"});
        var canvasOffset = $("#r3").offset(); // get r3 relative position
        var offsetX = canvasOffset.left;
        var offsetY = canvasOffset.top;
        var mouseX = parseInt(e.clientX) + $(document).scrollLeft();
        var mouseY = parseInt(e.clientY) + $(document).scrollTop();
        var w = $("#s1").width();
        var h = $("#s1").height();
        offset = {x:mouseX,y:mouseY,ox:e.clientX-offsetX,oy:e.clientY-offsetY,w:w,h:h};
      }
    }
  }
  InventorySystem.handleMouseUp = function (e)
  {
    if (resizeMode != NORMAL_MODE) {
      $("#overglass").css({display:"none"});
      TabBarManager.focusOnActiveTabs();
    }
    resizeMode = NORMAL_MODE;
  }
  InventorySystem.handleMouseMove = function (e)
  {
    if (resizeMode == RESIZE_1_MODE) {
      var mouseX = parseInt(e.clientX) + $(document).scrollLeft();
      var mouseY = parseInt(e.clientY) + $(document).scrollTop();
      var diffX = mouseX - offset.x;
      var diffY = mouseY - offset.y;
      v12Width = offset.x + offset.ox + diffX;
      hHeight = offset.y + offset.oy + diffY - $("#menu_bar").height();
      resize();
    } else if (resizeMode == RESIZE_2_MODE) {
      var mouseX = parseInt(e.clientX) + $(document).scrollLeft();
      var mouseY = parseInt(e.clientY) + $(document).scrollTop();
      var diffX = mouseX - offset.x;
      var diffY = mouseY - offset.y;
      hHeight = offset.y + offset.oy + diffY - $("#menu_bar").height();
      resize();
    } else if (resizeMode == RESIZE_3_MODE) {
      var mouseX = parseInt(e.clientX) + $(document).scrollLeft();
      var mouseY = parseInt(e.clientY) + $(document).scrollTop();
      var diffX = mouseX - offset.x;
      var diffY = mouseY - offset.y;
      v34Width = offset.x + offset.ox + diffX;
      hHeight = parseInt($("#s3").css("top"));
      resize();
    }
  }
  var resize = function()
  {
    var viewMode = TabBarManager.getViewMode();
    TabBarManager.hideTabList();
    if (viewMode == InventorySystem.EMPTY_VIEW_MODE) {
      $("#s1").css({display:"none"});
      $("#s2").css({display:"none"});
      $("#s3").css({display:"none"});
      $("#s4").css({display:"none"});
    } else if (viewMode == InventorySystem.CLASS_VIEW_MODE) {
      $("#s1").css({display:"block"});
      $("#s2").css({display:"block"});
      $("#s3").css({display:"none"});
      $("#s4").css({display:"none"});
      $("#s1").width(v12Width);
      $("#s1").height("100%");
      $("#s2").css({left:v12Width});
      $("#s2").width($(document).width() - v12Width);
      $("#s2").height("100%");
      hHeight = midHeight;
      v34Width = midv34Width;
    } else if (viewMode == InventorySystem.INSTANCE_VIEW_MODE) {
      $("#s1").css({display:"none"});
      $("#s2").css({display:"none"});
      $("#s3").css({display:"block"});
      $("#s4").css({display:"block"});
      $("#s3").css({top:"0px"});
      $("#s3").width(v34Width);
      $("#s3").height("100%");
      $("#s4").css({left:v34Width, top:"0px"});
      $("#s4").width($(document).width() - v34Width);
      $("#s4").height("100%");
      hHeight = midHeight;
      v12Width = midv12Width;
    } else if (viewMode == InventorySystem.FULL_VIEW_MODE) {
      $("#s1").css({display:"block"});
      $("#s2").css({display:"block"});
      $("#s3").css({display:"block"});
      $("#s4").css({display:"block"});
      $("#s1").width(v12Width);
      $("#s1").height(hHeight);
      $("#s2").css({left:v12Width});
      $("#s2").width($(document).width() - v12Width);
      $("#s2").height(hHeight);
      $("#s3").css({top:hHeight});
      $("#s3").width(v34Width);
      $("#s3").height($(document).height() - hHeight - $("#menu_bar").height());
      $("#s4").css({left:v34Width, top:hHeight});
      $("#s4").width($(document).width() - v34Width);
      $("#s4").height($(document).height() - hHeight - $("#menu_bar").height());
    }
  }
  InventorySystem.onResize = function (e)
  {
    resize();
  }
}
new InventorySystem();

function TabBarManager()
{
  function Tab(n, text, url)
  {
    var label = text;
    var link = null;
    var pinned = true;
    var filtered = false;
    var active = true;
    var parent = null;
    var children = new Array();
    var sessionAttributes = new Array();
    var tab_name = "tmp3_" + n;
    this.isPinned = function ()
    {
      return pinned;
    }
    this.pin = function ()
    {
      pinned = !pinned;
    }
    this.isFiltered = function ()
    {
      return filtered;
    }
    this.setFiltered = function (f)
    {
      filtered = f;
    }
    this.isActive = function ()
    {
      return active;
    }
    this.setActive = function (a)
    {
      active = a;
    }
    this.getId = function ()
    {
      return "tab" + n;
    }
    this.getLabelId = function ()
    {
      return "lbl" + n;
    }
    this.getPinId = function ()
    {
      return "pin" + n;
    }
    this.getFilterId = function ()
    {
      return "fltr" + n;
    }
    this.getIframeId = function ()
    {
      return "ifr3_" + n;
    }
    this.getLabel = function ()
    {
      return label;
    }
    this.setLabel = function (text)
    {
      label = text;
    }
    this.getUrl = function ()
    {
      return link;
    }
    this.setUrl = function (url)
    {
      if (url != null) {
        var rimId = (url.indexOf("?") > 0 ? "&" : "?") + "rimid=" + n;
        var instance = (url.indexOf("?") > 0 ? "&" : "?") + "instance=" + n;
        var tab_name_param = (url.indexOf("?") > 0 ? "&" : "?") + "tab_name=" + tab_name;
        link = url + rimId + instance + tab_name_param;
      } else {
        link = null;
      }
    }
    this.setParent = function (p)
    {
      parent = p;
    }
    this.hasParent = function ()
    {
      return parent != null;
    }
    this.getParent = function ()
    {
      return parent;
    }
    this.addChild = function (tab)
    {
      children.push(tab);
    }
    this.hasChildren = function ()
    {
      return children.length > 0;
    }
    this.getChildren = function ()
    {
      return children.slice(0);
    }
    this.removeChild = function (tab)
    {
      var child;
      var found = false;
      for (var i = 0; i < children.length && !found; i++) {
        child = children[i];
        if (child == tab) {
          found = true;
          children.splice(i, 1);
        }
      }
    }
    this.addSessionAttribute = function (att)
    {
      sessionAttributes.push(att);
    }
    this.hasSessionAttributes = function ()
    {
      return sessionAttributes.length > 0;
    }
    this.containsSessionAttribute = function (att)
    {
      return sessionAttributes.indexOf(att) >= 0;
    }
    this.getSessionAttributes = function ()
    {
      return sessionAttributes.slice(0);
    }
    function getParameterUrlValue(url, parameter) {
      indexofparameter = url.indexOf(parameter+"=");
      if (indexofparameter >= 0) {
        url = url.substring(indexofparameter+parameter.length+1);
        indexofamp = url.indexOf("&");
        if (indexofamp >= 0) {
          value = url.substring(0,indexofamp);
          value = value.replace("+"," ");
        }
      }
      return value;
    }
    this.setUrl(url);
    this.addSessionAttribute(tab_name);
    this.addSessionAttribute("<%=ConstantsFTStruts.VIEW%>" + n);
    if (url != null) {
      this.addSessionAttribute("solution||view_" + getParameterUrlValue(decodeURI(url), "view"));
    }
  }
  Tab();
  var tabBar1 = new Array();
  var tabBar2 = new Array();
  var tabBar3 = new Array();
  var tabBar4 = new Array();
  var activeTabs1 = new Array();
  var activeTabs2 = new Array();
  var activeTabs3 = new Array();
  var activeTabs4 = new Array();
  var tabCounter = 0;
  var activeTabList = null;
  TabBarManager.getViewMode = function ()
  {
    var viewMode;
    if (tabBar1.length == 0 && tabBar2.length == 0) {
      viewMode = tabBar3.length == 0 && tabBar4.length == 0 ? InventorySystem.EMPTY_VIEW_MODE : InventorySystem.INSTANCE_VIEW_MODE;
    } else {
      viewMode = tabBar3.length == 0 && tabBar4.length == 0 ? InventorySystem.CLASS_VIEW_MODE : InventorySystem.FULL_VIEW_MODE;
    }
    return viewMode;
  }
  TabBarManager.pinCloseTab = function (tabBarNumber, tabId)
  {
    var tabBar;
    var tab = getTab(tabBarNumber, tabId);
    var index;
    var child;
    var children;
    if (tab != null) {
      if (tab.isPinned()) {
        // unpin tab
        tab.pin();
        $("#" + tab.getPinId()).attr("src", "/activator/images/inventory-gui/inventory/close_tab.png");
      } else {
        cleanSessionAttributes(tabBarNumber, tab);
        // remove tab from last active tabs list
        removeFromActiveTabs(tabBarNumber, tab);
        // close tab
        tabBar = getTabBar(tabBarNumber);
        if (tabBar != null) {
          index = getTabIndex(tabBarNumber, tabId);
          if (index >= 0) {
            if (tab.hasChildren()) { // close all children tabs
              children = tab.getChildren();
              for (var i = 0; i < children.length; i++) {
                child = children[i];
                if (child.isPinned()) {
                  TabBarManager.pinCloseTab(tabBarNumber + 1, child.getId());
                }
                TabBarManager.pinCloseTab(tabBarNumber + 1, child.getId());
              }
            }
            tabBar.splice(index, 1);
            if (tab.hasParent()) {
              tab.getParent().removeChild(tab);
            }
            $("#" + tab.getId()).remove();
            $("#" + tab.getIframeId()).remove();
          }
        }
        if (tab.isActive()) {
          // activate last tab in historical list
          tab = popActiveTab(tabBarNumber);
          if (tab == null && tabBar != null && tabBar.length > 0) {
            // if there is no last active tab then activate the last tab in the tab bar
            tab = tabBar[tabBar.length - 1];
          }
          if (tab != null) {
            TabBarManager.setActiveTab(tabBarNumber, tab.getId());
          }
        }
        InventorySystem.onResize();
      }
    }
  }
  TabBarManager.forceCloseTab = function (tabBarNumber, tabId)
  {
    var tab = getTab(tabBarNumber, tabId);
    if (tab != null) {
      if (tab.isPinned()) {
        TabBarManager.pinCloseTab(tabBarNumber, tab.getId());
      }
      TabBarManager.pinCloseTab(tabBarNumber, tab.getId());
    }
  }
  TabBarManager.forceCloseAllTabs = function (tabBarNumber)
  {
    var tabBar = getTabBar(tabBarNumber);
    if (tabBar != null) {
      while (tabBar.length > 0) {
        TabBarManager.forceCloseTab(tabBarNumber, tabBar[0].getId());
      }
    }
  }
  TabBarManager.addTab = function (tabBarNumber, tabLabel, tabUrl)
  {
    var tab;
    var tabBar;
    if (hasPinTab(tabBarNumber)) {
      tab = getPinTab(tabBarNumber);
      tab.setLabel(tabLabel);
      tab.setUrl(tabUrl);
      if (tab.hasParent()) { // remove parent/child relationship
        tab.getParent().removeChild(tab);
      }
      $("#" + tab.getLabelId()).text(tab.getLabel());
      $("#" + tab.getIframeId()).attr("src", tab.getUrl());
    } else {
      tab = new Tab(tabCounter++, tabLabel, tabUrl);
      tabBar = getTabBar(tabBarNumber);
      tabBar.push(tab);
      $("#tb" + tabBarNumber).append(
          "<li id=\"" + tab.getId() + "\" class=\"tab selected\" onclick=\"TabBarManager.onClickedTab(event, " + tabBarNumber + ", '" + tab.getId() + "')\">"
          + "<span id=\"" + tab.getLabelId() + "\">" + tab.getLabel() + "</span>"
          + "<img id=\"" + tab.getFilterId() + "\" src=\"/activator/images/inventory-gui/inventory/filtered.png\" style=\"display:none; margin-left:5px; cursor:pointer;\" align=\"top\">"
          + "<img id=\"" + tab.getPinId() + "\" src=\"/activator/images/inventory-gui/inventory/pin_tab.png\" style=\"margin-left:5px; cursor:pointer;\" align=\"top\" "
          + "onclick=\"TabBarManager.setActiveTab(" + tabBarNumber + ", '" + tab.getId() + "');TabBarManager.pinCloseTab(" + tabBarNumber + ", '" + tab.getId() + "');\">"
          + "</li>");
      $("#sif" + tabBarNumber).append(
          "<iframe id=\"" + tab.getIframeId() + "\" src=\"" + tab.getUrl() + "\"></iframe>");
    }
    setAncestorRelationship(tabBarNumber, tab);
    InventorySystem.onResize();
    TabBarManager.setActiveTab(tabBarNumber, tab.getId());
    return tab.getId();
  }
  TabBarManager.switchTab = function (tabBarNumber, tabLabel, tabUrl, openNewTab)
  {
    if (openNewTab) {
      if (hasPinTab(tabBarNumber)) {
        // unpin tab so a new tab can be added later
        TabBarManager.pinCloseTab(tabBarNumber, getPinTab(tabBarNumber).getId());
      }
      TabBarManager.addTab(tabBarNumber, tabLabel, tabUrl);
    } else {
      TabBarManager.setTabLabel(tabBarNumber, tabLabel);
      setTabUrl(tabBarNumber, tabUrl);
    }
  }
  TabBarManager.setTabLabel = function (tabBarNumber, tabLabel, tabId)
  {
    var tab = tabId != null ? getTab(tabBarNumber, tabId) : getActiveTab(tabBarNumber);
    if (tab != null) {
      tab.setLabel(tabLabel);
      $("#" + tab.getLabelId()).text(tab.getLabel());
    }
  }
  var setTabUrl = function (tabBarNumber, tabUrl)
  {
    var activeTab = getActiveTab(tabBarNumber);
    if (activeTab != null) {
      activeTab.setUrl(tabUrl);
      $("#" + activeTab.getIframeId()).attr("src", activeTab.getUrl());
    }
  }
  TabBarManager.onClickedTab = function (e, tabBarNumber, tabId)
  {
    var event;
    var id;
    var tab;
    if (tabBarNumber == 3) {
      event = e ? e : window.event;
      if (event != null) {
        tab = getTab(tabBarNumber, tabId);
        id = event.target ? event.target.id : event.srcElement.id;
        // only refresh tab contents if the tab has been clicked but not the pin/close button
        if (id != null && tab != null && id != tab.getPinId()) {
          TabBarManager.refreshTab(tabBarNumber, tabId, false);
        }
      }
    }
    TabBarManager.setActiveTab(tabBarNumber, tabId);
  }
  TabBarManager.refreshTab = function (tabBarNumber, tabId, reload)
  {
    var tab = getTab(tabBarNumber, tabId);
    if (tab != null) {
      if (tab.hasParent()) {
        tab = tab.getParent();
      }
      document.getElementById(tab.getIframeId()).contentWindow.checkRefresh(reload);
    }
  }
  TabBarManager.setTabFiltered = function (tabBarNumber, filtered, tabId)
  {
    var tab = tabId != null ? getTab(tabBarNumber, tabId) : getActiveTab(tabBarNumber);
    if (tab != null) {
      tab.setFiltered(filtered);
      $("#" + tab.getFilterId()).css({display:tab.isFiltered() ? "inline" : "none"});
    }
  }
  TabBarManager.addSessionAttribute = function (tabBarNumber, attName)
  {
    var activeTab = getActiveTab(tabBarNumber);
    if (activeTab != null) {
      activeTab.addSessionAttribute(attName);
    }
  }
  TabBarManager.setActiveTab = function (tabBarNumber, tabId)
  {
    var tabBar;
    var activeTab = null;
    var tab = getTab(tabBarNumber, tabId);
    if (tab != null) {
      TabBarManager.hideTabList();
      tabBar = getTabBar(tabBarNumber);
      for (var i = 0; i < tabBar.length; i++) {
        tab = tabBar[i];
        if (tab.getId() == tabId) {
          tab.setActive(true);
          $("#" + tab.getId()).attr("class", "tab selected");
          $("#" + tab.getIframeId()).css({display:"block"});
          activeTab = tab;
        } else {
          if (tab.isActive()) {
            pushActiveTab(tabBarNumber, tab);
          }
          tab.setActive(false);
          $("#" + tab.getId()).attr("class", "tab");
          $("#" + tab.getIframeId()).css({display:"none"});
        }
      }
      if (activeTab != null) {
        TabBarManager.focusOnActiveTab(tabBarNumber);
      }
    }
  }
  TabBarManager.focusOnActiveTab = function (tabBarNumber)
  {
    var tabId;
    var index;
    var ulWidth;
    var wMax;
    var wLeft;
    var wRight;
    var activeTab = getActiveTab(tabBarNumber);
    if (activeTab != null) {
      tabId = activeTab == null ? null : activeTab.getId();
      index = getTabIndex(tabBarNumber, tabId);
      ulWidth = getTabsWidth(tabBarNumber);
      wMax = $("#s" + tabBarNumber).width();
      wLeft = 0;
      wRight = 0;
      if (index >= 0) {
        for (var i = 0; i <= index; i++) {
          wRight += ulWidth[i];
        }
        for (var i = 0; i < index && wRight - wLeft > wMax; i++) {
          wLeft += ulWidth[i];
        }
        $("#tbsc" + tabBarNumber).animate({
          left:"-" + wLeft + 'px'
        });
      }
    }
  }
  TabBarManager.focusOnActiveTabs = function ()
  {
    for (var i = 1; i <= 4; i++) {
      TabBarManager.focusOnActiveTab(i);
    }
  }
  TabBarManager.showTabList = function (tabBarNumber)
  {
    var tab;
    var offset;
    var html = "";
    var tabBar = getTabBar(tabBarNumber);
    if (isTabListVisible(tabBarNumber)) {
      TabBarManager.hideTabList();
    } else {
      if (tabBar != null && tabBar.length > 0) {
        for (var i = 0; i < tabBar.length; i++) {
          tab = tabBar[i];
          html += "<div class=\"row\" onclick=\"TabBarManager.setActiveTab(" + tabBarNumber + ",'" + tab.getId() + "');\">";
          html += "<span class=\"" + (tab.isActive() ? "active" : "") + "\">" + tab.getLabel() + "</span>";
          html += "</div>";
        }
        document.getElementById(CONTEXT_MENU_ID).innerHTML = html;
        activeTabList = tabBarNumber;
        offset = $("#tbb" + tabBarNumber).offset();
        $("#" + CONTEXT_MENU_ID).css({left:Math.max(0, offset.left - parseInt($("#" + CONTEXT_MENU_ID).css("width"))) + "px", top:(offset.top + parseInt($("#tbb" + tabBarNumber).css("height"))) + "px"});
        $("#" + CONTEXT_MENU_ID).fadeIn("fast");
      }
    }
  }
  TabBarManager.hideTabList = function ()
  {
    $("#" + CONTEXT_MENU_ID).fadeOut("fast");
    activeTabList = null;
  }
  TabBarManager.getTabBySessionAttribute = function (tabBarNumber, attName)
  {
    var tab = null;
    var tabBar = getTabBar(tabBarNumber);
    if (tabBar != null) {
      for (var i = 0; i < tabBar.length; i++) {
        tab = tabBar[i];
        if (!tab.containsSessionAttribute(attName)) {
          tab = null;
        }
      }
    }
    return tab;
  }
  var isTabListVisible = function (tabBarNumber)
  {
    return activeTabList == tabBarNumber;
  }
  var getTabsWidth = function (tabBarNumber)
  {
    var ws = new Array();
    $("#s" + tabBarNumber + " li").each(function() {
      ws.push(
          $(this).width() + parseInt($(this).css("padding-left")) + parseInt($(this).css("padding-right"))
              + parseInt($(this).css("border-left-width")) + parseInt($(this).css("border-right-width"))
              + parseInt($(this).css("margin-left")) + parseInt($(this).css("margin-right")));
    });
    return ws;
  }
  var hasPinTab = function (tabBarNumber)
  {
    var pin = false;
    var tabBar = getTabBar(tabBarNumber);
    if (tabBar != null) {
      pin = tabBar.length == 0 ? false : tabBar[tabBar.length - 1].isPinned();
    }
    return pin;
  }
  var getPinTab = function (tabBarNumber)
  {
    var tab = null;
    var tabBar = getTabBar(tabBarNumber);
    if (tabBar != null) {
      tab = tabBar.length == 0 ? null : (tabBar[tabBar.length - 1].isPinned() ? tabBar[tabBar.length - 1] : null);
    }
    return tab;
  }
  var getActiveTab = function (tabBarNumber)
  {
    var tab = null;
    var tabBar = getTabBar(tabBarNumber);
    if (tabBar != null) {
      for (var i = 0; i < tabBar.length && tab == null; i++) {
        tab = tabBar[i];
        if (!tab.isActive()) {
          tab = null;
        }
      }
    }
    return tab;
  }
  var getTabBar = function (tabBarNumber)
  {
    var tabBar = null;
    var tabBars = [tabBar1, tabBar2, tabBar3, tabBar4];
    if (tabBarNumber >= 1 && tabBarNumber <= tabBars.length) {
      tabBar = tabBars[tabBarNumber - 1];
    }
    return tabBar;
  }
  var getTab = function (tabBarNumber, tabId)
  {
    var tab = null;
    var tabBar = getTabBar(tabBarNumber);
    if (tabBar != null) {
      for (var i = 0; i < tabBar.length && tab == null; i++) {
        tab = tabBar[i];
        if (tab.getId() != tabId) {
          tab = null;
        }
      }
    }
    return tab;
  }
  var getTabIndex = function (tabBarNumber, tabId)
  {
    var index = -1;
    var tabBar = getTabBar(tabBarNumber);
    if (tabBar != null) {
      for (var i = 0; i < tabBar.length && index < 0; i++) {
        index = tabBar[i].getId() != tabId ? -1 : i;
      }
    }
    return index;
  }
  var getActiveTabs = function (tabBarNumber)
  {
    var tabList = null;
    var tabLists = [activeTabs1, activeTabs2, activeTabs3, activeTabs4];
    if (tabBarNumber >= 1 && tabBarNumber <= tabLists.length) {
      tabList = tabLists[tabBarNumber - 1];
    }
    return tabList;
  }
  var removeFromActiveTabs = function (tabBarNumber, tabToRemove)
  {
    var tab;
    var tabList = getActiveTabs(tabBarNumber);
    if (tabList != null) {
      for (var i = 0; i < tabList.length; i++) {
        tab = tabList[i];
        if (tab == tabToRemove) {
          tabList.splice(i--, 1);
        }
      }
    }
  }
  var pushActiveTab = function (tabBarNumber, activeTab)
  {
    var tab;
    var tabList = getActiveTabs(tabBarNumber);
    if (tabList != null) {
      removeFromActiveTabs(tabBarNumber, activeTab);
      tabList.push(activeTab);
    }
  }
  var popActiveTab = function (tabBarNumber)
  {
    var tabList = getActiveTabs(tabBarNumber);
    return tabList == null || tabList.length == 0 ? null : tabList.pop();
  }
  var setAncestorRelationship = function(tabBarNumber, tab)
  {
    var parent = getActiveTab(tabBarNumber - 1);
    if (parent != null) {
      parent.addChild(tab);
      tab.setParent(parent);
    }
  }
  var cleanSessionAttributes = function (tabBarNumber, tab)
  {
    var url;
    var sessionAttributes;
    if (tab.hasSessionAttributes()) {
      sessionAttributes = tab.getSessionAttributes();
      url = "<%=request.getContextPath()%>/CleanSessionActionFT.do";
			url += "?success=" + (tabBarNumber % 2 == 0 ? "noOps" : "noTree");
			for (var i = 0; i < sessionAttributes.length; i++) {
				url += "&sessionAttribute" + i + "=" + sessionAttributes[i];
			}
			setTabUrl(tabBarNumber, url);
		}
  }
}
TabBarManager();
</script>
<script>
function FilterPrinter()
{
  var FILTER_AREA_ID = "filter_area";
  var treeFilter = null;
  var selectedCriteriaIndex = null;
  var selectedFilterCriteriaIndex = null;
  var selectedFilterId = null;
  var oldSelectedFilterId = null;
  var mandatoryCriteria = null;
  var numberOfUserFilters = 0;
  this.setFilter = function (pTreeFilter)
  {
    treeFilter = pTreeFilter;
  }
  this.show = function ()
  {
    var maxheight = $(window).height() - 200;
    var maxwidth = $(window).width() - 200;
    var selectedCriteria = "";
    selectedCriteriaIndex = null;
    selectedFilterId = null;
    numberOfUserFilters = 0;
    var html = "<div class=\"filter\" style=\"width:" + maxwidth + "px; height:" + maxheight + "px;\"><div class=\"block header title\" >";
    html += "<%= filter_printer_title %>" + (treeFilter.getViewName() != null ? " &laquo;" + treeFilter.getViewName() + "&raquo;" : "") + "</div>";
    html += "<div class=\"block filter_area\" style=\"width:" + maxwidth + "px;\">";
    html += "<ul class=\"filter_bar\">";
    if (treeFilter.hasCriterias() || treeFilter.hasUserFilters()) {
      html += "<li>";
      html += "<div id=\"fdgr\" class=\"filter_definition\" style=\"width:" + (maxwidth / 2 - 10) + "px; height:" + (maxheight - 70) + "px;\">";
      html += "<div class=\"header\">";
      if (treeFilter.hasCriterias()) {
        html += treeFilter.hasUserFilters() ? "<%= filter_personal_criterias %>" : "<%= filter_groups %>";
      } else if (treeFilter.hasUserFilters()) {
        html += "<%= filter_personal %>";
      }
      html += "</div>";
      if (treeFilter.hasCriterias()) {
        var criteriaNames = treeFilter.getCriteriaNames();
        mandatoryCriteria = treeFilter.getMandatoryCriteria();
        if (mandatoryCriteria == null) {
          selectedCriteria = treeFilter.getSelectedCriteria() == null ? criteriaNames[0] : treeFilter.getSelectedCriteria();
        } else {
          selectedCriteria = mandatoryCriteria;
        }
        for (var j = 0; j < criteriaNames.length; j++) {
          if (mandatoryCriteria == null || mandatoryCriteria == criteriaNames[j]) {
            if (criteriaNames[j] == selectedCriteria) {
              selectedCriteriaIndex = j;
            }
            html += "<div id=\"crit" + j + "\" class=\"branch\" ";
            html += "onclick=\"filterPrinter.showGroupFields('" + criteriaNames[j] + "', " + j + ");filterPrinter.resetFields();\">";
            html += "" + criteriaNames[j] + "</div>";
            var criteriaFilters = treeFilter.getCriteriaFilters(criteriaNames[j]);
            if (criteriaFilters != null) {
              for (var i = 0; i < criteriaFilters.length; i++) {
                html += "<div id=\"cf_" + j + "_" + i + "\" class=\"branch\" style=\"";
                html += treeFilter.getActualFilterName() == criteriaFilters[i].getName() ? "font-weight:bold;" : "font-weight:normal;";
                if (treeFilter.getActualFilterName() != null && treeFilter.getName() == null) {
                  treeFilter.setName(treeFilter.getActualFilterName(), false);
                }
                if (treeFilter.getName() == criteriaFilters[i].getName()) {
                  html += "background:#e3e3e3;";
                  selectedFilterId = i;
                  selectedFilterCriteriaIndex = j;
                }
                html += "\" onclick=\"filterPrinter.setFields('" + criteriaFilters[i].getId() + "', '" + criteriaNames[j] + "');\">";
                html += "<span style=\"padding-left:10px;\">" + criteriaFilters[i].getName() + "</span></div>";
                numberOfUserFilters++;
              }
            }
          }
        }
      } else if (treeFilter.hasUserFilters()) {
        var userFilters = treeFilter.getUserFilters();
        numberOfUserFilters = userFilters.length;
        for (var i = 0; i < userFilters.length; i++) {
          html += "<div id=\"cf_0_" + i + "\" class=\"branch\" style=\"";
          html += treeFilter.getActualFilterName() == userFilters[i].getName() ? "font-weight:bold; " : "font-weight:normal; ";
          if (treeFilter.getActualFilterName() != null && treeFilter.getName() == null) {
            treeFilter.setName(treeFilter.getActualFilterName(), false);
          }
          if (treeFilter.getName() == userFilters[i].getName()) {
            html += "background:#cccccc;";
            selectedFilterId = i;
          }
          html += "\" onclick=\"filterPrinter.setFields('" + userFilters[i].getId() + "', null);\">";
          html += "" + userFilters[i].getName() + "</div>";
        }
      }
      html += "</div>";
      html += "</li>";
    }
    html += "<li>";
    html += "<div id=\"fddf\" class=\"filter_definition\" style=\"" + (treeFilter.hasCriterias() || treeFilter.hasUserFilters() ? ("width:" + (maxwidth / 2 - 10) + "px; height:" + (maxheight - 70) + "px;") : "width:" + (maxwidth - 10) + "px;") + "\">"
    html += "<div class=\"header\">";
    html += "<%= filter_definition %>";
    html += "</div>";
    html += "<div id=\"fieldsSpace\"></div>";
    html += "</div>";
    html += "</li>";
    html += "</ul>";
    html += "</div>";
    html += "<div class=\"block\" style=\"text-align:center; margin-bottom:10px;\">";
<%
if (request.getSession().getAttribute(Constants.UMM) != null && (sso_session == null || !sso_session.booleanValue())) {
%>
    html += "<input type=\"button\" class=\"btn\" value=\"<%= filter_save %>\" style=\"width:100px; height:25px; margin-top:5px;\" ";
    html += "onclick=\"filterPrinter.switchFields();filterPrinter.showHideSaveOption();\">";
<%
}
%>
    html += "<input type=\"button\" class=\"btn\" value=\"<%= button_accept %>\" style=\"width:100px; height:25px; margin-top:5px;\" ";
    html += "onclick=\"filterPrinter.storeFields(false);\">";
    html += "<input type=\"button\" class=\"btn\" value=\"<%= button_cancel %>\" style=\"width:100px; height:25px; margin-top:5px;\" ";
    html += "onclick=\"filterPrinter.cancel();\">";
    html += "</div>";
    html += "</div>";
    oldSelectedFilterId = selectedFilterId;
    document.getElementById(FILTER_AREA_ID).innerHTML = html;
    this.showGroupFields(selectedCriteria, selectedCriteriaIndex);
    if (treeFilter.getScroll() != null) {
      document.getElementById("cfs").scrollTop = treeFilter.getScroll();
    }
    document.body.onselectstart = "";
    $("#overglass").css({display:"block"});
    $("#" + FILTER_AREA_ID).css({top:"100px",left:"100px"});
    $("#" + FILTER_AREA_ID).fadeIn("fast");
  }

  this.switchFields = function () {
    var filterFields = treeFilter.getFields();
    for (var i = 0; i < filterFields.length; i++) {
      if (document.getElementById(filterFields[i].variable)) {
        document.getElementById(filterFields[i].variable).disabled = !(document.getElementById(filterFields[i].variable).disabled);
      }
    }
  }

  this.showGroupFields = function (group, groupIndex) {
    var filterFields = treeFilter.getFields();
    var html = "<table>";
    for (var i = 0; i < filterFields.length; i++) {
      if (filterFields[i].group == group) {
        html += "<tr>";
        html += "<td>" + filterFields[i].alias + ":</td>";
        if (filterFields[i].mandatory) {
          html += "<td><input type=\"hidden\" id=\"" + filterFields[i].variable + "\" ";
          html += "value=\"" + filterFields[i].value + "\">" + filterFields[i].value + "</td>";
        } else if (filterFields[i].listOfValues == null || filterFields[i].listOfValues.length == 0) {
          html += "<td><input type=\"text\" id=\"" + filterFields[i].variable + "\" ";
          html += "onkeypress=\"if (event.keyCode == 13) {filterPrinter.storeFields(false)} else {filterPrinter.unselectFilter()}\"";
          html += "onclick=\"focus();\" ";
          if (filterFields[i].value != null && filterFields[i].value != "") {
            html += "value=\"" + filterFields[i].value + "\" ";
          }
          if (filterFields[i].type == "date") {
            html += "onchange=\"filterPrinter.unselectFilter()\">";
            html += "&nbsp;<img border=0 src=\"/activator/images/hputils/datetimepicker/calendar.gif\" ";
            html += "onclick=\"NewCal('" + filterFields[i].variable + "','yyyymmdd',false,24,0);\" style=\"cursor:pointer\">";
          }
          html += "</td>";
        } else {
          html += "<td><select id=\"" + filterFields[i].variable + "\"";
          var ffvalue = filterFields[i].value == null ? "" : filterFields[i].value;
          if (ffvalue != null && ffvalue != "") {
            html += " value=\"" + filterFields[i].value + "\"";
          }
          html += " onchange=\"filterPrinter.unselectFilter()\">";
          for (var j = filterFields[i].listOfValues.length - 1; j >= 0 ; j--) {
            html += "<option value=\"" + filterFields[i].listOfValues[j].value + "\"";
            if (ffvalue == filterFields[i].listOfValues[j].value) {
              html += " selected";
            }
            html += ">";
            var txt = filterFields[i].listOfValues[j].value;
            if (txt == "") {
              txt = filterFields[i].listOfValues[j].name;
            } else if (txt == "true" || txt == "false") {
              txt = filterFields[i].listOfValues[j].name;
            }
            html += txt;
            html += "</option>";
          }
          html += "</select></td>";
        }
        html += "</tr>";
      }
    }
    html += "</table>";
    document.getElementById("fieldsSpace").innerHTML = html;
    if (groupIndex != null) {
      document.getElementById("crit" + selectedCriteriaIndex).style.backgroundColor = "#ffffff";
      selectedCriteriaIndex = groupIndex;
      document.getElementById("crit" + selectedCriteriaIndex).style.backgroundColor = "#cccccc";
      this.unselectFilter();
    }
  }
  this.showHideSaveOption = function () {
    if (document.getElementById("fltrpspsave")) {
      document.body.removeChild(document.getElementById("fltrpspsave"));
    } else {
      var width = document.body.clientWidth;
      var height = document.body.clientHeight;
      var html = "<div style=\"position:fixed; top:0px; left:0px; background:#ffffff; width:100%; height:100%; opacity:0.1;\">&nbsp;</div>";
      html += "<div class=\"confirmation_box\">";
      html += "<div class=\"title\">Filter Save</div> ";
      html += "<div class=\"block\">Filter Name: <input type=\"text\" style=\"width:200px\" id=\"filtername\" ";
      if (treeFilter.getName() != null && selectedFilterId != null) {
          html += "value=\"" + treeFilter.getName() + "\" ";
      }
      html += "onclick=\"focus();\">";
      html += "</div>";
      html += "<div class=\"block\">Description: <input type=\"text\" id=\"filterdesc\" style=\"width:200px\" ";
      if (treeFilter.getDescription() != null && selectedFilterId != null) {
          html += "value=\"" + treeFilter.getDescription() + "\" ";
      }
      html += "onclick=\"focus();\">";
      html += "</div>";
      html += "<div class=\"block\">";
      html += "<input type=\"button\" class=\"btn\" value=\"<%= button_accept %>\" onclick=\"filterPrinter.storeFields(true);\">";
      html += "&nbsp;&nbsp;&nbsp;&nbsp;";
      html += "<input type=\"button\" class=\"btn\" value=\"<%= button_cancel %>\" onclick=\"filterPrinter.switchFields();filterPrinter.cancelSave();\">";
      html += "</div>";
      html += "</span></div>";
      var fltrpspsave = document.createElement("div");
      fltrpspsave.setAttribute("id", "fltrpspsave");
      var ofp = document.body.appendChild(fltrpspsave);
      ofp.innerHTML = html;
    }
  }
  this.cancelSave = function () {
    if (document.getElementById("fltrpspsave")) {
      document.getElementById("fltrpspsave").innerHTML = "";
      document.body.removeChild(document.getElementById("fltrpspsave"));
    }
  }
  this.cancel = function () {
    var sel ;
    if (document.selection && document.selection.empty) {
      document.selection.empty() ;
    } else if (window.getSelection) {
      sel = window.getSelection();
      if (sel && sel.removeAllRanges) {
        sel.removeAllRanges() ;
      }
    }
    this.hide();
    this.cancelSave();
  }
  this.hide = function ()
  {
    $("#overglass").css({display:"none"});
    $("#" + FILTER_AREA_ID).fadeOut("fast");
  }
  var isRepeatedEnteredFilterName = function (enteredFilterName) {
    var userFilters = treeFilter.getUserFilters();
    var repeated = false;
    for (var i = 0; i < userFilters.length && !repeated; i++) {
      if (enteredFilterName == userFilters[i].getName()) {
        repeated = true;
      }
    }
    return repeated;
  }
  this.storeFields = function (database) {
    if (document.getElementById("filtername")) {
      if (document.getElementById("filtername").value == "") {
        var falert = new HPSAAlert("<%=error%>","<%= filter_name_empty %>");
        falert.setBounds(400, 120);
        falert.setButtonText("<%=confirm_operation_button_accept%>");
        falert.show();
      } else if (document.getElementById("filtername").value == treeFilter.getMandatoryFilterName()) {
        var falert = new HPSAAlert("<%=error%>","<%= filter_name_mandatory %>");
        falert.setBounds(400, 120);
        falert.setButtonText("<%=confirm_operation_button_accept%>");
        falert.show();
      } else if (isRepeatedEnteredFilterName(document.getElementById("filtername").value)) {
        var aop = "filterPrinter.doStoreFields(true);filterPrinter.switchFields();";
        var cop = null;
        var ttl = "<%= filter_name_duplicated_title %>";
        var msg = "<%= filter_name_duplicated_message %>";
        var fc = new HPSAConfirm(ttl, msg, aop, cop);
        fc.setAcceptButtonText("<%=confirm_operation_button_accept%>");
        fc.setCancelButtonText("<%=confirm_operation_button_cancel%>");
        fc.setBlockingConfirm(true);
        fc.show();
      } else {
        this.doStoreFields(database);
      }
    } else {
      this.doStoreFields(database);
    }
  }
  this.doStoreFields = function (database) {
    var error = false;
    var name = document.getElementById("filtername") ? document.getElementById("filtername").value : null;
    if (name == null && document.getElementById("userfilters")) {
      name = document.getElementById("userfilters").options[document.getElementById("userfilters").options.selectedIndex].text;
      if (name == "<%= filter_none %>") {
        name = null;
      }
    }
    var descr = null;
    if (document.getElementById("filterdesc")) {
      if (document.getElementById("filterdesc").value == "") {
        var falert = new HPSAAlert("<%=error%>","<%= filter_description_empty %>");
        falert.setBounds(400, 120);
        falert.setButtonText("<%=confirm_operation_button_accept%>");
        falert.show();
        error = true;
      } else {
        descr = document.getElementById("filterdesc").value;
      }
    }
    if (!error) {
      if (selectedFilterId != null) {
        if (treeFilter.hasCriterias()) {
          var selectedCriteriaName = treeFilter.getCriteriaNames()[selectedFilterCriteriaIndex];
          var criteriaFilters = treeFilter.getCriteriaFilters(selectedCriteriaName);
          if (criteriaFilters != null) {
            treeFilter.setActualFilterName(criteriaFilters[selectedFilterId].getName());
          }
        } else {
          treeFilter.setActualFilterName(treeFilter.getUserFilters()[selectedFilterId].getName());
        }
      } else {
        treeFilter.setActualFilterName(null);
      }
      treeFilter.setName(name);
      treeFilter.setDescription(descr);
      var filterFields = treeFilter.getFields();
      for (var i = 0; i < filterFields.length; i++) {
        if (document.getElementById(filterFields[i].variable)) {
          filterFields[i].value = document.getElementById(filterFields[i].variable).value;
        } else {
          filterFields[i].value = "";
        }
      }
      if (treeFilter.hasCriterias()) {
        treeFilter.setSelectedCriteria(treeFilter.getCriteriaNames()[selectedCriteriaIndex]);
      }
      this.cancel();
      var emptyFlds = this.emptyFields();
      if (database){
        treeFilter.SaveFilter();
      } else {
        treeFilter.setTreeFiltered(!emptyFlds, emptyFlds ? treeFilter.isTreeFiltered() : true); 
      }
    }
  }
  this.emptyFields = function () {
    var emptyF = true;
    var filterFields = treeFilter.getFields();
    for (var i = 0; i < filterFields.length && emptyF; i++) {
      if (document.getElementById(filterFields[i].variable)) {
        emptyF = document.getElementById(filterFields[i].variable).value == "";
      }
    }
    return emptyF;
  }
  this.revoke = function () {
    treeFilter.setTreeFiltered(false, true);
  }
  this.setFields = function (filterId, criteriaName) {
    if (criteriaName != null) {
        treeFilter.setSelectedCriteria(criteriaName);
    }
    treeFilter.setFields(filterId);
  }
  this.unselectFilter = function () {
    if (selectedCriteriaIndex != selectedFilterCriteriaIndex) {
      if (selectedFilterId != null) {
        document.getElementById("cf_" + (selectedFilterCriteriaIndex == null ? "0" : selectedFilterCriteriaIndex) + "_" + selectedFilterId).style.backgroundColor = "#ffffff";
        selectedFilterId = null;
      }
    } else if (filedsValuesHasChanged()) {
      if (selectedFilterId != null) {
        document.getElementById("cf_" + (selectedFilterCriteriaIndex == null ? "0" : selectedFilterCriteriaIndex) + "_" + selectedFilterId).style.backgroundColor = "#ffffff";
        selectedFilterId = null;
      }
    } else if (oldSelectedFilterId != null && selectedFilterCriteriaIndex != null) {
      selectedFilterId = oldSelectedFilterId;
      document.getElementById("cf_" + (selectedFilterCriteriaIndex == null ? "0" : selectedFilterCriteriaIndex) + "_" + selectedFilterId).style.backgroundColor = "#e3e3e3";
    }
  }
  var filedsValuesHasChanged = function () {
    var filterFields = treeFilter.getFields();
    var changed = false;
    for (var i = 0; i < filterFields.length && !changed; i++) {
      if (document.getElementById(filterFields[i].variable)) {
        changed = document.getElementById(filterFields[i].variable).value != (filterFields[i].value == null ? "" : filterFields[i].value);
      }
    }
    return changed;
  }
  this.resetFields = function () {
    var filterFields = treeFilter.getFields();
    for (var i = 0; i < filterFields.length; i++) {
      if (document.getElementById(filterFields[i].variable)) {
        if (document.getElementById(filterFields[i].variable).type != "hidden") {
          document.getElementById(filterFields[i].variable).value = "";
        }
      }
    }
    this.unselectFilter();
  }
  this.setScroll = function (scrollTop) {
    treeFilter.setScroll(scrollTop);
  }
}
var filterPrinter = new FilterPrinter();
</script>
<script>
function showContextMenu(html, x, y, tabBarNumber)
{
  document.getElementById(CONTEXT_MENU_ID).innerHTML = html;
  offset = $("#tbb" + tabBarNumber).offset();
  $("#" + CONTEXT_MENU_ID).css({left:x + "px", top:(y + offset.top + parseInt($("#tbb" + tabBarNumber).css("height"))) + "px"});
  $("#" + CONTEXT_MENU_ID).fadeIn("fast");
}
function hideContextMenu()
{
  $("#" + CONTEXT_MENU_ID).fadeOut("fast");
}
function closeInventory()
{
  var ttl = "<%=confirm_operation%>";
  var msg = "<%=confirm_operation_close_inventory%>";
  var fc = new HPSAConfirm(ttl, msg, "confirmedCloseInventory()", "");
  fc.setAcceptButtonText("<%=confirm_operation_button_accept%>");
  fc.setCancelButtonText("<%=confirm_operation_button_cancel%>");
  fc.setBlockingConfirm(true);
  fc.show();
}
function confirmedCloseInventory()
{
  closeAllTabs();
  window.close();
}
function closeAllTabs()
{
  TabBarManager.forceCloseAllTabs(1);
  TabBarManager.forceCloseAllTabs(3);
}
function crossLaunch(solutionName, viewName, branchPath, pk, operation, fnt)
{
  var tab;
  var sessionAttributes;
  var sessionAttribute = null;
  var instance = "";
  var view;
  var op;
  var tabBarNumber = 3;
  if (viewName && solutionName && branchPath && pk) {
    view = solutionName + "||" + viewName;
    op = operation != null ? "&operation=" + operation : "";
    tab = (!fnt) ? TabBarManager.getTabBySessionAttribute(tabBarNumber, "solution||view_" + view) : null;
    if (tab != null) {
      sessionAttributes = tab.getSessionAttributes();
      if (sessionAttributes != null) {
        for (var i = 0; i < sessionAttributes.length && sessionAttribute == null; i++) {
          sessionAttribute = sessionAttributes[i];
          if (sessionAttribute.indexOf("view") != 0) {
            sessionAttribute = null;
          }
        }
        instance = sessionAttribute != null ? "&oldinstance=" + sessionAttribute : "";
      }
      TabBarManager.forceCloseTab(tabBarNumber, tab.getId());
    }
    TabBarManager.addTab(3, "Cross Launch", 
        "<%=request.getContextPath()%>/GetFullTreeInstanceAction.do?rmn=3&view=" + view + "&route=" + branchPath + "&pk=" + pk + op + instance);
  } else {
    var falert = new HPSAAlert("<%=error%>","<%= cross_launch_required_parameters %>");
    falert.setBounds(400, 120);
    falert.setButtonText("<%=confirm_operation_button_accept%>");
    falert.show();
  }
}
</script>
<script>
// backward compatibility functions
function setSessionAttribute(tabBarNumber, tab, attName)
{
  TabBarManager.addSessionAttribute(parseInt(tabBarNumber), attName);
}
function addRimToMenu(tabBarNumber, tabLabel, tabSelected, tabUrl, hasWarning)
{
  if (hasWarning) {
    confirmOperation("TabBarManager.addTab(" + tabBarNumber + ", '" + tabLabel + "', '" + tabUrl + "');", null);
  } else {
    TabBarManager.addTab(parseInt(tabBarNumber), tabLabel, tabUrl);
  }
}
function switchView(tabBarNumber, tabLabel, tabSelected, tabUrl, hasWarning, openNewTab)
{
  if (hasWarning) {
    confirmOperation("TabBarManager.switchTab(" + tabBarNumber + ", '" + tabLabel + "', '" + tabUrl + "', " + openNewtab + ");", null);
  } else {
    TabBarManager.switchTab(parseInt(tabBarNumber), tabLabel, tabUrl, openNewTab);
  }
}
function refreshParentRimTree(tabBarNumber, tabId, reloadTree)
{
  TabBarManager.refreshTab(parseInt(tabBarNumber), tabId, reloadTree);
}
function closeRim(tabBarNumber, tabId)
{
  TabBarManager.forceCloseTab(parseInt(tabBarNumber), tabId);
}
function hideFlyingMenu()
{
	hideContextMenu();
}
function confirmOperation(acceptop, cancelOp)
{
  var aop = acceptop == null ? "" : acceptop;
  var cop = cancelOp == null ? "" : cancelOp;
  var ttl = "<%=confirm_operation_title%>";
  var msg = "<%=confirm_operation_message%>";
  var fc = new HPSAConfirm(ttl, msg, aop, cop);
  fc.setAcceptButtonText("<%=confirm_operation_button_accept%>");
  fc.setCancelButtonText("<%=confirm_operation_button_cancel%>");
  fc.setBlockingConfirm(true);
  fc.show();
}
</script>
<script>
$(function() {
  var operation = <%= operation != null ? "\"" + operation  + "\"": "null" %>;
  var fnt = <%= fnt != null ? fnt.equalsIgnoreCase("true") : false %>; 
  var useRandomColor = false;
	var inventoryWinName = "Inventory";
	var currentWindow = window;
  if ((!window.name || window.name != inventoryWinName) && (window.location.href.indexOf("?cl") > -1 || window.location.href.indexOf("&cl") > -1)) {
	  var attr = "location=false,menubar=false,resizable=true,scrollbars=true,status=false,width=700,height=600,left=150,top=150";
	  var inventoryWinRef = window.open("", inventoryWinName);
	  if (inventoryWinRef.location.href != "about:blank") {
		  inventoryWinRef.crossLaunch('<%= solutionName %>', '<%= viewName %>', '<%= branchPath %>', '<%= pk %>', operation, fnt);
	  } else {
		  window.open(window.location.href, inventoryWinName, attr);
	  }
	  currentWindow = top;
	  currentWindow.opener = top;
	  currentWindow.close();
	  try {
      if (inventoryWinRef) {
        inventoryWinRef.focus();
      }
    } catch (e) {
      // ignore it
    }
  }
  InventorySystem.init();
  function handleDoubleClick(e){
    
  }
  function handleMouseDown(e){
    InventorySystem.handleMouseDown(e);
  }
  function handleMouseUp(e){
    InventorySystem.handleMouseUp(e);
  }
  function handleMouseMove(e){
    InventorySystem.handleMouseMove(e);
  }
  function handleDragStart(e){
    InventorySystem.handleMouseDown(e);
  }
  function handleDragOver(e){
    InventorySystem.handleMouseMove(e);
  }
  function handleDragLeave(e){
    InventorySystem.handleMouseUp(e);
  }
  function addEvent(evnt, elem, func) {
    if (elem.addEventListener) { // W3C DOM
      elem.addEventListener(evnt,func,false);
    } else if (elem.attachEvent) { // IE DOM
      elem.attachEvent("on"+evnt, func);
    } else { // Not much to do
      elem[evnt] = func;
    }
  }
  addEvent("dblclick", document.body, handleDoubleClick);
  addEvent("mousedown", document.body, handleMouseDown);
  addEvent("mouseup", document.body, handleMouseUp);
  addEvent("mousemove", document.body, handleMouseMove);
  addEvent("dragstart", document.body, handleDragStart);
  addEvent("dragover", document.body, handleDragOver);
  addEvent("dragleave", document.body, handleDragLeave);

<%
if (vts != null) {
%>
<%= TreeViewStructureCodeWriter.writeMenus(vts, contextPath, hasClassView, classic_inventory_view, 0) %>
<%
}
%>
  var defaultTrees = new Array();
	var defaultTreesLabel = new Array();
<%
if (vts != null) {
%>
<%= TreeViewStructureCodeWriter.writeDefaultViews(vts) %>
<%
}
%>
  var firstDefaultTabId = null;
  for (var i = 0; i < defaultTrees.length && i < defaultTreesLabel.length; i++) {
    var tabId = TabBarManager.addTab(3, defaultTreesLabel[i], "<%=request.getContextPath()%>/GetTreeInstanceAction.do?view=" + defaultTrees[i] + "&&rmn=3");
    if (i + 1 < defaultTrees.length && i + 1 < defaultTreesLabel.length) {
      TabBarManager.pinCloseTab(3, tabId);
    }
    if (i == 0) {
      firstDefaultTabId = tabId;
    }
  }
  if (firstDefaultTabId != null) {
    TabBarManager.setActiveTab(3, firstDefaultTabId);
  }
<%
if (cl != null) {
%>
  crossLaunch('<%= solutionName %>', '<%= viewName %>', '<%= branchPath %>', '<%= pk %>', operation);
<%
}
%>
});
function handleResize(e){
  $("#overglass").css({display:"none"});
  filterPrinter.hide();
}
</script>
</head>

<body onresize="InventorySystem.onResize();handleResize();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();" onbeforeunload="closeAllTabs();">
<div class="main_area">
  <div id="s1" style="position:absolute; top:0px; left:0px; width:30%; height:50%;">
    <div class="square">
      <div id="tbsc1" class="scrollable_tab_bar">
        <ul id="tb1" class="tab_bar"></ul>
      </div>
      <div id="tbb1" class="tab_bar_context_menu" onclick="TabBarManager.showTabList(1);">&nbsp;</div>
      <div id="sif1" class="tab_window"></div>
    </div>
    <div id="sb1" class="status_bar">&nbsp;</div>
    <div id="r1" class="resize nsew"></div>
  </div>
  <div id="s2" style="position:absolute; top:0px; left:30%; width:70%; height:50%;">
    <div class="square">
      <div id="tbsc2" class="scrollable_tab_bar">
        <ul id="tb2" class="tab_bar"></ul>
      </div>
      <div id="tbb2" class="tab_bar_context_menu" onclick="TabBarManager.showTabList(2);">&nbsp;</div>
      <div id="sif2" class="tab_window" style="border-left:1px solid #e3e3e3;"></div>
    </div>
    <div id="sb2" class="status_bar">&nbsp;</div>
    <div id="r2" class="resize ns"></div>
  </div>
  <div id="s3" style="position:absolute; top:50%; left:0px; width:30%; height:50%;">
    <div class="square">
      <div id="tbsc3" class="scrollable_tab_bar">
        <ul id="tb3" class="tab_bar"></ul>
      </div>
      <div id="tbb3" class="tab_bar_context_menu" onclick="TabBarManager.showTabList(3);">&nbsp;</div>
      <div id="sif3" class="tab_window"></div>
    </div>
    <div id="sb3" class="status_bar">&nbsp;</div>
    <div id="r3" class="resize ew"></div>
  </div>
  <div id="s4" style="position:absolute; top:50%; left:30%; width:70%; height:50%;">
    <div class="square">
      <div id="tbsc4" class="scrollable_tab_bar">
        <ul id="tb4" class="tab_bar"></ul>
      </div>
      <div id="tbb4" class="tab_bar_context_menu" onclick="TabBarManager.showTabList(4);">&nbsp;</div>
      <div id="sif4" class="tab_window" style="border-left:1px solid #e3e3e3;"></div>
    </div>
    <div id="sb4" class="status_bar">&nbsp;</div>
  </div>
</div>
<div id="menu_bar" class="menu_bar"></div>
<div id="overglass" style="position:fixed; top:0px; left:0px; background:#ffffff; width:100%; height:100%; display:none; opacity:0.1;">&nbsp;</div>
<div id="context_menu" class="context_menu"></div>
<div id="filter_area" class="context_menu" style="display:none;"></div>
</body>

</html>