<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Modify Address Pool"
        contentType="text/html; charset=UTF-8"
        import="com.hp.ov.activator.crmportal.bean.*,com.hp.ov.activator.crmportal.action.*, java.util.HashMap,java.io.*,
		java.text.*, java.net.*,java.util.HashSet, com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.helpers.*, 
		java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, java.sql.DriverManager, java.util.ArrayList,
		com.hp.ov.activator.crmportal.common.*, org.apache.log4j.Logger, com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.inventory.SAVPN.*, javax.sql.DataSource, java.sql.Connection"
 %>


<%
    //load param parameters got here
	ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
	HashMap serviceParameters = new HashMap ();
	serviceParameters = (HashMap)request.getAttribute("serviceParameters");
	HashMap parentServiceParameters = new HashMap ();
	parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
	String attachmentid = (String)request.getAttribute("attachmentid");
	
	String customerId = (String) serviceParameters.get("customerid");
	
	int rowCounter = 0;
	
   	Connection con = null;
	DataSourceLocator dsl = new DataSourceLocator(); 
	
	com.hp.ov.activator.vpn.inventory.IPAddrPool[] pools = null;

	PreparedStatement statePstmt1 = null;
	PreparedStatement statePstmt2 = null;
	
	ResultSet resultSet1 = null;
	ResultSet resultSet2 = null;
	
	String pool1 = "";
	String pool2 = "";
	
	String ipnet1 = "";
	String ipnet2 = "";
	
	String pe1ipaddr1 = "";
	String pe2ipaddr1 = "";
	String ce1ipaddr1 = "";
	String ce2ipaddr1 = "";
	
	String pe1ipaddr2 = "";
	String pe2ipaddr2 = "";
	String ce1ipaddr2 = "";
	String ce2ipaddr2 = "";
	
	String addrfam1 = "";
	String addrfam2 = "";
	
	try
	{
		DataSource ds = dsl.getDataSource();
		if (ds != null)
		{
			con = ds.getConnection();
			
			pools = com.hp.ov.activator.vpn.inventory.IPAddrPool.findAll(con, "type='IPNet'");
						
			ArrayList<Object> availablePoolList = new ArrayList<Object>();
			
			if (pools != null) 
			{
				for (int poolCount = 0; poolCount < pools.length; poolCount++) 
				{
					String poolName = pools[poolCount].getName();
					
					if (com.hp.ov.activator.vpn.inventory.IPNet.findByPoolnameCount(con, poolName, "count__ > '0'") > 0) 
					{
						availablePoolList.add(pools[poolCount]);

					}
				}
			}
			
			if (0 != availablePoolList.size()) 
			{
				pools = (com.hp.ov.activator.vpn.inventory.IPAddrPool[]) availablePoolList.toArray(new com.hp.ov.activator.vpn.inventory.IPAddrPool[availablePoolList.size()]);

			} else 
			{
				pools = null;
			}
								 
			String query1 = "select ip.poolname, ip.ipnetaddr, ip.pe1_ipaddr, ip.ce1_ipaddr, ip.pe2_ipaddr, ip.ce2_ipaddr, af.addressfamily from v_ipnet ip, v_l3accessflow af "+
							"where ip.ipnetaddr = (select ipnet from v_l3accessflow where serviceid = ?) and ip.ipnetaddr = af.ipnet";
						 
			statePstmt1 = con.prepareStatement(query1);
			statePstmt1.setString(1, attachmentid);
			resultSet1 = statePstmt1.executeQuery();
			
			while(resultSet1.next())
			{
				pool1 = resultSet1.getString(1);
				ipnet1 = resultSet1.getString(2);
				pe1ipaddr1 = resultSet1.getString(3);
				pe2ipaddr1 = resultSet1.getString(4);
				ce1ipaddr1 = resultSet1.getString(5);
				ce2ipaddr1 = resultSet1.getString(6);
				addrfam1 = resultSet1.getString(7);
			}
			
			String query2 = "select ip.poolname, ip.ipnetaddr, ip.pe1_ipaddr, ip.ce1_ipaddr, ip.pe2_ipaddr, ip.ce2_ipaddr, af.addressfamily from v_ipnet ip, v_l3accessflow af "+
							"where ip.ipnetaddr = (select secondaryipnet from v_l3accessflow where serviceid = ?) and ip.ipnetaddr = af.secondaryipnet";
			
			statePstmt2 = con.prepareStatement(query2);
			statePstmt2.setString(1, attachmentid);
			resultSet2 = statePstmt2.executeQuery();
			
			while(resultSet2.next())
			{
				pool2 = resultSet2.getString(1);
				ipnet2 = resultSet2.getString(2);
				pe1ipaddr2 = resultSet2.getString(3);
				pe2ipaddr2 = resultSet2.getString(4);
				ce1ipaddr2 = resultSet2.getString(5);
				ce2ipaddr2 = resultSet2.getString(6);
				addrfam2 = resultSet2.getString(7);
			}
			
		}             
	}
	catch (SQLException sqle)
	{ %>
		<B><bean:message key="err.addrpool.inventory" /></B>: <%= sqle.getMessage () %>.
		<%  return;
	}
	catch (Exception e) 
	{ %>
		<B><bean:message key="err.addrpool.inventory" /></B>: <%= e.getMessage () %>.
		<%  return;
	}
	finally
	{
		if (con != null)
		{
			try{ resultSet1.close(); }catch(Exception ignoreme){}
			try{ statePstmt1.close(); }catch(Exception ignoreme){}
			try{ resultSet2.close(); }catch(Exception ignoreme){}
			try{ statePstmt2.close(); }catch(Exception ignoreme){}
			
			try 
			{
				con.close();
			}
			catch (Exception rollbackex)
			{
				// Ignore
			}
		}
	}
%>

	<tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.addressfamily" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>"><%=addrfam1%></td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>
    <% rowCounter++; %>
	
	<input type="hidden" name="AddressFamily" value="<%= addrfam1 %>">
	
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.addr.pool" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_AddressPool">
  <%    if (pools != null) {
          if (pool1 == null) {
			pool1 = pools[0].getPrimaryKey();
          }
		  
          com.hp.ov.activator.vpn.inventory.IPAddrPool tempPool = null;
		  
          for (int i=0; pools != null && i < pools.length; i++) {
         	if(pools[i].getAddressfamily().equals(addrfam1)){
         		tempPool=pools[i];%>
         		<option<%= tempPool.getName().equals (pool1) ? " selected": "" %> value="<%=  tempPool.getName() %>"><%= tempPool.getName() %></option>
         <%}

           }
        }
  %>
        </select>

      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>
    <% rowCounter++; %>
	
	<tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.secondary.addr.pool" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_SecondaryAddressPool">
  <%    if (pools != null) 
		{		  		  
          if ((pool2 == null) || ("-none-".equals(pool2)))
		  {
			%> <option value="-none-" selected >-none-</option> <%
			pool2 = "-none-";
		  }
		  else
		  {
			%> <option value="-none-" >-none-</option> <%
		  }
          		  
          com.hp.ov.activator.vpn.inventory.IPAddrPool tempPool = null;
		  
          for (int i=0; pools != null && i < pools.length; i++) 
		  {
         	if(pools[i].getAddressfamily().equals(addrfam1))
			{
         		tempPool=pools[i];%>
         		<option<%= tempPool.getName().equals (pool2) ? " selected": "" %> value="<%=  tempPool.getName() %>"><%= tempPool.getName() %></option>
         <%}

           }
        }
  %>
        </select>

      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>



