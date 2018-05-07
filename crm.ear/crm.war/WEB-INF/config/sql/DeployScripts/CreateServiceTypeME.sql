insert into CRM_SERVICETYPE (Name, Description, ISPARENT__) values ('layer2-VPN', 'Create a new L2 corporate VPN.', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('layer2-Site', 'Add a new customer site to the VPN.', 'layer2-VPN', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('layer2-Attachment', 'Add a Site attachment to the Layer2 Site.', 'layer2-Site', 0);
insert into CRM_SERVICETYPE (Name, Description, ISPARENT__) values ('layer2-VPWS', 'Create a new L2 P2P VPWS.', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('vpws-Site', 'Add a new customer site to the VPWS.', 'layer2-VPWS', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('vpws-Attachment', 'Add a Site attachment to the VPWS Site.', 'vpws-Site', 0);
insert into CRM_SERVICETYPE (Name, Description, ISPARENT__) values ('Hidden', 'Which and whose child service should not be displayed on the top service table.', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('Site', 'Add a general customer site.', 'Hidden', 0);