BEGIN { ds_inventory_found = 0; edb_datasource_found = 0; inventory_sec_domain_found = 0; }
/<datasource jta="true" jndi-name="java:\/hpsa\/jdbc\/inventoryDB" pool-name="inventoryDB" enabled="true" use-java-context="true" use-ccm="true">/   {
  ds_inventory_found = 1;
}

/<connection-url>jdbc:edb:/ {
  edb_datasource_found = 1;
}

{ print }
/<\/datasource>/ {
   if (ds_inventory_found==1) {
       print  "                <datasource jta=\"true\" jndi-name=\"java:/crm/jdbc/crmDB\" pool-name=\"crmDB\" enabled=\"true\" use-java-context=\"true\" use-ccm=\"true\">";
       print  "                    <connection-url>";
	   
	   if (edb_datasource_found==1) {
			printf("                     jdbc:edb://%s\n",crm_db_url);
		}
		else {
			printf("                     jdbc:oracle:thin:@%s\n",crm_db_url);
		}
		
       print  "                    </connection-url>";
       print  "                    <driver>";
	   
	   if (edb_datasource_found==1) {
			print  "                        edb";
	   } else {
			print  "                        oracle";
	   }
	   
       print  "                    </driver>";
       print  "                    <pool>";
       print  "                        <min-pool-size>";
       print  "                            0";
       print  "                        </min-pool-size>";
       print  "                        <max-pool-size>";
       print  "                            5";
       print  "                        </max-pool-size>";
       print  "                        <prefill>";
       print  "                            true";
       print  "                        </prefill>";
       print  "                        <use-strict-min>";
       print  "                            false";
       print  "                        </use-strict-min>";
       print  "                        <flush-strategy>";
       print  "                            FailingConnectionOnly";
       print  "                        </flush-strategy>";
       print  "                    </pool>";
       print  "                    <security>";
       print  "                        <security-domain>";
       print  "                            CRMPortalDSEncryptDBPassword";
       print  "                        </security-domain>";
       print  "                    </security>";
       print  "                    <validation>";
       print  "                        <validate-on-match>";
       print  "                            false";
       print  "                        </validate-on-match>";
       print  "                        <background-validation>";
       print  "                            false";
       print  "                        </background-validation>";
       print  "                        <use-fast-fail>";
       print  "                            false";
       print  "                        </use-fast-fail>";
       print  "                    </validation>";
       print  "                </datasource>";
       ds_inventory_found=0;
   }
}

/<security-domain name=\"InventoryDSEncryptDBPassword\" cache-type=\"default\">/{
   inventory_sec_domain_found=1;
}

/<\/security-domain>/ {
   if (inventory_sec_domain_found==1) {
       print  "                <security-domain name=\"CRMPortalDSEncryptDBPassword\" cache-type=\"default\">";
       print  "		<authentication>";
       print  "            		    <login-module code=\"org.picketbox.datasource.security.SecureIdentityLoginModule\" flag=\"required\">";
       printf("            			<module-option name = \"userName\" value=\"%s\"/>\n",crm_user);
       printf("            			<module-option name = \"password\" value=\"%s\"/>\n",crm_password);
       print  "            			<module-option name=\"managedConnectionFactoryName\" value=\"jboss.jca:name=swe2DS,service=LocalTxCM\"/>";
       print  "			</login-module>";
       print  "		</authentication>";
       print  "                </security-domain>";
       inventory_sec_domain_found=0;
     }
}