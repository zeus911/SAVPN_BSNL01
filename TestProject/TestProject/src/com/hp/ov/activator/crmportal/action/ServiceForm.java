
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;

import java.io.Serializable;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.bean.Customer;
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.ServiceType;

public class ServiceForm extends ActionForm implements Serializable 
{
	String serviceid,servicename,state,type,customerid,customername,parentserviceid,
	       endTime,status,actionflag,messageid,SP_Activation_Scope,SP_StartTime,
           SP_RoutingProtocol,staticCounter,presname,prefixCounter;
	


	String SP_VLANId,SP_Location,SP_LoopDetection,SP_Comment,SP_ConnectivityType,
	       SP_EndTime,SP_Region,SP_CAR,SP_QOS_PROFILE,SP_QOS_BASE_PROFILE;
	String SP_AddressPool, SP_SecondaryAddressPool, SP_Managed_CE_Router,SP_CE_based_QoS,SP_OSPF_Area,SP_Customer_ASN,include;
	String SP_Site_Service_ID_aEnd,SP_Site_Service_ID_zEnd,SP_PW_aEnd,SP_PW_zEnd,
		   SP_PW_aEnd_location,SP_PW_zEnd_location,aEndSelected,zEndSelected,
		   SP_PW_aEnd_region,SP_PW_zEnd_region,SP_RL,SP_UNIType_aEnd,SP_UNIType_zEnd,
		   SP_PW_Type_aEnd,SP_PW_Type_zEnd,SP_EthType_aEnd,SP_EthType_zEnd,
		   SP_VLANIdaEnd,SP_VLANIdzEnd,SP_DLCIaEnd,SP_DLCIzEnd;
    String submitDate,modifyDate,SP_request_synchronisation,SP_Customer_name,SP_Contact_person, SP_Customer_email;
	String SP_QOS_CLASS_0_PERCENT,SP_QOS_CLASS_1_PERCENT,SP_QOS_CLASS_2_PERCENT,SP_QOS_CLASS_3_PERCENT,SP_QOS_CLASS_4_PERCENT,SP_QOS_CLASS_5_PERCENT,SP_QOS_CLASS_6_PERCENT,SP_QOS_CLASS_7_PERCENT;
	String route0,route1,route2,route3,route4,route5;
	String mask0,mask1,mask2,mask3,mask4,mask5;
	String prefixroute0,prefixroute1,prefixroute2,prefixroute3,prefixroute4,prefixroute5;
	String prefixmask0,prefixmask1,prefixmask2,prefixmask3,prefixmask4,prefixmask5;
	
	String sendSaDeleteRequest = "false";  
	String newServiceId,operation_type,otherCustomer,vpnId,VPNid,connTypeVPNId;
	String MulticastVPNId,MulticastStatus,MulticastRP,MulticastQoSClass,MulticastRateLimit;
	String mv,currentPageNo,viewPageNo,currentRs,lastRs,totalpages ; //richa - 11687
	String SP_PEInterface;
	String SP_IPNetAddr;
	
	String SP_QoSChildEnabled;
	String reusedSite;
 
	 String SP_Vlan_Flag_aEnd , SP_Vlan_Flag_zEnd;


	public String getSP_Vlan_Flag_aEnd() {
		return SP_Vlan_Flag_aEnd;
	}

	public void setSP_Vlan_Flag_aEnd(String sP_Vlan_Flag_aEnd) {
		SP_Vlan_Flag_aEnd = sP_Vlan_Flag_aEnd;
	}

	public String getSP_Vlan_Flag_zEnd() {
		return SP_Vlan_Flag_zEnd;
	}

	public void setSP_Vlan_Flag_zEnd(String sP_Vlan_Flag_zEnd) {
		SP_Vlan_Flag_zEnd = sP_Vlan_Flag_zEnd;
	}
	



	public String getSP_IPNetAddr() {
		return SP_IPNetAddr;
	}

	public void setSP_IPNetAddr(String sP_IPNetAddr) {
		SP_IPNetAddr = sP_IPNetAddr;
	}

	long nextOperationTime,lastUpdateTime;
    boolean deactivate = false;
    ServiceParameterVO [] serviceparameterVO = null;
    ServiceParameter [] parameters = null;
    Service service = null;
    Service parentService = null;
    Service [] services = null;
    Service [] parentServices = null;
    Customer customer = null;
    ServiceType[] serviceTypes = null;
    ArrayList subServiceTypes = null;
    ArrayList multipleMemberships = null;
    int[] sitecount = new int[0];
    int[] parentsSubService = new int[0];
	
	// IGW
	String SP_PERouter, SP_PEInterface_aEnd, SP_PERouter_zEnd, SP_PEInterface_zEnd, SP_Trunk_Type, SP_AddressPool_aEnd,
    SP_AddressPool_zEnd, IPv6_family_aEnd, IPv6_family_zEnd, include_aEnd, include_zEnd, SP_trunk_id, SP_trunk_policy_aside,
    SP_trunk_policy_zside, SP_Traffic_policy_io_aend, SP_Traffic_policy_io_zend,
	SP_IPv6_family_aEnd, SP_IPv6_family_zEnd, SP_area_number_aEnd, SP_area_number_zEnd, subinterface_sel,
	SP_trunk_description_aEnd, SP_trunk_description_zEnd, SP_EndA_name, SP_EndZ_name, SP_ip_submask_zEnd,
	SP_ip_submask_aEnd, SP_lnk_Protocol_aside, SP_lnk_Protocol_zside, SP_pim_name_aside, SP_pim_name_zside,
	SP_Interface_description_aEnd, SP_Interface_description_zEnd, SP_Trunk_number_aEnd, SP_Trunk_number_zEnd,
	SP_trunk_ipaddress_aEnd, SP_trunk_ipaddress_zEnd, SP_trunk_negotiation_aside, SP_trunk_negotiation_zside,
	SP_trunk_aside_mtu, SP_trunk_zside_mtu, SP_trunk_aside_ospf_cost, SP_trunk_zside_ospf_cost, SP_trunk_ldp_aside,
	SP_trunk_ldp_zside, SP_trunk_aside_processid, SP_trunk_zside_processid, SP_network_type_aside,
	SP_network_type_zside, SP_ospf_aside, SP_ospf_zside, SP_IPv6_Address_aEnd, SP_IPv6_Address_zEnd, SP_IPv6_Pool_aEnd,
	SP_IPv6_Pool_zEnd, SP_trunk_aIPbinding, SP_trunk_zIPbinding, SP_OSPF_aPassword, SP_OSPF_zPassword, SP_LDP_aPassword, SP_LDP_zPassword;
	

	
    


  public String getSP_PEInterface_aEnd() {
    return SP_PEInterface_aEnd;
  }



  public void setSP_PEInterface_aEnd(String sP_PEInterface_aEnd) {
    SP_PEInterface_aEnd = sP_PEInterface_aEnd;
  }



  public String getSP_PERouter_zEnd() {
    return SP_PERouter_zEnd;
  }



  public void setSP_PERouter_zEnd(String sP_PERouter_zEnd) {
    SP_PERouter_zEnd = sP_PERouter_zEnd;
  }



  public String getSP_PEInterface_zEnd() {
    return SP_PEInterface_zEnd;
  }



  public void setSP_PEInterface_zEnd(String sP_PEInterface_zEnd) {
    SP_PEInterface_zEnd = sP_PEInterface_zEnd;
  }



  public String getSP_Trunk_Type() {
    return SP_Trunk_Type;
  }



  public void setSP_Trunk_Type(String sP_Trunk_Type) {
    SP_Trunk_Type = sP_Trunk_Type;
  }



  public String getSP_AddressPool_aEnd() {
    return SP_AddressPool_aEnd;
  }



  public void setSP_AddressPool_aEnd(String sP_AddressPool_aEnd) {
    SP_AddressPool_aEnd = sP_AddressPool_aEnd;
  }



  public String getSP_AddressPool_zEnd() {
    return SP_AddressPool_zEnd;
  }



  public void setSP_AddressPool_zEnd(String sP_AddressPool_zEnd) {
    SP_AddressPool_zEnd = sP_AddressPool_zEnd;
  }



    public String getSP_trunk_id() {
    return SP_trunk_id;
  }



  public void setSP_trunk_id(String sP_trunk_id) {
    SP_trunk_id = sP_trunk_id;
  }



  public String getSP_trunk_policy_aside() {
    return SP_trunk_policy_aside;
  }



  public void setSP_trunk_policy_aside(String sP_trunk_policy_aside) {
    SP_trunk_policy_aside = sP_trunk_policy_aside;
  }



  public String getSP_trunk_policy_zside() {
    return SP_trunk_policy_zside;
  }



  public void setSP_trunk_policy_zside(String sP_trunk_policy_zside) {
    SP_trunk_policy_zside = sP_trunk_policy_zside;
  }



  public String getSP_Traffic_policy_io_aend() {
    return SP_Traffic_policy_io_aend;
  }



  public void setSP_Traffic_policy_io_aend(String sP_Traffic_policy_io_aend) {
    SP_Traffic_policy_io_aend = sP_Traffic_policy_io_aend;
  }



  public String getSP_Traffic_policy_io_zend() {
    return SP_Traffic_policy_io_zend;
  }



  public void setSP_Traffic_policy_io_zend(String sP_Traffic_policy_io_zend) {
    SP_Traffic_policy_io_zend = sP_Traffic_policy_io_zend;
  }



  public String getSP_IPv6_family_aEnd() {
    return SP_IPv6_family_aEnd;
  }



  public void setSP_IPv6_family_aEnd(String sP_IPv6_family_aEnd) {
    SP_IPv6_family_aEnd = sP_IPv6_family_aEnd;
  }



  public String getSP_IPv6_family_zEnd() {
    return SP_IPv6_family_zEnd;
  }



  public void setSP_IPv6_family_zEnd(String sP_IPv6_family_zEnd) {
    SP_IPv6_family_zEnd = sP_IPv6_family_zEnd;
  }



  public String getSP_area_number_aEnd() {
    return SP_area_number_aEnd;
  }



  public void setSP_area_number_aEnd(String sP_area_number_aEnd) {
    SP_area_number_aEnd = sP_area_number_aEnd;
  }



  public String getSP_area_number_zEnd() {
    return SP_area_number_zEnd;
  }



  public void setSP_area_number_zEnd(String sP_area_number_zEnd) {
    SP_area_number_zEnd = sP_area_number_zEnd;
  }



  public String getSP_trunk_description_aEnd() {
    return SP_trunk_description_aEnd;
  }



  public void setSP_trunk_description_aEnd(String sP_trunk_description_aEnd) {
    SP_trunk_description_aEnd = sP_trunk_description_aEnd;
  }



  public String getSP_trunk_description_zEnd() {
    return SP_trunk_description_zEnd;
  }



  public void setSP_trunk_description_zEnd(String sP_trunk_description_zEnd) {
    SP_trunk_description_zEnd = sP_trunk_description_zEnd;
  }



  public String getSP_EndA_name() {
    return SP_EndA_name;
  }



  public void setSP_EndA_name(String sP_EndA_name) {
    SP_EndA_name = sP_EndA_name;
  }



  public String getSP_EndZ_name() {
    return SP_EndZ_name;
  }



  public void setSP_EndZ_name(String sP_EndZ_name) {
    SP_EndZ_name = sP_EndZ_name;
  }



  public String getSP_ip_submask_zEnd() {
    return SP_ip_submask_zEnd;
  }



  public void setSP_ip_submask_zEnd(String sP_ip_submask_zEnd) {
    SP_ip_submask_zEnd = sP_ip_submask_zEnd;
  }



  public String getSP_ip_submask_aEnd() {
    return SP_ip_submask_aEnd;
  }



  public void setSP_ip_submask_aEnd(String sP_ip_submask_aEnd) {
    SP_ip_submask_aEnd = sP_ip_submask_aEnd;
  }



  public String getSP_lnk_Protocol_aside() {
    return SP_lnk_Protocol_aside;
  }



  public void setSP_lnk_Protocol_aside(String sP_lnk_Protocol_aside) {
    SP_lnk_Protocol_aside = sP_lnk_Protocol_aside;
  }



  public String getSP_lnk_Protocol_zside() {
    return SP_lnk_Protocol_zside;
  }



  public void setSP_lnk_Protocol_zside(String sP_lnk_Protocol_zside) {
    SP_lnk_Protocol_zside = sP_lnk_Protocol_zside;
  }



  public String getSP_pim_name_aside() {
    return SP_pim_name_aside;
  }



  public void setSP_pim_name_aside(String sP_pim_name_aside) {
    SP_pim_name_aside = sP_pim_name_aside;
  }



  public String getSP_pim_name_zside() {
    return SP_pim_name_zside;
  }



  public void setSP_pim_name_zside(String sP_pim_name_zside) {
    SP_pim_name_zside = sP_pim_name_zside;
  }



  public String getSP_Interface_description_aEnd() {
    return SP_Interface_description_aEnd;
  }



  public void setSP_Interface_description_aEnd(String sP_Interface_description_aEnd) {
    SP_Interface_description_aEnd = sP_Interface_description_aEnd;
  }



  public String getSP_Interface_description_zEnd() {
    return SP_Interface_description_zEnd;
  }



  public void setSP_Interface_description_zEnd(String sP_Interface_description_zEnd) {
    SP_Interface_description_zEnd = sP_Interface_description_zEnd;
  }



  public String getSP_Trunk_number_aEnd() {
    return SP_Trunk_number_aEnd;
  }



  public void setSP_Trunk_number_aEnd(String sP_Trunk_number_aEnd) {
    SP_Trunk_number_aEnd = sP_Trunk_number_aEnd;
  }



  public String getSP_Trunk_number_zEnd() {
    return SP_Trunk_number_zEnd;
  }



  public void setSP_Trunk_number_zEnd(String sP_Trunk_number_zEnd) {
    SP_Trunk_number_zEnd = sP_Trunk_number_zEnd;
  }



  public String getSP_trunk_ipaddress_aEnd() {
    return SP_trunk_ipaddress_aEnd;
  }



  public void setSP_trunk_ipaddress_aEnd(String sP_trunk_ipaddress_aEnd) {
    SP_trunk_ipaddress_aEnd = sP_trunk_ipaddress_aEnd;
  }



  public String getSP_trunk_ipaddress_zEnd() {
    return SP_trunk_ipaddress_zEnd;
  }



  public void setSP_trunk_ipaddress_zEnd(String sP_trunk_ipaddress_zEnd) {
    SP_trunk_ipaddress_zEnd = sP_trunk_ipaddress_zEnd;
  }



  public String getSP_trunk_negotiation_aside() {
    return SP_trunk_negotiation_aside;
  }



  public void setSP_trunk_negotiation_aside(String sP_trunk_negotiation_aside) {
    SP_trunk_negotiation_aside = sP_trunk_negotiation_aside;
  }



  public String getSP_trunk_negotiation_zside() {
    return SP_trunk_negotiation_zside;
  }



  public void setSP_trunk_negotiation_zside(String sP_trunk_negotiation_zside) {
    SP_trunk_negotiation_zside = sP_trunk_negotiation_zside;
  }



  public String getSP_trunk_aside_mtu() {
    return SP_trunk_aside_mtu;
  }



  public void setSP_trunk_aside_mtu(String sP_trunk_aside_mtu) {
    SP_trunk_aside_mtu = sP_trunk_aside_mtu;
  }



  public String getSP_trunk_zside_mtu() {
    return SP_trunk_zside_mtu;
  }



  public void setSP_trunk_zside_mtu(String sP_trunk_zside_mtu) {
    SP_trunk_zside_mtu = sP_trunk_zside_mtu;
  }



  public String getSP_trunk_aside_ospf_cost() {
    return SP_trunk_aside_ospf_cost;
  }



  public void setSP_trunk_aside_ospf_cost(String sP_trunk_aside_ospf_cost) {
    SP_trunk_aside_ospf_cost = sP_trunk_aside_ospf_cost;
  }



  public String getSP_trunk_zside_ospf_cost() {
    return SP_trunk_zside_ospf_cost;
  }



  public void setSP_trunk_zside_ospf_cost(String sP_trunk_zside_ospf_cost) {
    SP_trunk_zside_ospf_cost = sP_trunk_zside_ospf_cost;
  }



  public String getSP_trunk_ldp_aside() {
    return SP_trunk_ldp_aside;
  }



  public void setSP_trunk_ldp_aside(String sP_trunk_ldp_aside) {
    SP_trunk_ldp_aside = sP_trunk_ldp_aside;
  }



  public String getSP_trunk_ldp_zside() {
    return SP_trunk_ldp_zside;
  }



  public void setSP_trunk_ldp_zside(String sP_trunk_ldp_zside) {
    SP_trunk_ldp_zside = sP_trunk_ldp_zside;
  }



  public String getSP_trunk_aside_processid() {
    return SP_trunk_aside_processid;
  }



  public void setSP_trunk_aside_processid(String sP_trunk_aside_processid) {
    SP_trunk_aside_processid = sP_trunk_aside_processid;
  }



  public String getSP_trunk_zside_processid() {
    return SP_trunk_zside_processid;
  }



  public void setSP_trunk_zside_processid(String sP_trunk_zside_processid) {
    SP_trunk_zside_processid = sP_trunk_zside_processid;
  }



  public String getSP_network_type_aside() {
    return SP_network_type_aside;
  }



  public void setSP_network_type_aside(String sP_network_type_aside) {
    SP_network_type_aside = sP_network_type_aside;
  }



  public String getSP_network_type_zside() {
    return SP_network_type_zside;
  }



  public void setSP_network_type_zside(String sP_network_type_zside) {
    SP_network_type_zside = sP_network_type_zside;
  }



  public String getSP_ospf_aside() {
    return SP_ospf_aside;
  }



  public void setSP_ospf_aside(String sP_ospf_aside) {
    SP_ospf_aside = sP_ospf_aside;
  }



  public String getSP_ospf_zside() {
    return SP_ospf_zside;
  }



  public void setSP_ospf_zside(String sP_ospf_zside) {
    SP_ospf_zside = sP_ospf_zside;
  }



  public String getSP_IPv6_Address_aEnd() {
    return SP_IPv6_Address_aEnd;
  }



  public void setSP_IPv6_Address_aEnd(String sP_IPv6_Address_aEnd) {
    SP_IPv6_Address_aEnd = sP_IPv6_Address_aEnd;
  }



  public String getSP_IPv6_Address_zEnd() {
    return SP_IPv6_Address_zEnd;
  }



  public void setSP_IPv6_Address_zEnd(String sP_IPv6_Address_zEnd) {
    SP_IPv6_Address_zEnd = sP_IPv6_Address_zEnd;
  }



  public String getSP_IPv6_Pool_aEnd() {
    return SP_IPv6_Pool_aEnd;
  }



  public void setSP_IPv6_Pool_aEnd(String sP_IPv6_Pool_aEnd) {
    SP_IPv6_Pool_aEnd = sP_IPv6_Pool_aEnd;
  }



  public String getSP_IPv6_Pool_zEnd() {
    return SP_IPv6_Pool_zEnd;
  }



  public void setSP_IPv6_Pool_zEnd(String sP_IPv6_Pool_zEnd) {
    SP_IPv6_Pool_zEnd = sP_IPv6_Pool_zEnd;
  }



  public String getSP_trunk_aIPbinding() {
    return SP_trunk_aIPbinding;
  }



  public void setSP_trunk_aIPbinding(String sP_trunk_aIPbinding) {
    SP_trunk_aIPbinding = sP_trunk_aIPbinding;
  }



  public String getSP_trunk_zIPbinding() {
    return SP_trunk_zIPbinding;
  }



  public void setSP_trunk_zIPbinding(String sP_trunk_zIPbinding) {
    SP_trunk_zIPbinding = sP_trunk_zIPbinding;
  }



  public String getSP_OSPF_aPassword() {
    return SP_OSPF_aPassword;
  }



  public void setSP_OSPF_aPassword(String sP_OSPF_aPassword) {
    SP_OSPF_aPassword = sP_OSPF_aPassword;
  }



  public String getSP_OSPF_zPassword() {
    return SP_OSPF_zPassword;
  }



  public void setSP_OSPF_zPassword(String sP_OSPF_zPassword) {
    SP_OSPF_zPassword = sP_OSPF_zPassword;
  }



    public String getSP_LDP_aPassword() {
    return SP_LDP_aPassword;
  }



  public void setSP_LDP_aPassword(String sP_LDP_aPassword) {
    SP_LDP_aPassword = sP_LDP_aPassword;
  }



  public String getSP_LDP_zPassword() {
    return SP_LDP_zPassword;
  }



  public void setSP_LDP_zPassword(String sP_LDP_zPassword) {
    SP_LDP_zPassword = sP_LDP_zPassword;
  }



    public ServiceForm(){}
    
    
  
	public String getReusedSite() {
		return reusedSite;
	}



	public void setReusedSite(String reusedSite) {
		this.reusedSite = reusedSite;
	}



	public String getSP_QoSChildEnabled()
    {
      return SP_QoSChildEnabled;
    }



    public void setSP_QoSChildEnabled(String SP_QoSChildEnabled)
    {
      this.SP_QoSChildEnabled = SP_QoSChildEnabled;
    }



  public void setServiceid( String serviceid )
	{
		this.serviceid = serviceid;
	}

	public String getServiceid()
	{
		return serviceid;
	}

	
	public void setServicename( String servicename )
	{
		this.servicename = servicename;
	}

	public String getServicename()
	{
		return servicename;
	}
	
	public void setPresname( String presname )
	{
		this.presname = presname;
	}

	public String getPresname()
	{
		return presname;
	}


	public void setState( String state )
	{
		this.state = state;
	}

	public String getState()
	{
		return state;
	}

	public void setType( String type )
	{
		this.type = type;
	}

	public String getType()
	{
		return type;
	}
	
	public void setCustomerid( String customerid )
	{
		this.customerid = customerid;
	}

	public String getCustomerid()
	{
		return customerid;
	}

	public void setCustomername( String customername )
	{
		this.customername = customername;
	}

	public String getCustomername()
	{
		return customername;
	}

	
	
	public void setParentserviceid( String parentserviceid )
	{
		this.parentserviceid = parentserviceid;
	}

	public String getParentserviceid()
	{
		return parentserviceid;
	}

	public void setStatus( String status )
	{
		this.status = status;
	}

	public String getStatus()
	{
		return status;
	}
	
	public void setActionflag( String actionflag )
	{
		this.actionflag = actionflag;
	}

	public String getActionflag()
	{
		return actionflag;
	}

	public void setMessageid( String messageid )
	{
		this.messageid = messageid;
	}

	public String getMessageid()
	{
		return messageid;
	}
	
	public void setSP_Activation_Scope( String SP_Activation_Scope )
	{
		this.SP_Activation_Scope = SP_Activation_Scope;
	}

	public String getSP_Activation_Scope()
	{
		return SP_Activation_Scope;
	}
	
	public void setSP_StartTime( String SP_StartTime )
	{
		this.SP_StartTime = SP_StartTime;
	}

	public String getSP_StartTime()
	{
		return SP_StartTime;
	}
	
	public void setSP_RoutingProtocol( String SP_RoutingProtocol )
	{
		this.SP_RoutingProtocol = SP_RoutingProtocol;
	}

	public String getSP_RoutingProtocol()
	{
		return SP_RoutingProtocol;
	}
	
	public void setStaticCounter( String staticCounter )
	{
		this.staticCounter = staticCounter;
	}

	public String getStaticCounter()
	{
		return staticCounter;
	}
	
	
	
	public void setNextOperationTime( long nextOperationTime )
	{
		this.nextOperationTime = nextOperationTime;
	}

	public long getNextOperationTime()
	{
		return nextOperationTime;
	}

	public void setEndTime( String endTime )
	{
		this.endTime = endTime;
	}

	public String getEndTime()
	{
		return endTime;
	}

	public void setLastUpdateTime( long lastUpdateTime )
	{
		this.lastUpdateTime = lastUpdateTime;
	}

	public long getLastupdatetime()
	{
		return lastUpdateTime;
	}
	
	public void setSendSaDeleteRequest( String sendSaDeleteRequest )
	{
		this.sendSaDeleteRequest = sendSaDeleteRequest;
	}

	public String getSendSaDeleteRequest()
	{
		return sendSaDeleteRequest;
	}
	
	public void setSubmitDate( String submitDate )
	{
		this.submitDate = submitDate;
	}

	public String getSubmitDate()
	{
		return submitDate;
	}
	
	public void setModifyDate( String modifyDate )
	{
		this.modifyDate = modifyDate;
	}

	public String getModifyDate()
	{
		return modifyDate;
	}
	
	
	 public void setServiceparameterVO( ServiceParameterVO [] serviceparameterVO )
		{
			this.serviceparameterVO = serviceparameterVO;
		}

	public ServiceParameterVO [] getServiceparameterVO()
		{
			return serviceparameterVO;
		}
	
	public void setServiceparameters( ServiceParameter [] parameters )
		{
			this.parameters = parameters;
		}

	public ServiceParameter [] getServiceparameters()
		{
			return parameters;
		}
	
   
	public void setService( Service service )
	{
		this.service = service;
	}
	
	public Service getService()
	{
		return service;
	}
	
	public void setParentService( Service parentService )
	{
		this.parentService = parentService;
	}
	
	public Service getParentService()
	{
		return parentService;
	}
	
   public void setServices( Service [] services )
	{
		this.services = services;
	}


  public Service [] getServices()
	{
		return services;
	}
  
  public void setParentServices( Service [] parentServices )
	{
		this.parentServices = parentServices;
	}

  public Service [] getParentServices()
	{
		return parentServices;
	}
  
  public void setCustomer( Customer customer )
	{
		this.customer = customer;
	}

  public Customer getCustomer()
	{
		return customer;
	}
  
   public void setSitecount( int[] sitecount )
	{
		this.sitecount = sitecount;
	}

   public int[] getSitecount()
	{
		return sitecount;
	}
	
	public void setServiceTypes( ServiceType[] serviceTypes )
	{
		this.serviceTypes = serviceTypes;
	}

    public ServiceType[] getServiceTypes()
	{
		return serviceTypes;
	}
	public void setSubServiceTypes( ArrayList subServiceTypes )
	{
		this.subServiceTypes = subServiceTypes;
	}

    public ArrayList getSubServiceTypes()
	{
		return subServiceTypes;
	}
	
	public void setMultipleMemberships( ArrayList multipleMemberships )
	{
		this.multipleMemberships = multipleMemberships;
	}

    public ArrayList getMultipleMemberships()
	{
		return multipleMemberships;
	}
    
    
    public void setSP_VLANId( String SP_VLANId )
	{
		this.SP_VLANId = SP_VLANId;
	}

	public String getSP_VLANId()
	{
		return SP_VLANId;
	}
	
	public void setSP_Location( String SP_Location )
	{
		this.SP_Location = SP_Location;
	}

	public String getSP_Location()
	{
		return SP_Location;
	}
	public void setSP_LoopDetection( String SP_LoopDetection )
	{
		this.SP_LoopDetection = SP_LoopDetection;
	}

	public String getSP_LoopDetection()
	{
		return SP_LoopDetection;
	}
	public void setSP_Comment( String SP_Comment )
	{
		this.SP_Comment = SP_Comment;
	}

	public String getSP_Comment()
	{
		return SP_Comment;
	}
	
	public void setSP_EndTime( String SP_EndTime )
	{
		this.SP_EndTime = SP_EndTime;
	}

	public String getSP_EndTime()
	{
		return SP_EndTime;
	}
	
	public void setSP_Region( String SP_Region )
	{
		this.SP_Region = SP_Region;
	}

	public String getSP_Region()
	{
		return SP_Region;
	}
	
	public void setSP_CAR( String SP_CAR )
	{
		this.SP_CAR = SP_CAR;
	}

	public String getSP_CAR()
	{
		return SP_CAR;
	}
	
	public void setSP_QOS_PROFILE( String SP_QOS_PROFILE )
	{
		this.SP_QOS_PROFILE = SP_QOS_PROFILE;
	}

	public String getSP_QOS_PROFILE()
	{
		return SP_QOS_PROFILE;
	}
	
	public void setSP_QOS_BASE_PROFILE( String SP_QOS_BASE_PROFILE )
	{
		this.SP_QOS_BASE_PROFILE = SP_QOS_BASE_PROFILE;
	}

	public String getSP_QOS_BASE_PROFILE()
	{
		return SP_QOS_BASE_PROFILE;
	}
    

	public void setSP_AddressPool( String SP_AddressPool )
	{
		this.SP_AddressPool = SP_AddressPool;
	}

	public String getSP_AddressPool()
	{
		return SP_AddressPool;
	}
	
	public void setSP_SecondaryAddressPool( String SP_SecondaryAddressPool )
	{
		this.SP_SecondaryAddressPool = SP_SecondaryAddressPool;
	}

	public String getSP_SecondaryAddressPool()
	{
		return SP_SecondaryAddressPool;
	}
	
	public void setSP_PERouter( String SP_PERouter )
	{
		this.SP_PERouter = SP_PERouter;
	}

	public String getSP_PERouter()
	{
		return SP_PERouter;
	}
	
	public void setSP_PEInterface( String SP_PEInterface )
	{
		this.SP_PEInterface = SP_PEInterface;
	}

	public String getSP_PEInterface()
	{
		return SP_PEInterface;
	}
	
	public void setSP_Managed_CE_Router( String SP_Managed_CE_Router )
	{
		this.SP_Managed_CE_Router = SP_Managed_CE_Router;
	}

	public String getSP_CE_based_QoS()
	{
		return SP_CE_based_QoS;
	}
	
	public void setSP_CE_based_QoS( String SP_CE_based_QoS )
	{
		this.SP_CE_based_QoS = SP_CE_based_QoS;
	}

	public String getSP_OSPF_Area()
	{
		return SP_OSPF_Area;
	}
	
	public void setSP_OSPF_Area( String SP_OSPF_Area )
	{
		this.SP_OSPF_Area = SP_OSPF_Area;
	}
		
	public void setSP_Customer_ASN( String SP_Customer_ASN )
	{
		this.SP_Customer_ASN = SP_Customer_ASN;
	}

	public String getSP_Customer_ASN()
	{
		return SP_Customer_ASN;
	}

	public void setInclude( String include )
	{
		this.include = include;
	}

	public String getInclude()
	{
		return include;
	}	

   public void setSP_Site_Service_ID_aEnd( String SP_Site_Service_ID_aEnd )
	{
		this.SP_Site_Service_ID_aEnd = SP_Site_Service_ID_aEnd;
	}

	public String getSP_Site_Service_ID_aEnd()
	{
		return SP_Site_Service_ID_aEnd;
	}


	public void setSP_Site_Service_ID_zEnd( String SP_Site_Service_ID_zEnd )
	{
		this.SP_Site_Service_ID_zEnd = SP_Site_Service_ID_zEnd;
	}

	public String getSP_Site_Service_ID_zEnd()
	{
		return SP_Site_Service_ID_zEnd;
	}


	public void setSP_PW_aEnd( String SP_PW_aEnd )
	{
		this.SP_PW_aEnd = SP_PW_aEnd;
	}

	public String getSP_PW_aEnd()
	{
		return SP_PW_aEnd;
	}


	public void setSP_PW_zEnd( String SP_PW_zEnd )
	{
		this.SP_PW_zEnd = SP_PW_zEnd;
	}

	public String getSP_PW_zEnd()
	{
		return SP_PW_zEnd;
	}


	public void setSP_PW_aEnd_location( String SP_PW_aEnd_location )
	{
		this.SP_PW_aEnd_location = SP_PW_aEnd_location;
	}

	public String getSP_PW_aEnd_location()
	{
		return SP_PW_aEnd_location;
	}


	public void setSP_PW_zEnd_location( String SP_PW_zEnd_location )
	{
		this.SP_PW_zEnd_location = SP_PW_zEnd_location;
	}

	public String getSP_PW_zEnd_location()
	{
		return SP_PW_zEnd_location;
	}


	public void setSP_PW_aEnd_region( String SP_PW_aEnd_region )
	{
		this.SP_PW_aEnd_region = SP_PW_aEnd_region;
	}

	public String getSP_PW_aEnd_region()
	{
		return SP_PW_aEnd_region;
	}


	public void setSP_PW_zEnd_region( String SP_PW_zEnd_region )
	{
		this.SP_PW_zEnd_region = SP_PW_zEnd_region;
	}

	public String getSP_PW_zEnd_region()
	{
		return SP_PW_zEnd_region;
	}


	public void setSP_RL( String SP_RL )
	{
		this.SP_RL = SP_RL;
	}

	public String getSP_RL()
	{
		return SP_RL;
	}


	public void setSP_UNIType_aEnd( String SP_UNIType_aEnd )
	{
		this.SP_UNIType_aEnd = SP_UNIType_aEnd;
	}

	public String getSP_UNIType_aEnd()
	{
		return SP_UNIType_aEnd;
	}

    public void setSP_UNIType_zEnd( String SP_UNIType_zEnd )
	{
		this.SP_UNIType_zEnd = SP_UNIType_zEnd;
	}

	public String getSP_UNIType_zEnd()
	{
		return SP_UNIType_zEnd;
	}

    
	  public void setSP_PW_Type_aEnd( String SP_PW_Type_aEnd )
	{
		this.SP_PW_Type_aEnd = SP_PW_Type_aEnd;
	}

	public String getSP_PW_Type_aEnd()
	{
		return SP_PW_Type_aEnd;
	}


	  public void setSP_PW_Type_zEnd( String SP_PW_Type_zEnd )
	{
		this.SP_PW_Type_zEnd = SP_PW_Type_zEnd;
	}

	public String getSP_PW_Type_zEnd()
	{
		return SP_PW_Type_zEnd;
	}


	  public void setSP_EthType_aEnd( String SP_EthType_aEnd )
	{
		this.SP_EthType_aEnd = SP_EthType_aEnd;
	}

	public String getSP_EthType_aEnd()
	{
		return SP_EthType_aEnd;
	}


	  public void setSP_EthType_zEnd( String SP_EthType_zEnd )
	{
		this.SP_EthType_zEnd = SP_EthType_zEnd;
	}

	public String getSP_EthType_zEnd()
	{
		return SP_EthType_zEnd;
	}


	  public void setSP_VLANIdaEnd( String SP_VLANIdaEnd )
	{
		this.SP_VLANIdaEnd = SP_VLANIdaEnd;
	}

	public String getSP_VLANIdaEnd()
	{
		return SP_VLANIdaEnd;
	}


	  public void setSP_VLANIdzEnd( String SP_VLANIdzEnd )
	{
		this.SP_VLANIdzEnd = SP_VLANIdzEnd;
	}

	public String getSP_VLANIdzEnd()
	{
		return SP_VLANIdzEnd;
	}


	  public void setSP_DLCIaEnd( String SP_DLCIaEnd )
	{
		this.SP_DLCIaEnd = SP_DLCIaEnd;
	}

	public String getSP_DLCIaEnd()
	{
		return SP_DLCIaEnd;
	}


	  public void setSP_DLCIzEnd( String SP_DLCIzEnd )
	{
		this.SP_DLCIzEnd = SP_DLCIzEnd;
	}

	public String getSP_DLCIzEnd()
	{
		return SP_DLCIzEnd;
	}


	  public void setSP_request_synchronisation( String SP_request_synchronisation )
	{
		this.SP_request_synchronisation = SP_request_synchronisation;
	}

	public String getSP_request_synchronisation()
	{
		return SP_request_synchronisation;
	}



	  public void setSP_Customer_name( String SP_Customer_name )
	{
		this.SP_Customer_name = SP_Customer_name;
	}

	public String getSP_Customer_name()
	{
		return SP_Customer_name;
	}



	  public void setSP_Contact_person( String SP_Contact_person )
	{
		this.SP_Contact_person = SP_Contact_person;
	}

	public String getSP_Contact_person()
	{
		return SP_Contact_person;
	}

	  public void setSP_Customer_email( String SP_Customer_email )
	{
		this.SP_Customer_email = SP_Customer_email;
	}

	public String getSP_Customer_email()
	{
		return SP_Customer_email;
	}


	  public void setaEndSelected( String aEndSelected )
	{
		this.aEndSelected = aEndSelected;
	}

	public String getaEndSelected()
	{
		return aEndSelected;
	}


	  public void setzEndSelected( String zEndSelected )
	{
		this.zEndSelected = zEndSelected;
	}

	public String getzEndSelected()
	{
		return zEndSelected;
	}


      public void setSP_ConnectivityType( String SP_ConnectivityType )
	{
		this.SP_ConnectivityType = SP_ConnectivityType;
	}

	public String getSP_ConnectivityType()
	{
		return SP_ConnectivityType;
	}


    public void setSP_QOS_CLASS_0_PERCENT( String SP_QOS_CLASS_0_PERCENT )
	{
		this.SP_QOS_CLASS_0_PERCENT = SP_QOS_CLASS_0_PERCENT;
	}

	public String getSP_QOS_CLASS_0_PERCENT()
	{
		return SP_QOS_CLASS_0_PERCENT;
	}



	 public void setSP_QOS_CLASS_1_PERCENT( String SP_QOS_CLASS_1_PERCENT )
	{
		this.SP_QOS_CLASS_1_PERCENT = SP_QOS_CLASS_1_PERCENT;
	}

	public String getSP_QOS_CLASS_1_PERCENT()
	{
		return SP_QOS_CLASS_1_PERCENT;
	}


	 public void setSP_QOS_CLASS_2_PERCENT( String SP_QOS_CLASS_2_PERCENT )
	{
		this.SP_QOS_CLASS_2_PERCENT = SP_QOS_CLASS_2_PERCENT;
	}

	public String getSP_QOS_CLASS_2_PERCENT()
	{
		return SP_QOS_CLASS_2_PERCENT;
	}



	 public void setSP_QOS_CLASS_3_PERCENT( String SP_QOS_CLASS_3_PERCENT )
	{
		this.SP_QOS_CLASS_3_PERCENT = SP_QOS_CLASS_3_PERCENT;
	}

	public String getSP_QOS_CLASS_3_PERCENT()
	{
		return SP_QOS_CLASS_3_PERCENT;
	}


	 public void setSP_QOS_CLASS_4_PERCENT( String SP_QOS_CLASS_4_PERCENT )
	{
		this.SP_QOS_CLASS_4_PERCENT = SP_QOS_CLASS_4_PERCENT;
	}

	public String getSP_QOS_CLASS_4_PERCENT()
	{
		return SP_QOS_CLASS_4_PERCENT;
	}

 public void setSP_QOS_CLASS_5_PERCENT( String SP_QOS_CLASS_5_PERCENT )
	{
		this.SP_QOS_CLASS_5_PERCENT = SP_QOS_CLASS_5_PERCENT;
	}

 	public String getSP_QOS_CLASS_5_PERCENT(){
		return SP_QOS_CLASS_5_PERCENT;
	}
	
	public String getSP_QOS_CLASS_6_PERCENT() {
		return SP_QOS_CLASS_6_PERCENT;
	}

	public void setSP_QOS_CLASS_6_PERCENT(String SP_QOS_CLASS_6_PERCENT) {
		this.SP_QOS_CLASS_6_PERCENT = SP_QOS_CLASS_6_PERCENT;
	}

	public String getSP_QOS_CLASS_7_PERCENT() {
		return SP_QOS_CLASS_7_PERCENT;
	}

	public void setSP_QOS_CLASS_7_PERCENT(String SP_QOS_CLASS_7_PERCENT) {
		this.SP_QOS_CLASS_7_PERCENT = SP_QOS_CLASS_7_PERCENT;
	}

    public void setRoute0( String route0 )
	{
		this.route0 = route0;
	}

	public String getRoute0()
	{
		return route0;
	}


	public void setRoute1( String serviceid )
	{
		this.route1 = route1;
	}

	public String getRoute1()
	{
		return route1;
	}


	public void setRoute2( String route2 )
	{
		this.route2 = route2;
	}

	public String getRoute2()
	{
		return route2;
	}


	public void setRoute3( String route3 )
	{
		this.route3 = route3;
	}

	public String getRoute3()
	{
		return route3;
	}


	public void setRoute4( String route4 )
	{
		this.route4 = route4;
	}

	public String getRoute4()
	{
		return route4;
	}


	public void setRoute5( String route5 )
	{
		this.route5 = route5;
	}

	public String getRoute5()
	{
		return route5;
	}


  //MASK

   public void setMask0( String mask0 )
	{
		this.mask0 = mask0;
	}

	public String getMask0()
	{
		return mask0;
	}


	public void setMask1( String mask1 )
	{
		this.mask1 = mask1;
	}

	public String getMask1()
	{
		return mask1;
	}


	public void setMask2( String mask2 )
	{
		this.mask2 = mask2;
	}

	public String getMask2()
	{
		return mask2;
	}


	public void setMask3( String mask3 )
	{
		this.mask3 = mask3;
	}

	public String getMask3()
	{
		return mask3;
	}


	public void setMask4( String mask4 )
	{
		this.mask4 = mask4;
	}

	public String getMask4()
	{
		return mask4;
	}


	public void setMask5( String mask5 )
	{
		this.mask5 = mask5;
	}

	public String getMask5()
	{
		return mask5;
	}


   public void setNewServiceId( String newServiceId )
	{
		this.newServiceId = newServiceId;
	}

	public String getNewServiceId()
	{
		return newServiceId;
	}


  
   public void setOperation_type( String operation_type )
	{
		this.operation_type = operation_type;
	}

	public String getOperation_type()
	{
		return operation_type;
	}



	public void setOtherCustomer( String otherCustomer )
	{
		this.otherCustomer = otherCustomer;
	}

	public String getOtherCustomer()
	{
		return otherCustomer;
	}



	public void setVpnId( String vpnId )
	{
		this.vpnId = vpnId;
	}

	public String getVpnId()
	{
		return vpnId;
	}


	public void setVPNid( String VPNid )
	{
		this.VPNid = VPNid;
	}

	public String getVPNid()
	{
		return VPNid;
	}

 
    public void setMulticastVPNId( String MulticastVPNId )
	{
		this.MulticastVPNId = MulticastVPNId;
	}

	public String getMulticastVPNId()
	{
		return MulticastVPNId;
	}


	public void setMulticastStatus( String MulticastStatus )
	{
		this.MulticastStatus = MulticastStatus;
	}

	public String getMulticastStatus()
	{
		return MulticastStatus;
	}


	public void setMulticastRP( String MulticastRP )
	{
		this.MulticastRP = MulticastRP;
	}

	public String getMulticastRP()
	{
		return MulticastRP;
	}


	public void setMulticastQoSClass( String MulticastQoSClass )
	{
		this.MulticastQoSClass = MulticastQoSClass;
	}

	public String getMulticastQoSClass()
	{
		return MulticastQoSClass;
	}


	public void setMulticastRateLimit( String MulticastRateLimit )
	{
		this.MulticastRateLimit = MulticastRateLimit;
	}

	public String getMulticastRateLimit()
	{
		return MulticastRateLimit;
	}


    public void setMv( String mv )
	{
		this.mv = mv;
	}

	public String getMv()
	{
		return mv;
	}


	public void setCurrentPageNo( String currentPageNo )
	{
		this.currentPageNo = currentPageNo;
	}

	public String getCurrentPageNo()
	{
		return currentPageNo;
	}


	public void setViewPageNo( String viewPageNo )
	{
		this.viewPageNo = viewPageNo;
	}

	public String getViewPageNo()
	{
		return viewPageNo;
	}

	
   public void setConnTypeVPNId( String connTypeVPNId )
	{
		this.connTypeVPNId = connTypeVPNId;
	}

	public String getConnTypeVPNId()
	{
		return connTypeVPNId;
	}


//Richa - 11687


    public void setCurrentRs( String currentRs )
	{
		this.currentRs = currentRs;
	}

	public String getCurrentRs()
	{
		return currentRs;
	}


	public void setLastRs( String lastRs )
	{
		this.lastRs = lastRs;
	}

	public String getLastRs()
	{
		return lastRs;
	}


	public void setTotalPages( String totalpages )
	{
		this.totalpages = totalpages;
	}

	public String getTotalPages()
	{
		return totalpages;
	}


	public String getPrefixCounter() {
		return prefixCounter;
	}

	public void setPrefixCounter(String prefixCounter) {
		this.prefixCounter = prefixCounter;
	}

	public String getPrefixroute0() {
		return prefixroute0;
	}

	public void setPrefixroute0(String prefixroute0) {
		this.prefixroute0 = prefixroute0;
	}

	public String getPrefixroute1() {
		return prefixroute1;
	}

	public void setPrefixroute1(String prefixroute1) {
		this.prefixroute1 = prefixroute1;
	}

	public String getPrefixroute2() {
		return prefixroute2;
	}

	public void setPrefixroute2(String prefixroute2) {
		this.prefixroute2 = prefixroute2;
	}

	public String getPrefixroute3() {
		return prefixroute3;
	}

	public void setPrefixroute3(String prefixroute3) {
		this.prefixroute3 = prefixroute3;
	}

	public String getPrefixroute4() {
		return prefixroute4;
	}

	public void setPrefixroute4(String prefixroute4) {
		this.prefixroute4 = prefixroute4;
	}

	public String getPrefixroute5() {
		return prefixroute5;
	}

	public void setPrefixroute5(String prefixroute5) {
		this.prefixroute5 = prefixroute5;
	}

	public String getPrefixmask0() {
		return prefixmask0;
	}

	public void setPrefixmask0(String prefixmask0) {
		this.prefixmask0 = prefixmask0;
	}

	public String getPrefixmask1() {
		return prefixmask1;
	}

	public void setPrefixmask1(String prefixmask1) {
		this.prefixmask1 = prefixmask1;
	}

	public String getPrefixmask2() {
		return prefixmask2;
	}

	public void setPrefixmask2(String prefixmask2) {
		this.prefixmask2 = prefixmask2;
	}

	public String getPrefixmask3() {
		return prefixmask3;
	}

	public void setPrefixmask3(String prefixmask3) {
		this.prefixmask3 = prefixmask3;
	}

	public String getPrefixmask4() {
		return prefixmask4;
	}

	public void setPrefixmask4(String prefixmask4) {
		this.prefixmask4 = prefixmask4;
	}

	public String getPrefixmask5() {
		return prefixmask5;
	}

	public void setPrefixmask5(String prefixmask5) {
		this.prefixmask5 = prefixmask5;
	}
	
	
	
	//Richa-11687
	
	/**
     * Reset all properties to their default values.
     *
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     */
	 @Override
  public void reset(ActionMapping actionMapping,HttpServletRequest request)
	 {
		 serviceid = null;
		 servicename  = null;
		 state = null;
		 type = null;
		 customerid = null;	
		 parentserviceid = null;	
		 submitDate = null;	
		 modifyDate = null;			 	
		 status = "Active";	
		 endTime = "";
		 lastUpdateTime = 0;
		 nextOperationTime = 0; 
		 serviceparameterVO = null;
		 parameters = null;
		 
	 }

    /**
     * Ensure that the fields have  input.
     *
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     */
	 @Override
  public ActionErrors validate(ActionMapping actionMapping,HttpServletRequest request)
	 {
		 ActionErrors actionErrors = new ActionErrors();
		 if(customerid == null || customerid.trim().equals(""))
		 {
			 actionErrors.add("customerid",new ActionError("error.no.customer.id"));
		 }
		 if(serviceid == null || serviceid.trim().equals(""))
		 {
			 actionErrors.add("serviceid",new ActionError("error.no.serviceid"));
		 }
		
		    return actionErrors;
	 }

} // End serviceForm



