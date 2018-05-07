
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.*;
import org.apache.struts.action.*;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;



/**
 * Form bean for the user profile page.
 * This form has the following fields,
 * with default values in square brackets:
 * <ul>
 * <li><b>password</b> - Entered password value
 * <li><b>username</b> - Entered username value
 * </ul>
 *
 * @author ramola
 * @version $Revision: 1.7 $ $Date: 2010-10-05 14:19:07 $
 */
public  class LoginForm extends ActionForm 
{

	String userId, passWord;

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getUserId() {
		return userId;
	}

	public String getPassWord() {
		return passWord;
	}

public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		ActionErrors ae = new ActionErrors();

		if (userId == null || userId.equals("")) {
			ae.add("userId", new ActionError("error.no.userId"));
		}

		if (passWord == null || passWord.equals("")) {
			ae.add("passWord", new ActionError("error.no.passWord"));
		}
 
		return ae;
	}

} // End LoginForm

