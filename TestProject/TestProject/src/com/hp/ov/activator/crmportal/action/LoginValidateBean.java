

/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;

import javax.servlet.http.*;
import org.apache.struts.action.*;

public class LoginValidateBean {

	String userRole, userId ,passWord;

	public LoginValidateBean() {}

	public void setParameters(HttpServletRequest request) {
		userId = request.getParameter("userId");
		passWord = request.getParameter("passWord");
	}

	public ActionErrors validate() {
		ActionErrors ae = new ActionErrors();
		 //System.out.println("Loginvalidatebean validate");
		/*if (userId.equals(passWord)) 
		{
			
			ae.add("userId",new ActionMessage("Invalid Login"));
			return ae;
		}*/

		if (userId.equals("admin")) 
		{
			userRole = "admin";
		} 
		else if (userId.equals("operator")) 
		{
			userRole = "operator";
		}
		else if (userId.equals("visitor")) 
		{
			userRole = "observer";
		}
		else 
		{
			
			ae.add("userId",new ActionMessage("error.invalid.login"));
			return ae;
		}

		 //System.out.println("Loginvalidatebean validate:::userRole"+userRole);
		return ae;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
}		


