insert into CRM_SERVICETYPE (Name, Description, ISPARENT__) values ('layer3-VPN', 'Create a new L3 corporate VPN.', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('layer3-Site', 'Add a new customer site to the VPN.', 'layer3-VPN', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('layer3-Protection', 'Add a protection attachment to the Layer3 site.', 'layer3-Site', 0);
insert into CRM_SERVICETYPE (Name, Description, ParentServType, ISPARENT__) values ('layer3-Attachment', 'Add a Site attachment to the Layer3 Site.', 'layer3-Site', 0);
