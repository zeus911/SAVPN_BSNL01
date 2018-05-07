import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;

import org.apache.struts.tiles.ControllerSupport;

public class CreateControllers {

	private static ArrayList<String> existingControllers = null;
	private String neId = "";

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		CreateControllers sample1 = new CreateControllers();
		// Should be the NE ID of router

		sample1.neId = "100";
		sample1.loadFile();
		//
		sample1.loadExistingControllers();
		sample1.create();
	}

	private void loadExistingControllers() {

		String q = "select name from cr_elementcomponent where ectype='Controller'";

		existingControllers = new ArrayList<String>();

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
				existingControllers.add(rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception while getting free vlan ids ");
			e.printStackTrace();
		} finally {

			try {
				rs.close();
			} catch (Exception e) {
			}
			try {
				statePstmt.close();
			} catch (Exception e) {
			}
			try {
				con.close();
			} catch (Exception e) {
			}
		}

	}

	private ArrayList<String> controllers = new ArrayList<String>();

	private void loadFile() {
		// TODO Auto-generated method stub

		String csvFile = "controllers.csv";
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";

		try {

			br = new BufferedReader(new FileReader(csvFile));
			while ((line = br.readLine()) != null) {
				// use comma as separator
				String[] token = line.split(cvsSplitBy);

				System.out.println("Controller= " + token[0]);

				controllers.add(token[0]);
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}

	private void create() {
		String sequenceQuery = "select sequencename.nextval from dual";

		for (String controller : controllers) {
			String parentController = controller.substring(0,
					controller.lastIndexOf("/"));
			String componentNumber = controller.substring(controller
					.lastIndexOf("/") + 1);
			System.out.println("parent controller ");
			String parentControllerId = getParentControllerId(parentController);
			if (parentControllerId.equals("")) {
				System.out.println("Parent controller not found for "
						+ controller + " and hence not insterted into DB");
				continue;
			}
			String insertQuery = "Insert into "
					+ "cr_elementcomponent(ELEMENTCOMPONENTID, NE_ID,PARENTEC_ID,"
					+ "NAME,STATE,ECTYPE,COMPONENTNUMBER,CAPACITYCOUNT__,COUNT__,ISPARENT__) "
					+ "?,?,?,?,?,?,?,?,?";
			PreparedStatement statePstmt = null;
			ResultSet rs = null;
			Connection con = null;
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");

				// step2 create the connection object
				con = DriverManager.getConnection(
						"jdbc:oracle:thin:@172.30.8.137:1521:tsadb", "hpesa",
						"hpesa123");
				// con = DriverManager.getConnection(
				// "jdbc:oracle:thin:@172.30.8.110:1531:psadb.bsnl.co.in",
				// "hpesa", "hpesa123");
				statePstmt = con.prepareStatement(sequenceQuery);
				rs = statePstmt.executeQuery();
				String ecId = "";
				if (rs.next()) {
					ecId = rs.getString(1);
				}
				rs.close();
				statePstmt.close();
				statePstmt = con.prepareStatement(insertQuery);
				// statePstmt.setString(2, "GigabitEthernet0/0/0");
				statePstmt.setString(1, ecId);
				statePstmt.setString(2, neId);
				statePstmt.setString(3, parentControllerId);
				statePstmt.setString(4, controller);
				statePstmt.setString(5, "ADDED");
				statePstmt.setString(6, "Controller");
				statePstmt.setString(7, componentNumber);
				String capacityCount = "0";
				if (controller.startsWith("cau4")) {
					capacityCount = "63";
				}
				statePstmt.setString(8, capacityCount);
				statePstmt.setString(9, "1");
				statePstmt.setString(10, "0");
				statePstmt.executeUpdate();

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

		// step1 load the driver class

	}

	private String getParentControllerId(String parentController) {
		// TODO Auto-generated method stub
		PreparedStatement statePstmt = null;
		ResultSet rs = null;
		Connection con = null;
		String parentControllerId = "";
		if (parentController.startsWith("cau4")) {
			parentController = parentController.substring(parentController
					.indexOf("-"));
			parentController = "SONET" + parentController;
		} else if (parentController.startsWith("ce1")) {
			parentController = parentController.substring(parentController
					.indexOf("-"));
			parentController = "E1" + parentController;
		}
		System.out.println("Parent Controller " + parentController);
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
			String query = "select elementcomponentid from cr_elementcomponent where name=?";
			statePstmt = con.prepareStatement(query);
			statePstmt.setString(1, parentController);

			rs = statePstmt.executeQuery();
			if (rs.next()) {
				parentControllerId = rs.getString(1);

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
		return parentControllerId;
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
