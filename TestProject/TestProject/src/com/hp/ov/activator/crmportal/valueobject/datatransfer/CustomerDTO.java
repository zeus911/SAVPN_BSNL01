
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.valueobject.datatransfer;

import java.io.Serializable;


public class CustomerDTO implements Serializable
{

	private String CustomerId;
	private String CompanyName;
	private String CompanyAddress;
	private String CompanyCity;
	private String CompanyZipCode;	
	private String ContactpersonName;	
	private String ContactpersonSurname;	
	private String ContactpersonPhonenumber;	
	private String ContactpersonEmail;	
	private String Status;	
	private long LastUpdateTime;
	

	public CustomerDTO () {}

	public CustomerDTO (
		String CustomerId,
		String CompanyName,
		String CompanyAddress,
		String CompanyCity,
		String CompanyZipCode,
		String ContactpersonName,
		String ContactpersonSurname,
		String ContactpersonPhonenumber,
		String ContactpersonEmail,
		String Status,
		long LastUpdateTime )
	{
		this.CustomerId = CustomerId;
		this.CompanyName = CompanyName;
		this.CompanyAddress = CompanyAddress;
		this.CompanyCity = CompanyCity;
		this.CompanyZipCode = CompanyZipCode;
		this.ContactpersonName = ContactpersonName;
		this.ContactpersonSurname = ContactpersonSurname;
		this.ContactpersonPhonenumber = ContactpersonPhonenumber;
		this.ContactpersonEmail = ContactpersonEmail;
		this.Status = Status;
		this.LastUpdateTime = LastUpdateTime;
	}

	public void setCustomerid( String CustomerId )
	{
		this.CustomerId = CustomerId;
	}

	public String getCustomerid()
	{
		return CustomerId;
	}

	

	public void setCompanyname( String CompanyName )
	{
		this.CompanyName = CompanyName;
	}

	public String getCompanyname()
	{
		return CompanyName;
	}

	

	public void setCompanyaddress( String CompanyAddress )
	{
		this.CompanyAddress = CompanyAddress;
	}

	public String getCompanyaddress()
	{
		return CompanyAddress;
	}

	
	public void setCompanycity( String CompanyCity )
	{
		this.CompanyCity = CompanyCity;
	}

	public String getCompanycity()
	{
		return CompanyCity;
	}

	

	public void setCompanyzipcode( String CompanyZipCode )
	{
		this.CompanyZipCode = CompanyZipCode;
	}

	public String getCompanyzipcode()
	{
		return CompanyZipCode;
	}



	public void setContactpersonname( String ContactpersonName )
	{
		this.ContactpersonName = ContactpersonName;
	}

	public String getContactpersonname()
	{
		return ContactpersonName;
	}

	

	public void setContactpersonsurname( String ContactpersonSurname )
	{
		this.ContactpersonSurname = ContactpersonSurname;
	}

	public String getContactpersonsurname()
	{
		return ContactpersonSurname;
	}

	

	public void setContactpersonphonenumber( String ContactpersonPhonenumber )
	{
		this.ContactpersonPhonenumber = ContactpersonPhonenumber;
	}

	public String getContactpersonphonenumber()
	{
		return ContactpersonPhonenumber;
	}

	

	public void setContactpersonemail( String ContactpersonEmail )
	{
		this.ContactpersonEmail = ContactpersonEmail;
	}

	public String getContactpersonemail()
	{
		return ContactpersonEmail;
	}

	

	public void setStatus( String Status )
	{
		this.Status = Status;
	}

	public String getStatus()
	{
		return Status;
	}

	

	public void setLastupdatetime( long LastUpdateTime )
	{
		this.LastUpdateTime = LastUpdateTime;
	}

	public long getLastupdatetime()
	{
		return LastUpdateTime;
	}

	
}
