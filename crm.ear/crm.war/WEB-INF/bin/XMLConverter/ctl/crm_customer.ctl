OPTIONS (BINDSIZE=1500000, rows=100) load data
CHARACTERSET UTF8
infile  Customer.dat  "var 6"
APPEND
into table crm_customer
REENABLE DISABLED_CONSTRAINTS EXCEPTIONS EXCEPT_TABLE
(
      CustomerId   VARCHARC(4),
      CompanyName   VARCHARC(4),
      CompanyAddress   VARCHARC(4),
      CompanyCity   VARCHARC(4),
      CompanyZipCode   VARCHARC(4),
      ContactpersonName   VARCHARC(4),
      ContactpersonSurname   VARCHARC(4),
      ContactpersonPhonenumber   VARCHARC(4),
      ContactpersonEmail   VARCHARC(4),
      Status   VARCHARC(4),
      LastUpdateTime   VARCHARC(4,32),
      CreationTime   VARCHARC(4),
      ISPARENT__   VARCHARC(4)
)
