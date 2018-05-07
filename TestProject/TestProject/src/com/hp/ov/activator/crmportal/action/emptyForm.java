
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
 * Form bean for the empty forme.
 * This form is used for submit bottons.
 *
 * @author Frederik H. Andersen
 * @version $Revision: 1.2 $ $Date: 2010-10-05 14:19:08 $
 */
public  class emptyForm extends ActionForm 
{

	String blank;

	public void setBlank(String blank) {
		this.blank = blank;
	}

	public String getBlank() {
		return blank;
	}

} // End emptyForm

