insert into CRM_STATE (Name, Description, ISPARENT__) values ('Delete_Requested', 'A delete request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Delete_In_Progress', 'The deactivation is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Delete_Failure', 'The deactivation failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Delete_Temporary_Failure', 'The deactivation temporary failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Delete', 'Delete service now.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Request_Sent', 'A request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('In_Progress', 'The activation is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Failure', 'The activation failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Temporary_Failure', 'The temporary activation failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Partial_Temporary_Failure', 'The temporary partial activation failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Partial', 'The activation suceeded only partially.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Partial_In_Progress', 'The partially suceeded activation is in progress.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Ok', 'The activation was Successful.', 0);


insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_In_Progress', 'The PE activation is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Failure', 'The PE activation failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Temporary_Failure', 'The PE activation temporary failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Ok', 'The PE activation was Successful.', 0);


insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Request_Sent', 'A PE request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Request_Sent', 'A CE request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_In_Progress', 'The CE activation is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Failure', 'The CE activation failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Temporary_Failure', 'The CE activation temporary failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Ok', 'The CE activation was Successful.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_Request_Sent', 'A modify request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_In_Progress', 'The modification is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_Temporary_Failure', 'The modification temporary failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_Failure', 'The modification failed.', 0);



insert into CRM_STATE (Name, Description, ISPARENT__) values ('Wait_Start_Time', 'The scheduled request has been sent to SA.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Wait_Start_Time', 'The PE scheduled request has been sent to SA.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Wait_Start_Time', 'The CE scheduled request has been sent to SA.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Ok_Wait_End_Time', 'The PE activation was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Ok_Wait_End_Time', 'The CE activation was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Ok_Wait_End_Time', 'The activation was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_Wait_Start_Time', 'A scheduled modify request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Ok_Wait_Mod_End_Time', 'The activation was Successful. Wait for scheduled undo.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Ok_Wait_Mod_End_Time', 'The PE activation was Successful. Wait for scheduled undo.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Sched_Request_Sent', 'A scheduled request has been sent to Service Activator.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Sched_Modify_Request_Sent', 'A scheduled modify request has been sent to Service Activator.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Sched_Delete_Confirm', 'A scheduled delete job is waiting for confirmation.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Sched_Modify_Confirm', 'A scheduled modify job is waiting for confirmation.', 0);


insert into CRM_STATE (Name, Description, ISPARENT__) values ('Wait_Start_Time_Failure', 'A scheduled activation failure', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Wait_Start_Time_Failure', 'A scheduled PE activation failure', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Wait_Start_Time_Failure', 'A scheduled CE activation failure', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_Wait_Start_Time_Failure', 'A scheduled modify failure.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Wait_End_Time_Failure', 'A scheduled deletion failure.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Wait_End_Time_Failure', 'A scheduled PE deletion failure.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Wait_End_Time_Failure', 'A scheduled CE deletion failure.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_Wait_End_Time_Failure', 'A scheduled undo modify failure.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Modify_Partial', 'The modification succeded partially.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Undo_Modify_Sent', 'A undo partial modification request was sent to Service Activator.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Undo_Modify_In_Progress', 'The undo partial modification activation is being handled by to Service Activator.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Disable_Request_Sent', 'A disable service request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Disable_In_Progress', 'The disable service activation is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Disabled', 'Service was successfully disabled', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Disable_Temporary_Failure', 'Service disable activation temporary failed', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Disable_Failure', 'Service disable activation failed', 0);



insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Disabled', 'PE Service was successfully disabled', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Disabled', 'The disable service activation is being handled by to Service Activator.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Enable_Request_Sent', 'A enable service request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Enable_In_Progress', 'The enable service activation is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Enable_Failure', 'Service enable activation failed', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Enable_Temporary_Failure', 'Service enable activation temporary failed', 0);

-- Periodic modify states
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Request_Sent', 'A periodic modify request has been sent to Service Activator.', 0);


insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Wait_Start', 'The periodic modification is waiting for a start time.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Ok_Wait_Start', 'The periodic modification is waiting for a start time.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_In_Progress', 'The periodic modification is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Wait_End', 'The periodic modification is waiting for a end time.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Ok_Wait_End', 'The periodic modification is waiting for a end time.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Ok', 'The periodic modification succeded. Waiting for a next period to send', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Failure', 'The periodic modification failed. Waiting for a next period to send', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Periodic_Modify_Temporary_Failure', 'The periodic modification failed. Waiting for a next period to send', 0);



insert into CRM_STATE (Name, Description, ISPARENT__) values ('REUSE_FAILURE', 'Service multiplexing reusing failed.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('Partial_Disabled', 'Some attachments of a site are disabled while some are not', 0);

insert into crm_state (Name, Description, ISPARENT__) values ('Waiting_Operator','Jobs Waiting for Operator to interact with',0);
insert into crm_state (Name, Description, ISPARENT__) values ('PE_Waiting_Operator','PE Jobs Waiting for Operator to interact with',0);

insert into crm_state (Name, Description, ISPARENT__) values ('MSG_Failure','Request Message format is not correct',0);
insert into crm_state (Name, Description, ISPARENT__) values ('PE_MSG_Failure','PE Request Message format is not correct',0);


insert into crm_state (Name, Description, ISPARENT__) values ('PE_Delete_In_Progress','PE_Delete_In_Progress',0);

-- PR 17619
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_Request_Sent','A PE modify request has been sent to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_In_Progress','The PE modification is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_Failure','The PE modification failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_Temporary_Failure','The PE modification temporary failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_Partial','The PE modification succeded partially.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Disable_In_Progress','The disable service activation is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Enable_In_Progress','The enable service activation is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_Wait_Start_Time','A scheduled modify PE request has been sent to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_Wait_Start_Time_Failure','A scheduled modify PE failure.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Modify_Wait_End_Time_Failure','A scheduled undo modify PE failure.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Sched_Modify_Confirm','A scheduled modify PE job is waiting for confirmation.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Undo_Modify_In_Progress','The undo partial PE modification activation is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Disable_Temporary_Failure','PE Service disable activation temporary failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Disable_Failure','PE Service disable activation temporary failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Enable_Temporary_Failure','PE Service enable activation temporary failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Enable_Failure','PE Service enable activation failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_Request_Sent','A periodic PE modify request has been sent to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_Failure','The periodic PE modification failed. Waiting for a next period to send.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_Wait_Start','The periodic PE modification is waiting for a start time.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_In_Progress','The periodic PE modification is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_Ok_Wait_End','The periodic PE modification is waiting for a end time.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_Ok_Wait_Start','The periodic modification is waiting for next start time.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_Temporary_Failure','The periodic PE modification failed. Waiting for a next period to send.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Sched_Request_Sent','A scheduled PE request has been sent to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Sched_Request_Sent','A scheduled CE request has been sent to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Sched_Modify_Request_Sent', 'A scheduled PE modify request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Undo_Modify_Sent', 'A undo partial PE modification request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Disable_Request_Sent', 'A disable PE service request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Enable_Request_Sent', 'A enable PE service request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Wait_End_Time', 'The activation was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Wait_End_Time', 'The PE activation was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Wait_End_Time', 'The CE activation was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Delete_Temporary_Failure', 'The PE deactivation temporary failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Delete_Failure', 'The PE deactivation failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('Wait_Mod_End_Time', 'The activation was Successful. Wait for scheduled undo.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Wait_Mod_End_Time', 'The PE activation was Successful. Wait for scheduled undo.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Periodic_Modify_Wait_End','The periodic PE modification is waiting for a end time.',0);
insert into crm_state (Name, Description, ISPARENT__) values ('CE_Waiting_Operator','CE Jobs Waiting for Operator to interact with',0);

-- Added new state for managed ce redesign for flow through activation
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Request_Sent', 'The PE activation and CE setup request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_In_Progress', 'The PE activation and CE setup request is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Failure', 'The PE activation and CE setup was failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Temporary_Failure', 'The PE activation and CE setup temporarily failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Ok', 'The PE activation and CE setup was Successful.', 0);
insert into crm_state (Name, Description, ISPARENT__) values ('PE_CE_Waiting_Operator','PE CE Jobs Waiting for Operator to interact with',0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Request_Sent', 'The CE setup request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_In_Progress', 'The CE setup request is being handled by to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Failure', 'The CE setup failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Temporary_Failure', 'The CE setup temporarily failed.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Ok', 'The CE setup was Successful.', 0);
insert into crm_state (Name, Description, ISPARENT__) values ('CE_Setup_Waiting_Operator','CE Jobs Waiting for Operator to interact with',0);	

insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Wait_Start_Time', 'The PE activation and CE setup scheduled request has been sent to SA.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Ok_Wait_End_Time', 'The PE activation and CE setup activation was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Wait_Start_Time_Failure', 'The scheduled PE activation and CE setup failure', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Wait_End_Time_Failure', 'The scheduled PE and CE deletion failure.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Sched_Request_Sent','A scheduled PE CE request has been sent to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Wait_Mod_End_Time', 'The PE activation was Successful. Wait for scheduled undo.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Periodic_Modify_Wait_End','The periodic PE CE modification is waiting for a end time.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Undo_Modify_Sent', 'A undo partial PE CE modification request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Disable_Request_Sent', 'A disable PE CE service request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Enable_Request_Sent', 'A enable PE CE service request was sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Ok_Wait_Mod_End_Time', 'The PE CE activation was Successful. Wait for scheduled undo.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Disabled', 'PE CE Service was successfully disabled', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Enable_In_Progress','The enable service activation is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Enable_Temporary_Failure','PE CE Service enable activation temporary failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Enable_Failure','PE CE Service enable activation failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Wait_End_Time', 'request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Disable_In_Progress', 'The disable service activation is being handled by Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Modify_Wait_Start_Time', 'A scheduled modify request has been sent to Service Activator.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Periodic_Modify_In_Progress','The periodic modification is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Periodic_Modify_Wait_Start','The periodic modification is waiting for a start time.',0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Wait_Start_Time', 'The CE_Setup scheduled request has been sent to SA.', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Ok_Wait_End_Time', 'The CE_Setup setup was Successful.The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Wait_End_Time', 'The request for scheduled deletion was sent', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Wait_Start_Time_Failure', 'The scheduled CE setup failure', 0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('CE_Setup_Wait_End_Time_Failure', 'The scheduled CE deletion failure.', 0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Modify_Request_Sent','A PE CE modify request has been sent to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Modify_In_Progress','The PE CE modification is being handled by to Service Activator.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Modify_Failure','The PE CE modification failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Modify_Temporary_Failure','The PE CE modification temporary failed.',0);
insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_CE_Modify_Partial','The PE CE modification succeeded partially.',0);

insert into CRM_STATE (Name, Description, ISPARENT__) values ('PE_Sched_Delete_Confirm', 'A scheduled PE delete job is waiting for confirmation.', 0);