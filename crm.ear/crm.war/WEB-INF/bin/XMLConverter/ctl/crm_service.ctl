OPTIONS (BINDSIZE=1500000, rows=100) load data
CHARACTERSET UTF8
infile  Service.dat  "var 6"
APPEND
into table crm_service
REENABLE DISABLED_CONSTRAINTS EXCEPTIONS EXCEPT_TABLE
(
      ServiceId   VARCHARC(4),
      PresName   VARCHARC(4),
      State   VARCHARC(4),
      SubmitDate   VARCHARC(4),
      ModifyDate   VARCHARC(4),
      Type   VARCHARC(4),
      CustomerId   VARCHARC(4),
      ParentServiceId   VARCHARC(4),
      EndTime   VARCHARC(4),
      NextOperationTime   VARCHARC(4,32),
      LastUpdateTime   VARCHARC(4,32),
      ISPARENT__   VARCHARC(4)
)
