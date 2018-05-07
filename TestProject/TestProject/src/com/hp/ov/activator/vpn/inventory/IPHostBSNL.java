package com.hp.ov.activator.vpn.inventory;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.hp.ov.activator.vpn.IPAddressHelper.IPAddressHelper;

public class IPHostBSNL extends IPHost {

  private static final String IP_ADDRESS_TYPE = "IPHOST";
  private String ipHostAddr;

  @Override
  public void generateAndStore(Connection con) throws Exception {

    IPAddressHelper ipAddressHelperObj = new IPAddressHelper(AddressFamily, StartAddress, ParentIPNetAddr,
        NumberOfEntries, PoolName, IP_ADDRESS_TYPE);

    List<Map<String, String>> ipBeanList = ipAddressHelperObj.generateIPAddresses();
    for (int i = 0; i < ipBeanList.size(); i++) {
      IPHost ipHostBean = new IPHost();
      Map<String, String> ipHostMap = ipBeanList.get(i);

      ipHostBean.setIp(ipHostMap.get("Poolname") + "@" + ipHostMap.get("IP"));
      ipHostBean.setIpstr(ipHostMap.get("Ipstr"));
      ipHostBean.setPoolname(ipHostMap.get("Poolname"));

      if (ipHostAddr == null) {
        ipHostAddr = ipHostBean.getIp();
      }
      ipHostBean.store(con);
      con.commit();
    }
  }

  @Override
  public String generateAndStoreIPHost(Connection con) throws Exception {
    generateAndStore(con);
    return ipHostAddr;
  }

}
