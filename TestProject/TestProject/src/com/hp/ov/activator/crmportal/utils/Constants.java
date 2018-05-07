package com.hp.ov.activator.crmportal.utils;

/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
 *
 ************************************************************************
 */

import java.text.SimpleDateFormat;

/**
 * Manifest constants for this application.
 *
 * @author Frederik Husted Andersen
 * @version $Revision: 1.11 $ $Date: 2010-10-05 14:19:19 $
 */

public final class Constants {

	/**
	 * The package name for this application.
	 */
	public static final String Package = "com.hp.ov.activator.crmportal";

	// Added by Divya --- to check Qos profile complaint status

	public static String COMPLAINT = "compliant";
	public static String PAR_COMPLAINT = "partial-compliant";
	public static String NON_COMPLAINT = "non-compliant";
	public static String QOS_PROFILE = "QOS_PROFILE";

	/**
	 * The name for database pool.
	 */
	public static final String DATABASE_POOL = "database_pool";

	public static String CUSTOMER_ID_SEQUENCE = "CRM_CUSTOMER_ID_SEQ";
	public static String SERVICE_ID_SEQUENCE = "CRM_SERVICE_ID_SEQ";
	public static String MESSAGE_ID_SEQUENCE = "CRM_MESSAGE_ID_SEQ";
	/**
	 * The token that represents the logon activity in an ActionForward.
	 */
	public static final String LOGON = "logon";

	/**
	 * The session scope attribute under which the roles for the currently logged in user is stored.
	 */
	public static final String ROLES_KEY = "roles";

	/**
	 * The token that represents a nominal outcome in an ActionForward.
	 */
	public static final String SUCCESS = "success";
	public static final String FAILURE = "failure";

	/**
	 * The session scope attribute under which the Username for the currently logged in user is stored.
	 */
	public static final String USER_KEY = "user";

	/**
	 * The token that represents the welcome activity in an ActionForward.
	 */
	public static final String WELCOME = "welcome";

	/**
	 * The value to indicate debug logging.
	 */
	public static final int DEBUG = 1;

	/**
	 * The value to indicate normal logging.
	 */
	public static final int NORMAL = 0;

	/**
	 * The value to indicate the total no of records to be displayed in a services page
	 */
	public static final int REC_PER_PAGE = 10;

	// public static final String DATASOURCE_NAME = "java:/crmportal/jdbc/ServicesDB";
	public static final String DATASOURCE_NAME = "java:/crm/jdbc/crmDB";
	public static final String LOGIN_SUCCESS = "login_success";
	public static final String LOGIN_FAILURE = "login_failure";

	public static final String USER = "user";
	public static final String ID = "id";

	public static final String USERNAME = "username";
	public static final String PASSWORD = "password";
	public static final String DRIVER = "driver";
	public static final String MAX_USAGES = "max_usage";
	public static final String CONNECTIONS = "connections";
	public static final String URL = "url";

	public static final String REFRESH = "refresh";
	public static final String UPDATE = "Update";
	public static final String LOG_DIRECTORY = "log_dir";

	public static final String SOCKET_LIS_PORT = "socketListener_port";
	public static final String SOCKET_LIS_HOST = "socketListener_host";
	public static final String TEMPLATE_DIR = "template_dir";
	public static final String REQUEST_SYNCHRONISATION = "request_synchronisation";

	public static final String ACTION_JOIN_VPN = "JoinVPN";
	public static final String ACTION_LEAVE_VPN = "LeaveVPN";
	public static final String ACTION_CREATE_L2_VPN = "L2VPN";
	public static final String ACTION_CREATE_L2_SITE_VPN = "L2SiteVPN";
	public static final String PARAMETER_PE_CE_PROTOCOL = "RoutingProtocol";
	public static final String PARAMETER_OLD_CONNECTIVITY = "hidden_old_connectivity";
	public static final String PARAMETER_MODIFIED_VPN_ID = "hidden_connectivity_VPNid";
	public static final String PARAMETER_LAST_UNDO = "hidden_lastOperationUndo";
	public static final String PARAMETER_LAST_COMMIT = "hidden_lastOperationCommit";
	public static final String PARAMETER_PERIODIC = "periodic";
	public static final String PARAMETER_LAST_MODIFIED = "hidden_LastModifiedAttribute";
	public static final String PARAMETER_LAST_MODIFIED_VALUE = "hidden_LastModifiedAttributeValue";
	public static final String PARAMETER_CAR = "CAR";

	public static final String TYPE_GIS_ATTACHMENT ="GIS-Attachment";
	// Added to fix PR 10998 --Divya
	public static final String PARAMETER_PERIODIC_MODIFIED = "Periodic_Org_CAR";
	public static final String PARAMETER_PERIODIC_MODIFIED_VALUE = "Periodic_Org_CARValue";
	public static final String PARAMETER_PERIODIC_ACTION = "Periodic_Action";
	// ends here

	// date format constants
	public static final SimpleDateFormat DEFAULT_DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
	public static final SimpleDateFormat SCHEDULED_DATE_FORMAT = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

	public static final String PERIODIC_INTERVAL = "periodic_interval";
	// static final String PARAMETER_NEXT_START = "hidden_nextPeriodicStart";
	public static final String PATH_TO_ROLES = "roles_file";
	public static final String ROLE_OPERATOR = "operator";
	public static final String ROLE_OBSERVER = "observer";
	public static final String ROLE_ADMIN = "admin";
	// basicauthenticator
	public static final String WEB_INF = "WEB-INF";
	// public static final String rolesFilePath = "roles.xml";
	public static final String rolesFilePath = "roles.xml";
	public static final String LOGS_DIRECTORY = "log_dir";

	//
	public static final String CRM_STATES_TABLE = "CRM_MESSAGE";
	public static final String CRM_STATES_TABLE_ID = "messageid";

	public static final String CRMPortalLOG = "CRMPortalLOG";

	// message dispatcher class
	public static final String PK_START_TAG = "<Service_id>";
	public static final String PK_END_TAG = "</Service_id>";
	public static final String STATUS_START_TAG = "<Resp_status>";
	public static final String STATUS_END_TAG = "</Resp_status>";
	public static final String DATA_START_TAG = "<Resp_data>";
	public static final String DATA_END_TAG = "</Resp_data>";
	public static final String DATA_EMPTY_TAG = "<Resp_data/>";

	public static final int SLEEP_TIMEOUT = 600000;

	// Added by Divya
	public static final String MSGID_START_TAG = "<Message_id>";
	public static final String MSGID_END_TAG = "</Message_id>";

	public static final String TYPE_LAYER3_VPN = "layer3-VPN";
	public static final String TYPE_LAYER2_VPN = "layer2-VPN";
	public static final String TYPE_LAYER2_VPWS = "layer2-VPWS";
	public static final String TYPE_SITE = "Site";
	public static final String TYPE_LAYER3_ATTACHMENT = "layer3-Attachment";
	public static final String TYPE_LAYER2_ATTACHMENT = "layer2-Attachment";
	public static final String TYPE_LAYER2_VPWS_ATTACHMENT = "vpws-Attachment";
	public static final String TYPE_LAYER3_PROTECTION = "layer3-Protection";

	public static final String ATTACHMENT_TYPE_L3VPN = "L3VPN";
	public static final String ATTACHMENT_TYPE_L2VPN = "L2VPN";
	public static final String ATTACHMENT_TYPE_L2VPWS = "L2VPWS";

	//The Trunk types
	public static final String TRUNK_TYPE_IPTRUNK = "IP-Trunk ";
	public static final String TRUNK_TYPE_ETHTRUNK = "Eth-Trunk ";
	public static final String TRUNK_TYPE_ETHTRUNK_MIN = "1";
	public static final String TRUNK_TYPE_STM16 = "STM16 ";
	public static final String TRUNK_TYPE_STM16_MIN = "0";
	public static final String TYPE_GIS_PROTECTION = "GIS-Protection ";
	public static final String MEMBER_REPLACE = "_###MEMBER_REPLACE###_";
	public static final String TRUNK_REPLACE = "_TRUNK_";
	public static final String LINK_REPLACE = "_LINK_";
	
	public static final String TYPE_GIS_SITE = "GIS-Site";
	public static final String TYPE_GIS_VPN ="GIS-VPN";
	
	// With release 510 3A, Site is a common object. so typicaly the following
	// types should be changed to "Site". But it is retained as it might require
	// some additional effort to change whole CRM code.
	public static final String TYPE_LAYER2_SITE = "layer2-Site";
	public static final String TYPE_LAYER3_SITE = "layer3-Site";

	public static final String MODIFYCONNECTIVITYTYPE = "ModifyConnectivityType";
	public static final String XSLNAME_SITE = "Site";
	public static final String XSLNAME_SITES = "Sites";
	public static final String XSLNAME_L3_ATTACHMENT = "L3-Attachment";
	public static final String XSLNAME_L2VPWS_ATTACHMENT = "L2VPWS-Attachment";

	public static final String XSLPARAM_ACTION = "ACTION";
	public static final String XSLPARAM_HOST = "HOST";
	public static final String XSLPARAM_PORT = "PORT";
	public static final String XSLPARAM_TEMPLATE_DIR = "TEMPLATE_DIR";
	public static final String XSLPARAM_LOG_DIRECTORY = "LOG_DIRECTORY";
	public static final String XSLPARAM_REQUEST_SYNCHRONISATION = "request_synchronisation";
	public static final String XSLPARAM_SERVICEID = "serviceid";
	public static final String XSLPARAM_CUSTOMERID = "customerid";
	public static final String XSLPARAM_MESSAGEID = "messageid";
	public static final String XSLPARAM_TYPE = "type";
	public static final String XSLPARAM_VPNSERVICEID = "vpnserviceid";
	public static final String XSLPARAM_PW_AEND = "PW_aEnd";
	public static final String XSLPARAM_PW_ZEND = "PW_zEnd";
	public static final String XSLPARAM_PRESNAME = "presname";
	public static final String XSLPARAM_XSLNAME = "xslName";
	public static final String XSLPARAM_ADDRESS_TYPE = "Address_type";
	public static final String XSLPARAM_ADDRESS_FAMILY = "AddressFamily";
	
	public static final String XSLPARAM_SUBINTERFACENAME = "SubInterfaceName";
	public static final String XSLPARAM_PARENTINTERFACE_AEND = "ParentInterface_aEnd";
	public static final String XSLPARAM_PARENTINTERFACE_ZEND = "ParentInterface_zEnd";
	public static final String XSLPARAM_SUBADDRESSPOOL_AEND = "SubAddressPool_aEnd";
	public static final String XSLPARAM_SUBADDRESSPOOL_ZEND = "SubAddressPool_zEnd";
	public static final String XSLPARAM_SUB_IPADDRESS_AEND = "Sub_ipaddress_aEnd";
	public static final String XSLPARAM_SUB_IPADDRESS_ZEND = "Sub_ipaddress_zEnd";
	public static final String XSLPARAM_SUB_IP_SUBMASK_AEND = "Sub_ip_submask_aEnd";
	public static final String XSLPARAM_SUB_IP_SUBMASK_ZEND = "Sub_ip_submask_zEnd";
	public static final String XSLPARAM_SUBTRUNK_POLICY_ASIDE = "Subtrunk_policy_aside";
	public static final String XSLPARAM_SUBTRUNK_POLICY_ZSIDE = "Subtrunk_policy_zside";
	public static final String XSLPARAM_SUBTRUNK_QOS_ASIDE = "subtrunk_qos_aside";
    public static final String XSLPARAM_SUBTRUNK_QOS_ZSIDE = "Subtrunk_qos_zside";
	public static final String XSLPARAM_SUB_IP_NETWORKIP_AEND = "Sub_ip_networkIP_aEnd";
	public static final String XSLPARAM_SUB_IP_NETWORKIP_ZEND = "Sub_ip_networkIP_zEnd";
	public static final String XSLPARAM_SUB_WILDCARD_AEND = "Sub_wildcard_aEnd";
	public static final String XSLPARAM_SUB_WILDCARD_ZEND = "Sub_wildcard_zEnd";
	
	public static final String XSLPARAM_SUB_IPV6_FAMILY_AEND = "Sub_IPv6_family_aEnd";
	public static final String XSLPARAM_SUB_IPV6_FAMILY_ZEND = "Sub_IPv6_family_zEnd";
	public static final String XSLPARAM_SUB_IPV6_POOL_AEND = "Sub_IPv6_Pool_aEnd";
	public static final String XSLPARAM_SUB_IPV6_POOL_ZEND = "Sub_IPv6_Pool_zEnd";
	public static final String XSLPARAM_SUB_IPV6_ADDRESS_AEND = "Sub_IPv6_Address_aEnd";
    public static final String XSLPARAM_SUB_IPV6_ADDRESS_ZEND = "Sub_IPv6_Address_zEnd";
    public static final String XSLPARAM_SUB_IPV6_ENCAP_AEND = "Sub_IPv6_encap_aEnd";
    public static final String XSLPARAM_SUB_IPV6_ENCAP_ZEND = "Sub_IPv6_encap_zEnd";
    public static final String XSLPARAM_SUB_IPV6_BINDING_AEND = "Sub_IPv6_binding_aEnd";
    public static final String XSLPARAM_SUB_IPV6_BINDING_ZEND = "Sub_IPv6_binding_zEnd";
	
	public static final String XSLPARAM_SUBTRUNK_PROCESSID_AEND = "Subtrunk_processid_aEnd";
	public static final String XSLPARAM_SUBTRUNK_PROCESSID_ZEND = "Subtrunk_processid_zEnd";
	public static final String XSLPARAM_SUBAREA_NUMBER_AEND = "SubArea_number_aEnd";
	public static final String XSLPARAM_SUBAREA_NUMBER_ZEND = "SubArea_number_zEnd";
	public static final String XSLPARAM_LNK_PROTOCOL_ASIDE = "lnk_Protocol_aside";
	public static final String XSLPARAM_LNK_PROTOCOL_ZSIDE = "lnk_Protocol_zside";
	public static final String XSLPARAM_SUB_PIM_NAME_ASIDE = "Sub_pim_name_aside";
	public static final String XSLPARAM_SUB_PIM_NAME_ZSIDE = "Sub_pim_name_zside";
	public static final String XSLPARAM_SUB_NETWORK_TYPE_ASIDE = "Sub_network_type_aside";
	public static final String XSLPARAM_SUB_NETWORK_TYPE_ZSIDE = "Sub_network_type_zside";
	public static final String XSLPARAM_SUB_OSPF_ASIDE = "Sub_ospf_aside";
	public static final String XSLPARAM_SUB_OSPF_ZSIDE = "Sub_ospf_zside";
	public static final String XSLPARAM_SUB_TRUNK_NEGOTIATION_ASIDE = "SubNegotiation_aend";
	public static final String XSLPARAM_SUB_TRUNK_NEGOTIATION_ZSIDE = "SubNegotiation_zend";
	public static final String XSLPARAM_SUBOSPF_APASSWORD = "SubOSPF_aPassword";
	public static final String XSLPARAM_SUBOSPF_ZPASSWORD = "SubOSPF_zPassword";
	public static final String XSLPARAM_SUBLDP_APASSWORD = "SubLDP_aPassword";
    public static final String XSLPARAM_SUBLDP_ZPASSWORD = "SubLDP_zPassword";
	public static final String XSLPARAM_SUBTRUNK_OSPF_COST_AEND = "Subtrunk_ospf_cost_aend";
	public static final String XSLPARAM_SUBTRUNK_OSPF_COST_ZEND = "Subtrunk_ospf_cost_zend";
	public static final String XSLPARAM_SUBTRUNK_MTU_AEND = "Subtrunk_mtu_aend";
	public static final String XSLPARAM_SUBTRUNK_MTU_ZEND = "Subtrunk_mtu_zend";
	public static final String XSLPARAM_SUBLDP_AEND = "Subldp_aend";
	public static final String XSLPARAM_SUBLDP_ZEND = "Subldp_zend";
	public static final String XSLPARAM_SUBINT_DESCRIPTION_AEND = "SubInt_description_aEnd";
	public static final String XSLPARAM_SUBINT_DESCRIPTION_ZEND = "SubInt_description_zEnd";

	public static final String IP_ADDR_V4 = "IPv4";

	public static final String SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND = "Site_Attachment_ID_aEnd";
	public static final String SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND = "Site_Attachment_ID_zEnd";
	public static final String SERVICE_PARAM_HIDDEN_SITE_ID = "hidden_site_id";
	public static final String SERVICE_PARAM_HIDDEN_LASTMODIFYACTION = "hidden_LastModifyAction";
	public static final String SERVICE_PARAM_VPN_ID = "vpn_id";
	public static final String SERVICE_PARAM_FAILURE_DESCRIPTION = "Failure_Description";
	public static final String SERVICE_PARAM_SERVICEMULTIPLEXING_AEND = "ServiceMultiplexing_aEnd";
	public static final String SERVICE_PARAM_SERVICEMULTIPLEXING_ZEND = "ServiceMultiplexing_zEnd";
	public static final String SERVICE_PARAM_SITE_SERVICE_ID_AEND = "Site_Service_ID_aEnd";
	public static final String SERVICE_PARAM_SITE_SERVICE_ID_ZEND = "Site_Service_ID_zEnd";
	public static final String SERVICE_PARAM_DELETED_ZEND_SITEID = "Deleted_zEnd_SiteId";
	public static final String SERVCIE_PARAM_HIDDEN_UNDO_WAIT = "hidden_UndoWait";
	public static final String SERVICE_PARAM_FAILURE_STATUS = "Failure_Status";
	public static final String SERVICE_PARAM_MULTICASTQOSCLASS = "MulticastQoSClass";
	public static final String SERVICE_PARAM_MULTICASTRP = "MulticastRP";
	public static final String SERVICE_PARAM_MULTICASTRATELIMIT = "MulticastRateLimit";
	public static final String SERVCIE_PARAM_MULTICASTSTATUS = "MulticastStatus";
	public static final String SERVICE_PARAM_MULTICASTVPNID = "MulticastVPNId";
	public static final String SERVICE_PARAM_ATTACHMENTID = "attachmentid";
	public static final String SERVICE_PARAM_ATTACHMENTTYPE = "Attachmenttype";
	public static final String SERVICE_PARAM_OPERATOR = "operator";

	public static final String SERVICE_STATE_FAILURE = "Failure";
	public static final String SERVICE_STATE_OK = "Ok";
	public static final String SERVICE_STATE_MSG_FAILURE = "MSG_Failure";
	public static final String SERVICE_STATE_DELETE = "Delete";
	public static final String SERVICE_STATE_REUSE_FAILURE = "Reuse_Failure";

	public static final String SERVICE_STATE_ENABLE_IN_PROGRESS = "Enable_In_Progress";
	public static final String SERVICE_STATE_DISABLE_IN_PROGRESS = "Disable_In_Progress";
	public static final String SERVICE_STATE_DISABLED = "Disabled";

	public static final String ACTION_ADD = "Add";
	public static final String ACTION_CREATE = "Create";
	public static final String ACTION_DELETE = "Delete";
	public static final String ACTION_REMOVE = "Remove";
	public static final String ACTION_ENABLE = "enabled";
	public static final String ACTION_DISABLE = "disabled";

	public static final String ACTION_JOINVPN = "JoinVPN";
	public static final String ACTION_LEAVEVPN = "LeaveVPN";
	public static final String ACTION_MODIFYMULTICAST = "ModifyMulticast";
	public static final String ACTION_MODIFYCONNECTIVITYTYPE = "ModifyConnectivityType";

	public static final String CRMPORTALLOG = "CRMPortalLOG";

	public static final String ACTIVATION_SCOPE_PARAM = "Activation_Scope";
	public static final String ACTIVATION_SCOPE_VALUE_PE_ONLY = "PE_ONLY";
	public static final String ACTIVATION_SCOPE_PE = "PE";
	public static final String ACTIVATION_SCOPE_VALUE_CE_ONLY = "CE_ONLY";
	public static final String ACTIVATION_SCOPE_CE = "CE";
	public static final String ACTIVATION_SCOPE_VALUE_BOTH = "BOTH";
	// Added for redesign of managed CE
	public static final String ACTIVATION_SCOPE_PE_CE = "PE_CE";
	public static final String ACTIVATION_SCOPE_CE_SETUP = "CE_Setup";
	public static final String ACTIVATE_CE = "Activate_CE";
	public static final String PARAM_NEXT_STATE = "hidden_next_state";
	public static final String PARAM_ACTIVATE_CE_FLAG = "hidden_activate_CE";
	public static final String PARAM_MANAGED_CE = "Managed_CE_Router";

	public static final String MESSAGE_ID_PATH = "resp_msg/@msg_id";
	public static final String SERVICE_ID_PATH = "resp_msg/header/Service_response/Service_id";
	public static final String STATUS_PATH = "resp_msg/body/Response/major_code/code";
	public static final String DATA_PATH = "resp_msg/body/Response/minor_code/description";
	public static final String MINOR_CODE_PATH = "resp_msg/body/Response/minor_code/code";
	public static final String RESPONSE_DATA = "resp_msg/body/Response/response_data/data";

	public static final String START_TIME = "StartTime";
	public static final String END_TIME = "EndTime";
	public static final String STATE_REQUEST_SENT = "Request_Sent";
	public static final String STATE_SCHED_REQUEST_SENT = "Sched_Request_Sent";
	public static final String STATE_FAILURE = "Failure";
	public static final String STATE_WAIT_END_TIME = "Wait_End_Time";
	public static final String STATE_DELETE_REQUESTED = "Delete_Requested";
	public static final String STATE_DELETE_FAILURE = "Delete_Failure";
	public static final String STATE_PE_WAIT_MOD_END_TIME = "PE_Wait_Mod_End_Time";
	public static final String STATE_WAIT_MOD_END_TIME = "Wait_Mod_End_Time";
	public static final String STATE_PE_OK = "PE_Ok";
	public static final String STATE_MODIFY_WAIT_END_TIME_FAILURE = "Modify_Wait_End_Time_Failure";
	public static final String STATE_PE_MODIFY_WAIT_END_TIME_FAILURE = "PE_Modify_Wait_End_Time_Failure";
	public static final String STATE_PE_PERIODIC_MODIFY_WAIT_START = "PE_Periodic_Modify_Wait_Start";
	public static final String STATE_PE_PERIODIC_MODIFY_IN_PROGRESS = "PE_Periodic_Modify_In_Progress";
	public static final String STATE_MODIFY_FAILURE = "Modify_Failure";
	public static final String STATE_MODIFY_PARTIAL = "Modify_Partial";
	public static final String STATE_PE_CE_MODIFY_PARTIAL = "PE_CE_Modify_Partial";
	public static final String STATE_PE_CE_OK = "PE_CE_Ok";
	public static final String STATE_PARTIAL_DISABLED = "Partial_Disabled";
	public static final String REUSED = "REUSED";

	public static final String SA_RESP_ACT_OK = "200";
	public static final String SA_RESP_WAIT_START = "303";

	public static final String SERVICE_PARAM_VALUE_VPWS_FAILURE = "VPWS Failure";
	public static final String SERVICE_PARAM_VALUE_SITE_FAILURE = "Site Failure";
	public static final String SERVICE_PARAM_VALUE_L2VPWS_ATTACHMENT_FAILURE = "L2 VPWS Attachment Failure";
	public static final String XSLNAME_CREATE_L2VPWS = "Createlayer2-VPWS";

	public static final String SKIP_ACTIVATION = "skip_activation";
	public static final String ACTION_MODIFY_QOSPROFILE = "ModifyQoSProfile";
	public static final String REGION = "Region";
	public static final String PW_AEND_REGION = "PW_aEnd_region";
	public static final String PW_ZEND_REGION = "PW_zEnd_region";

}
