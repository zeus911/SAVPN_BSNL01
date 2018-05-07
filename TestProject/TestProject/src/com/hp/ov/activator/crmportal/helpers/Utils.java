/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;


public class Utils {

	 /**
	   * Performs the following substring replacements
	   * (to facilitate output to XML/HTML pages):
	   * <p/>
	   * & -> &amp;
	   * < -> &lt;
	   * > -> &gt;
	   * " -> &#034;
	   * ' -> &#039;
	   * <p/>
	   * See also OutSupport.out().
	   */
	  public static String escapeXml(String input) {
	    if(input == null)
	      return null;
	    if(input.length() == 0)
	      return input;
	    
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < input.length(); i++) {
	      char c = input.charAt(i);
	      if (c == '&')
	        sb.append("&amp;");
	      else if (c == '<')
	        sb.append("&lt;");
	      else if (c == '>')
	        sb.append("&gt;");
	      else if (c == '"')
	        sb.append("&#034;");
	      else if (c == '\'')
	        sb.append("&#039;");
	      else
	        sb.append(c);
	    }
	    return sb.toString();
	  }

	  
	  /**
	 * @param input
	 * @return
	 * Removes the <?xml version="1.0" encoding="UTF-8"?> header from the xml string
	 */
	public static String escapeXmlHeader(String input) {

		int index = input.indexOf("?>");
		if (index != -1 && (input.substring(0, index + 2)).startsWith("<?xml"))
			return (input.substring(index + 2));
		else
			return input;
	}


}
