import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;

public class Sample1 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Hello");
		// Sample1 sample1 = new Sample1();
		//
		// // sample1.test();
		// sample1.printAll();
String str="x@10.100";
String checkclass = str.substring(0, str.indexOf("."));
System.out.println(checkclass);
		//SingletonExample example = SingletonExample.getInstance();

	}

	private void printAll() {
		String q = "select tname from tab";

		ArrayList<String> pList = new ArrayList<String>();

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
			// con = DriverManager.getConnection(
			// "jdbc:oracle:thin:@172.30.8.110:1531:psadb.bsnl.co.in",
			// "hpesa", "hpesa123");
			statePstmt = con.prepareStatement(q);
			// statePstmt.setString(2, "GigabitEthernet0/0/0");
			rs = statePstmt.executeQuery();
			while (rs.next()) {

				pList.add(rs.getString(1));
			}

			for (String tname : pList) {
				PreparedStatement subStatePstmt = null;
				ResultSet subRs = null;
				try {
					String subquery = "select * from \"" + tname + "\"";

					subStatePstmt = con.prepareStatement(subquery);
					subRs = subStatePstmt.executeQuery();
					ResultSetMetaData metadata = subRs.getMetaData();
					int columnCount = metadata.getColumnCount();
					while (subRs.next()) {
						// System.out.println("columnCount is " + columnCount);
						String row = "";
						for (int i = 1; i <= columnCount; i++) {
							String type = metadata.getColumnClassName(i);

							if (type.equals("java.lang.String")) {
								String value = subRs.getString(i);
								row = row + "#" + value;

								// if (value != null && value.equals("M")) {
								//
								// System.out.println("tname and value is "
								// + tname + "#"
								// + metadata.getColumnName(i) + "#"
								// + value);
								// }
							}
						}
						if (row.trim().length() > 0 && row.contains("#M320#")) {
							System.out.println(tname + row);
						}
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				} finally {

					try {
						subRs.close();
						subStatePstmt.close();

					} catch (Exception e) {
					}
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

	private void test() {
		// TODO Auto-generated method stub
		String cr_interface = "'%GigabitEthernet0/0/0%'";
		String q = " select ci.vlanid from cr_interface ci inner join cr_terminationpoint tp on tp.terminationpointid=ci.TERMINATIONPOINTID inner join cr_networkelement ne on ne.networkelementid=tp.ne_id where tp.ne_id=? and tp.name like "
				+ cr_interface;

		ArrayList<String> pList = new ArrayList<String>();

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

			statePstmt = con.prepareStatement(q);
			statePstmt.setString(1, "100");
			// statePstmt.setString(2, "GigabitEthernet0/0/0");
			rs = statePstmt.executeQuery();
			while (rs.next()) {
				System.out.println("Vlan range " + rs.getString(1));
				pList.add(rs.getString(1));
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

		ArrayList<Integer> newVlanList = new ArrayList<Integer>();

		int cnt = 0;
		for (int vlanId = 501; vlanId <= 1000; vlanId++) {
			if (!pList.contains(String.valueOf(vlanId))) {
				if (!newVlanList.contains(new Integer(vlanId))) {
					newVlanList.add(new Integer(vlanId));

				}
			}
		}
		for (int vlanId = 2001; vlanId <= 4096; vlanId++) {
			if (!pList.contains(String.valueOf(vlanId))) {
				if (!newVlanList.contains(new Integer(vlanId))) {
					newVlanList.add(new Integer(vlanId));
				}
			}
		}
		int[] freeVlanIds = new int[newVlanList.size()];
		for (cnt = 0; cnt < freeVlanIds.length; cnt++) {
			System.out.println("Vlan id added is "
					+ newVlanList.get(cnt).intValue());
			freeVlanIds[cnt] = newVlanList.get(cnt).intValue();
		}
	}
}
