package com.hp.ov.activator.vpn.inventory;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.hp.ov.activator.vpn.IPAddressHelper.IPAddressHelper;

public class IPNetBSNL extends IPNet {

  private static final String IP_ADDRESS_TYPE = "IPNET";
  private String ipNetAddr;

  @Override
  public void generateAndStore(Connection con) throws Exception {

    IPAddressHelper ipAddressHelperObj = new IPAddressHelper(AddressFamily, StartAddress, ParentIPNetAddr,
        NumberOfEntries, PoolName, IP_ADDRESS_TYPE);

    List<Map<String, String>> ipBeanList = ipAddressHelperObj.generateIPAddresses();
    for (int i = 0; i < ipBeanList.size(); i++) {
      IPNet ipNetBean = new IPNet();
      Map<String, String> ipNetMap = ipBeanList.get(i);

      ipNetBean.setIpnetaddr(ipNetMap.get("Poolname") + "@" + ipNetMap.get("IPNetAddr"));
      ipNetBean.setPe1_ipaddr(ipNetMap.get("Ce1_ipaddr"));
      ipNetBean.setCe1_ipaddr(ipNetMap.get("Pe1_ipaddr"));
      ipNetBean.setPe2_ipaddr(ipNetMap.get("Pe2_ipaddr"));
      ipNetBean.setCe2_ipaddr(ipNetMap.get("Ce2_ipaddr"));
      ipNetBean.setNetmask(ipNetMap.get("Netmask"));
      ipNetBean.setHostmask(ipNetMap.get("Hostmask"));
      ipNetBean.setIpnetaddrstr(ipNetMap.get("Ipnetaddrstr"));
      ipNetBean.setPoolname(ipNetMap.get("Poolname"));

      if (ipNetAddr == null) {
        ipNetAddr = ipNetBean.getIpnetaddr();
      }
      ipNetBean.store(con);
      con.commit();
    }
  }

  @Override
  public String generateAndStoreIPNet(Connection con) throws Exception {
    generateAndStore(con);
    return ipNetAddr;
  }
}
