insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Request_Sent', '300', 'In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '501', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '306', 'Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '307', 'Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Temporary_Failure', '300', 'In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Temporary_Failure', '301', 'Waiting_Operator', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Temporary_Failure', '501', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Temporary_Failure', '201', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Failure', '300', 'In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '201', 'Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial', '300', 'Partial_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial_In_Progress', '201', 'Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial_In_Progress', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial_In_Progress', '501', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial_In_Progress', '306', 'Partial_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial_In_Progress', '307', 'Partial_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial_Temporary_Failure', '300', 'Partial_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial_Temporary_Failure', '501', 'Failure', 0);

-- Added by tanye. For service multiplexing 
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Request_Sent', '401', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Requested', '300', 'Delete_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_In_Progress', '200', 'Delete', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_In_Progress', '501', 'Delete_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_In_Progress', '306', 'Delete_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_In_Progress', '307', 'Delete_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Temporary_Failure', '300', 'Delete_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Temporary_Failure', '501', 'Delete_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Failure', '300', 'Delete_In_Progress', 0);

-- Handle workflow failures!

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Request_Sent', '500', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '500', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Failure', '500', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Temporary_Failure', '500', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Partial', '500', 'Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Requested', '500', 'Delete_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_In_Progress', '500', 'Delete_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Failure', '500', 'Delete_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Temporary_Failure', '500', 'Delete_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Temporary_Failure', '201', 'Delete_Failure', 0);

-- Handle modify actions

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Request_Sent', '500', 'Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '500', 'Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Request_Sent', '300', 'Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '501', 'Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '306', 'Modify_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '307', 'Modify_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Temporary_Failure', '300', 'Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Temporary_Failure', '501', 'Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Temporary_Failure', '201', 'Modify_Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Failure', '300', 'Modify_In_Progress', 0);
-- Handle scheduled actions

-- for create/delete

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Start_Time', '305', 'In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Start_Time', '200', 'Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '304', 'Wait_End_Time', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_End_Time', '301', 'Sched_Delete_Confirm', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_End_Time', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Delete_Confirm', '302', 'Delete_In_Progress', 0);

--for do/undo modify
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Wait_Start_Time', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '304', 'Wait_Mod_End_Time', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Mod_End_Time', '302', 'Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Mod_End_Time', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Modify_Confirm', '301', 'Modify_In_Progress', 0);


-- failure cases
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Request_Sent', '500', 'Wait_Start_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Modify_Request_Sent', '500', 'Modify_Wait_Start_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Start_Time', '500', 'Wait_Start_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Start_Time', '501', 'Wait_Start_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Wait_Start_Time', '500', 'Modify_Wait_Start_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Wait_Start_Time', '501', 'Modify_Wait_Start_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_End_Time', '500', 'Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_End_Time', '501', 'Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Mod_End_Time', '500', 'Modify_Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Mod_End_Time', '501', 'Modify_Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Delete_Confirm', '500', 'Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Modify_Confirm', '500', 'Modify_Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Delete_Confirm', '501', 'Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Modify_Confirm', '501', 'Modify_Wait_End_Time_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Modify_In_Progress', '201', 'Modify_Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Undo_Modify_Sent', '500', 'Modify_Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Undo_Modify_Sent', '401', 'Modify_Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Undo_Modify_Sent', '300', 'Undo_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Modify_Partial', '300', 'Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Undo_Modify_In_Progress', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Undo_Modify_In_Progress', '500', 'Modify_Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Undo_Modify_In_Progress', '201', 'Modify_Partial', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Undo_Modify_In_Progress', '501', 'Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Disable_Request_Sent', '300', 'Disable_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Disable_In_Progress', '200', 'Disabled', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Disable_In_Progress', '306', 'Disable_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Disable_In_Progress', '307', 'Disable_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Disable_Temporary_Failure', '300', 'Disable_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Disable_Temporary_Failure', '501', 'Disable_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Disable_In_Progress', '500', 'Disable_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Disable_In_Progress', '501', 'Disable_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Enable_Request_Sent', '300', 'Enable_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Enable_In_Progress', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Enable_In_Progress', '306', 'Enable_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Enable_In_Progress', '307', 'Enable_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Enable_Temporary_Failure', '300', 'Enable_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Enable_Temporary_Failure', '501', 'Enable_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Enable_In_Progress', '500', 'Enable_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values( 'Enable_In_Progress', '501', 'Enable_Failure', 0);


-- Periodic modification mappings
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Request_Sent', '500', 'Periodic_Modify_Failure', 0);
--insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_Start', '200', 'Periodic_Modify_Wait_Start', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_Start', '305', 'Periodic_Modify_In_Progress', 0);
--insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_Start', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_Start', '501', 'Periodic_Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Ok_Wait_Start', '305', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Ok_Wait_Start', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_End', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_In_Progress', '304', 'Periodic_Modify_Wait_End', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_In_Progress', '307', 'Periodic_Modify_Temporary_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_In_Progress', '501', 'Periodic_Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_End', '301', 'Periodic_Modify_In_Progress', 0);

--insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Ok_Wait_End', '200', 'Periodic_Modify_Wait_Start', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Temporary_Failure', '305', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Temporary_Failure', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Failure', '305', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Failure', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Failure', '300', 'Periodic_Modify_Wait_Start', 0);

-- PR14444

-- PR16088

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('In_Progress','301','Waiting_Operator',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('Waiting_Operator','302','In_Progress',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('Request_Sent','400','MSG_Failure',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('MSG_Failure','300','In_Progress',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('PE_Delete_In_Progress','501','Delete_Failure',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('PE_Delete_In_Progress','200','Delete',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('PE_Delete_In_Progress','306','Delete_Temporary_Failure',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('PE_Delete_In_Progress','307','Delete_Temporary_Failure',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('PE_Delete_In_Progress','500','Delete_Failure',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('Waiting_Operator','306','Temporary_Failure',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('Waiting_Operator','307','Temporary_Failure',0);

-- PR 17619
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Failure', '500', 'Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Temporary_Failure', '500', 'Modify_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Request_Sent', '300', 'In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '303', 'Wait_Start_Time', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('In_Progress', '300', 'In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_Start_Time', '300', 'In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Wait_End_Time', '302', 'Delete_In_Progress', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_In_Progress', '300', 'Delete_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Sched_Modify_Request_Sent', '300', 'Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '303', 'Modify_Wait_Start_Time', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Wait_Start_Time', '300', 'Modify_In_Progress', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Request_Sent', '300', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_In_Progress', '303', 'Periodic_Modify_Wait_Start', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_Start', '300', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_In_Progress', '300', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_In_Progress', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Wait_Start', '200', 'Ok', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Request_Sent', '401', 'Modify_Failure', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_In_Progress', '201', 'Delete_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '300', 'Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_In_Progress', '301', 'Waiting_Operator', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Waiting_Operator', '310', 'Modify_In_Progress', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Disable_Temporary_Failure', '500', 'Disable_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Disable_Temporary_Failure', '200', 'Disabled', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Enable_Temporary_Failure', '500', 'Enable_Failure', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Enable_Temporary_Failure', '200', 'Ok', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Request_Sent', '401', 'Periodic_Modify_Failure', 0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('Waiting_Operator','201','Failure',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('Waiting_Operator','500','Failure',0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values('Temporary_Failure','200','Ok',0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Modify_Temporary_Failure','200','Ok',0);

insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Temporary_Failure', '303', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Periodic_Modify_Failure', '303', 'Periodic_Modify_In_Progress', 0);
insert into CRM_STATEMAPPING (CurrentState, SaResponse, NextState, ISPARENT__) values ('Delete_Requested', '200', 'Delete', 0);