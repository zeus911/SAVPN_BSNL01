/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import java.io.*;


/**
 * Form bean
 *
 * @author ramola
 * @version $Revision: 1.8 $ $Date: 2011-03-23 09:43:01 $
 */
public class CustomerForm extends ActionForm implements Serializable
{
	String customerid, companyname,companyaddress,
    companycity,companyzipcode,contactpersonname,
    contactpersonsurname,contactpersonphonenumber,
    contactpersonemail,creationtime,status,actionflag,haspendingjobs,matchcase;
    long lastUpdateTime;
    boolean soft = false;
    boolean deactivate = false;
    
    public CustomerForm(){}

	public void setCustomerid( String customerid )
	{
		this.customerid = customerid;
	}

	public String getCustomerid()
	{
		return customerid;
	}

	
	public void setCompanyname( String companyname )
	{
		this.companyname = companyname;
	}

	public String getCompanyname()
	{
		return companyname;
	}


	public void setCompanyaddress( String companyaddress )
	{
		this.companyaddress = companyaddress;
	}

	public String getCompanyaddress()
	{
		return companyaddress;
	}

	public void setCompanycity( String companycity )
	{
		this.companycity = companycity;
	}

	public String getCompanycity()
	{
		return companycity;
	}
	

	public void setCompanyzipcode( String companyzipcode )
	{
		this.companyzipcode = companyzipcode;
	}

	public String getCompanyzipcode()
	{
		return companyzipcode;
	}


	public void setContactpersonname( String contactpersonname )
	{
		this.contactpersonname = contactpersonname;
	}

	public String getContactpersonname()
	{
		return contactpersonname;
	}

	
	public void setContactpersonsurname( String contactpersonsurname )
	{
		this.contactpersonsurname = contactpersonsurname;
	}

	public String getContactpersonsurname()
	{
		return contactpersonsurname;
	}

	
	public void setContactpersonphonenumber( String contactpersonphonenumber )
	{
		this.contactpersonphonenumber = contactpersonphonenumber;
	}

	public String getContactpersonphonenumber()
	{
		return contactpersonphonenumber;
	}


	public void setContactpersonemail( String contactpersonemail )
	{
		this.contactpersonemail = contactpersonemail;
	}

	public void setHaspendingjobs( String haspendingjobs )
	{
		this.haspendingjobs = haspendingjobs;
	}

	public String getContactpersonemail()
	{
		return contactpersonemail;
	}

	public String getHaspendingjobs()
	{
		return haspendingjobs;
	}
	
	public void setStatus( String status )
	{
		this.status = status;
	}

	public String getStatus()
	{
		return status;
	}

	public void setCreationtime( String creationtime )
	{
		this.creationtime = creationtime;
	}

	public String getCreationtime()
	{
		return creationtime;
	}
	
	public void setMatchcase( String matchcase )
	{
		this.matchcase = matchcase;
	}

	public String getMatchcase()
	{
		return matchcase;
	}
	
	public void setActionflag( String actionflag )
	{
		this.actionflag = actionflag;
	}

	public String getActionflag()
	{
		return actionflag;
	}
	
	public void setSoft( boolean soft )
	{
		this.soft = soft;
	}

	public boolean getSoft()
	{
		return soft;
	}

	public void setDeactivate( boolean deactivate )
	{
		this.deactivate = deactivate;
	}

	public boolean getDeactivate()
	{
		return deactivate;
	}
	
	public void setLastUpdateTime( long lastUpdateTime )
	{
		this.lastUpdateTime = lastUpdateTime;
	}

	public long getLastupdatetime()
	{
		return lastUpdateTime;
	}



    /**
     * Reset all properties to their default values.
     *
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     */
	 public void reset(ActionMapping actionMapping,HttpServletRequest request)
	 {
		 customerid = null;
		 companyname = null;
		 companyaddress = null;
		 companycity = null;
	     companyzipcode = null;	
		 contactpersonname = null;	
		 contactpersonsurname = null;	
		 contactpersonphonenumber = null;	
		 contactpersonemail = null;	
		 haspendingjobs = "Yes";
		 status = "Active";	
		 lastUpdateTime = 0;
		 
	 }

    /**
     * Ensure that both fields have been input.
     *
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     */
	 public ActionErrors validate(ActionMapping actionMapping,HttpServletRequest request)
	 {
		 ActionErrors actionErrors = new ActionErrors();
		 if(customerid == null || customerid.trim().equals(""))
		 {
			 actionErrors.add("customerid",new ActionError("error.no.customer.id"));
		 }
		 if(companyname == null || companyname.trim().equals(""))
		 {
			 actionErrors.add("companyname",new ActionError("error.no.company.name"));
		 }
		/* if(companyaddress == null || companyaddress.trim().equals(""))
		 {
			 actionErrors.add("companyaddress",new ActionError("error.no.companyaddress"));
		 }
		 if(companycity == null || companycity.trim().equals(""))
		 {
			 actionErrors.add("companycity",new ActionError("error.no.city"));
		 }
		 if(companyzipcode == null || companyzipcode.trim().equals(""))
		 {
			 actionErrors.add("companyzipcode",new ActionError("error.no.zipcode"));
		 }
		 if(contactpersonname == null || contactpersonname.trim().equals(""))
		 {
			 actionErrors.add("contactpersonname",new ActionError("error.no.firstname"));
		 }
		 if(contactpersonsurname == null || contactpersonsurname.trim().equals(""))
		 {
			 actionErrors.add("contactpersonsurname",new ActionError("error.no.surname"));
		 }
		 if(contactpersonphonenumber == null || contactpersonphonenumber.trim().equals(""))
		 {
			 actionErrors.add("contactpersonphonenumber",new ActionError("error.no.phonenumber"));
		 }
		 if(contactpersonemail == null || contactpersonemail.trim().equals(""))
		 {
			 actionErrors.add("contactpersonemail",new ActionError("error.no.email"));
		 }
		 */
		    return actionErrors;
	 }

} // End CustomerForm

