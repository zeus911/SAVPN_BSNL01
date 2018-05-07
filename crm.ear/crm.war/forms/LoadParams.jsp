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
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- *- html -*- --%>

<%@ page import="com.hp.ov.activator.crmportal.servlet.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*,
                 java.util.*, java.io.*,   
                 java.text.*, java.net.*,
                 com.hp.ov.activator.crmportal.servlet.DatabasePool,
                 com.hp.ov.activator.crmportal.servlet.Constants,
                 org.apache.log4j.Logger"
%>

     <%
  
		/* 	 HashMap deleteParams = new HashMap();
		     deleteParams.put("soft","true");
		     deleteParams.put("customerid",customerForm.getCustomerid());
		   

		if (!customerForm.getStatus().equalsIgnoreCase("deleted"))
	         {
                deleteParams.put("deactivate","true");
	            pageContext.setAttribute("deleteparamsMap", deleteParams); */
	    %>
          
		<!--	<html:link page="/DeleteCustomerfromSearch.do" name="deleteparamsMap" scope="page" >
	        <html:img page="/images/DeleteCustomer.gif" border="0" title="Delete customer"/>
	        </html:link>
         -->

        <%
			//} 



  /* DatabasePool dbp1 = (DatabasePool) session.getAttribute (Constants.DATABASE_POOL);
   Connection con1 = null;
   Logger logger = Logger.getLogger("CRMPortalLOG");
   HashMap serviceParameters = new HashMap ();
   HashMap parentServiceParameters = new HashMap ();
   String serviceid = request.getParameter ("serviceid");
   String parentserviceid = request.getParameter ("parentserviceid");*/
   Service service = (Service)request.getAttribute("Service");
   HashMap serviceParameters = new HashMap ();
   HashMap parentServiceParameters = new HashMap ();
   String serviceid = request.getParameter ("serviceid");
   String parentserviceid = request.getParameter ("parentserviceid");
   
   /*try {
	 con1 = dbp1.getConnection ();
     if (serviceid != null && !serviceid.equals("")) {
       Service service = Service.findByPrimaryKey(con1, serviceid);*/
       if(service != null)
		   {
         serviceParameters.put("serviceid", service.getServiceid());
         serviceParameters.put("state", service.getState());
         serviceParameters.put("presname", service.getPresname());
         serviceParameters.put("submitdate", service.getSubmitdate());
         serviceParameters.put("modifydate", service.getModifydate());
         serviceParameters.put("type", service.getType());
         serviceParameters.put("customerid", service.getCustomerid());
         // if parent service id was passed througth request - then use it, else use from service params
         parentserviceid = parentserviceid != null ? parentserviceid : service.getParentserviceid();
         // if it is Layer3 site - then there aren't any parent service id, it should be fetched from VPNMembership
         if(parentserviceid == null && "layer3-Site".equals(service.getType()))
		{
           /*
            this situation is usefull when creating/deleting L3Site and after failure retry is pressed
            parent service id is needed only in this case
            for other cases for Layer3 sites parent service id is not used
           */
//           final VPNMembership[] memberships = VPNMembership.findBySiteid(con1, serviceid);
            VPNMembership[] memberships = (VPNMembership[])request.getAttribute("VPNMembership");
           if(memberships != null && memberships.length > 0)
			   {
             parentserviceid = memberships[0].getVpnid();
               }
         }
       }
       serviceParameters.put("parentserviceid", parentserviceid);

       // If the service already exists then use the parentServiceId from there.
       //parentserviceid = service.getParentserviceid();
       
     /* 
	 ServiceParameter[] serviceParamArray = ServiceParameter.findByServiceid(con1, serviceid);
	 */

      ServiceParameter[] serviceParamArray = (ServiceParameter[])request.getAttribute("ServiceParameter");
       // Map all array entries to a HashMap.
       if (serviceParamArray != null) {
         for (int i = 0; i < serviceParamArray.length; i++) { 
           serviceParameters.put(serviceParamArray[i].getAttribute(), serviceParamArray[i].getValue());
         }
       }
     }
		
     if (parentserviceid != null && !parentserviceid.equals("")) {
       //Service parentService = Service.findByPrimaryKey(con1, parentserviceid);
	   Service parentService = (Service)request.getAttribute("parentService");
       if (parentService != null) {
         parentServiceParameters.put("serviceid", parentService.getServiceid());
         parentServiceParameters.put("state", parentService.getState());
         parentServiceParameters.put("presname", parentService.getPresname());
         parentServiceParameters.put("submitdate", parentService.getSubmitdate());
         parentServiceParameters.put("modifydate", parentService.getModifydate());
         parentServiceParameters.put("type", parentService.getType());
         parentServiceParameters.put("customerid", parentService.getCustomerid());
         parentServiceParameters.put("parentserviceid", parentService.getParentserviceid());

         //ServiceParameter[] parentServiceParamArray = ServiceParameter.findByServiceid(con1, parentserviceid);
		 ServiceParameter[] parentServiceParamArray = (ServiceParameter[])request.getAttribute("parentServiceParamArray");

         if (parentServiceParamArray != null) {
           for (int i = 0; i < parentServiceParamArray.length; i++) {
             parentServiceParameters.put (parentServiceParamArray[i].getAttribute(), parentServiceParamArray[i].getValue());
           }//for
         }
       }
     }
  /* } catch (Exception e) {
     logger.error("Exception, problem fetching service information.",e);
   } finally {
     if (con1 != null)
       dbp1.releaseConnection (con1);
   } */
%>
