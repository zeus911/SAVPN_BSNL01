/*####################################################################
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
#  $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/WEB-INF/src/java/com/hp/ov/activator/crmportal/helpers/XSLTransformHelper.java,v $
#  $Revision: 1.5 $
#  $Date: 2010-10-05 14:19:15 $
#  $Author: shiva $
######################################################################*/


package com.hp.ov.activator.crmportal.helpers;


import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import org.xml.sax.SAXException;

public class XSLTransformHelper {

	/**
	 * @param args
	 * @throws IOException 
	 * @throws TransformerException 
	 * @throws SAXException 
	 */
	

	public static Writer transformXML(Reader reader, Writer writer, URL xslURL,
			HashMap parameters) throws TransformerException {

		try {
			System.setProperty("javax.xml.transform.TransformerFactory", "org.apache.xalan.processor.TransformerFactoryImpl");
			TransformerFactory tFactory = TransformerFactory.newInstance();
			StreamSource xmlSource = new StreamSource(reader);
			StreamSource xslSource = new StreamSource(xslURL.openStream(),
					xslURL.toExternalForm());
			StreamResult result = new StreamResult(writer);
			Transformer transformer = tFactory.newTransformer(xslSource);

			if (parameters != null)
				transformer = addParemeters(transformer, parameters);
			transformer.transform(xmlSource, result);
		} catch (TransformerConfigurationException e) {

			throw new TransformerException(e.getMessage());
		} catch (TransformerFactoryConfigurationError e) {
			throw new TransformerException(e.getMessage());
		} catch (IOException e) {
			throw new TransformerException(e.getMessage());
		} catch (TransformerException e) {
			throw new TransformerException(e.getMessage());
		} catch (Exception e) {
			throw new TransformerException(e.getMessage());
		}

		return writer;
	}




	private static Transformer addParemeters(Transformer transformer,
			HashMap paramters) {

		if (paramters != null) {

			Set keys = paramters.keySet();
			Iterator iterator = keys.iterator();
			while (iterator.hasNext()) {
				String key = (String) iterator.next();
				String value = (String) paramters.get(key);
				transformer.setParameter(key, value);
			}
		}

		return transformer;
	}

}
