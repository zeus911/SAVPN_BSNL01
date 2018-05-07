
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.io.*;
import java.util.*;
import java.net.*;
import java.lang.*;

public class JspHelper
{
  // Checks if the IP address is valid.
  static public boolean validateIpAddress (String ipaddress)
  {
    if(ipaddress != null && ipaddress.length() > 0 && ipaddress.length() <=15) {

      Vector parts = new Vector();

      // Read all parts of the IP
      StringTokenizer st = new StringTokenizer(ipaddress, ".");
      while (st.hasMoreTokens()) {
        parts.add(st.nextToken());
      }

      // All ip addresses should consist of 4 parts.
      if (parts.size() != 4) {
        return false;
      }

      // Check that all 4 parts are numbers and between 0 and 255
      for (int i = 0; i<parts.size(); i++) {
        try {
          int part = Integer.parseInt((String)parts.get(i));

          if (part < 0 || part > 255) {
            return false;
          }
        } catch (NumberFormatException e) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }
}
