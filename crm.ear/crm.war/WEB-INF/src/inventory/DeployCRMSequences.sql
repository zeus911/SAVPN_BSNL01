create or replace procedure drop_upload_sequence_if_exists
	(sname in varchar2)

is
  cnt NUMBER;
  
begin
	SELECT COUNT(*) INTO cnt FROM user_sequences WHERE sequence_name = sname;
		IF cnt <> 0 THEN
		  execute immediate 'DROP sequence ' || sname;
		END IF;
end;
/

create or replace procedure drop_crm_sequences is
begin
	drop_upload_sequence_if_exists('CRM_CUSTOMER_ID_SEQ');
	drop_upload_sequence_if_exists('CRM_SERVICE_ID_SEQ');
	drop_upload_sequence_if_exists('CRM_MESSAGE_ID_SEQ');
end;
/

{call drop_crm_sequences()};

-- delete the pl/sql script procedure
drop procedure drop_crm_sequences;

-- Now create sequences 
create sequence CRM_SERVICE_ID_SEQ increment by 1 start with 1000;
create sequence CRM_CUSTOMER_ID_SEQ increment by 1 start with 1;
create sequence CRM_MESSAGE_ID_SEQ increment by 1 start with 1;