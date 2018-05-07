/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.Socket;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;
import com.hp.ov.activator.crmportal.utils.Constants;

import org.apache.log4j.Logger;

public class SendXML {
	private HashMap parameters = null;

	private int port = 3099;

	private String host = null;

	private String action = null;

	private String template_dir = null;

	private String log_dir = null;

	private String templateFile = null;

	private BufferedReader in = null;

	private StringBuffer xmlMessage = new StringBuffer();

	private final String encoding = "UTF-8";

	Logger logger = Logger.getLogger("CRMPortalLOG");

	private final String skip_activation;

	public SendXML(HashMap parameters) {
		this.parameters = parameters;
		if (parameters.get("PORT") != null) {
			try {
				port = Integer.parseInt((String) parameters.get("PORT"));
			} catch (NumberFormatException e) { /* Ignore */
			}
		}

		host = (String) parameters.get("HOST");
		action = (String) parameters.get("ACTION");
		template_dir = (String) parameters.get("TEMPLATE_DIR");
		log_dir = (String) parameters.get("LOG_DIRECTORY");
		skip_activation = (String) parameters.get("skip_activation");
	}

	public String getXMLMessage() {
		return xmlMessage.toString();
	}

	public void Init() throws Exception {
		String xml = null;

		logger.debug("Service request parameters received");
		logger.debug("******************************************************************");

		for (Iterator iter = parameters.entrySet().iterator(); iter.hasNext();) {
			Map.Entry entry = (Map.Entry) iter.next();
			String key = (String) entry.getKey();
			String value = (String) entry.getValue();
			logger.debug(key + " = " + value);
		}
		logger.debug("************************************************************************");

		if (host == null) {
			throw new IOException(
					"The socketListener_host was not set correctly in the web.xml file.");
		}

		if (action == null) {
			throw new IOException(
					"The action was not specified, cannot handle service action.");
		}

		if (template_dir == null) {
			throw new IOException(
					"The template_dir was not specified, cannot handle service action.");
		}
		
		if("false".equals(skip_activation)){
			parameters.put("skip_activation", "activate");
		}
		else if("true".equals(skip_activation)){
			parameters.put("skip_activation", "skip_activation");
		}else{
			parameters.put("skip_activation", "default");
		}


		StringBuffer template = new StringBuffer(action);

		if (parameters.get(Constants.XSLPARAM_XSLNAME) != null) {
			template.append((String) parameters.get(Constants.XSLPARAM_XSLNAME));
		} else {
			if (parameters.get("type") != null) {
				template.append((String) parameters.get("type"));
			} else {
				throw new IOException(
						"The service type or xslName was not specified, cannot handle service action.");
			}
		}

		template.append(".xsl");
		templateFile = template.toString();

		try {
			in = new BufferedReader(new FileReader(template_dir + "/"
					+ templateFile));
		} catch (FileNotFoundException e) {
			throw new IOException("Template file not found: " + templateFile);
		}
		in.close();

		String s = "<test></test>";
		StringWriter sw = new StringWriter();
		StringReader sr = new StringReader(s);
		String url = "file:///" + template_dir + "/" + templateFile;
		URL xslURL = new URL(url);
		logger.debug("template xsl URL==>" + xslURL);
		
		// The XMLTransformer throws exception if params with null value
		// are found in the map. So loop through the map and remove the
		// entries with null values before calling transformXML
		Vector<String> remkeys = new Vector<String>();
		for (Iterator iter = parameters.entrySet().iterator(); iter.hasNext();) {
			Map.Entry entry = (Map.Entry) iter.next();
			String key = (String) entry.getKey();
			String value = (String) entry.getValue();
			if(value == null)
			{
				remkeys.add(key);
				logger.debug("Removing param with null value from the map: " + key );
			}
		}
		for (int i=0;i<remkeys.size();i++ )
		{
			parameters.remove((String)remkeys.elementAt(i));
		}

		//calling method in XSLTransformerHelper to generate xsl file
		try {

			xml = XSLTransformHelper.transformXML(sr, sw, xslURL, parameters)
					.toString();
			
			/*
				Static routes:
				are directly compound from database because with a big amount of static routes the XSLTransformHelper.transformXML launch error
				the following string are replaced in SendXML after transformXML:
				##nl## -> is \n
				##lt## -> is <
				##gt## -> is >
			*/
			xml = xml.replaceAll("##gt##", ">");
			xml = xml.replaceAll("##lt##", "<");
			xml = xml.replaceAll("##nl##", "\n");
			
			xml = Utils.escapeXmlHeader(xml);
			xmlMessage.append(xml);

		} catch (Exception e) {
			logger.debug(e.getMessage());
			throw new IOException(
					"XsL Transformation: Error Generating the Service Request xml ");
		}

		if (log_dir != null) {
			try {
				String s1 = templateFile;
				String xmls = "xml";

				StringBuffer sb = new StringBuffer(s1);
				sb.replace(sb.length() - 3, sb.length(), xmls);
				OutputStreamWriter out = new OutputStreamWriter(
						new BufferedOutputStream(new FileOutputStream(log_dir
								+ "/" + sb)), encoding);
				out.write(xmlMessage.toString(), 0, xmlMessage.toString()
						.length());
				out.flush();
				out.close();
			} catch (FileNotFoundException e) {
				logger.error("Could not write the xml log file");
			} catch (UnsupportedEncodingException e) {
				logger.error("The character encoding is unknown.");
			}
		} else {
			logger.error("The log_dir was not set, could not write logfile.");
		}

	}

	public void Send() throws IOException {
		Socket sock = null;
		OutputStreamWriter writer = null;

		try {
			sock = new Socket(host, port);
			if (sock != null) {
				writer = new OutputStreamWriter(sock.getOutputStream(),
						encoding);
				if (writer != null) {
					writer.write(xmlMessage.toString(), 0, xmlMessage
							.toString().length());
				} else {
					throw new IOException(
							"Could not create OutputStreamWriter object to send XML message to Service Activators Socket Listener Module");
				}
			} else {
				throw new IOException(
						"Could not create socket connection to Service Activators Socket Listener Module");
			}
		} catch (UnsupportedEncodingException e) {
			logger.error("The character encoding is unknown.");
		} catch (UnknownHostException ue){
          logger.debug("Unknown Host: " + ue.getMessage());
          throw new IOException(
            "Unknown Host: " + ue.getMessage());
        } catch (ConnectException ce){
          logger.debug("HPSA Socket Connection Error" + ce.getMessage());
          throw new IOException(
            "HPSA Socket Connection Error" );
        }
        finally {
			if (writer != null) {
				writer.flush();
				writer.close();
			}
			if (sock != null) {
				sock.close();
			}
		}
	}
}
