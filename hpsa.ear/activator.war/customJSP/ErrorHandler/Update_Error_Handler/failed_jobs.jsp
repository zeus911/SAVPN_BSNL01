<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>               
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/Update_Error_Handler/failed_jobs.jsp,v $                                                                   --%>
<%-- $Revision: 1.34 $                                                                 --%>
<%-- $Date: 2010-11-15 07:39:07 $                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- Queue: 'failed_jobs' --%>

<%@ page contentType="text/html; charset=UTF-8"
         import="javax.sql.DataSource,java.sql.Connection,
                 java.sql.*,com.hp.ov.activator.mwfm.JobRequestDescriptor,
                 com.hp.ov.activator.mwfm.WFManager,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.mwfm.AttributeDescriptor,
                 java.util.ArrayList,
                 com.hp.ov.activator.vpn.inventory.*,
                 java.text.*,com.hp.ov.activator.cr.inventory.NetworkElement,
                 java.util.*,
                 com.hp.ov.activator.vpn.errorhandler.*,
                 com.hp.ov.activator.vpn.utils.*,
                 com.hp.ov.activator.inventory.facilities.StringFacility,
                 java.io.*, com.hp.ov.activator.cr.struts.nnm.cl.NNMiAbstractCrossLaunchAction, com.hp.ov.activator.nnm.common.*" %>

<%
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>

<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
   

 <style>
.infoHead{
    font-family: Verdana, Helvetica, Arial, Sans-serif;
   font-size: 8pt;
   font-weight: bold;
    color: black;
    width: 20%;
    border-right: 1px solid #cccccc;
    border-bottom: 1px solid #cccccc;
}

.infoValue{
    font-family: Verdana, Helvetica, Arial, Sans-serif;
   font-size: 8pt;
    color: black;
    border-right: 1px solid #cccccc;
    border-bottom: 1px solid #cccccc;
}

   </style>
   <script language="JavaScript">       
    window.resizeTo(800,700);
   </script>
</head>


<body onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: ErrorHandler</h3>
<center>
<table width="100%" border=0 cellpadding=0>
<tr>
   <th class="tableHeading">Job ID</th>
   <th class="tableHeading">Workflow</th>
   <th class="tableHeading">Start Date & Time</th>
   <th class="tableHeading">Post Date & Time</th>
   <th class="tableHeading">Step Name</th>
   <th class="tableHeading">Description</th>
   <th class="tableHeading">Status</th>
</tr>


<%-- Get the job descriptor to enable access to general job information --%>
<% JobRequestDescriptor jd= (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); %>

<tr>
    <td class="tableRow"> <%= jd.jobId %> </td>
    <td class="tableRow"> <%= jd.name %> </td>
    <td class="tableRow"> <%= jd.startTime %> </td>
    <td class="tableRow"> <%= jd.postDate %> </td>
    <td class="tableRow"> <%= jd.stepName == null ? "&nbsp;" : jd.stepName %> </td>
    <td class="tableRow"> <%= jd.description == null ? "&nbsp;" : jd.description %> </td>
    <td class="tableRow"> <%= jd.status == null ? "&nbsp;" : jd.status %> </td>
</tr>
</table>

<%


    String ip = request.getRemoteAddr();
    AttributeDescriptor ad0 = jd.attributes[0]; // return_code
    AttributeDescriptor ad1 = jd.attributes[1]; // VPN_Info
    AttributeDescriptor ad2 = jd.attributes[2]; // message_data
    AttributeDescriptor ad6 = jd.attributes[6]; // message_url
    AttributeDescriptor ad7 = jd.attributes[7]; //skipactivation
    AttributeDescriptor ad8 = jd.attributes[8]; //activation_identifier
    AttributeDescriptor ad9 = jd.attributes[9]; //isp object
    AttributeDescriptor ad10 = jd.attributes[10]; //SERVICE_ID
    AttributeDescriptor ad12 = jd.attributes[12]; //attachment_id_aEnd
    AttributeDescriptor ad13 = jd.attributes[13]; //attachment_id_zEnd

    
    
    String return_code = request.getParameter("return_code");
    if ( return_code == null ) {
      return_code = ad0.value == null ? "" : ad0.value;
    }

    String VPN_Info = request.getParameter("VPN_Info");
    if ( VPN_Info == null ) {
      VPN_Info = ad1.value == null ? "" : ad1.value;
    }

    String message_data = request.getParameter("message_data");
    if ( message_data == null ) {
      message_data = ad2.value == null ? "" : ad2.value;
    }

    String message_url = request.getParameter("message_url");
    if ( message_url == null ) {
      message_url = ad6.value == null ? "" : ad6.value;
    }

    String skip_activation = request.getParameter("skip_activation");
    if ( skip_activation == null ) {
      skip_activation = ad7.value == null ? "" : ad7.value;
    }

    String activation_identifier = request.getParameter("activation_identifier");
    if ( activation_identifier == null ) {
      activation_identifier = ad8.value == null ? "" : ad8.value;
    }
     
    String service_id = request.getParameter("service_id");
    if ( service_id == null ) {
      service_id = ad10.value == null ? "" : ad10.value;
    }
   
    String attachment_id_aEnd = request.getParameter("attachment_id_aEnd");   
    if ( attachment_id_aEnd == null ) {
      attachment_id_aEnd = ad12.value == null ? "" : ad12.value;
    }
   
   String attachment_id_zEnd = request.getParameter("attachment_id_zEnd");   
    if ( attachment_id_zEnd == null ) {
      attachment_id_aEnd = ad13.value == null ? "" : ad13.value;
    }

String module_name ="GenericCLI";
String service_type="";
boolean show_activation_dialog=false;
boolean show_reselect_box=false;;
String equipment_name=null;
String primary_key=null;
String element_type=null;
String vendor=null;
String router_id="";
int selected = 0;
int networkelementSize=0;
boolean show_ne_link=true;
com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements = null;
boolean nnmEnabled = false;
//For NNM Cross Launch
com.hp.ov.activator.nnm.common.NNMiConfiguration nnmconf = null;

if(request.getParameter("router_id") != null){
      router_id=request.getParameter("router_id");
//      System.out.println("selected interface: " + interface_name);
    }


String error_string=null;
switch ( Integer.parseInt(return_code)) {
     case 0:   error_string="(OK)"; break;
     case 1: error_string="(FAILED)";  break;   
     case 2: error_string="(PARTIAL)"; break;   
     case 10:  error_string="(SCHEDULED)"; break;   
     default:  error_string="(UNKNOWN)";
 } 


%>
    <p>
    <table cellspacing="5">


<tr>
   <td><b>VPN Info</b></td>
   <td colspan="3"><%= VPN_Info %></td>
</tr>

<tr>
   <td><b>Request Message</b></b></td>
   <td colspan="3"><a href ="#" onClick="val='/activator/customJSP/ErrorHandler/Update_Error_Handler/show_request_message.jsp?'; window.open(val,'RequestMessage','resizable=yes,status=yes,width=900,height=500,scrollbars=yes');"><%= message_url %> </a>
   </td>
</tr>


<%
   DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection con = null;
        try {
        if (ds != null)  {
            con = ds.getConnection();
            if (con != null) {
               nnmconf = com.hp.ov.activator.nnm.common.NNMiConfiguration.findById(con, "1");
				 if((nnmconf != null) && (nnmconf.getEnable_cl()== true )){
					nnmEnabled=true;
				}

           //for vpws, service id is vpn_id, for l2vpn&l3vpn service_id is attachment
           Service service_obj= Service.findByServiceid(con,service_id); 
             
            if(service_obj !=null){
            		if(service_obj.getType()!=null && service_obj.getType().equals("L2VPWS"))
            		{       		
            		
            			Service accessflow_obj= AccessFlow.findByServiceid(con,attachment_id_aEnd);     
                    if(accessflow_obj !=null){
            		        int flowpoint_count = FlowPoint.findByAttachmentidCount(con,attachment_id_aEnd);
                        if (flowpoint_count == 0)
                           show_reselect_box =true;
            		    }
            		    
            		    accessflow_obj= AccessFlow.findByServiceid(con,attachment_id_zEnd);     
                    if(accessflow_obj !=null){
            		        int flowpoint_count = FlowPoint.findByAttachmentidCount(con,attachment_id_zEnd);
                        if (flowpoint_count == 0)
                           show_reselect_box =true;
            		    }           		    
            		
            		}else
            		{
                
                    AccessFlow accessflow_obj= AccessFlow.findByServiceid(con,service_id);     
                    if(accessflow_obj !=null){
            		        int flowpoint_count = FlowPoint.findByAttachmentidCount(con,service_id);
                         if (flowpoint_count == 0){
							if(accessflow_obj.getAsbr_status()!= null && accessflow_obj.getAsbr_status().equalsIgnoreCase("Failure"))
                           show_reselect_box =false;
							else
							show_reselect_box =true;
						 }
            		    }
            		}           
            }
            
            
            


    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    
    ErrorHandler erHandler = new ErrorHandler(); 

    ActivationInformation[] act= erHandler.getActivationInfo(con,activation_identifier,module_name);
    
    
%>

<%
    if(act!=null && act.length!=0 ){
	networkElements = new NetworkElement[act.length];
        int i=0;
show_activation_dialog=true;
 
 %>
<tr>
<td><b>Activation Attempts</b></td>
<td colspan="3" align="center">

 <table  align="left">
  <tr>
    <th class="infoHead" width="15%">Time stamp</th>
    <th class="infoHead"  width="15%">Activation dialog</th>
    <th class="infoHead"  width="40%">Equipment name(IP)</th>
    <th class="infoHead"  width="15%">Protocol</th>
    <th class="infoHead"  width="15%">Device dialog</th>
 </tr>


<%
	           
         for (;i<act.length;++i)  {
              String ipaddress= act[i].getHost();
              NetworkElement nes[]=NetworkElement.findByManagement_ip(con,ipaddress);
              if(nes !=null && nes.length >0) {
                equipment_name=nes[0].getName();
                primary_key=nes[0].getNetworkelementid();
                vendor=nes[0].getVendor();
                element_type=nes[0].getElementtype();
         				boolean exist= false;
  							for (int j=0;j<networkelementSize;++j){
                	if(equipment_name.equals(networkElements[j].getName())){
										exist= true;
										break;
        			 		}
        			 }
        			 	if(!exist){
        			 		networkElements[networkelementSize]= nes[0];
        			 		networkelementSize++;
        			 	}
        	
        			 		
               }else 
              {
                  equipment_name="";
              }
              //find the Equipment Details 
             String format="E MMM d HH:mm:ss z yyyy";
             java.text.SimpleDateFormat formatter= new java.text.SimpleDateFormat(format);
             java.util.Date date=new java.util.Date(new Long(act[i].getTime_stamp()).longValue());   

  %>
                
                <tr> 
                <td width="15%" class="infoValue" align="left"><%= formatter.format(date)%></td>
                <td width="15%" class="infoValue" align="left">
                
                <a href="#" onClick="val= '/activator/customJSP/ErrorHandler/Update_Error_Handler/show_activation_dialog.jsp?message_id=<%=act[i].getMessageId()%>&equipment_name=<%=equipment_name%>&element_type=<%=element_type%>&vendor=<%=vendor%>&action=view&service_type=<%=act[i].getDescription()%>'; window.open(val,'ActivationDialog','resizable=yes,status=yes,width=750,height=500,scrollbars=yes');"><%= act[i].getDescription()%>
				</a>
				<input width="15%" type="button" value="Save" onClick="val= '/activator/customJSP/ErrorHandler/Update_Error_Handler/show_activation_dialog.jsp?message_id=<%=act[i].getMessageId()%>&equipment_name=<%=equipment_name%>&element_type=<%=element_type%>&vendor=<%=vendor%>&action=save&service_type=<%=act[i].getDescription()%>'; window.open(val,'SaveResMgrLog','resizable=yes,status=yes,width=750,height=500,scrollbars=yes');">                
                </td>
                
                <td width="15%" class="infoValue" align="left">
                <%if(equipment_name!="" && show_ne_link){%>
                <U> 
                            <a style="cursor: pointer;  cursor: hand;" onClick="val= '/activator/inventory/SAVPN/ViewFormNetworkElementAction.do?networkelementid=<%=primary_key%>&datasource=inventoryDB'; a=window.open(val,'Equipmentwindow<%=primary_key%>','resizable=yes,status=yes,width=750,height=300,scrollbars=yes');a.focus();"><%=equipment_name%></a>
                </U> (<%= act[i].getHost()%>)

                <%}else if(show_ne_link){%>

                    <%= act[i].getHost()%>

                <%}else if (equipment_name!=""){%>

                <%=equipment_name+"(" +act[i].getHost()+")"%>
                
                
                <%}else{%>

                    <%=act[i].getHost()%>
                
                <%}%>
            
                </td>
                
                
                <td width="15%" class="infoValue" align="left"><%= act[i].getProtocol()%></td>
                
                
            <td width="40%" class="infoValue" align="left"><input type="button" value="View" onClick="val= '/activator/customJSP/ErrorHandler/Update_Error_Handler/show_cli_interaction.jsp?message_id=<%= act[i].getMessageId()%>&action=view&service_type=<%=act[i].getDescription()%>'; b=window.open(val,'ViewResMgrLog<%=i%>','resizable=yes,status=yes,width=800,height=400,scrollbars=yes');b.focus();">
                <input width="15%" type="button" value="Save" onClick="val= '/activator/customJSP/ErrorHandler/Update_Error_Handler/show_cli_interaction.jsp?message_id=<%= act[i].getMessageId()%>&action=save&service_type=<%=act[i].getDescription()%>'; window.open(val,'SaveResMgrLog','resizable=yes,status=yes,width=800,height=400,scrollbars=yes');">
                
                </td>
            </tr>             
      <% 
                
           }//end of for loop
%>




</tr>  

</table>
</td>
</tr>

<form name="nnmform">
 <% if (nnmEnabled && networkElements != null) {     %>
              <tr>
                  <td class="list0"><b>Select Router</b>&nbsp;&nbsp;</td><td class="list0" colspan="3">
					<select name="router_id" id="router_id" onchange="document.nnmform.submit()">				
<%                 	for (int j=0 ;j<networkelementSize;j++)  {
										    if(router_id.equals(networkElements[j].getNetworkelementid())){
                            selected = j;  %>
                 <option SELECTED value="<%= networkElements[j].getNetworkelementid() %>">
                     <%= networkElements[j].getName() %> ( <%= networkElements[j].getRole() %> )
					 </option>
<%              } else { %>
                            <option value="<%= networkElements[j].getNetworkelementid() %>">
                        <%= networkElements[j].getName() %> ( <%= networkElements[j].getRole() %> )
                      </option>
<%                  }										
										}
                   %>
				  </select>
                   </td>
			  </tr>
			  
<%
					 com.hp.ov.activator.vpn.inventory.NetworkElement ne = com.hp.ov.activator.vpn.inventory.NetworkElement.findByNetworkelementid(con, networkElements[selected].getNetworkelementid()); %>
			   <tr>
                  <td class="list0"><b>Topology view</b>&nbsp;&nbsp;</td><td class="list0" colspan="3">
                  <select name="rsi_id" id="rsi_id">
                 
				  <% if(ne !=null){
                  		session.setAttribute(NNMiAbstractCrossLaunchAction.DATASOURCE_NNMI_CL, ds);
                        session.setAttribute(NNMiAbstractCrossLaunchAction.NNMI_IP, ne.getManagement_ip());
                		session.setAttribute(NNMiAbstractCrossLaunchAction.NNMI_NAME, ne.getName()); 
                	}%>
                        <option SELECTED value="nnm_l3neighbor_view">NNM L3 Neighbor View</option>
                        <option value="nnm_l2neighbor_view">NNM L2 Neighbor View</option>
             
                    </select>
                   <INPUT TYPE="Button" value= " Launch Views" name="RSI_Operation" onClick="launchRsiView()";">


                </td>
                </tr>
                <%  } %>

				<input type="hidden" name="router_id" id="router_id" value="" >

</form>
                <!-- end RSI --> 
   

<%
}

    }
        }



          } catch (Exception e) {
              e.printStackTrace();
        out.println("Exception in error handler proceesing  : " + e.getMessage());
    } finally{
        try{
          con.close();
        }catch(Exception ex){
           out.println("Exception during the closing DB connection : " + ex.getMessage());
        }
    }






if(!show_activation_dialog){ 
    
    %>

<tr>    
<td><b>Activation attempts</b></td>
<td colspan="3">

No Activation error dialogs available from CLI plug-in. Some likely reasons could be :<br>
1) Resources may not be available for activation. Check e.g. for available device interfaces or IP address pool entries.<br>
2) A workflow has been stopped. Check the MWFM log files for more details. <br>
3) The VPN SVP is running in demo mode. Check service provider related inventory parameters.<br>

</td>
</tr>
 
<%}%>

<tr>
   <td><b>Error Code</b></td>
   <td colspan="3"><%= return_code %> <%=error_string%></td>
</tr>

<form name="rsform" action="/activator/customJSP/ErrorHandler/Update_Error_Handler/failed_jobs.jsp" method="POST">

<tr>
   <td><b>Description</b</td>
   <td colspan="3">
     <textarea cols="60" rows="4" name="errorhandler_description" id="errorhandler_description"></textarea>
   </td>
</tr>

</form>

      <%-- Concrete job information: attributes --%>
      <form name="form" action="/activator/sendCasePacket" method="POST"
        onsubmit="errorhandler_description.value=document.rsform.errorhandler_description.value">


        
        <input type="hidden" name="id" value="<%= jd.jobId %>">
        <input type="hidden" name="workflow" value="<%= jd.name %>">
        <input type="hidden" name="queue" value="failed_jobs">
        <input type="hidden" name="return_code" value="<%= return_code%>">
        <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
        <input type="hidden" name="errorhandler_description" value="">
        <input type="hidden" name="clientip" value="<%= ip %>">
        <input type="hidden" name="skip_activation" value="<%= skip_activation%>"> 
        <input type="hidden" name="reselect_resource" value="false"> 


        

        <%-- Common trailer --%>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
    
   <tr>
   <td><b>Re-submission options</b></td>

   <td></td>
  <TD align="left" colspan="2">
   <%if(show_reselect_box){%>
        <INPUT TYPE="Checkbox" NAME="retainresources" checked="true" VALUE="retain-resources" onClick="">Retain Resources </INPUT>
    <%}%>
   <INPUT TYPE="Checkbox" NAME="skipactivation"   VALUE="skip-activation"   onClick="">Skip Failed Activation</INPUT></TD>
   </tr>

      <tr>
      <td align="center" colspan="5">
       </tr>
       <tr>
      <td align="center" colspan="5">
       </tr>
       <tr>
      <td align="center" colspan="5">
       </tr>

   <tr>
        <td align="center" colspan="5">
        
        <input type="button" width="30" value="Re-submit" onclick="Submitt();">
        <input type="submit" width="30" value="Fail" onclick="fail(); ">
        
          </td>
        </tr>
      </form>

</table>
</center>



<script type="text/javascript" src="/activator/javascript/CRModel/utils.js"></script>
 <script language="JavaScript">     

 function fail(){

		 if (document.form.skipactivation.checked){

				document.form.skip_activation.value='true';                    
    
            }else{
				 document.form.skip_activation.value='false';
            } 
			if (document.form.retainresources.checked){

				document.form.reselect_resource.value='false';                    
    
            }else{
				 document.form.reselect_resource.value='true';
            } 
			
 }


 
  function Submitt()
    {
        var submit_form=true;
        var submit_form_message="";
        
            
           if (document.form.skipactivation.checked){
                
                    submit_form_message=submit_form_message+"\n"+"Before confirming skip-activation, you must manually correct the configuration on the network element.";
                     document.form.skip_activation.value='true';                    
    
            }else{
             document.form.skip_activation.value='false';
            }


            <%if(show_reselect_box){%>
            if(!document.form.retainresources.checked){
                    
                     submit_form_message=submit_form_message+"\n"+"Previosly selected resources will be released, Operator has to select new resources." ;
                      document.form.reselect_resource.value='true';

            }
            
                <%}%>
       
     
	if(submit_form_message!=""){
	   submit_form=confirm(submit_form_message);
	}

	 if (submit_form== true)
	 {
		 document.form.return_code.value='0';
		 document.form.submit();  
	 }
 }


function launchRsiView() {
	var rsi_link;
	var win;
	
	var uuid = "<%= session.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_UUID) %>";
    var ip = "<%= session.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_IP) %>";
    var name = "<%= session.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_NAME) %>";
	var identification_method;

    if (uuid != "null" && uuid != "") identification_method = "nnmi_uuid="+uuid;
    else if (ip != "null" && ip != "") identification_method = "nnmi_ip="+ip;
    else identification_method = "nnmi_name="+name;

    if(document.nnmform.rsi_id.value=='nnm_l2neighbor_view'){
		rsi_link='/activator/inventory/CRModel/NNMiShowL2ConnectionAction.do?' + identification_method;
	}
	if(document.nnmform.rsi_id.value=='nnm_l3neighbor_view')
		rsi_link='/activator/inventory/CRModel/NNMiShowL3ConnectionAction.do?' + identification_method

	
	win=window.open(rsi_link);
	win.focus();
	if(isIE7())
	win.setTimeout("self.close()", 3000);
	
}



  </script>
</body>
</html>
