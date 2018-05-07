import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GenerateCommandXMLs {
	private String st = null;
	private List<String> pList = new ArrayList<String>();
	private String directoryName = "/home/hpesa/suman/intupload/qos_input/";

	private String readFile() {

		File file = new File("/home/hpesa/suman/intupload/sample.xml");

		BufferedReader br;
		try {
			br = new BufferedReader(new FileReader(file));
			st = "";
			String line = "";
			while ((line = br.readLine()) != null) {
				st = st + line;
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return st;
	}

	public GenerateCommandXMLs() {
		this.st = readFile();
	}

	public static void main(String args[]) {
		GenerateCommandXMLs commandGenerator = new GenerateCommandXMLs();
		commandGenerator.getIPs();
		commandGenerator.generateFiles();

	}

	private void generateFiles() {
		// TODO Auto-generated method stub
		for (String ip : pList) {

			BufferedWriter bw = null;
			FileWriter fw = null;

			try {

				String fileName = directoryName + ip;
				fw = new FileWriter(fileName);
				bw = new BufferedWriter(fw);
				bw.write(st);

			} catch (IOException e) {

				e.printStackTrace();

			} finally {

				try {

					if (bw != null)
						bw.close();

					if (fw != null)
						fw.close();

				} catch (IOException ex) {

					ex.printStackTrace();

				}

			}
		}
	}

	private void getIPs() {

		// TODO Auto-generated method stub
		String query = "select ip from cr_networkelement where vendor='Cisco' and osversion !='CiscoXR'";

		// TODO Auto-generated method stub
		// TODO Auto-generated method stub

		PreparedStatement statePstmt = null;
		int rows = 0;
		Connection con = null;
		ResultSet rs = null;
		// step1 load the driver class
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// step2 create the connection object
			con = DriverManager.getConnection(
					"jdbc:oracle:thin:@172.30.8.137:1521:tsadb", "hpesa",
					"hpesa123");
			// con = DriverManager.getConnection(
			// "jdbc:oracle:thin:@15.153.133.77:1521:orcl", "hpesa",
			// "hpesa123");

			statePstmt = con.prepareStatement(query);
			
			rs = statePstmt.executeQuery();

			while (rs.next()) {

				pList.add(rs.getString(1));
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

}
