package com.hp.ov.activator.inventory.SAVPN;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import javax.servlet.http.HttpServletRequest;


public class IPNetForm extends ActionForm implements IPNetConstants {
    public String IPNetAddr = null;
    public String IPNetAddr___hide = null;
    public String PE1_IPAddr = null;
    public String PE1_IPAddr___hide = null;
    public String CE1_IPAddr = null;
    public String CE1_IPAddr___hide = null;
    public String PE2_IPAddr = null;
    public String PE2_IPAddr___hide = null;
    public String CE2_IPAddr = null;
    public String CE2_IPAddr___hide = null;
    public String Netmask = null;
    public String Netmask___hide = null;
    public String Hostmask = null;
    public String Hostmask___hide = null;
    public String PoolName = null;
    public String PoolName___hide = null;
    public String IPNetAddrStr = null;
    public String IPNetAddrStr___hide = null;
    public String ParentIPNetAddr = null;
    public String ParentIPNetAddr___hide = null;
    public String StartAddress = null;
    public String StartAddress___hide = null;
    public String NumberOfEntries = null;
    public String NumberOfEntries___hide = null;
    public String AddressFamily = null;
    public String AddressFamily___hide = null;

    public String getIpnetaddr() {
        return this.IPNetAddr;
    }

    public void setIpnetaddr(String IPNetAddr) {
        this.IPNetAddr = IPNetAddr;
    }

    public String getIpnetaddr___hide() {
        return this.IPNetAddr___hide;
    }

    public void setIpnetaddr___hide(String IPNetAddr___hide) {
        this.IPNetAddr___hide = IPNetAddr___hide;
    }

    public String getPe1_ipaddr() {
        return this.PE1_IPAddr;
    }

    public void setPe1_ipaddr(String PE1_IPAddr) {
        this.PE1_IPAddr = PE1_IPAddr;
    }

    public String getPe1_ipaddr___hide() {
        return this.PE1_IPAddr___hide;
    }

    public void setPe1_ipaddr___hide(String PE1_IPAddr___hide) {
        this.PE1_IPAddr___hide = PE1_IPAddr___hide;
    }

    public String getCe1_ipaddr() {
        return this.CE1_IPAddr;
    }

    public void setCe1_ipaddr(String CE1_IPAddr) {
        this.CE1_IPAddr = CE1_IPAddr;
    }

    public String getCe1_ipaddr___hide() {
        return this.CE1_IPAddr___hide;
    }

    public void setCe1_ipaddr___hide(String CE1_IPAddr___hide) {
        this.CE1_IPAddr___hide = CE1_IPAddr___hide;
    }

    public String getPe2_ipaddr() {
        return this.PE2_IPAddr;
    }

    public void setPe2_ipaddr(String PE2_IPAddr) {
        this.PE2_IPAddr = PE2_IPAddr;
    }

    public String getPe2_ipaddr___hide() {
        return this.PE2_IPAddr___hide;
    }

    public void setPe2_ipaddr___hide(String PE2_IPAddr___hide) {
        this.PE2_IPAddr___hide = PE2_IPAddr___hide;
    }

    public String getCe2_ipaddr() {
        return this.CE2_IPAddr;
    }

    public void setCe2_ipaddr(String CE2_IPAddr) {
        this.CE2_IPAddr = CE2_IPAddr;
    }

    public String getCe2_ipaddr___hide() {
        return this.CE2_IPAddr___hide;
    }

    public void setCe2_ipaddr___hide(String CE2_IPAddr___hide) {
        this.CE2_IPAddr___hide = CE2_IPAddr___hide;
    }

    public String getNetmask() {
        return this.Netmask;
    }

    public void setNetmask(String Netmask) {
        this.Netmask = Netmask;
    }

    public String getNetmask___hide() {
        return this.Netmask___hide;
    }

    public void setNetmask___hide(String Netmask___hide) {
        this.Netmask___hide = Netmask___hide;
    }

    public String getHostmask() {
        return this.Hostmask;
    }

    public void setHostmask(String Hostmask) {
        this.Hostmask = Hostmask;
    }

    public String getHostmask___hide() {
        return this.Hostmask___hide;
    }

    public void setHostmask___hide(String Hostmask___hide) {
        this.Hostmask___hide = Hostmask___hide;
    }

    public String getPoolname() {
        return this.PoolName;
    }

    public void setPoolname(String PoolName) {
        this.PoolName = PoolName;
    }

    public String getPoolname___hide() {
        return this.PoolName___hide;
    }

    public void setPoolname___hide(String PoolName___hide) {
        this.PoolName___hide = PoolName___hide;
    }

    public String getIpnetaddrstr() {
        return this.IPNetAddrStr;
    }

    public void setIpnetaddrstr(String IPNetAddrStr) {
        this.IPNetAddrStr = IPNetAddrStr;
    }

    public String getIpnetaddrstr___hide() {
        return this.IPNetAddrStr___hide;
    }

    public void setIpnetaddrstr___hide(String IPNetAddrStr___hide) {
        this.IPNetAddrStr___hide = IPNetAddrStr___hide;
    }

    public String getParentipnetaddr() {
        return this.ParentIPNetAddr;
    }

    public void setParentipnetaddr(String ParentIPNetAddr) {
        this.ParentIPNetAddr = ParentIPNetAddr;
    }

    public String getParentipnetaddr___hide() {
        return this.ParentIPNetAddr___hide;
    }

    public void setParentipnetaddr___hide(String ParentIPNetAddr___hide) {
        this.ParentIPNetAddr___hide = ParentIPNetAddr___hide;
    }

    public String getStartaddress() {
        return this.StartAddress;
    }

    public void setStartaddress(String StartAddress) {
        this.StartAddress = StartAddress;
    }

    public String getStartaddress___hide() {
        return this.StartAddress___hide;
    }

    public void setStartaddress___hide(String StartAddress___hide) {
        this.StartAddress___hide = StartAddress___hide;
    }

    public String getNumberofentries() {
        return this.NumberOfEntries;
    }

    public void setNumberofentries(String NumberOfEntries) {
        this.NumberOfEntries = NumberOfEntries;
    }

    public String getNumberofentries___hide() {
        return this.NumberOfEntries___hide;
    }

    public void setNumberofentries___hide(String NumberOfEntries___hide) {
        this.NumberOfEntries___hide = NumberOfEntries___hide;
    }

    public String getAddressfamily() {
        return this.AddressFamily;
    }

    public void setAddressfamily(String AddressFamily) {
        this.AddressFamily = AddressFamily;
    }

    public String getAddressfamily___hide() {
        return this.AddressFamily___hide;
    }

    public void setAddressfamily___hide(String AddressFamily___hide) {
        this.AddressFamily___hide = AddressFamily___hide;
    }

    public void reset(ActionMapping mapping, HttpServletRequest request) {
        super.reset(mapping, request);
        this.IPNetAddr = null;
        this.IPNetAddr___hide = null;
        this.PE1_IPAddr = null;
        this.PE1_IPAddr___hide = null;
        this.CE1_IPAddr = null;
        this.CE1_IPAddr___hide = null;
        this.PE2_IPAddr = null;
        this.PE2_IPAddr___hide = null;
        this.CE2_IPAddr = null;
        this.CE2_IPAddr___hide = null;
        this.Netmask = null;
        this.Netmask___hide = null;
        this.Hostmask = null;
        this.Hostmask___hide = null;
        this.PoolName = null;
        this.PoolName___hide = null;
        this.IPNetAddrStr = null;
        this.IPNetAddrStr___hide = null;
        this.ParentIPNetAddr = null;
        this.ParentIPNetAddr___hide = null;
        this.StartAddress = null;
        this.StartAddress___hide = null;
        this.NumberOfEntries = null;
        this.NumberOfEntries___hide = null;
        this.AddressFamily = null;
        this.AddressFamily___hide = null;
    }

    public ActionErrors validate(ActionMapping mapping,
        HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();

        if ((IPNetAddr != null) && (IPNetAddr.getBytes().length > 200)) {
            errors.add(IPNetConstants.IPNETADDR_FIELD,
                new ActionMessage(IPNetConstants.IPNETADDR____STRINGLENGTHERROR));
        }

        if ((IPNetAddr == null) || IPNetAddr.equals("")) {
            errors.add(IPNetConstants.IPNETADDR_FIELD,
                new ActionMessage(IPNetConstants.IPNETADDR_EMPTY));
        }

        if ((PE1_IPAddr != null) && (PE1_IPAddr.getBytes().length > 200)) {
            errors.add(IPNetConstants.PE1_IPADDR_FIELD,
                new ActionMessage(
                    IPNetConstants.PE1_IPADDR____STRINGLENGTHERROR));
        }

        if ((PE1_IPAddr == null) || PE1_IPAddr.equals("")) {
            errors.add(IPNetConstants.PE1_IPADDR_FIELD,
                new ActionMessage(IPNetConstants.PE1_IPADDR_EMPTY));
        }

        if ((CE1_IPAddr != null) && (CE1_IPAddr.getBytes().length > 200)) {
            errors.add(IPNetConstants.CE1_IPADDR_FIELD,
                new ActionMessage(
                    IPNetConstants.CE1_IPADDR____STRINGLENGTHERROR));
        }

        if ((CE1_IPAddr == null) || CE1_IPAddr.equals("")) {
            errors.add(IPNetConstants.CE1_IPADDR_FIELD,
                new ActionMessage(IPNetConstants.CE1_IPADDR_EMPTY));
        }

        if ((PE2_IPAddr != null) && (PE2_IPAddr.getBytes().length > 200)) {
            errors.add(IPNetConstants.PE2_IPADDR_FIELD,
                new ActionMessage(
                    IPNetConstants.PE2_IPADDR____STRINGLENGTHERROR));
        }

        if ((CE2_IPAddr != null) && (CE2_IPAddr.getBytes().length > 200)) {
            errors.add(IPNetConstants.CE2_IPADDR_FIELD,
                new ActionMessage(
                    IPNetConstants.CE2_IPADDR____STRINGLENGTHERROR));
        }

        if ((Netmask != null) && (Netmask.getBytes().length > 200)) {
            errors.add(IPNetConstants.NETMASK_FIELD,
                new ActionMessage(IPNetConstants.NETMASK____STRINGLENGTHERROR));
        }

        if ((Netmask == null) || Netmask.equals("")) {
            errors.add(IPNetConstants.NETMASK_FIELD,
                new ActionMessage(IPNetConstants.NETMASK_EMPTY));
        }

        if ((Hostmask != null) && (Hostmask.getBytes().length > 200)) {
            errors.add(IPNetConstants.HOSTMASK_FIELD,
                new ActionMessage(IPNetConstants.HOSTMASK____STRINGLENGTHERROR));
        }

        if ((Hostmask == null) || Hostmask.equals("")) {
            errors.add(IPNetConstants.HOSTMASK_FIELD,
                new ActionMessage(IPNetConstants.HOSTMASK_EMPTY));
        }

        if ((PoolName != null) && (PoolName.getBytes().length > 200)) {
            errors.add(IPNetConstants.POOLNAME_FIELD,
                new ActionMessage(IPNetConstants.POOLNAME____STRINGLENGTHERROR));
        }

        if ((PoolName == null) || PoolName.equals("")) {
            errors.add(IPNetConstants.POOLNAME_FIELD,
                new ActionMessage(IPNetConstants.POOLNAME_EMPTY));
        }

        if ((IPNetAddrStr != null) && (IPNetAddrStr.getBytes().length > 200)) {
            errors.add(IPNetConstants.IPNETADDRSTR_FIELD,
                new ActionMessage(
                    IPNetConstants.IPNETADDRSTR____STRINGLENGTHERROR));
        }

        if ((ParentIPNetAddr != null) &&
                (ParentIPNetAddr.getBytes().length > 200)) {
            errors.add(IPNetConstants.PARENTIPNETADDR_FIELD,
                new ActionMessage(
                    IPNetConstants.PARENTIPNETADDR____STRINGLENGTHERROR));
        }

        if ((StartAddress != null) && (StartAddress.getBytes().length > 200)) {
            errors.add(IPNetConstants.STARTADDRESS_FIELD,
                new ActionMessage(
                    IPNetConstants.STARTADDRESS____STRINGLENGTHERROR));
        }

        if ((NumberOfEntries != null) &&
                (NumberOfEntries.getBytes().length > 200)) {
            errors.add(IPNetConstants.NUMBEROFENTRIES_FIELD,
                new ActionMessage(
                    IPNetConstants.NUMBEROFENTRIES____STRINGLENGTHERROR));
        }

        if ((AddressFamily != null) && (AddressFamily.getBytes().length > 200)) {
            errors.add(IPNetConstants.ADDRESSFAMILY_FIELD,
                new ActionMessage(
                    IPNetConstants.ADDRESSFAMILY____STRINGLENGTHERROR));
        }

        //Validation of the form elements
        String datasource = request.getParameter(IPNetConstants.DATASOURCE);
        javax.sql.DataSource dbp = (javax.sql.DataSource) com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet.getDatasource(datasource);
        java.sql.Connection con = null;

        try {
            String inputParentIpNetAddr = request.getParameter(
                    "parentipnetaddr");
            String inputIpNetAddr = request.getParameter("startaddress");
            String countString = request.getParameter("numberofentries");
            String parentPoolname = request.getParameter("poolname");
            com.hp.ov.activator.vpn.inventory.IPAddrPool parentBean = null;
            con = (java.sql.Connection) dbp.getConnection();

            String addressFamily = request.getParameter("addressfamily");
            
            //validation for edit screen
            String editvalue = request.getParameter("EditValue");  

            if (con != null) {
                con.close();
            }
            
            System.out.println("inputIpNetAddr :: "+ inputIpNetAddr);
            System.out.println("inputParentIpNetAddr :: "+inputParentIpNetAddr);
            System.out.println("countString :: "+countString);
            // First round of validation:
            // Check if all parameters are given
            
            if(editvalue != null && editvalue.equalsIgnoreCase("1")) {
            	System.out.println("************* Inside Edit Value *************");
            	return null;
            }
            else {
            	if (inputIpNetAddr.equals("") || inputParentIpNetAddr.equals("") ||
                        countString.equals("")) {
                    errors.add(IPNetConstants.STARTADDRESS_FIELD,
                        new ActionMessage("global.error.allparameters.mandatory"));

                    return errors;
                }

                if (parentPoolname.equals("")) {
                    errors.add(IPNetConstants.POOLNAME_FIELD,
                        new ActionMessage("poolname.error.notnull"));

                    return errors;
                }

                if (addressFamily.equals("")) {
                    errors.add(IPNetConstants.ADDRESSFAMILY_FIELD,
                        new ActionMessage("addressfamily.error.notnull"));

                    return errors;
                }

                // Check if noEntries is of integer type and that some number of instances must be created:
                //
                long noEntries = 0;

                try {
                    noEntries = Long.parseLong(countString);
                } catch (Exception e) {
                    errors.add(IPNetConstants.NUMBEROFENTRIES_FIELD,
                        new ActionMessage("numberofentries.error.notinteger"));

                    return errors;
                }

                if (noEntries < 1) {
                    errors.add(IPNetConstants.NUMBEROFENTRIES_FIELD,
                        new ActionMessage("numberofentries.error.lessthan1"));

                    return errors;
                }

                // Check CIDR format of ipNetAddr; i.e. that "/" exists:
                java.util.StringTokenizer t = new java.util.StringTokenizer(inputIpNetAddr,
                        "/");

                if (t.countTokens() != 2) {
                    errors.add(IPNetConstants.STARTADDRESS_FIELD,
                        new ActionMessage("startaddress.error.format"));

                    return errors;
                }

                String ipNetAddr = t.nextToken();
                String maskNumberString = t.nextToken();

                // Check CIDR format of parent ipNetAddr, i.e. that "/" exists:
                t = new java.util.StringTokenizer(inputParentIpNetAddr, "/");

                if (t.countTokens() != 2) {
                    errors.add(IPNetConstants.PARENTIPNETADDR_FIELD,
                        new ActionMessage("parentipnetaddr.error.format"));

                    return errors;
                }

                String parentIpNetAddr = t.nextToken();
                String parentMaskString = t.nextToken();

                //Check masks and ip address formats:
                int maskNumber = 0;

                try {
                    maskNumber = Integer.parseInt(maskNumberString);
                } catch (Exception e) {
                    errors.add(IPNetConstants.STARTADDRESS_FIELD,
                        new ActionMessage("ipnetaddrmask.error.format"));

                    return errors;
                }

                if (addressFamily.equals("IPv4")) {
                    if ((maskNumber > 31) || (maskNumber < 2)) {
                        errors.add(IPNetConstants.STARTADDRESS_FIELD,
                            new ActionMessage("ipnetaddripv4mask.error.range"));

                        return errors;
                    }

                    if (!sun.net.util.IPAddressUtil.isIPv4LiteralAddress(ipNetAddr)) {
                        errors.add(IPNetConstants.STARTADDRESS_FIELD,
                            new ActionMessage("startaddress.error.ipv4format"));

                        return errors;
                    }

                    // Now check the parent ip address (xx.xx...)
                    if (!sun.net.util.IPAddressUtil.isIPv4LiteralAddress(
                                parentIpNetAddr)) {
                        errors.add(IPNetConstants.PARENTIPNETADDR_FIELD,
                            new ActionMessage("parentipnetaddr.error.ipv4format"));

                        return errors;
                    }
                }

                if (addressFamily.equals("IPv6")) {
                    if ((maskNumber > 127) || (maskNumber < 2)) {
                        errors.add(IPNetConstants.STARTADDRESS_FIELD,
                            new ActionMessage("ipnetaddripv6mask.error.range"));

                        return errors;
                    }

                    if (!sun.net.util.IPAddressUtil.isIPv6LiteralAddress(ipNetAddr)) {
                        errors.add(IPNetConstants.STARTADDRESS_FIELD,
                            new ActionMessage("startaddress.error.ipv6format"));

                        return errors;
                    }

                    // Now check the parent ip address (xx:xx...)
                    if (!sun.net.util.IPAddressUtil.isIPv6LiteralAddress(
                                parentIpNetAddr)) {
                        errors.add(IPNetConstants.PARENTIPNETADDR_FIELD,
                            new ActionMessage("parentipnetaddr.error.ipv6format"));

                        return errors;
                    }
                }

                //Check parent ipNetAddr mask is an integer and the value is in the range
                int parentMaskNumber = 0;

                try {
                    parentMaskNumber = Integer.parseInt(parentMaskString);
                } catch (Exception e) {
                    errors.add(IPNetConstants.PARENTIPNETADDR_FIELD,
                        new ActionMessage("parentipnetaddrmask.error.format"));

                    return errors;
                }

                if (addressFamily.equals("IPv4")) {
                    if ((parentMaskNumber > 30) || (parentMaskNumber < 2)) {
                        errors.add(IPNetConstants.PARENTIPNETADDR_FIELD,
                            new ActionMessage("parentipnetaddripv4mask.error.range"));

                        return errors;
                    }
                }

                if (addressFamily.equals("IPv6")) {
                    if ((parentMaskNumber > 126) || (parentMaskNumber < 2)) {
                        errors.add(IPNetConstants.PARENTIPNETADDR_FIELD,
                            new ActionMessage("parentipnetaddripv6mask.error.range"));

                        return errors;
                    }
                }

                /* The IPNet entries must be contained by the parent net. Therefore, the parent mask
                     must be shorter or equal to the ipnet mask (equal allows a single IPNet enty in pool)
                     Shorter means less number of bits in netmask, means a bigger span of sub-prefixes*/
                if (parentMaskNumber > maskNumber) {
                    errors.add(IPNetConstants.STARTADDRESS_FIELD,
                        new ActionMessage("global.masks.error.range"));

                    return errors;
                }
            }
        } catch (Exception e) {
            errors.add(IPNetConstants.STARTADDRESS_FIELD,
                new ActionMessage("global.unkown.exception"));

            return errors;
        }

        return errors;
    }
}