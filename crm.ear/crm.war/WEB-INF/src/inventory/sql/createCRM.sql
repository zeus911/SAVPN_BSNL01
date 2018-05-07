----------------------------------------
-- Bean name: Customer
----------------------------------------
--*[Creation SQL for bean Customer]:
--*CREATE TABLE crm_customer ...
CREATE TABLE crm_customer (
  CustomerId VARCHAR2(200) not null,  CompanyName VARCHAR2(200) ,  CompanyAddress VARCHAR2(200) ,  CompanyCity VARCHAR2(200) ,  CompanyZipCode VARCHAR2(200) ,  ContactpersonName VARCHAR2(200) ,  ContactpersonSurname VARCHAR2(200) ,  ContactpersonPhonenumber VARCHAR2(200) ,  ContactpersonEmail VARCHAR2(200) ,  Status VARCHAR2(200) not null,  LastUpdateTime NUMERIC(20) not null,  CreationTime VARCHAR2(200) not null  , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_customer.CustomerId IS 'Unique customer identifier\n';
COMMENT ON COLUMN crm_customer.CompanyName IS 'Name of company\n';
COMMENT ON COLUMN crm_customer.CompanyAddress IS 'Company address, both street and number\n';
COMMENT ON COLUMN crm_customer.CompanyCity IS 'The city in which the company is located\n';
COMMENT ON COLUMN crm_customer.CompanyZipCode IS 'Postal code\n';
COMMENT ON COLUMN crm_customer.ContactpersonName IS 'First name of the contact person\n';
COMMENT ON COLUMN crm_customer.ContactpersonSurname IS 'Surname of the contact person\n';
COMMENT ON COLUMN crm_customer.ContactpersonPhonenumber IS 'Phone number of the contact person\n';
COMMENT ON COLUMN crm_customer.ContactpersonEmail IS 'E-mail address of the contact person\n';
COMMENT ON COLUMN crm_customer.Status IS 'Customer''s current status\n';
COMMENT ON COLUMN crm_customer.LastUpdateTime IS 'Time of the update of the service\n';
COMMENT ON COLUMN crm_customer.CreationTime IS 'Timestamp of creation of customer in DB in YYYY.MM.DD HH24:MI:SS format\n';

COMMENT ON TABLE crm_customer IS 'Unique customer identifier';


--*Add primary and unique keys constraints for main table crm_customer ...
ALTER TABLE crm_customer ADD CONSTRAINT crm_customer_CustomerId_PK PRIMARY KEY ( CustomerId )
  ;
  







----------------------------------------
-- Bean name: Message
----------------------------------------
--*[Creation SQL for bean Message]:
--*CREATE TABLE CRM_MESSAGE ...
CREATE TABLE CRM_MESSAGE (
  sequenceId NUMERIC(20) not null,  messageId NUMERIC(20) not null,  serviceId VARCHAR2(200) not null,  state VARCHAR2(200) not null,  data VARCHAR2(2000) ,  responseData VARCHAR2(200)   , isParent__ CHAR(1) not null);


COMMENT ON COLUMN CRM_MESSAGE.sequenceId IS 'Id\n';
COMMENT ON COLUMN CRM_MESSAGE.messageId IS 'Id of message\n';
COMMENT ON COLUMN CRM_MESSAGE.serviceId IS 'Id of service that the message belongs to\n';
COMMENT ON COLUMN CRM_MESSAGE.state IS 'State code recieved in message\n';
COMMENT ON COLUMN CRM_MESSAGE.data IS 'Additional data recieved in message\n';
COMMENT ON COLUMN CRM_MESSAGE.responseData IS 'Additional operator comments received in message\n';

COMMENT ON TABLE CRM_MESSAGE IS 'Id ';


--*Add primary and unique keys constraints for main table CRM_MESSAGE ...
ALTER TABLE CRM_MESSAGE ADD CONSTRAINT CRM_MESSAGE_sequenceId_PK PRIMARY KEY ( sequenceId )
  ;
  







----------------------------------------
-- Bean name: State
----------------------------------------
--*[Creation SQL for bean State]:
--*CREATE TABLE crm_state ...
CREATE TABLE crm_state (
  Name VARCHAR2(200) not null,  Description VARCHAR2(200)   , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_state.Name IS 'Name of the state\n';
COMMENT ON COLUMN crm_state.Description IS 'Further description of the state\n';

COMMENT ON TABLE crm_state IS 'Name of the state';


--*Add primary and unique keys constraints for main table crm_state ...
ALTER TABLE crm_state ADD CONSTRAINT crm_state_Name_PK PRIMARY KEY ( Name )
  ;
  







----------------------------------------
-- Bean name: ServiceType
----------------------------------------
--*[Creation SQL for bean ServiceType]:
--*CREATE TABLE crm_servicetype ...
CREATE TABLE crm_servicetype (
  Name VARCHAR2(200) not null,  Description VARCHAR2(200) ,  ParentServType VARCHAR2(200)   , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_servicetype.Name IS 'Name of the serviceType\n';
COMMENT ON COLUMN crm_servicetype.Description IS 'Description for the ServiceType\n';
COMMENT ON COLUMN crm_servicetype.ParentServType IS 'Key to parent service type. Null if this is the parent service type\n';

COMMENT ON TABLE crm_servicetype IS 'Name of the serviceType';


--*Add primary and unique keys constraints for main table crm_servicetype ...
ALTER TABLE crm_servicetype ADD CONSTRAINT crm_servicetype_Name_PK PRIMARY KEY ( Name )
  ;
  



  --*ALTER TABLE crm_servicetype ADD CONSTRAINT ...
ALTER TABLE crm_servicetype 
  ADD CONSTRAINT CCRM4_0_crm_ser_ParentServT_FK FOREIGN KEY ( ParentServType )
  REFERENCES crm_servicetype ( Name )
   ON DELETE CASCADE  
  ;
    



--*CREATE INDEX CRM_crm_servicetype_Parent_4_1 ON crm_servicetype ...
CREATE INDEX CRM_crm_servicetype_Parent_4_1 ON crm_servicetype ( ParentServType );

----------------------------------------
-- Bean name: Service
----------------------------------------
--*[Creation SQL for bean Service]:
--*CREATE TABLE crm_service ...
CREATE TABLE crm_service (
  ServiceId VARCHAR2(200) not null,  PresName VARCHAR2(200) ,  State VARCHAR2(200) not null,  SubmitDate VARCHAR2(200) ,  ModifyDate VARCHAR2(200) ,  Type VARCHAR2(200) not null,  CustomerId VARCHAR2(200) not null,  ParentServiceId VARCHAR2(200) ,  EndTime VARCHAR2(200) ,  NextOperationTime NUMERIC(20) not null,  LastUpdateTime NUMERIC(20) not null  , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_service.ServiceId IS 'Unique service identifier\n';
COMMENT ON COLUMN crm_service.PresName IS 'The presentation name of the service\n';
COMMENT ON COLUMN crm_service.State IS 'The state of the service\n';
COMMENT ON COLUMN crm_service.SubmitDate IS 'The date of creation\n';
COMMENT ON COLUMN crm_service.ModifyDate IS 'The date of last modification\n';
COMMENT ON COLUMN crm_service.Type IS 'The type of the service\n';
COMMENT ON COLUMN crm_service.CustomerId IS 'Reference to the parent customer\n';
COMMENT ON COLUMN crm_service.ParentServiceId IS 'Key to parent service. Null if this is the parent service\n';
COMMENT ON COLUMN crm_service.EndTime IS 'The possible end time of providing the service\n';
COMMENT ON COLUMN crm_service.NextOperationTime IS 'Time of the next periodic activation\n';
COMMENT ON COLUMN crm_service.LastUpdateTime IS 'Time of the update of the service\n';

COMMENT ON TABLE crm_service IS 'Unique service identifier';


--*Add primary and unique keys constraints for main table crm_service ...
ALTER TABLE crm_service ADD CONSTRAINT crm_service_ServiceId_PK PRIMARY KEY ( ServiceId )
  ;
  



  --*ALTER TABLE crm_service ADD CONSTRAINT ...
ALTER TABLE crm_service 
  ADD CONSTRAINT CCRM5_0_crm_ser_State_FK FOREIGN KEY ( State )
  REFERENCES crm_state ( Name )
   ON DELETE CASCADE  
  ;
  ALTER TABLE crm_service 
  ADD CONSTRAINT CCRM5_1_crm_ser_CustomerId_FK FOREIGN KEY ( CustomerId )
  REFERENCES crm_customer ( CustomerId )
   ON DELETE CASCADE  
  ;
  ALTER TABLE crm_service 
  ADD CONSTRAINT CCRM5_2_crm_ser_Type_FK FOREIGN KEY ( Type )
  REFERENCES crm_servicetype ( Name )
   ON DELETE CASCADE  
  ;
  ALTER TABLE crm_service 
  ADD CONSTRAINT CCRM5_3_crm_ser_ParentServi_FK FOREIGN KEY ( ParentServiceId )
  REFERENCES crm_service ( ServiceId )
   ON DELETE CASCADE  
  ;
    



--*CREATE INDEX CRM_crm_service_State_5_1 ON crm_service ...
CREATE INDEX CRM_crm_service_State_5_1 ON crm_service ( State );
--*CREATE INDEX CRM_crm_service_CustomerId_5_2 ON crm_service ...
CREATE INDEX CRM_crm_service_CustomerId_5_2 ON crm_service ( CustomerId );
--*CREATE INDEX CRM_crm_service_NextOperat_5_3 ON crm_service ...
CREATE INDEX CRM_crm_service_NextOperat_5_3 ON crm_service ( NextOperationTime );
--*CREATE INDEX CRM_crm_service_Type_5_4 ON crm_service ...
CREATE INDEX CRM_crm_service_Type_5_4 ON crm_service ( Type );
--*CREATE INDEX CRM_crm_service_ParentServ_5_5 ON crm_service ...
CREATE INDEX CRM_crm_service_ParentServ_5_5 ON crm_service ( ParentServiceId );

----------------------------------------
-- Bean name: ServiceParameter
----------------------------------------
--*[Creation SQL for bean ServiceParameter]:
--*CREATE TABLE crm_serviceparam ...
CREATE TABLE crm_serviceparam (
  ServiceId VARCHAR2(200) not null,  Attribute VARCHAR2(200) not null,  Value VARCHAR2(4000)   , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_serviceparam.ServiceId IS 'Unique service identifier for the parent service\n';
COMMENT ON COLUMN crm_serviceparam.Attribute IS 'The name of the attribute or parameter\n';
COMMENT ON COLUMN crm_serviceparam.Value IS 'The value of the attribute or parameter\n';

COMMENT ON TABLE crm_serviceparam IS 'Unique service identifier for the parent service';


--*Add primary and unique keys constraints for main table crm_serviceparam ...
ALTER TABLE crm_serviceparam ADD CONSTRAINT crm_servicepara_ServiceId_A_PK PRIMARY KEY ( ServiceId , Attribute )
  ;
  



  --*ALTER TABLE crm_serviceparam ADD CONSTRAINT ...
ALTER TABLE crm_serviceparam 
  ADD CONSTRAINT CCRM6_0_crm_ser_ServiceId_FK FOREIGN KEY ( ServiceId )
  REFERENCES crm_service ( ServiceId )
   ON DELETE CASCADE  
  ;
    



--*CREATE INDEX CRM_crm_serviceparam_Servi_6_1 ON crm_serviceparam ...
CREATE INDEX CRM_crm_serviceparam_Servi_6_1 ON crm_serviceparam ( ServiceId );

----------------------------------------
-- Bean name: StateMapping
----------------------------------------
--*[Creation SQL for bean StateMapping]:
--*CREATE TABLE crm_statemapping ...
CREATE TABLE crm_statemapping (
  CurrentState VARCHAR2(200) not null,  SaResponse VARCHAR2(200) not null,  NextState VARCHAR2(200) not null  , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_statemapping.CurrentState IS 'The current state of the service\n';
COMMENT ON COLUMN crm_statemapping.SaResponse IS 'The response from SA for synchronisation\n';
COMMENT ON COLUMN crm_statemapping.NextState IS 'The next state for the service\n';

COMMENT ON TABLE crm_statemapping IS 'The current state of the service';


--*Add primary and unique keys constraints for main table crm_statemapping ...
ALTER TABLE crm_statemapping ADD CONSTRAINT crm_statemappin_CurrentStat_PK PRIMARY KEY ( CurrentState , SaResponse )
  ;
  



  --*ALTER TABLE crm_statemapping ADD CONSTRAINT ...
ALTER TABLE crm_statemapping 
  ADD CONSTRAINT CCRM7_0_crm_sta_NextState_FK FOREIGN KEY ( NextState )
  REFERENCES crm_state ( Name )
   ON DELETE CASCADE  
  ;
  ALTER TABLE crm_statemapping 
  ADD CONSTRAINT CCRM7_1_crm_sta_CurrentStat_FK FOREIGN KEY ( CurrentState )
  REFERENCES crm_state ( Name )
   ON DELETE CASCADE  
  ;
    



--*CREATE INDEX CRM_crm_statemapping_NextS_7_1 ON crm_statemapping ...
CREATE INDEX CRM_crm_statemapping_NextS_7_1 ON crm_statemapping ( NextState );
--*CREATE INDEX CRM_crm_statemapping_Curre_7_2 ON crm_statemapping ...
CREATE INDEX CRM_crm_statemapping_Curre_7_2 ON crm_statemapping ( CurrentState );

----------------------------------------
-- Bean name: StaticRoute
----------------------------------------
--*[Creation SQL for bean StaticRoute]:
--*CREATE TABLE crm_staticRoute ...
CREATE TABLE crm_staticRoute (
  AttachmentId VARCHAR2(200) ,  StaticRouteAddress VARCHAR2(200)   , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_staticRoute.AttachmentId IS 'Service identifier for the attachment\n';
COMMENT ON COLUMN crm_staticRoute.StaticRouteAddress IS 'Static route for customer site\n';

COMMENT ON TABLE crm_staticRoute IS 'Service identifier for the attachment';


--*Add primary and unique keys constraints for main table crm_staticRoute ...
ALTER TABLE crm_staticRoute ADD CONSTRAINT CRM#8StaticRout_AttachmentI_PK PRIMARY KEY ( AttachmentId , StaticRouteAddress )
  ;
  



  --*ALTER TABLE crm_staticRoute ADD CONSTRAINT ...
ALTER TABLE crm_staticRoute 
  ADD CONSTRAINT CCRM8_0_StaticR_AttachmentI_FK FOREIGN KEY ( AttachmentId )
  REFERENCES crm_service ( ServiceId )
  ;
    



--*CREATE INDEX CRM_crm_staticRoute_Attach_8_1 ON crm_staticRoute ...
CREATE INDEX CRM_crm_staticRoute_Attach_8_1 ON crm_staticRoute ( AttachmentId );

----------------------------------------
-- Bean name: VPNMembership
----------------------------------------
--*[Creation SQL for bean VPNMembership]:
--*CREATE TABLE crm_vpn_membership ...
CREATE TABLE crm_vpn_membership (
  vpnId VARCHAR2(200) not null,  siteAttachmentId VARCHAR2(200) not null,  ConnectivityType VARCHAR2(200) not null  , isParent__ CHAR(1) not null);


COMMENT ON COLUMN crm_vpn_membership.vpnId IS 'Service id of VPN\n';
COMMENT ON COLUMN crm_vpn_membership.siteAttachmentId IS 'Service id of siteAttachmentID\n';
COMMENT ON COLUMN crm_vpn_membership.ConnectivityType IS 'Type of connectivity in this VPN\n';

COMMENT ON TABLE crm_vpn_membership IS 'Service id of VPN';


--*Add primary and unique keys constraints for main table crm_vpn_membership ...
ALTER TABLE crm_vpn_membership ADD CONSTRAINT crm_vpn_members_vpnId_siteA_PK PRIMARY KEY ( vpnId , siteAttachmentId )
  ;
  



  --*ALTER TABLE crm_vpn_membership ADD CONSTRAINT ...
ALTER TABLE crm_vpn_membership 
  ADD CONSTRAINT CCRM9_0_crm_vpn_siteAttachm_FK FOREIGN KEY ( siteAttachmentId )
  REFERENCES crm_service ( ServiceId )
   ON DELETE CASCADE  
  ;
  ALTER TABLE crm_vpn_membership 
  ADD CONSTRAINT CCRM9_1_crm_vpn_vpnId_FK FOREIGN KEY ( vpnId )
  REFERENCES crm_service ( ServiceId )
   ON DELETE CASCADE  
  ;
    



--*CREATE INDEX CRM_crm_vpn_membership_sit_9_1 ON crm_vpn_membership ...
CREATE INDEX CRM_crm_vpn_membership_sit_9_1 ON crm_vpn_membership ( siteAttachmentId );
--*CREATE INDEX CRM_crm_vpn_membership_vpn_9_2 ON crm_vpn_membership ...
CREATE INDEX CRM_crm_vpn_membership_vpn_9_2 ON crm_vpn_membership ( vpnId );

