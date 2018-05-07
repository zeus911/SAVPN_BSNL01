/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.helpers.DeleteGISSiteAttachmentListener;
import com.hp.ov.activator.crmportal.helpers.DeleteL2SiteAttachmentListener;
import com.hp.ov.activator.crmportal.helpers.DeleteL3SiteAttachmentListener;
import com.hp.ov.activator.crmportal.helpers.SendXML;
import com.hp.ov.activator.crmportal.helpers.ServiceUtils;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.helpers.VPWSDeleteUtils;



public class DeleteServiceAction extends Action 
{
	public DeleteServiceAction() 
	{}

	public ActionForward execute(ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception 
			{

		Service service = null; //for temp PR 15068
		Logger logger = Logger.getLogger("CRMPortalLOG");

		DatabasePool dbp = null;
		Connection con = null;
		String serviceid = ((ServiceForm)form).getServiceid();
		HashMap allParameters = new HashMap();
		boolean error = false;   
		Service[] subServices = null;
		VPNMembership[] relatedServices =null;
		VPNMembership[] serviceMembership = null;

		String curState = null;
		//richa - 11687
		
		// Manual LSPs ER
		int lspcount = 0;

		HttpSession session1 = request.getSession();
		HashMap hmp = (HashMap)session1.getAttribute("deleteParam");

		String mv = ((ServiceForm)form).getMv();
		String currentPageNo = ((ServiceForm)form).getCurrentPageNo();
		String viewPageNo = ((ServiceForm)form).getViewPageNo();
		String currentRs = ((ServiceForm)form).getCurrentRs();
		String lastRs = ((ServiceForm)form).getLastRs();
		String totalPages = ((ServiceForm)form).getTotalPages();

		String pid = request.getParameter ("parentserviceid");
		String SiteAtt = request.getParameter ("attachmentid");
		logger.debug("DeleteServiceAction: parentserviceid is "+pid+", attachmentid is"+SiteAtt);

		//richa - 11687

		// Get database connection from session
		HttpSession session = request.getSession();
		dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);

		try
		{

			con = (Connection) dbp.getConnection();    		
			IdGenerator idGenerator = new IdGenerator(con);

			allParameters.put("ACTION", Constants.ACTION_DELETE);
			allParameters.put("HOST", session.getAttribute(Constants.SOCKET_LIS_HOST));
			allParameters.put("PORT", session.getAttribute(Constants.SOCKET_LIS_PORT));
			allParameters.put("TEMPLATE_DIR", session.getAttribute(Constants.TEMPLATE_DIR));
			allParameters.put("operator", session.getAttribute(Constants.USER_KEY));
			allParameters.put("LOG_DIRECTORY", session.getAttribute(Constants.LOG_DIRECTORY));
			allParameters.put("request_synchronisation", (session.getAttribute(Constants.REQUEST_SYNCHRONISATION) == null ? "true" : session.getAttribute(Constants.REQUEST_SYNCHRONISATION)));

			//print the hashmap here
			logger.debug("DeleteServiceAction -- serviceid >>>>>> "
					+serviceid);


			if(serviceid != null) 
			{
				service = Service.findByPrimaryKey(con, serviceid);
				curState = service.getState();

				String parentServiceId=null;
				parentServiceId=service.getParentserviceid();
				//logger.debug("DeleteServiceAction -- Parent serviceid >>>>>> "    +parentServiceId);
				//logger.debug("DeleteServiceAction -- SiteAttachment serviceid >>>>>> "    +SiteAtt);
				//logger.debug("deleteParam is >>>>>>>>>");
				//logger.debug(hmp);

				request.setAttribute("service",service);
				//richa - 11687
				request.setAttribute("mv",mv);
				request.setAttribute("currentPageNo",currentPageNo);
				request.setAttribute("viewPageNo",viewPageNo);
				request.setAttribute("totalPages",totalPages);
				//richa - 11687
				
				// Manual LSPs ER
				lspcount = getManualLSPCount(con, serviceid, logger);

				if (service != null)
				{
					subServices 
					= Service.findByParentserviceid(con, serviceid);

					serviceMembership 
					= VPNMembership.findBySiteattachmentid(con, service.getServiceid());

					if(serviceMembership==null){
						if(parentServiceId!=null && parentServiceId!="" )
							serviceMembership=VPNMembership.findBySiteattachmentid(con,parentServiceId);
					}

					relatedServices 
					= VPNMembership.findByVpnid(con, service.getServiceid());

					if(relatedServices ==null) // layer3-attachment or site
						relatedServices= VPNMembership.findByVpnid(con, parentServiceId);

					request.setAttribute("subServices",subServices);
					request.setAttribute("serviceMembership",serviceMembership);
					request.setAttribute("relatedServices",relatedServices);

					logger.debug("DeleteServiceAction -- service_type is "+service.getType()+", subServices is "+subServices+", relatedServices is "+relatedServices);     	         
					String serviceType = service.getType();
					if(serviceType.equalsIgnoreCase(Constants.TYPE_LAYER3_PROTECTION)||serviceType.equalsIgnoreCase(Constants.TYPE_GIS_PROTECTION) ||
							serviceType.equalsIgnoreCase(Constants.TYPE_GIS_ATTACHMENT)	|| serviceType.equalsIgnoreCase(Constants.TYPE_LAYER3_ATTACHMENT) || serviceType.equalsIgnoreCase(Constants.TYPE_LAYER2_ATTACHMENT) ) {
						allParameters.put("ACTION", Constants.ACTION_REMOVE);
					}
					if(serviceType.equalsIgnoreCase(Constants.TYPE_LAYER3_SITE)||serviceType.equalsIgnoreCase(Constants.TYPE_GIS_SITE) || serviceType.equalsIgnoreCase(Constants.TYPE_LAYER2_SITE) ) {
						allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_SITE);
					}
					
					// Manual LSPs ER
					if ((service.getType().equals("layer2-VPWS") || (subServices == null && relatedServices == null)) 
						&& !((lspcount > 0) && (service.getType().equals("layer2-VPN") || service.getType().equals("layer3-VPN") || service.getType().equals("layer2-VPWS")||service.getType().equals("GIS-VPN"))))
					{						
						/*
								subServices	relatedServices		result	
						VPWS							ok to delete
						VPLS		null		null			ok to delete
						L3VPN		null		null			ok to delete
						L3Att		null
						L2Att		null
						 */
						// Get all parameters for the deletion
						allParameters = ServiceUtils.fillParameterTable(allParameters, service,
								idGenerator.getMessageId(), con);

						String StartTime =((ServiceForm)form).getEndTime();
						if (StartTime != null && !StartTime.equals(""))
							allParameters.put("StartTime",StartTime);
						String sendDelete = ((ServiceForm)form).getSendSaDeleteRequest();
						logger.debug("Delete Service Action :::::::::Service type is "+serviceType);

						if(serviceType.equals("layer3-Protection"))
							serviceType = "layer3-Attachment";
						
						if(serviceType.equals("GIS-Protection"))
							serviceType = "GIS-Attachment";

						if(serviceType.equalsIgnoreCase("layer3-Attachment"))
							ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getServiceid(), 
									Constants.PARAMETER_LAST_COMMIT,
									DeleteL3SiteAttachmentListener.class.getName());
						// Added for GIS
						if(serviceType.equalsIgnoreCase("GIS-Attachment"))
							ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getServiceid(), 
									Constants.PARAMETER_LAST_COMMIT,
									DeleteGISSiteAttachmentListener.class.getName());
						if(serviceType.equalsIgnoreCase("layer2-Attachment"))
							ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getServiceid(), 
									Constants.PARAMETER_LAST_COMMIT,
									DeleteL2SiteAttachmentListener.class.getName());

						// Send message to SA if service is not in Failure state.
						//System.out.println("VALUES FOR GIS:::"+sendDelete+""+curState);
						
						if (sendDelete.equals("true") && (!(curState.equals("REUSE_FAILURE")))) 
						{
							// Set state in order to track change.
							service.setState("Delete_Requested");                         

							ServiceUtils.updateService(con, service);

							//PR15581 set attach state to Delete_Requested
							if(relatedServices != null){
								for(int i = 0; i < relatedServices.length; i++){
									Service attachsrv = Service.findByPrimaryKey(con, relatedServices[i].getSiteattachmentid());
									attachsrv.setState("Delete_Requested");
									ServiceUtils.updateService(con, attachsrv);
									if(serviceType.equalsIgnoreCase(Constants.TYPE_LAYER2_VPWS)) {
										Service siteSrv = Service.findByPrimaryKey(con, attachsrv.getParentserviceid());
										Service attachments [] =Service.findByParentserviceid(con,siteSrv.getServiceid());
										if(attachments != null && attachments.length == 1 ){
											if(!relatedServices[i].getConnectivitytype().contains(Constants.REUSED)){
												//Service siteSrv = Service.findByPrimaryKey(con, attachsrv.getParentserviceid());
												siteSrv.setState("Delete_Requested");
												ServiceUtils.updateService(con, siteSrv);
											}
										}
									}
								}
							}

							// set skip_activation value
							allParameters.put("skip_activation", session.getAttribute("SKIP_ACTIVATION"));             

							//PR 15068
							allParameters.put("vpnserviceid", pid);   
							//End of PR 15068
							if(allParameters.get("type").equals("layer3-Protection"))
								allParameters.put("type", "layer3-Attachment");
							//Added for GIS
							if(allParameters.get("type").equals("GIS-Protection"))
								allParameters.put("type", "GIS-Attachment");
							if(allParameters.get("type").equals(Constants.TYPE_LAYER2_VPWS)) {
								VPWSDeleteUtils.DeleteAttachment(con,allParameters,serviceid, curState);
							}
							SendXML sender = new SendXML(allParameters);
							sender.Init();
							sender.Send();
							logger.debug("sender.Send():::::::::::::::Service type is "+serviceType);
						} else { 
							//sendDelete is false
							logger.error("Service had state Failure, SO no message sent to Service Activator.");
							Service MSGparentService =null;
							MSGparentService=Service.findByPrimaryKey(con, service.getParentserviceid());     		            
							ServiceUtils.deleteService(con, service);
							//for reused sites, only delete attachment itself but not site
							if((MSGparentService.getState()).equals("MSG_Failure")){
								ServiceUtils.deleteService(con, MSGparentService);
							}
							logger.debug("delected service from table");
						} 
					} //subservices,relatedservices

				}//service

			}//service id

		}
		catch (IOException ie) {
			ie.printStackTrace();
			error = true;
			logger.error("delete service Action class errors: ", ie);
			request.setAttribute("errormessage", ie.getMessage());
			// Set back the service state.
			if (service != null) {
				service.setState("Delete_Failure");

				try {
					ServiceUtils.updateService(con, service);
					ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "Failure_Description", ie.getMessage());
				} catch (Exception excep) {
					logger.error("Could not set back the service state upon failure, " + "portal and SA migth be inconsistent.");
				}
			}
		}
		catch(Exception ex)
		{
			logger.error("delete service  Action class errors: ", ex);
			request.setAttribute("errormessage", ex.getMessage());
			error = true;
			//     		 logger.debug("service delete Action class errors: " , ex);	
		}finally
		{
			// close the connection
			dbp.releaseConnection(con);
		}

		ListServicesAction allServices = new ListServicesAction();

		// Forward Action
		if(!(error))
		{        
			//Transfer to the related jsp's
			// Manual LSPs ER
			if ((service.getType().equals("layer2-VPWS") || (subServices == null && relatedServices == null)) 
				&& !((lspcount > 0) && (service.getType().equals("layer2-VPN") || service.getType().equals("layer3-VPN") || service.getType().equals("layer2-VPWS")||service.getType().equals("GIS-VPN"))))
			{
				logger.debug("directly forward to list all JSP");
				request.setAttribute("DeleteAction", "Delete"); // Richa - 11687
				ActionForward actionforward = allServices.execute(mapping,form,request,response);

				return  mapping.findForward(Constants.FAILURE);
			}
			else 
			{
				logger.debug("forward to delete JSP");
				request.setAttribute("DeleteAction", "Delete");
				return mapping.findForward(Constants.SUCCESS); 
			}
		}else
		{         	
			logger.debug("forward to list all JSP");
			request.setAttribute("DeleteAction", "Delete"); // Richa - 11687
			ActionForward actionforward = allServices.execute(mapping,form,request,response);
			return  mapping.findForward(Constants.FAILURE);
		}


			}// execute method

	/* Gets the count of the Manual LSP in the DB */
	private int getManualLSPCount(Connection con, String vpnId, Logger logger)
	{
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String count_str = "";
		int count = 0;

		String query =  "select count(*) from V_LSP lsp, V_LSPVPNMEMBERSHIP mem where lsp.lspid = mem.lspid and lsp.usagemode='Manual' and mem.vpnid=?";
		
		try 
		{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, vpnId);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				count_str = rset.getString(1);
			}
			
			count = Integer.parseInt(count_str);

		}
		catch(Exception e)
		{
			logger.error("Exception inside getManualLSPCount(): "+e);
		}
		finally
		{
			try{ rset.close(); }catch(Exception ignoreme){}
			try{ pstmt.close(); }catch(Exception ignoreme){}
		}

		return count;
	}

}
