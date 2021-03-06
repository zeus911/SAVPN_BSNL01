/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;


import java.sql.*;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.bean.*;




/**
 *  Action class for Customer Search Action.
 *
 */
public  class CustomerAction extends Action
{
	public CustomerAction() 
	{
		//System.out.println("ACTION constructor>>"+"CustomerAction");
	}

    public ActionForward execute(ActionMapping mapping,
            ActionForm form,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception 
       {
    	 Logger logger = Logger.getLogger("CRMPortalLOG"); 
         DatabasePool dbp = null;
         Connection connection = null;
         ArrayList customersList = null; 
         Customer[] customers = null; 
         boolean error = false;
         String actionFlag;
         Calendar c = Calendar.getInstance(); 
            
          // Get database connection from session
		HttpSession session = request.getSession();
		dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
			
		//Transfer properties from Customer formbean to customer bean

		String creationtime = null;
		long lastUpdateTime = c.getTimeInMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
		  
			if ( date != null )
			{
				creationtime =  sdf.format( date ).toString();
			}


//Richa
			
			int size=0;
			int cpage = 1;
			int recPerPage = Constants.REC_PER_PAGE;  //Just Initialization
			String strPageNo = "1";
			int totalPages = 1 ;
			int currentRs=0;
			int lastRs=0;		
			int iPageNo = 1;
			int vPageNo = 1;
       	    String pt=(String)request.getParameter("mv"); 
			
     //Richa


        Customer cust = new Customer();
     	cust.setCustomerid(((CustomerForm) form).getCustomerid());
     	cust.setCompanyname(((CustomerForm) form).getCompanyname()); 
     	cust.setCompanyaddress(((CustomerForm) form).getCompanyaddress()); 
     	cust.setCompanycity(((CustomerForm) form).getCompanycity()); 
     	cust.setCompanyzipcode(((CustomerForm) form).getCompanyzipcode()); 
     	cust.setContactpersonname(((CustomerForm) form).getContactpersonname()); 
     	cust.setContactpersonsurname(((CustomerForm) form).getContactpersonsurname()); 
     	cust.setContactpersonphonenumber(((CustomerForm) form).getContactpersonphonenumber()); 
     	cust.setContactpersonemail(((CustomerForm) form).getContactpersonemail()); 
     	cust.setStatus("Active"); 
     
     	
     	try
     	{
     	actionFlag = ((CustomerForm) form).getActionflag();	
     	connection = (Connection) dbp.getConnection();
     	if(actionFlag.equals("add"))
     	{
            // Store Customer in db
     		cust.setCreationtime(creationtime);
     		cust.setLastupdatetime(lastUpdateTime);
     		cust.store(connection);
     	}
     	if(actionFlag.equals("update"))
     	{
            // Update Customer in db
     		cust.setLastupdatetime(lastUpdateTime);
            cust.setCreationtime(((CustomerForm) form).getCreationtime());
     		cust.update(connection);
     	}

 		// Get new list of Active Customers  		
 		customers = Customer.findAll(connection," status != 'Deleted'"); 
 		if(customers!=null)
 		{
 			customersList = new ArrayList(customers.length);
              
 			for(int i=0;i<customers.length;i++)
 			{
 				CustomerForm custForm = new CustomerForm();
 				custForm.setCustomerid(customers[i].getCustomerid());
 				custForm.setCompanyname(customers[i].getCompanyname()); 
 				custForm.setCompanyaddress(customers[i].getCompanyaddress()); 
 				custForm.setCompanycity(customers[i].getCompanycity()); 
 				custForm.setCompanyzipcode(customers[i].getCompanyzipcode()); 
 				custForm.setContactpersonname(customers[i].getContactpersonname()); 
 				custForm.setContactpersonsurname(customers[i].getContactpersonsurname()); 
 				custForm.setContactpersonphonenumber(customers[i].getContactpersonphonenumber()); 
 				custForm.setContactpersonemail(customers[i].getContactpersonemail()); 
 				custForm.setCreationtime(customers[i].getCreationtime());
 				custForm.setLastUpdateTime(customers[i].getLastupdatetime());
 				custForm.setStatus(customers[i].getStatus()); 
 				customersList.add(custForm);
 				
 			}
             
			 /* 
		  *   PAGINATION LOGIC
		  *   cpage = currentpage number 
		  *   currentRs = starting number of record pointer on the current page
		  *   lastRs = last number of record pointer on the current page
		  *   recPerPage = total no of records to be displayed per page
		  *   vPageNo = view this page number
		  */

		String strRecPerPage = (String)session.getAttribute("recordsPerPage"); //CONFIGURED VALUE
		 size=customersList.size();
		 cpage = 1;
		 recPerPage = Integer.parseInt(strRecPerPage);
		 strPageNo = "1";
		 totalPages = 1 ;
		 currentRs=0;
		 lastRs=0;
		 
		 iPageNo = 1;
		 vPageNo = 1;
		

		if(size%recPerPage==0)
		  { totalPages= size/recPerPage ; }
		else
		  { totalPages= size/recPerPage+1 ; }
		
		 if(totalPages==0){totalPages = 1;}
		
		 if(request.getParameter("currentPageNo")!= null)
			{
			 
		      strPageNo =(String)request.getParameter("currentPageNo");
	          iPageNo = Integer.parseInt(strPageNo);
		    }
			
			if(request.getParameter("viewPageNo")!= null)
			{
              vPageNo = Integer.parseInt((String)request.getParameter("viewPageNo"));
			}
			else
           {
				vPageNo =1;
           }
			

		if ((pt == null) || (pt.equals("null")))
        {
			if(size >0)
			 {
			    cpage = 1;
			    currentRs = 1; 
               if(recPerPage > size )
				{lastRs = size;}
               else 
				{lastRs =  cpage*recPerPage; }
			}
			if(size==0)
			 {
				cpage = 1;
				currentRs=1;
               lastRs=1;
				totalPages=1;
			 }
			
			vPageNo=1;
   	    }
		else
        {  
			
		 if(request.getParameter("navigate")==null)
		   {
			if(pt.equals("next"))
		    { /* next page navigation*/
			
			 cpage = iPageNo+1;
			 currentRs = (cpage*recPerPage)-recPerPage+1;
             lastRs = cpage*recPerPage;
			 vPageNo = cpage;
			 if(cpage == totalPages)
			 {
				lastRs = size;
			    vPageNo = totalPages; 
			 }
            }
			   if(pt.equals("prev"))
			  {  /* previous page  navigation*/
				
			   cpage = iPageNo-1;
				currentRs = (cpage*recPerPage)-recPerPage+1;
			   lastRs = cpage*recPerPage;
			  }
			   if(pt.equals("first"))
			  { /* first page  navigation*/
				
				cpage = 1;
				 currentRs = 1;
				if(recPerPage > size ) {lastRs = size;}
				 else {lastRs =  cpage*recPerPage;}  
				  vPageNo=1;
			  }
			   if(pt.equals("last"))
			  { /* last page  navigation*/
				
			   cpage = totalPages;
				currentRs = (cpage*recPerPage)-recPerPage+1;            
				 lastRs = size;
				 vPageNo = totalPages; 
			  }

			   if(pt.equals("viewpageno"))
			  { /* view a particular page */
				
			   cpage = vPageNo;
			   currentRs = (cpage*recPerPage)-recPerPage+1;
			   lastRs = cpage*recPerPage;
			
					 if(vPageNo==totalPages)
					  {
					   lastRs = size;				    
					  }else
					  {
					  lastRs =  cpage*recPerPage;
					  }
			   }
            
			} // end if(request.getParameter("navigate")==null)
			 else
			 { //when its a reload and not navigate
			  
				 cpage = Integer.parseInt((String)request.getParameter("currentPageNo"));
				 currentRs = Integer.parseInt((String)request.getParameter("currentRs"));
				 lastRs = Integer.parseInt((String)request.getParameter("lastRs"));
				 totalPages = Integer.parseInt((String)request.getParameter("totalPages"));
			 }
		   }

			request.setAttribute("cpage",String.valueOf(cpage));
			request.setAttribute("currentRs",String.valueOf(currentRs));
			request.setAttribute("lastRs",String.valueOf(lastRs));
			request.setAttribute("totalPages",String.valueOf(totalPages));
			request.setAttribute("vPageNo",String.valueOf(vPageNo));
			request.setAttribute("recPerPage",String.valueOf(recPerPage));

 			/*CustomerForm[] customerForms = new CustomerForm[customers.length];
			customersList.toArray( customerForms );
			return customerForms;*/
 		  }
     	}
     	catch(Exception ex)
     	{
     		 error = true;
     		 logger.error("CustomerAction class errors: " , ex);	
     	}finally
     	{
             // close the connection
            dbp.releaseConnection(connection);
     	}
          // Forward Action
	        if(!(error))
	         {        
       	         //Transfer our new Customerslist to the jsp
	 		    request.setAttribute("CRM_customers", customersList);  
	        	return mapping.findForward(Constants.SUCCESS);
                 
             }else
             { 
            	 request.setAttribute("CreateCustomerForm",(CustomerForm) form);
            	 return mapping.findForward(Constants.FAILURE);
             }
       }
} // End CustomerAction

