import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.hp.ov.activator.mwfm.WFAuthenticator;
import com.hp.ov.activator.mwfm.WFManager;
import com.hp.ov.activator.mwfm.component.WFConfigException;
import com.hp.ov.activator.mwfm.component.WFConnectivityException;
import com.hp.ov.activator.mwfm.component.WFDBException;
import com.hp.ov.activator.mwfm.component.WFInvalidAttributeTypeException;
import com.hp.ov.activator.mwfm.component.WFJobNotStartedException;
import com.hp.ov.activator.mwfm.component.WFLockedException;
import com.hp.ov.activator.mwfm.component.WFMaxWorkListLengthException;
import com.hp.ov.activator.mwfm.component.WFNoSuchAttributeException;
import com.hp.ov.activator.mwfm.component.WFNotAuthorizedException;
import com.hp.ov.activator.mwfm.component.WFOfflineException;
import com.hp.ov.activator.mwfm.component.WFShutdownInProgressException;
import com.hp.ov.activator.mwfm.component.WFSuspendedException;
import com.hp.ov.activator.mwfm.component.WFUniqueWorkflowException;
import com.hp.ov.activator.mwfm.component.WFWorkflowException;

public class DeleteChannelization {
	private HashMap<String, String> neMap = new HashMap<String, String>();
	private String neId;
	private String interfaceName;
	private String routerName;
	private String controllerName;
	private String isASR;
	private String vendor;
	private String elementtype;
	private String numberOfSlots;
	private String timeslots;

	public String getInterfaceName() {
		return interfaceName;
	}

	public void setInterfaceName(String interfaceName) {
		this.interfaceName = interfaceName;
	}

	public String getRouterName() {
		return routerName;
	}

	public void setRouterName(String routerName) {
		this.routerName = routerName;
	}

	public DeleteChannelization() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String agrs[]) {

		DeleteChannelization main1 = new DeleteChannelization();
		System.out.println("TestChannelization");

		// main1.interfaceName = "ds-4/2/0:3:1";
		// main1.interfaceName = "e1-4/2/0:3";
		// main1.interfaceName = "ds-1/0/0:3";
		// main1.interfaceName = "Serial0/5/1/0/1/1/2/1:0";
		// main1.routerName = "JuniperProd";
		// main1.routerName = "CiscoASR";
		// main1.interfaceName = "Serial4/1/17:0";
		main1.interfaceName = "Serial4/2/0/2:0";
		main1.routerName = "HuaweiTest";
		main1.process();

	}

	public boolean process() {
		boolean flag = false;
		WFAuthenticator wfauth;
		try {
			wfauth = (WFAuthenticator) Naming.lookup("//172.30.8.136:2000/wfm");
			WFManager wfm = (WFManager) wfauth.login("hpesa", "hpesa00");
			HashMap map = getMap();
			String name = "CRModel_ModifyChannel";
			System.out.println("DeleteChannel started ");
			HashMap output = wfm.startAndWaitForJob(name, map);

			System.out.println("Start ModifyChannel workflow...");
			long l2 = ((Long) output.get("return_code")).longValue();

			if (output != null) {
				Long errorCode = (Long) output.get("activation_major_code");
				if (errorCode != null && errorCode.toString().equals("0")) {
					System.out.println(new Date() + " " + neId + " Success");
					flag = true;
				} else {
					System.out.println(new Date() + " " + neId + " Fail");
				}
			}
			printMap(output);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFNotAuthorizedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFMaxWorkListLengthException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFWorkflowException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFConnectivityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFDBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFJobNotStartedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFInvalidAttributeTypeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFSuspendedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFLockedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFUniqueWorkflowException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFShutdownInProgressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFOfflineException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFNoSuchAttributeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WFConfigException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NotBoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (flag == true) {
			deleteTPs(interfaceName, routerName);
		}
		return flag;
	}

	private void deleteTPs(String interfaceName2, String routerName2) {
		// TODO Auto-generated method stub
		String query = "delete from cr_terminationpoint where name = ? "
				+ "and ne_id in (select networkelementid from cr_networkelement where name = ?)";

		// TODO Auto-generated method stub
		// TODO Auto-generated method stub

		PreparedStatement statePstmt = null;
		int rows = 0;
		Connection con = null;
		int rs;
		// step1 load the driver class
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// step2 create the connection object
			con = DriverManager.getConnection(
					"jdbc:oracle:thin:@172.30.8.137:1521:tsadb", "hpesa",
					"hpesa123");

			statePstmt = con.prepareStatement(query);
			statePstmt.setString(1, interfaceName);
			statePstmt.setString(2, routerName);
			// statePstmt.setString(2, "GigabitEthernet0/0/0");
			rs = statePstmt.executeUpdate();
			if (rs == 1) {
				System.out.println("interface deleted successfully ");
			}
		} catch (Exception e) {
			System.out.println("Exception while getting free vlan ids ");
			e.printStackTrace();
		} finally {
			try {

				statePstmt.close();
				con.close();
			} catch (Exception e) {
			}
		}

	}

	private void printMap(HashMap output) {
		// TODO Auto-generated method stub
		System.out.println(output);
	}

	private HashMap getMap() {

		populateFields(interfaceName, routerName);

		HashMap map = new HashMap();
		map.put("name", interfaceName);
		map.put("controller_name", controllerName);
		map.put("ne_id", neId);
		map.put("timeslots", timeslots);
		map.put("slots_number", this.numberOfSlots);
		boolean sonet = false;
		if (controllerName.startsWith("SONET")) {
			sonet = true;
		}
		map.put("sonet", Boolean.toString(sonet));
		if (numberOfSlots.equals("32")) {
			map.put("unframed", "true");
		} else {
			map.put("unframed", "false");
		}
		String au4 = "";
		String tug3 = "";
		String tug2 = "";

		String fpc = "";
		String pic = "";
		String e1_number = "";
		Matcher localMatcher1;
		String channel_group_number = "";
		if (sonet) {
			Object matcherExpression = "";

			if (isASR.equals("true")) {
				matcherExpression = Pattern
						.compile("Serial\\d+/\\d+/\\d+/\\d+/(\\d+)/(\\d+)/(\\d+)/(\\d+):(\\d+)");
			} else {
				matcherExpression = Pattern
						.compile("Serial\\d+/\\d+/\\d+\\.(\\d+)/(\\d+)/(\\d+)/(\\d+):(\\d+)");
			}

			localMatcher1 = ((Pattern) matcherExpression)
					.matcher(interfaceName);
			if (localMatcher1.matches()) {
				au4 = localMatcher1.group(1);
				tug3 = localMatcher1.group(2);
				tug2 = localMatcher1.group(3);
				e1_number = localMatcher1.group(4);
				channel_group_number = localMatcher1.group(5);
			} else {
				System.out.println("Illegal interface name " + interfaceName);
			}

		} else if (vendor.equals("Huawei") || vendor.equals("Cisco")) {
			Pattern matcherExpression = Pattern
					.compile("Serial(\\d+)/(\\d+)/(\\d+)/(\\d+):(\\d+)");
			localMatcher1 = ((Pattern) matcherExpression)
					.matcher(interfaceName);
			if (localMatcher1.matches()) {
				fpc = localMatcher1.group(1);
				pic = localMatcher1.group(2);
				e1_number = localMatcher1.group(4);
				channel_group_number = localMatcher1.group(5);
				channel_group_number = channel_group_number == null ? "0"
						: channel_group_number;
			} else {
				matcherExpression = Pattern
						.compile("Serial(\\d+)/(\\d+)/(\\d+):(\\d+)");
				localMatcher1 = ((Pattern) matcherExpression)
						.matcher(interfaceName);

				if (localMatcher1.matches()) {
					fpc = localMatcher1.group(1);
					pic = localMatcher1.group(2);
					e1_number = localMatcher1.group(3);
					channel_group_number = localMatcher1.group(4);
					channel_group_number = channel_group_number == null ? "0"
							: channel_group_number;
				} else {
					System.out
							.println("Illegal InterfaceName " + interfaceName);
				}
			}
		} else if (vendor.equals("Juniper")) {
			Pattern matcherExpression = Pattern
					.compile("ds-(\\d+)/(\\d+)/(\\d+):(\\d+):(\\d+)");
			localMatcher1 = ((Pattern) matcherExpression)
					.matcher(interfaceName);
			if (localMatcher1.matches()) {
				fpc = localMatcher1.group(1);
				pic = localMatcher1.group(2);

				e1_number = localMatcher1.group(4);

				channel_group_number = localMatcher1.group(5);
				channel_group_number = channel_group_number == null ? "0"
						: channel_group_number;
			} else {
				matcherExpression = Pattern
						.compile("ds-(\\d+)/(\\d+)/(\\d+):(\\d+)");
				localMatcher1 = ((Pattern) matcherExpression)
						.matcher(interfaceName);
				if (localMatcher1.matches()) {
					fpc = localMatcher1.group(1);
					pic = localMatcher1.group(2);

					e1_number = localMatcher1.group(3);

					channel_group_number = localMatcher1.group(4);
					channel_group_number = channel_group_number == null ? "0"
							: channel_group_number;

				} else {
					matcherExpression = Pattern
							.compile("e1-(\\d+)/(\\d+)/(\\d+):(\\d+)");
					localMatcher1 = ((Pattern) matcherExpression)
							.matcher(interfaceName);
					if (localMatcher1.matches()) {
						fpc = localMatcher1.group(1);
						pic = localMatcher1.group(2);

						e1_number = localMatcher1.group(4);

						channel_group_number = "0";
					} else {
						matcherExpression = Pattern
								.compile("e1-(\\d+)/(\\d+)/(\\d+)");
						localMatcher1 = ((Pattern) matcherExpression)
								.matcher(interfaceName);
						if (localMatcher1.matches()) {
							fpc = localMatcher1.group(1);
							pic = localMatcher1.group(2);

							e1_number = "0";

							channel_group_number = "0";
						}
					}
				}
			}
		}

		System.out.println(" fpc# " + fpc + " pic# " + pic + " e1_number "
				+ e1_number + "au_4 " + au4 + " tug_3#" + tug3 + " tug2#"
				+ tug2 + " e1#" + e1_number + " channel group number# "
				+ channel_group_number);
		int k = interfaceName.indexOf(':');
		int m = 0;
		map.put("channel_group_count", Integer.toString(10));
		map.put("channel_group", channel_group_number);
		map.put("fpc", fpc);
		map.put("pic", pic);
		map.put("e1_number", e1_number);
		map.put("au_4", au4);
		map.put("tug_3", tug3);
		map.put("tug_2", tug2);
		map.put("e1", e1_number);
		map.put("mode", "DeleteChannel");
		map.put("clientip", "");
		map.put("customer", "");
		map.put("date", new java.util.Date().toString());
		System.out.println("Input map is " + map);
		return map;

	}

	private void populateFields(String interfaceName, String routerName) {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub

		String query = "select ec.name, ec.ne_id,ne.vendor,ne.elementtype,inf.NUMBEROFSLOTS,inf.timeslots from cr_terminationpoint tp "
				+ "inner join cr_elementcomponent ec on tp.ec_id=ec.elementcomponentid "
				+ "inner join cr_networkelement ne on ne.networkelementid=tp.ne_id "
				+ "inner join cr_interface inf on tp.terminationpointid=inf.terminationpointid "
				+ "where tp.name = ? and ne.name =?";

		PreparedStatement statePstmt = null;
		ResultSet rs = null;
		Connection con = null;
		// step1 load the driver class
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// step2 create the connection object
			con = DriverManager.getConnection(
					"jdbc:oracle:thin:@172.30.8.137:1521:tsadb", "hpesa",
					"hpesa123");

			statePstmt = con.prepareStatement(query);
			statePstmt.setString(1, interfaceName);
			statePstmt.setString(2, routerName);
			// statePstmt.setString(2, "GigabitEthernet0/0/0");
			rs = statePstmt.executeQuery();
			if (rs.next()) {
				controllerName = rs.getString(1);
				neId = rs.getString(2);
				vendor = rs.getString(3);
				elementtype = rs.getString(4);
				numberOfSlots = rs.getString(5);
				timeslots = rs.getString(6);
				if (elementtype.contains("ASR")) {
					isASR = "true";
				} else {
					isASR = "false";
				}
			}
		} catch (Exception e) {
			System.out.println("Exception while getting free vlan ids ");
			e.printStackTrace();
		} finally {

			try {
				rs.close();
				statePstmt.close();
				con.close();
			} catch (Exception e) {
			}
		}
	}
}
