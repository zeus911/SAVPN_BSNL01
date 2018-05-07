/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.StaticRoute;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.utils.Constants;

public class CreateL3SiteListener implements StateListener{
    Logger logger = Logger.getLogger("CRMPortalLOG");

  public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {

    //if (PortalSyncListener.DEBUG) {
	  logger.debug("Inside StateListener for layer3 site");
      logger.debug("connection = " + connection);
      logger.debug("serviceId = " + serviceId);
      logger.debug("state = " + state);
      logger.debug("data = " + data);
    //}

    if (state == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (serviceId == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (connection == null)
      return StateListener.REMOVE_AND_CONTINUE;

    // if service failed or in some transitional state then everything ok and let's wait for our state
    //if (state.indexOf("Ok") == -1 )
    if (state.indexOf("Ok") == -1 && state.indexOf("MSG_Failure") == -1 )
      return StateListener.STAY_AND_CONTINUE;

   // logger.debug("StateListener for layer3 site fired:need to create attachment circuit here");


    try{

    HashMap allParameters=new HashMap();
	String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
    String socketListener_host = PortalSyncListener.servletConfig.getInitParameter (Constants.SOCKET_LIS_HOST);
	String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
    String templateDir = PortalSyncListener.servletConfig.getInitParameter (Constants.TEMPLATE_DIR);
    String logDir = PortalSyncListener.servletConfig.getInitParameter (Constants.LOGS_DIRECTORY);

    allParameters.put("HOST", socketListener_host);
    allParameters.put("PORT", socketListener_port);
    allParameters.put("TEMPLATE_DIR",templateDir);
    allParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
    allParameters.put("LOG_DIRECTORY", logDir);
    allParameters.put("request_synchronisation", request_synchronisation);


      //Get one attachment service id and store
    //chnages for attachment is starts here

    IdGenerator idGenerator = new IdGenerator(connection);
    String attachment_service_id= idGenerator.getServiceId();


    //ServiceUtils.saveOrUpdateParameter(connection,serviceId,"initial_attachment_id",attachment_service_id);

    ServiceParameter activationScope=ServiceParameter.findByServiceidattribute(connection, serviceId,"Activation_Scope");
    String activation_Scope="";
    if(activationScope!=null)
    	activation_Scope=activationScope.getValue();

    //logger.debug("StateListener for layer3site: activation scope is "+activation_Scope);
    ServiceParameter stTime=ServiceParameter.findByServiceidattribute(connection, serviceId,"StartTime");
    String startTime="";
    if(stTime!=null)
        	startTime=stTime.getValue();
   // logger.debug("StateListener for layer3site: start time   is "+startTime);

    Service attachment_service =  new Service();

//state based on ACTIVATION SCOPE


    if (activation_Scope != null &&  activation_Scope.equals("BOTH"))    {

    	attachment_service.setState("Request_Sent");
          if (startTime!=null &&   !startTime.equalsIgnoreCase(""))

        	  attachment_service.setState("Sched_Request_Sent");
      }

    if (activation_Scope != null &&
    activation_Scope.equals("PE_ONLY"))
    {
 	   attachment_service.setState("Request_Sent");
           if (startTime!=null && !startTime.equalsIgnoreCase(""))

 	   attachment_service.setState("Sched_Request_Sent");
      }

   if (activation_Scope != null && activation_Scope.equals("CE_ONLY"))   {
	   		attachment_service.setState("Request_Sent");

            if (startTime!=null && !startTime.equalsIgnoreCase(""))

            	attachment_service.setState("Sched_Request_Sent");
      }

   if (activation_Scope == null)   {

	   	attachment_service.setState("Request_Sent");
	   	if (startTime!=null && !startTime.equalsIgnoreCase(""))
    	  	  attachment_service.setState("Sched_Request_Sent");
      }



   //logger.debug("StateListener for layer3site: state set is  "+attachment_service.getState());

    Thread.sleep(2000);
    //Sleeping for two seconds to wait for the commit of the site parameters
    String vpnserviceid=ServiceUtils.getServiceParam(connection, serviceId, "l3vpnserviceid");
    if (vpnserviceid == null)
      vpnserviceid = "";

	Service site= Service.findByPrimaryKey(connection, serviceId);
    ServiceParameter siteparams[]=ServiceParameter.findByServiceid(connection, serviceId);
    attachment_service.setCustomerid(site.getCustomerid());
    attachment_service.setEndtime(site.getEndtime());
    attachment_service.setModifydate(site.getModifydate());
    attachment_service.setLastupdatetime(site.getLastupdatetime());
    attachment_service.setNextoperationtime(site.getNextoperationtime());
    attachment_service.setParentserviceid(site.getServiceid());
    attachment_service.setPresname(site.getPresname()+"layer3-Attachment");
    attachment_service.setServiceid(attachment_service_id);
    //attachment_service.setState(site.getState());
    attachment_service.setSubmitdate(site.getSubmitdate());
    attachment_service.setType("layer3-Attachment");

        attachment_service.store(connection);


        logger.debug("laye3site listener:::::::::::::Stored the attachment service bean");

    VPNMembership mem = new VPNMembership();
    mem.setVpnid(vpnserviceid);
    mem.setSiteattachmentid(attachment_service_id);
    String conntype = ServiceUtils.getServiceParam(connection, serviceId, "ConnectivityType");
    mem.setConnectivitytype(conntype);
    mem.store(connection);
    logger.debug("Stored the VPNMembership: " + mem.toString());

    //logger.debug("laye3site listener:::::::::::::site parameters");
    for(int i=0;i<siteparams.length;i++){

    	ServiceParameter tmp=siteparams[i];
    	tmp.setServiceid(attachment_service_id);
    	//logger.debug(tmp.getAttribute()+":::::::"+tmp.getValue());
    	allParameters.put(tmp.getAttribute(),tmp.getValue());
    	if(!tmp.getAttribute().equals(Constants.PARAMETER_LAST_COMMIT)){
    	    	tmp.store(connection);
    	}
     }
  
	/*
		Static routes:
		are directly compound from database because with a big amount of static routes the XSLTransformHelper.transformXML launch error
		the following string are replaced in SendXML after transformXML:
		##nl## -> is \n
		##lt## -> is <
		##gt## -> is >
	*/
    StaticRoute staticRoutes[] = StaticRoute.findByAttachmentid(connection, site.getServiceid());
	String staticRoutesXml = "##nl##          ";
    if (staticRoutes != null) {
        for (int i = 0; i < staticRoutes.length; i++) {
          StaticRoute staticRoute = new StaticRoute();
          staticRoute.setAttachmentid(attachment_service_id);
          staticRoute.setStaticrouteaddress(staticRoutes[i].getStaticrouteaddress());
          staticRoute.store(connection);
          StaticRoute oldStaticRoute = staticRoutes[i];
          oldStaticRoute.delete(connection);
		  staticRoutesXml += "  ##lt##Static_route##gt##" + staticRoutes[i].getStaticrouteaddress() + "##lt##/Static_route##gt####nl##          ";
        }
		allParameters.put("STATIC_Routes", staticRoutesXml);
	}

    //PR15882 remove the protocol param from site params
    ServiceParameter RoutingProtocol = ServiceParameter.findByServiceidattribute(connection, site.getServiceid(), "RoutingProtocol");
    if(RoutingProtocol != null)
      RoutingProtocol.delete(connection);

    allParameters.put("parentserviceid",serviceId);
    allParameters.put("attachmenttype","Initial");

    allParameters.put("type", "layer3-Attachment");
    allParameters.put("ACTION", Constants.ACTION_ADD);
    allParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
    allParameters.put("serviceid",attachment_service_id);
    ServiceUtils.saveOrUpdateParameter(connection,attachment_service_id,"Site_Service_id",serviceId);

    allParameters.put("vpnserviceid",vpnserviceid);
    ServiceUtils.saveOrUpdateParameter(connection,attachment_service_id,"vpnserviceid",vpnserviceid);

    allParameters.put("presname",site.getPresname()+"layer3-Attachment");
    //ServiceUtils.saveOrUpdateParameter(connection,attachment_service_id,"presname",site.getPresname()+"layer3-Attachment");


    String messageid = idGenerator.getMessageId();
    allParameters.put("messageid",messageid);


  //set the lastcommit action to CreateL3VPNStateListener
    ServiceUtils.saveOrUpdateParameter(connection, attachment_service_id, Constants.PARAMETER_LAST_COMMIT, CreateL3VPNStateListener.class.getName());
    String addressFamily=ServiceUtils.getServiceParam(connection, vpnserviceid,"AddressFamily");
    ServiceUtils.saveOrUpdateParameter(connection, attachment_service_id, "AddressFamily", addressFamily);
	allParameters.put(Constants.XSLPARAM_ADDRESS_FAMILY, addressFamily);

//  set skip_activation value
    //PR 15247
//  allParameters.put("skip_activation",PortalSyncListener.servletConfig.getInitParameter("SKIP_ACTIVATION"));
     // Send message to SA.
    try {
      SendXML sender = new SendXML(allParameters);
      sender.Init();
      sender.Send();
      } catch (IOException e){
        attachment_service.setState(Constants.SERVICE_STATE_MSG_FAILURE);
        try{
          ServiceUtils.updateService(connection, attachment_service);
          ServiceUtils.saveOrUpdateParameter(connection, attachment_service_id,
            "Failure_Description",
            e.getMessage());
        }catch(Exception ex) {

        }
      }

    }catch(Exception ex){

    		logger.error("Exception in laye3site listener"+ex);
    }

    //chnages for attachment id ends here


    return StateListener.REMOVE_AND_CONTINUE;

  }


}
