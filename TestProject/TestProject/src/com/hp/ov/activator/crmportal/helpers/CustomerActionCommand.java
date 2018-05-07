
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.valueobject.datatransfer.CustomerDTO;
import com.hp.ov.activator.crmportal.bean.*;

public final class CustomerActionCommand 
{
	private HttpSession session;
	private HttpServletRequest request ;
	private CustomerDTO customerDTO;
    private DatabasePool dbp;
    private Connection connection;
    private Customer customerBean;
    private ArrayList newCustomers = null;
	public CustomerActionCommand()
	{}
	public ArrayList execute(HttpServletRequest req,CustomerDTO customerDTO)throws SQLException
	{
		this.request = req;
		this.customerDTO = customerDTO;
		this.session = request.getSession(false);
		
		try 
	    {
			connection=initializeDBPool();
			if (connection!=null)
		    this.newCustomers =generateCustomerId(connection);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	    return this.newCustomers;
	}
	
	private Connection initializeDBPool()throws SQLException
	{
//		 Get database connection from session
		 dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
		 connection = (Connection) dbp.getConnection();
         return connection;
	}
	
	private ArrayList generateCustomerId(Connection con)throws Exception
	{
        // Generate unique customer id and insert customer
		ArrayList result = null;
	    IdGenerator generator  = new IdGenerator(con);
	    String customerId = generator.getCustomerId(); 
	    if (customerId != null) 
		{
		customerDTO.setCustomerid(customerId);
		customerDTO.setStatus("Active"); 
		result = insertCustomer(con);
		}
	    return result;
	}
	
	private ArrayList insertCustomer(Connection connection)throws Exception
	{
		ArrayList customerList = new ArrayList();
		Customer[] customers = null; 
		
		String CustomerId  = customerDTO.getCustomerid();
		String CompanyName = customerDTO.getCompanyname();
		String CompanyAddress  = customerDTO.getCompanyaddress();
		String CompanyCity     = customerDTO.getCompanycity();
		String CompanyZipCode  = customerDTO.getCompanyzipcode();
		String ContactpersonName    = customerDTO.getContactpersonname();
		String ContactpersonSurname = customerDTO.getContactpersonsurname();
		String ContactpersonPhonenumber  = customerDTO.getContactpersonphonenumber();
		String ContactpersonEmail  = customerDTO.getContactpersonemail();
		String Status        = customerDTO.getStatus();
		long LastUpdateTime  = customerDTO.getLastupdatetime();
		String creationtime = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
		  
			if ( date != null )
			{
				creationtime =  sdf.format( date ).toString();
			}

		customerBean = new Customer (CustomerId, CompanyName, CompanyAddress,
		           CompanyCity,CompanyZipCode, ContactpersonName,
		           ContactpersonSurname, ContactpersonPhonenumber, 
		           ContactpersonEmail, Status, LastUpdateTime, creationtime );
		
        // Store Customer record in db
		customerBean.store(connection);
		
		// Get updated list of Active Customers	
		customers = Customer.findAll(connection," status != 'Deleted'"); 
		 
		// make an arraylist of DTO's here  to send to controller 
		if(customers!=null)
		{
			CustomerDTO custDTO = new CustomerDTO();
			int size = customers.length;
			for(int i=0;i<size;i++)
			{	
			custDTO.setCompanyaddress(customers[i].getCompanyaddress());
			custDTO.setCompanycity(customers[i].getCompanycity());
			custDTO.setCompanyname(customers[i].getCompanyname());
			custDTO.setCompanyzipcode(customers[i].getCompanyzipcode());
			custDTO.setContactpersonemail(customers[i].getContactpersonemail());
			custDTO.setContactpersonname(customers[i].getContactpersonname());
			custDTO.setContactpersonphonenumber(customers[i].getContactpersonphonenumber());
			custDTO.setContactpersonsurname(customers[i].getContactpersonsurname());
			custDTO.setCustomerid(customers[i].getCustomerid());
			custDTO.setLastupdatetime(customers[i].getLastupdatetime());
			custDTO.setStatus(customers[i].getStatus());
			customerList.add(custDTO);
			}
		}
	    
		   	
		//Close the connection
		closeDBConnection(connection);
		return customerList;
	}
	
	private void closeDBConnection(Connection conn)
	{
		// Make sure connection is closed again
		dbp.releaseConnection(conn);

	}
}
