<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 java.net.*,
                 java.io.*"
%>

<%!  
   // global 
   final static String actionLabel    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("181", "Actions");
   final static String viewLabel      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("182", "View");
   final static String menuCloseImg   = ""; 
   final static String msgFrame       = "messageLine";
   final static String actionFrame    = "action";

   // jobs action menu
   final static String wfStopLabel    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("183", "Stop");
   final static String wfStopImg      = "../images/stopworkflow.16.gif";
   final static String wfIntLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("184", "Interact");
   final static String wfIntImg       = "../images/interact.16.gif";
   final static String interactPerm   = "1";
   final static String stopPerm       = "2";
   final static String fullPerm       = "3";
   final static String notSelected    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("185", "Please select a job first.");
   final static String noInteractPerm = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("186", "You do not have the appropriate permissions to interact with the requested job.");
   final static String noStopPerm     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("187", "You do not have the appropriate permissions to stop the requested job.");


   // workflow action menu
   final static String wfStartLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("112", "Start");
   final static String wfStartImg     = "../images/startwrkflow.16.gif";
   final static String wfOtherLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("188", "Start Other");
   final static String wfOtherImg     = "../images/otherworkflow.16.gif";
   final static String wfReloadLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("189", "Reload Workflows");
   final static String wfReloadImg     = "../images/reloadwrkflow.16.gif";

   // messages action menu
   final static String msgDelLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("190", "Delete");
   final static String msgDelImg     = "../images/delmessage.16.gif";
   final static String msgDelAllLabel= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("191", "Delete All");
   final static String msgDelAllImg  = "../images/delall.16.gif";

   // test action menu
   final static String testStartLabel= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("112", "Start");
   final static String testStartImg  = "../images/testStart.16.gif";

   // help action menu
   final static String helpImg         = "../images/docHelp.16.gif";  
   final static String introLabel      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("192", "Introduction");
   final static String workflowLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("141", "Workflows");
   final static String inventoryLabel  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("145", "Inventory");
   final static String pluginLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("193", "Plug-ins");
   final static String pluginLibLabel  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("271", "Plug-in Lib");
   final static String exampleLabel    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("194", "Examples");

   // logs action menu
   final static String logLabel      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("195", "Log Files");
   final static String logCloseImg   ="";
   final static String logLabelImg   ="../images/workflowlog.16.gif";
   final static String logDelLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("196", "Delete Inactive");
   final static String logDelImg     = "../images/clearlog.16.gif";
   final static String logMenuFrame  = "action";
   final static String logActionFrame= "action2";
   final static String trackLabel      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("76", "Activation Status");
   final static String trackLabelImg   ="../images/track.16.gif";

   // config action menu
   final static String uiLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("197", "Operator UI");
   final static String uiImg       = "../images/config.gif";
   //final static String mwfmLabel   = "MWFM ";
   final static String mwfmImg     = "../images/config.gif";  
   final static String serverLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("198", "Server Stats");
   final static String serverImg   = "../images/config.gif";
   final static String wfLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("199", "Workflow Stats");
   final static String wfImg       = "../images/config.gif";  
   final static String statServerPort = ":7070";

   // tools action menu
   final static String backupLabel         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("301", "Backup");
   final static String backupImg           = "../backup/images/save.gif";

   final static String crmLabel         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("311", "CRM Portal");
   final static String crmImg           = "../crm/images/crmPortal.gif";

   // backup action menu
   final static String equipmentsLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("302","Equipments");
   final static String createConfigLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("303","Insert Config");
   final static String createConfigImg     = "../backup/images/createconfig.gif";
   final static String listConfigLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("304","List Configs");
   final static String listConfigImg       = "../backup/images/list.gif";
   final static String findConfigLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("305","Find Config");
   final static String findConfigImg       = "../backup/images/search.gif";
   final static String backupConfigLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("306","Manual Backup");
   final static String backupConfigImg     = "../backup/images/save.gif";
   //-----------------
   final static String schedulingLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("307","Scheduling");
   final static String createPolicyLabel   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("308","Create Policy");
   final static String createPolicyImg     = "../backup/images/createPolicy.gif";
   final static String listPolicyLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("309","List Policies");
   final static String listPolicyImg       = "../backup/images/list.gif";
   //-----------------
   final static String retrievalLabel     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("310","Retrieval");
   final static String retrievalImg       = "../backup/images/hard-disk.gif";

//////////////////////////////////////////////
//  Utility functions
//////////////////////////////////////////////

   public String buildHeader(String headerName, String frameName) {
     String html;

     if (frameName.equals(logActionFrame)) {
         html = "<br>\n";
     } 
     else  {
        //top corners
        html =  " <html>\n";
        html += " <head>\n";
        html += " <script language='JavaScript' src='../javascript/menu.js'></script>\n ";
        html += " <script language='JavaScript' src='../javascript/backup.js'></script>\n ";
        html += " <script language='JavaScript' src='../javascript/table.js'></script>\n ";
        html += " <link rel='stylesheet' type='text/css' href='../css/activator.css'>\n ";
        html += " <base target='" + frameName + "'>\n ";
        html += " </head>\n ";
        html += " <body background='../images/stripe.gif'>\n ";
     }

     // table definition for menu header and options
     html += " <div align='center'>\n " ;
     html += " <TABLE border='0' cellspacing='0' cellpadding='0' width=150>\n ";
     html += " <tr>\n ";
     html += "   <td width='20' valign='top'><img src='../images/tl_navcorner_20.gif'";
     html += "     width='20' height='20' border='0' alt=''></td>\n";
     html += "   <td width=110 height='20' class='navHeading'>"+headerName+"</td>\n";
     html += "   <td width='20' valign='top'><img src='../images/tr_navcorner_20.gif'";
     html += "     width='20' height='20' border='0' alt=''></TD>\n";
     html += " </tr>\n ";
     html += " <tr><td colspan=3  height='10' class='actRow'>&nbsp</td></tr>\n";

     return html;
   }
  
   String buildBottomCorners() {
     String html;
       
     // bottom corners 
     html = "<tr>";
     html += "<td width='20' valign='top'><img src='../images/bl_navcorner_20.gif'";
     html += " width='20' height='20' border='0' alt=''></td>\n";
     html += " <td width='110' align='left' class='navRow' >&nbsp</td>\n";
     html += " <td width='20' valign='top'><img src='../images/br_navcorner_20.gif'";
     html += " width='20' height='20' border='0' alt=''></TD>\n";
     html += " </tr>\n";

     return html;
   }


   String buildFooter()
   {
     String html;

     // bottom corners 
     html = buildBottomCorners();

     html += "</div>\n";
     html += "</table>\n";
     html += "</body>\n"; 
     html += "</html>\n";
     return html;
   }

  String drawLine()
  {
     String html;
     html  = "<tr>";
     html += "<td width='30' class='actRow'><spacer type='block' width='1' height='1'></td>";
     html += "<td width='80' bgcolor='black'><spacer type='block' width='1' height='1'></td>";
     html += "<td width='30' class='actRow'><spacer type='block' width='1' height='1'></td>";
     html += "</td>";
     html += "</tr>\n";
     return html;
  }

//////////////////////////////////////////////
//  Log functions
//////////////////////////////////////////////
  String buildLogActions() {
    String html;
  
    // build the header
    html = buildHeader(actionLabel,logActionFrame);

    // build the body
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +logDelImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='verifyAction.jsp?action=delLogs'";
    html += " target='messageLine'>"+ "&nbsp " + logDelLabel +"</a>\n";
    html += " </td>\n ";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'>";
    html += " </td>\n ";
    html += " </tr>\n";

    // build the footer
    html += buildFooter();

    return html;
  }


  String buildLogFileMenu(HttpSession session) {

    String html;

    html = buildHeader(viewLabel,logMenuFrame);

    // Figure out what log files need to be displayed --
    // *.log files can just simply be processed with showLog.jsp
    // *.xml files need to be processed by servlet/logFile

    // display the tracking page
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +trackLabelImg+ "'>";
    html += " <td width='110' height='15' class='actRow' ";
    //html += " <td width='110' height='15' class='actRow' onClick='../servlet/track'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='trackFrame.jsp' target='main'>"+ "&nbsp " + trackLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    File[] af = new File ((String) session.getAttribute(Constants.LOG_DIRECTORY)).listFiles();
    if (af != null) {

      for (int i = 0; i < af.length; i++) {
         String logName=af[i].getName();

         // hack because the current log name is way too long for the menu
         int eIndex = logName.indexOf(".log.xml");
         String displayLogName = (eIndex==-1 ? logName : logName.substring(0,eIndex));

         html += " <tr>\n";
         html += " <td width='20' height='15' class='actRow'align='right'>";
         html += " <img src='" +logLabelImg+ "'></td>\n";
         html += " <td width='110' height='15' class='actRow'";
         html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
         html += " <a href='logFrame.jsp?name=" +URLEncoder.encode(logName) + "'";
         html += " target='main'>"+"&nbsp " + displayLogName+"</a>";
         html += " </td>\n ";
         html += " <td width='20' height='15' class='actRow'>";
         html += " <spacer type='block' width='1' height='1'>";
         html += " </td>\n ";
         html += " </tr>\n ";
       }
     }

     // close the html
     html += buildBottomCorners();
     html += "</div>\n";
     html += "</table>\n";

     // now build the log Actions submenu -- ONLY if the user has permission to delete logs
     if (((Boolean) session.getValue(Constants.MWFM_SERVICES)).booleanValue() == true) {
         html += buildLogActions();
     } 
     else {
         html += "</body>";
         html += "</html>";
     }

     return html;
   }

//////////////////////////////////////////////
//  help actions 
//////////////////////////////////////////////
  String buildHelpActions() {
    String html;
  
    // build the header
    html = buildHeader(viewLabel,actionFrame);

    // build the body
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +helpImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='../docs/IntroductionToServiceActivator.pdf' target='_blank'>"+ "&nbsp " + introLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +helpImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='../docs/Workflows.pdf' target='_blank'>"+ "&nbsp " + workflowLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +helpImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='../docs/Inventory.pdf' target='_blank'>"+ "&nbsp " + inventoryLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +helpImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='../docs/Plug-ins.pdf' target='_blank'>"+ "&nbsp " + pluginLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +helpImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='../docs/Plug-inLibraryGuide.pdf' target='_blank'>"+ "&nbsp " + pluginLibLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +helpImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='../docs/PuttingServiceActivatorToWork.pdf' target='_blank'>"+ "&nbsp " + exampleLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // build the footer
    html += buildFooter();

    return html;
  }

//////////////////////////////////////////////
//  message actions 
//////////////////////////////////////////////
  String buildMessageActions() {
    String html;
  
    // build the header
    html = buildHeader(actionLabel,msgFrame);

    // delete the selected message
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +msgDelImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='deleteMessage.jsp'>"+ "&nbsp " + msgDelLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // Delete all messages
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +msgDelAllImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='deleteAllMsgs.jsp'>"+ "&nbsp " + msgDelAllLabel +"</a>\n";
    html += " </td>\n ";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // build the footer
    html += buildFooter();

    return html;
  }

//////////////////////////////////////////////
//  job actions 
//////////////////////////////////////////////
  String buildJobInteractAction() {
    String html;

    html = " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +wfIntImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='interact.jsp' target='messageLine' " +
            " OnClick='return checkInteractJob(\"" + notSelected + "\",\""+noInteractPerm+"\");'> " + "&nbsp " + wfIntLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    return html;
}

  String buildJobStopAction() {
    String html;
  
    html = " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +wfStopImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='verifyAction.jsp?action=stop' target='messageLine' " +
            " OnClick='return checkStopJob(\"" + notSelected + "\",\"" + noStopPerm+"\");'>"+ "&nbsp " + wfStopLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    return html;
}

  String buildJobActions() {
    String html;
  
    // build the header
    html = buildHeader(actionLabel,msgFrame);

    // interact with a running job 
    html += buildJobInteractAction();

    // stop the job 
    html += buildJobStopAction();

    // build the footer
    html += buildFooter();

    return html;
  }

public String buildJobSpecificActions(String jobPerms) {
    String html;

    // build the header
    html = buildHeader(actionLabel,msgFrame);

    // build the interact action
    if (jobPerms.equals(interactPerm) || jobPerms.equals(fullPerm)) {
       html +=  buildJobInteractAction();
    }

    // build the stop action
    if (jobPerms.equals(stopPerm) || jobPerms.equals(fullPerm)) {
       html +=  buildJobStopAction();
    }

    // build the footer
    html += buildFooter();

    return html;
  }
  

//////////////////////////////////////////////
//  workflow actions 
//////////////////////////////////////////////
  String buildWorkflowActions(HttpSession session) {
    String html;
  
    // build the header
    html = buildHeader(actionLabel,msgFrame);

    // build the body
    // start workflow
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +wfStartImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='startProcessName.jsp'>"+ "&nbsp " + wfStartLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // start a workflow not listed
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +wfOtherImg+ "'>";
    html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='startOther.jsp' onClick=\"var win=window.open('startOther.jsp','startOther','width=600,height=200,titlebar=yes');win.focus();return false\"> " + "&nbsp " + wfOtherLabel +"</a>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // if the user has administrative provide a "reload workflow" option
    if (((Boolean) session.getValue(Constants.MWFM_SERVICES)).booleanValue() == true) {
       html += " <tr>\n ";
       html += " <td width='20' height='15' class='actRow' align='right'>";
       html += " <img src='" +wfReloadImg+ "'>";
       html += " <td width='110' height='15' class='actRow' onClick='mClk(this);'";
       html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
       html += " <a href='showAvailWF.jsp?reload=yes' target='availWF'>"+ "&nbsp " + wfReloadLabel +"</a></td>\n";
       html += " <td width='20' height='15' class='actRow'>";
       html += " <spacer type='block' width='1' height='1'></td>\n ";
       html += " </tr>\n";
    }


    // build the footer
    html += buildFooter();

    return html;
  }

//////////////////////////////////////////////
//  test actions 
//////////////////////////////////////////////
  String buildTestActions() {
    String html;
  
    // build the header
    html = buildHeader(actionLabel,msgFrame);

    // build the body
    // start the test
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +testStartImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='tests/startTest.jsp'>"+ "&nbsp " + testStartLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // build the footer
    html += buildFooter();

    return html;
  }

//////////////////////////////////////////////
//  configuration actions 
//////////////////////////////////////////////
  String buildConfigActions(String serverName, String displayStats) {
    String html;
  
    // build the header
    html = buildHeader(viewLabel,msgFrame);

    // build the body
    // operator ui configuration 
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +uiImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='displayUIparms.jsp' target='configBody'>";
    html += " &nbsp " + uiLabel + "</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    //  mwfm configuration
    /***************  FOR NEXT RELEASE
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +mwfmImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='http://" + statServerPort + "/parameters' target='configBody'>";
    html += " &nbsp " + mwfmLabel + "</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
    ***********************/

    if (displayStats.equals("true")) {
        //  server statistics
        html += " <tr>\n ";
        html += " <td width='20' height='15' class='actRow' align='right'>";
        html += " <img src='" +serverImg+ "'>";
        html += " <td width='110' height='15' class='actRow'" ;
        html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
        html += " <a href='http://" + serverName + statServerPort + "/server' target='configBody'>";
        html += " &nbsp " + serverLabel + "</a></td>\n";
        html += " <td width='20' height='15' class='actRow'>";
        html += " <spacer type='block' width='1' height='1'></td>\n ";
        html += " </tr>\n";

        //  workflow statistics
        html += " <tr>\n ";
        html += " <td width='20' height='15' class='actRow' align='right'>";
        html += " <img src='" +wfImg+ "'>";
        html += " <td width='110' height='15' class='actRow'" ;
        html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
        html += " <a href='http://" + serverName + statServerPort + "/statistics' target='configBody'>";
        html += " &nbsp " + wfLabel +"</a></td>\n";
        html += " <td width='20' height='15' class='actRow'>";
        html += " <spacer type='block' width='1' height='1'></td>\n ";
        html += " </tr>\n";
    }

    // build the footer
    html += buildFooter();

    return html;
  }

//////////////////////////////////////////////
//  tools actions 
//////////////////////////////////////////////
  String buildToolsActions(HttpSession session) {
    String html;
    String hostName;
    String osName = System.getProperty("os.name");
    try {
      InetAddress localHostIP = InetAddress.getLocalHost();
      hostName = localHostIP.getHostName();
      // There is a problem with Windows 2000. But since it is never used as a server we use localhost
      if (osName.equals("Windows 2000"))
        hostName = "127.0.0.1";
    } catch (Exception e) {
      hostName = "127.0.0.1";
    }

    // build the header
    html = buildHeader(actionLabel,msgFrame);
    if(!((String)session.getAttribute(Constants.USER)).equalsIgnoreCase("nomenus"))
    {
	    // build the body
	    // Back-up
	    html += " <tr>\n ";
	    html += " <td width='20' height='15' class='actRow' align='right'>";
	    html += " <img src='" +backupImg+ "'>";
	    html += " <td width='110' height='15' class='actRow'" ;
	    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
	    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames[2].parent.frames[2].location.href='buildSubMenus.jsp?menu=backup'\" >"+ "&nbsp " + backupLabel +"</a></td>\n";
	    html += " <td width='20' height='15' class='actRow'>";
	    html += " <spacer type='block' width='1' height='1'></td>\n ";
	    html += " </tr>\n";

	    // CRM-portal
	    html += " <tr>\n ";
	    html += " <td width='20' height='15' class='actRow' align='right'>";
	    html += " <img src='" +crmImg+ "'>";
	    html += " <td width='110' height='15' class='actRow'" ;
	    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
	    html += " <a href='emptyMsgFrame.jsp' onclick=\"window.open('http://"+hostName+":8080/portal/portalLogin?user=" + session.getAttribute(Constants.USER) + "&password=empty')\" >"+ "&nbsp " + crmLabel +"</a></td>\n";
	    html += " <td width='20' height='15' class='actRow'>";
	    html += " <spacer type='block' width='1' height='1'></td>\n ";
	    html += " </tr>\n";
    }

    // build the footer
    html += buildFooter();

    return html;
  }

//////////////////////////////////////////////
//  backup model2 actions 
//////////////////////////////////////////////
  String buildBackupActions() {
    String html;
  
    // build the equipments menu
    html = buildHeader(equipmentsLabel,msgFrame);

    // build the body
    // create config
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +createConfigImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/CreationFormEquipmentConfiguration.jsp'\" >"+ "&nbsp Insert Config</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // list config
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +listConfigImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/FindEquipmentList.jsp'\" >"+ "&nbsp " + listConfigLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // find config
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +findConfigImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    //html += " <a href='../backup/FindSelectedEquipmentConfiguration.jsp'>"+ "&nbsp " + findConfigLabel +"</a></td>\n";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/FindSelectedEquipmentConfiguration.jsp'\" >"+ "&nbsp " + findConfigLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // backup config
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +backupConfigImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    //html += " <a href='../backup/BackupEquipmentConfiguration.jsp'>"+ "&nbsp " + backupConfigLabel +"</a></td>\n";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/BackupEquipmentConfiguration.jsp'\" >"+ "&nbsp " + backupConfigLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
/* Policies are skipped for now
    // build the footer
     html += "<tr>";
     html += " <td width='110' colspan='3' align='left' class='navRow' >&nbsp</td>\n";
     html += " </tr>\n";
     //html += "</div>\n";
     html += "</table>\n";
     //html += "</body>\n"; 
     //html += "</html>\n";

    // build the scheduling menu
    html += buildToolsHeader(schedulingLabel,msgFrame);

    // build the body
    // create policy
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +createPolicyImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/CreationFormSchedulingPolicy.jsp'\" >"+ "&nbsp " + createPolicyLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // list policy
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +listPolicyImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/FindSchedulingPolicy.jsp'\" >"+ "&nbsp " + listPolicyLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";


    // build the footer
     html += "<tr>";
     html += " <td width='110' colspan='3' align='left' class='navRow' >&nbsp</td>\n";
     html += " </tr>\n";
     //html += "</div>\n";
     html += "</table>\n";
     //html += "</body>\n"; 
     //html += "</html>\n";

    // build the retrieval menu
    html += buildToolsHeader(retrievalLabel,msgFrame);

    // create policy
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +retrievalImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    //html += " <a href='../backup/CreationFormRetrievalPolicy.jsp'>"+ "&nbsp " + createPolicyLabel +"</a></td>\n";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/CreationFormRetrievalPolicy.jsp'\" >"+ "&nbsp " + createPolicyLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";

    // list policy
    html += " <tr>\n ";
    html += " <td width='20' height='15' class='actRow' align='right'>";
    html += " <img src='" +listPolicyImg+ "'>";
    html += " <td width='110' height='15' class='actRow'" ;
    html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    //html += " <a href='../backup/FindRetrievalPolicy.jsp'>"+ "&nbsp " + listPolicyLabel +"</a></td>\n";
    html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/FindRetrievalPolicy.jsp'\" >"+ "&nbsp " + listPolicyLabel +"</a></td>\n";
    html += " <td width='20' height='15' class='actRow'>";
    html += " <spacer type='block' width='1' height='1'></td>\n ";
    html += " </tr>\n";
*/
    // build the footer
    html += buildFooter();
      
    return html;
  }

    
   public String buildToolsHeader(String headerName, String frameName) {
     String html;

     if (frameName.equals(logActionFrame)) {
         html = "<br>\n";
     } 
     else  {
        //top corners
        html =  " <html>\n";
        html += " <head>\n";
        html += " <script language='JavaScript' src='../javascript/menu.js'></script>\n ";
        html += " <script language='JavaScript' src='../javascript/backup.js'></script>\n ";
        html += " <link rel='stylesheet' type='text/css' href='../css/activator.css'>\n ";
        html += " <base target='" + frameName + "'>\n ";
        html += " </head>\n ";
        html += " <body background='../images/stripe.gif'>\n ";
     }

     // table definition for menu header and options
     html += " <div align='center'>\n " ;
     html += " <TABLE border='0' cellspacing='0' cellpadding='0' width=150>\n ";
     html += " <tr>\n ";
     //html += "   <td width='20' valign='top'><img src='../images/tl_navcorner_20.gif'";
     //html += "     width='20' height='20' border='0' alt=''></td>\n";
     html += "   <td width=110 colspan='3' height='20' class='navHeading'>&nbsp;"+headerName+"</td>\n";
     //html += "   <td width='20' valign='top'><img src='../images/tr_navcorner_20.gif'";
     //html += "     width='20' height='20' border='0' alt=''></TD>\n";
     html += " </tr>\n ";
     html += " <tr><td colspan=3  height='10' class='actRow'>&nbsp</td></tr>\n";

     return html;
   }
   
   ///////////////////////////////////////////////////////////////////
   // Equipment Actions
   ///////////////////////////////////////////////////////////////////
   public String buildEquipmentActions(String jobPerms, String allOptions) {
    	String html;
    	
    	// build the equipments menu
    	html = buildHeader(equipmentsLabel,msgFrame);

    	// build the body
    	// Clone option
    	if(allOptions !=  null && allOptions.equals("true")) {
	    	html += " <tr>\n ";
		html += " <td width='20' height='15' class='actRow' align='right'>";
	    	html += " <img src='../backup/images/list.gif'>";
    		html += " <td width='110' height='15' class='actRow'" ;
	    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    		html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/UpdateFormEquipmentConfiguration.jsp'\" >"+ "&nbsp Clone</a></td>\n";
	    	html += " <td width='20' height='15' class='actRow'>";
    		html += " <spacer type='block' width='1' height='1'></td>\n ";
	    	html += " </tr>\n";
	}

    	// Edit option
    	if(allOptions !=  null && allOptions.equals("true")) {
	    	html += " <tr>\n ";
		html += " <td width='20' height='15' class='actRow' align='right'>";
	    	html += " <img src='../backup/images/edit.gif'>";
    		html += " <td width='110' height='15' class='actRow'" ;
	    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    		html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/UpdateFormEquipmentConfiguration.jsp?only_conf=true'\" >"+ "&nbsp Edit</a></td>\n";
	    	html += " <td width='20' height='15' class='actRow'>";
    		html += " <spacer type='block' width='1' height='1'></td>\n ";
	    	html += " </tr>\n";
	}

    	// Delete option
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../backup/images/delete.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	//html += " <a href='emptyMsgFrame.jsp' target='messageLine' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/DeleteObjectConfirm.jsp?all=false&deleteClass=equipment'\" >"+ "&nbsp Delete</a></td>\n";
    	html += " <a href='../backup/jsp/DeleteObjectConfirm.jsp?all=false&deleteClass=equipment'>"+ "&nbsp Delete</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// Open option
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../backup/images/open.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	//html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/ShowEquipmentConfiguration.jsp'\" >"+ "&nbsp Open</a></td>\n";
    	html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/ShowEquipmentConfiguration.jsp'\" >"+ "&nbsp Restore Config</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// Audit option
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../backup/images/audit.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/AuditEquipmentConfiguration.jsp'\" >"+ "&nbsp Audit</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// build the footer
    	html += buildFooter();
    	html += "<p><center><a target='action' href='buildSubMenus.jsp?menu=backup'><img src='../backup/images/arrow_back.gif' border='0' alt='Back to menu'></a></center></p>";

     return html;
   }
   ///////////////////////////////////////////////////////////////////
   // Scheduling Actions
   ///////////////////////////////////////////////////////////////////
   public String buildSchedulingActions(String delete, String activeString) {
    	String html;
    	
    	// build the equipments menu
    	html = buildHeader(equipmentsLabel,msgFrame);

    	// build the body
    	// Modify 
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../backup/images/edit.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/UpdateFormSchedulingPolicy.jsp'\" >"+ "&nbsp Modify Policy</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// Active 
    	String active = "true";
    	if(!activeString.equalsIgnoreCase("ACTIVE")) {
    		active = "false";
    	}    	
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../images/ckmark.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/ActivePolicy.jsp?activeClass=scheduling&active=" + active + "'\" >"+ "&nbsp " + activeString + " Policy</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// Delete option
    	if(delete.equals("true")) {
	    	html += " <tr>\n ";
		html += " <td width='20' height='15' class='actRow' align='right'>";
    		html += " <img src='../backup/images/delete.gif'>";
	    	html += " <td width='110' height='15' class='actRow'" ;
    		html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    		html += " <a href='../backup/jsp/DeleteObjectConfirm.jsp?all=false&deleteClass=scheduling'>"+ "&nbsp Delete Policy</a></td>\n";
    		html += " <td width='20' height='15' class='actRow'>";
	    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    		html += " </tr>\n";
    	}

    	// build the footer
    	html += buildFooter();

    	// build the footer
    	html += "<p><center><a target='action' href='buildSubMenus.jsp?menu=backup'><img src='../backup/images/arrow_back.gif' border='0' alt='Back to menu'></a></center></p>";

     return html;
   }
   
   ///////////////////////////////////////////////////////////////////
   // Retrieval Actions
   ///////////////////////////////////////////////////////////////////
   public String buildRetrievalActions(String delete, String activeString) {
    	String html;
    	
    	// build the equipments menu
    	html = buildHeader(equipmentsLabel,msgFrame);

    	// build the body
    	// Modify 
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../backup/images/edit.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/UpdateFormRetrievalPolicy.jsp'\" >"+ "&nbsp Modify Policy</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// Active 
    	String active = "true";
    	if(!activeString.equalsIgnoreCase("ACTIVE")) {
    		active = "false";
    	}
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../images/ckmark.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/ActivePolicy.jsp?activeClass=retrieval&active=" + active + "'\" >"+ "&nbsp " + activeString + " Policy</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// Delete option
    	if(delete.equals("true")) {
	    	html += " <tr>\n ";
		html += " <td width='20' height='15' class='actRow' align='right'>";
    		html += " <img src='../backup/images/delete.gif'>";
	    	html += " <td width='110' height='15' class='actRow'" ;
    		html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    		html += " <a href='../backup/jsp/DeleteObjectConfirm.jsp?all=false&deleteClass=retrieval'>"+ "&nbsp Delete Policy</a></td>\n";
    		html += " <td width='20' height='15' class='actRow'>";
	    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    		html += " </tr>\n";
    	}

    	// build the footer
    	html += buildFooter();

    	// build the footer
    	html += "<p><center><a target='action' href='buildSubMenus.jsp?menu=backup'><img src='../backup/images/arrow_back.gif' border='0' alt='Back to menu'></a></center></p>";

     return html;
   }
   ///////////////////////////////////////////////////////////////////
   // Equipment Name Actions
   ///////////////////////////////////////////////////////////////////
   public String buildEquipmentNameActions() {
    	String html;
    	
    	// build the equipments menu
    	html = buildHeader(equipmentsLabel,msgFrame);

    	// Delete option
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../backup/images/delete.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	html += " <a href='../backup/jsp/DeleteObjectConfirm.jsp?all=true&deleteClass=equipmentName'>"+ "&nbsp Delete All Configs</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// Audit option
    	html += " <tr>\n ";
	html += " <td width='20' height='15' class='actRow' align='right'>";
    	html += " <img src='../backup/images/audit.gif'>";
    	html += " <td width='110' height='15' class='actRow'" ;
    	html += " onMouseOut='actUnhighlight(this);' onMouseOver='actHighlight(this);'>";
    	html += " <a href='emptyMsgFrame.jsp' onclick=\"parent.frames['main'].frames['main'].location='../backup/jsp/AuditLastEquipmentConfiguration.jsp'\" >"+ "&nbsp Audit Last Config</a></td>\n";
    	html += " <td width='20' height='15' class='actRow'>";
    	html += " <spacer type='block' width='1' height='1'></td>\n ";
    	html += " </tr>\n";

    	// build the footer
    	html += buildFooter();
    	html += "<p><center><a target='action' href='buildSubMenus.jsp?menu=backup'><img src='../backup/images/arrow_back.gif' border='0' alt='Back to menu'></a></center></p>";

     return html;
   }

%>
