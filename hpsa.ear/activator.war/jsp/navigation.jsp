<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, 
                 java.util.*,
                 java.net.*, 
                 javax.servlet.jsp.PageContext.*"
         info="Display main menu, show only options available to the user" 
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getValue (Constants.USER) == null) {
       response.sendRedirect ("sessionError.jsp");
       return;
    }

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
	request.setCharacterEncoding("UTF-8");
%>

<%!
	//I18N strings
	final static String workArea		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("153", "Work Area");
	final static String jobs		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("154", "Jobs");
	final static String messages		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("140", "Messages");
	final static String workflows		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("141", "Workflows");
	final static String inventory		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("145", "Inventory");
	final static String serviceInstance	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("36", "Service Instances");
	final static String instance		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("155", "Instances");
	final static String logs		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("139", "Logs");
	final static String configuration	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("143", "Configuration");
	final static String test		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("156", "Test");
	final static String help		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("157", "Help");
	final static String about		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("158", "About");
	final static String logout		= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("159", "Log Out");
%>

<html>
<head>
   <script language="JavaScript" src="../javascript/menu.js"></script>
   <script language="JavaScript" src="../../javascript/backup.js"></script>
   <link rel="stylesheet" type="text/css" href="../css/activator.css">
   <base target="_self">
</head>

<body background="../images/stripe.gif" topmargin="15">
<div align="center">

<TABLE border="0" cellspacing="0" cellpadding="0" width="150"> 
   <!-- add the product name gif -->
   <tr>
      <td width="20" valign="top">
        <img src="../images/tl_navcorner_20.gif" width="20" height="20" border="0" alt=""></td>
      <td width="110" align="left" class="navSubHeading"><%=workArea%></td>
      <td width="20" valign="top">
        <img src="../images/tr_navcorner_20.gif" width="20" height="20" border="0" alt=""></td>
   </tr>

<!-- spacer row -->
   <tr><td colspan=3  height="2" class="navRow">&nbsp</td></tr>

   <!-- Job Menu Options-->
   <tr>
      <td width="20" height="15" class="navRow" align="right">
         <img src="../images/jobs.16.gif"></td>
      <td width="110" height="15" CLASS="navRow" >
         <A href="jobFrame.jsp" target="main" class="navRow"
           onMouseOver="highlight(this);" 
           onMouseOut="unhighlight(this);" 
           onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=job';">
                    &nbsp <%=jobs%></a>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>
   
   
   <!-- Message Menu Options-->
   <tr>
      <td width="20"  height="15" class="navRow" align="right">
             <img src="../images/message.16.gif"></td>
      <td width="110" height="15" CLASS="navRow" >
             <A href="msgFrame.jsp" target="main" 
                 onMouseOver="highlight(this);" 
                 onMouseOut="unhighlight(this);" 
                 onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=message';" >
             &nbsp <%=messages%></a>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>
   
   <!-- Workflow Menu Options-->
   <tr>
      <td width="20" height="15" class="navRow" align="right"><img src="../images/workflow.16.gif"></td>
      <td width="110" height="15" CLASS="navRow" >
       <A href="wfFrame.jsp" target="main" 
          onMouseOver="highlight(this);" 
          onMouseOut="unhighlight(this);" 
          onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=workflow';">&nbsp <%=workflows%></a>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></TD>
   </tr>
   

  <!--  Start of the Inventory section - only place into menu if user selected IA inventory -->
<% 
    if (((Boolean) session.getValue(Constants.USE_IA_DB)).booleanValue() == true) {
%>
           <!--
              Don't select the inventory menu selection.  Since this pic
              spawns a new window we want the menu to continue to highlight
              the item that is displayed in the main framee
              onClick="menuSelect(this);">&nbsp <%=inventory%></td>
            -->

    <tr>
      <td width="20" height="15" class="navRow" align="right">
         <img src="../images/inventory.16.gif"></td>
      <td width="110" height="15" class="navRow" >
       <A href="javascript:window.open('inventory/invFrame.jsp?displayType=inventory','','resizable=yes,status=yes,width=700,height=600');void('');" 
            onMouseOver="highlight(this);"
            onMouseOut ="unhighlight(this);">&nbsp <%=inventory%></td>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>


<% } 
%>

   <!-- Tools Menu Options-->
   <tr>
      <td width="20" height="15" class="navRow" align="right">
         <img src="../images/tools/tool.gif"></td>
      <td width="110" height="15" CLASS="navRow" >
         <A href="toolsFrame.jsp" target="main" class="navRow"
           onMouseOver="highlight(this);" 
           onMouseOut="unhighlight(this);" 
           onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=tools';">
                    &nbsp Tools</a>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>

    <!-- Start of Logging section -->
   <tr>
     <td width="20"  height="15" class="navRow" align="right">
        <img src="../images/workflowlog.16.gif"></td>
     <td width="110" height="15" class="navRow" >
         <A href="logFrame.jsp?name=mwfm_active.log.xml" target="main" 
         onMouseOver="highlight(this);" 
         onMouseOut="unhighlight(this);"
         onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=logFiles';">&nbsp <%=logs%></a></td>
     <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>
      
  <!--  Start of Test section - only in menu if user has permissions to test messages -->
<% 
    if (((Boolean) session.getValue(Constants.MWFM_TESTS)).booleanValue() == true) {
%>
    <tr>
      <td width="20" height="15" class="navRow" align="right">
         <img src="../images/test.16.gif"></TD>
      <td width="110" height="15" CLASS="navRow" >
         <A href="tests/testFrame.jsp" target="main" 
            onMouseOver="highlight(this);" 
            onMouseOut="unhighlight(this);"
            onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=test';">&nbsp <%=test%></a></td>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>
<% } 
%>

  <!--  Start of Configuration section - only in menu if user is an administrator -->
<% 
   if (((Boolean) session.getValue(Constants.MWFM_SERVICES)).booleanValue() == true) {
%>
    <tr>
      <td width="20" height="15" class="navRow" align="right">
         <img src="../images/config.gif"></td>
      <td width="110" height="15" class="navRow"> 
         <A href="configFrame.jsp" target="main" 
           onMouseOver="highlight(this);" 
           onMouseOut="unhighlight(this);"
           onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=config';">&nbsp <%=configuration%></a></td>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>
<% } 
%>

   <!-- dividing bar  -->
   <tr>
      <td width="20" height="2" class="navRow"><spacer type="block" width="1" height="1"></td>
      <td width="110" height="2" class="navRow"><hr></hr></td>
      <td width="20" height="2" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>

   <!-- Help Menu Section  -->
   <tr>
     <td width="20" height="15" class="navRow" align="right">
         <img src="../images/help.16.gif"></td>
     <td width="110" height="15" CLASS="navRow"> 
         <a href="javascript:void('');"  
           onMouseOver="highlight(this);" 
           onMouseOut="unhighlight(this);"
           onClick="menuSelect(this);parent.frames[2].location.href='buildSubMenus.jsp?menu=help';">&nbsp <%=help%></a></td>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>
 
   <!-- About Menu Section  -->
   <tr>
     <td width="20" height="15" class="navRow" align="right">
         <img src="../images/about.16.gif"></td>
     <td width="110" height="15" CLASS="navRow" >
         <a href="javascript:void('');"  
            onMouseOver="highlight(this);" 
            onMouseOut="unhighlight(this);"
            onClick="menuSelect(this);var win=window.open('about.jsp','about','width=550,height=350');win.focus();">&nbsp <%=about%></td>
      <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>
   </tr>
 
   <!-- Log out Menu Section  -->
   <tr>
     <td width="20" height="15" class="navRow" align="right">
         <img src="../images/logout.16.gif"></TD>
     <td width="110" height="15" CLASS="navRow" >
         <A href="logout.jsp"
            onMouseOver="highlight(this);" 
            onMouseOut="unhighlight(this);">&nbsp <%=logout%></a></td>
     <td width="20" height="15" class="navRow"><spacer type="block" width="1" height="1"></td>    </tr>

   <!-- bottom corners -->
   <tr>
      <td width="20" valign="top">
        <img src="../images/bl_navcorner_20.gif" width="20" height="20" border="0" alt=""></td>
      <td width="110" align="left" class="navRow" >&nbsp</td>
      <td width="20" valign="top">
        <img src="../images/br_navcorner_20.gif" width="20" height="20" border="0" alt=""></TD>
   </tr>

</table>
</div>

<script>
    parent.frames['action'].location.href='buildSubMenus.jsp?menu=job'
</script>

</body>
</html>


