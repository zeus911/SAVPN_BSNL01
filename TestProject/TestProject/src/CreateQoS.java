import java.io.BufferedReader;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.HashMap;

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

public class CreateQoS extends Thread {
	private String connectionUrl;
	private String commandXml;

	public static void main(String args[]) {
		//String directoryName = "C:\\Suman\\Works\\eclipse\\workspace\\TestProject\\input\\";
		String directoryName = "/home/hpesa/suman/intupload/qos_input/";

		File directory = new File(directoryName);
		// get all the files from a directory
		File[] fList = directory.listFiles();
		int i = 0;
		for (File file : fList) {
			try {
				String ip = file.getName();

				CreateQoS createQoS = new CreateQoS();
				createQoS.connectionUrl = "telnet://" + ip;
				
				createQoS.commandXml = getXml(directoryName + ip);
				// System.out.println(commandXml);
				createQoS.start();
				i++;
				if (i % 25 == 0) {
					Thread.sleep(300000l);
				}

			} catch (Exception e) {
				System.out.println("Exception while processing "
						+ file.getName());
			}
		}

	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		activateRouter();
	}

	public void activateRouter() {
		WFAuthenticator wfauth;
		try {
			System.out.println(new Date()+ " "+connectionUrl + " Start");
			wfauth = (WFAuthenticator) Naming.lookup("//172.30.8.78:2000/wfm");
			WFManager wfm = (WFManager) wfauth.login("hpesa", "hpesa00");
			HashMap map = new HashMap();

			map.put("connection_url", connectionUrl);
			map.put("activation_dialog2", commandXml);
			String name = "BSNLExecuteCommands";

			HashMap output = wfm.startAndWaitForJob(name, map);

			if (output != null) {
				Long errorCode = (Long) output.get("activation_major_code");
				if (errorCode != null && errorCode.toString().equals("0")) {
					System.out.println(new Date()+ " "+connectionUrl + " Success");
				} else {
					System.out.println(new Date() + " " +connectionUrl + " Fail");
				}
			}
			// System.out.println("output for neId " + output);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		} catch (NotBoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private static String getXml(String fileName) {
		BufferedReader br = null;
		String everything = "";
		try {
			br = new BufferedReader(new FileReader(fileName));
			StringBuilder sb = new StringBuilder();
			String line = br.readLine();

			while (line != null) {
				sb.append(line);
				sb.append(System.lineSeparator());
				line = br.readLine();
			}
			everything = sb.toString();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return everything;
	}

}
