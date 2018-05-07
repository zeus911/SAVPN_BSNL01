
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;


import java.sql.*;
import java.util.*;

import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;

import com.hp.ov.activator.crmportal.bean.*;


public class CustomerSearchAction extends Action
{

	public CustomerSearchAction() 
	{
		
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
			 boolean b =false;
	         
			 			 
	          // Get database connection from session
			HttpSession session = request.getSession();
			dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);

			
			if ("true".equals((String)request.getParameter("navigation"))){
				form = (CustomerForm)session.getAttribute("SearchCustomerSubmit");
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
			
			CustomerForm cutomerForm = new CustomerForm();
			String str =(String)request.getParameter("navigation");
			
	 //Richa
			     	
	 try
	  {
	     		
	     	connection = (Connection) dbp.getConnection();
	     	 
	        if (((CustomerForm) form).getCustomerid() != null && 
	        		!((CustomerForm) form).getCustomerid().equals(""))
	        {
	          customers = new Customer[1];
	          customers[0] = Customer.findByPrimaryKey(connection, ((CustomerForm) form).getCustomerid());
	             if(customers[0] == null) 
	                 {
	                 customers = null;
	                 }
	        } 
	        else
	        {
	        	logger.debug("CustomerSearchAction >>"+"Cust ID is null");
	          StringBuffer addlnWhereClause = new StringBuffer();
            StringBuffer addlnFromClause = new StringBuffer();
	          String customerid     = ((CustomerForm) form).getCustomerid();
	          String company        = ((CustomerForm) form).getCompanyname();
	          String companyaddress  = ((CustomerForm) form).getCompanyaddress();
	          String companycity     = ((CustomerForm) form).getCompanycity();
	          String companyzipcode  = ((CustomerForm) form).getCompanyzipcode();
	          String contactpersonname        = ((CustomerForm) form).getContactpersonname();
	          String contactpersonsurname     = ((CustomerForm) form).getContactpersonsurname();
	          String contactpersonphonenumber = ((CustomerForm) form).getContactpersonphonenumber();
	          String contactpersonemail     = ((CustomerForm) form).getContactpersonemail();
	          String status     = ((CustomerForm) form).getStatus();
            String haspendingjobs = ((CustomerForm) form).getHaspendingjobs();
	          boolean matchcase = ((CustomerForm) form).getMatchcase() != null && ((CustomerForm) form).getMatchcase().equals("yes");

	          Vector parameters = new Vector();

	          if (contactpersonname != null && !contactpersonname.equals("")) {
	            contactpersonname.trim();
	            contactpersonname = "'" + contactpersonname + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "CONTACTPERSONNAME" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + contactpersonname + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (contactpersonsurname != null && !contactpersonsurname.equals("")) {
	            contactpersonsurname.trim();
	            contactpersonsurname = "'" + contactpersonsurname + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "CONTACTPERSONSURNAME" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + contactpersonsurname + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (company != null && !company.equals("")) {
	            company.trim();
	            company = "'" + company + "'";
	   		 parameters.addElement((matchcase ? "" : "upper(") + "COMPANYNAME" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + company + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (contactpersonphonenumber != null && !contactpersonphonenumber.equals("")) {
	            contactpersonphonenumber.trim();
	            contactpersonphonenumber = "'" + contactpersonphonenumber + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "CONTACTPERSONPHONENUMBER" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + contactpersonphonenumber + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (contactpersonemail != null && !contactpersonemail.equals("")) {
	            contactpersonemail.trim();
	            contactpersonemail = "'" + contactpersonemail + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "CONTACTPERSONEMAIL" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + contactpersonemail + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (customerid != null && !customerid.equals("")) {
	            customerid.trim();
	            customerid = "'" + customerid + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "CUSTOMERID" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + customerid + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (companyaddress != null && !companyaddress.equals("")) {
	            companyaddress.trim();
	            companyaddress = "'" + companyaddress + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "COMPANYADDRESS" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + companyaddress + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (companycity != null && !companycity.equals("")) {
	            companycity.trim();
	            companycity = "'" + companycity + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "COMPANYCITY" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + companycity + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (companyzipcode != null && !companyzipcode.equals("")) {
	            companyzipcode.trim();
	            companyzipcode = "'" + companyzipcode + "'";
	            parameters.addElement((matchcase ? "" : "upper(") + "COMPANYZIPCODE" + (matchcase ? " like ('%' ||" : ") like upper ('%'||") + companyzipcode + (matchcase ? "||'%')" : "||'%')"));
	          }

	          if (status != null && !status.equals("")) {
	            status = "'" + status + "'";
	            parameters.addElement("STATUS= "+ status);
	          }
	          

            
	          if (parameters.size() > 0) 
	          {

	            for(int i = 0; i < parameters.size(); i++) 
	            {
	              addlnWhereClause.append((i != 0 ? " and " : "") + parameters.elementAt(i));
	            }
	           //PR search customer 
	           //System.out.println("===haspendingjobs===="+haspendingjobs);
	           if (haspendingjobs != null && !haspendingjobs.equals("")) {
	             if (haspendingjobs.equals("yes")){	             	
	             	addlnWhereClause.append( "and crm_customer.customerid in (select customerid from crm_service  where state like '%Waiting_Operator' or state like '%Failure' or state like '%FAILURE' or state like '%Confirm')");
	            }else if(haspendingjobs.equals("no")){	            	
	            	addlnWhereClause.append( "and crm_customer.customerid not in (select customerid from crm_service  where state like '%Waiting_Operator' or state like '%Failure' or state like '%FAILURE' or state like '%Confirm')");
	            }else{	            	
	            	}            
	          }	            
	          //System.out.println("==addlnWhereClause==="+addlnWhereClause);
            //PR ends
	            customers = Customer.findAll (connection, addlnWhereClause.toString());
	          } 
	          else 
	          {
	            customers = Customer.findAll (connection);
	          }
	          
	          
	          
	        }


	 		// Set the  retrieved list of required Customers  		
	 		
	 		if(customers!=null)
	 		{
	 			logger.info("CustomerSearchAction :: no of recs retrieved >> "+customers.length); 	
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
	 				custForm.setStatus(customers[i].getStatus()); 
	 				customersList.add(custForm);
	 				
	 			}

//Start Richa
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
				 vPageNo = cpage;
			 }
		   }

	request.setAttribute("cpage",String.valueOf(cpage));
	request.setAttribute("currentRs",String.valueOf(currentRs));
	request.setAttribute("lastRs",String.valueOf(lastRs));
	request.setAttribute("totalPages",String.valueOf(totalPages));
	request.setAttribute("vPageNo",String.valueOf(vPageNo));
	request.setAttribute("recPerPage",String.valueOf(recPerPage));
	request.setAttribute("Option","Search");
	request.setAttribute("navigation","str");

// End Richa
                   
	 		  } //end of Customer  If
	    }
	    catch(Exception ex)
	    {
	      error = true;
	       logger.error("CustomerSearchAction class errors: " , ex);	
	    }finally
	    {
	         // close the connection
	        dbp.releaseConnection(connection);
	     }
	          // Forward Action
		        if(!(error))
		         {        
		        	
	       	         //Transfer our new Customerslist to the jsp
		 		  //  request.setAttribute("CRM_customers_searchresult", customersList);   //Commented by Richa
					  request.setAttribute("CRM_customers", customersList);  //Added by richa
					  session.setAttribute("SearchCustomerSubmit",(CustomerForm) form);
					return mapping.findForward(Constants.SUCCESS);
	                 
	             }else
	             {
	            	 session.setAttribute("SearchCustomerSubmit",(CustomerForm) form);
	            	 return mapping.findForward(Constants.FAILURE);
	             }
	  }//method
	
	
}
