OPTIONS (BINDSIZE=1500000, rows=100) load data
CHARACTERSET UTF8
infile  VPNMembership.dat  "var 6"
APPEND
into table crm_vpn_membership
REENABLE DISABLED_CONSTRAINTS EXCEPTIONS EXCEPT_TABLE
(
      vpnId   VARCHARC(4),
      siteAttachmentId   VARCHARC(4),
      ConnectivityType   VARCHARC(4),
      ISPARENT__   VARCHARC(4)
)
