OPTIONS (BINDSIZE=1500000, rows=100) load data
CHARACTERSET UTF8
infile  ServiceParameter.dat  "var 6"
APPEND
into table crm_serviceparam
REENABLE DISABLED_CONSTRAINTS EXCEPTIONS EXCEPT_TABLE
(
      ServiceId   VARCHARC(4),
      Attribute   VARCHARC(4),
      Value   VARCHARC(4),
      ISPARENT__   VARCHARC(4)
)
