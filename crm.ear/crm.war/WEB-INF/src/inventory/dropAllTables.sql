create or replace procedure drop_crm_tables is
begin
execute immediate 'DROP TABLE CRM_STATICROUTE';
execute immediate 'DROP TABLE CRM_VPN_MEMBERSHIP';
execute immediate 'DROP TABLE CRM_SERVICEPARAM';
execute immediate 'DROP TABLE CRM_SERVICE';
execute immediate 'DROP TABLE CRM_STATEMAPPING';
execute immediate 'DROP TABLE CRM_STATE';
execute immediate 'DROP TABLE CRM_SERVICETYPE';
execute immediate 'DROP TABLE CRM_CUSTOMER';
execute immediate 'DROP TABLE CRM_MESSAGE';
execute immediate 'drop sequence CRM_CUSTOMER_ID_SEQ';
execute immediate 'drop sequence CRM_MESSAGE_ID_SEQ';
execute immediate 'drop sequence CRM_SERVICE_ID_SEQ';
end;
/


{call drop_crm_tables()};

-- delete the pl/sql script procedure
drop procedure drop_crm_tables;
