<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>


<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- FindCustomer.jsp                                                --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  (The parameters are sent by CustomerSearchForm.jsp)           --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It displays the customers who match with the data sent by     --%>
<%--  FindCustomerForm.jsp, if no parameters are present all the    --%>
<%--  customers will be displayed.                                  --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" 
         info="Find All customers"
         import="java.util.*,java.sql.*,com.hp.ov.activator.crmportal.utils.*,
		 com.hp.ov.activator.crmportal.helpers.*,com.hp.ov.activator.crmportal.action.CustomerForm,com.hp.ov.activator.crmportal.bean.*,com.hp.ov.activator.crmportal.utils.DatabasePool" %>


<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!--<%@ include file="../jsp/CheckSession.jsp" %>-->

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");
  
%>

<%
    session.setAttribute("special_search_value", null);
    ArrayList customers = ( ArrayList)request.getAttribute("CRM_customers");
	CustomerForm customerForm = null;

	//Added by Richa
 //int size=0;
			int cpage = 1;
			int recPerPage = 10;
			String strPageNo = "1";
			int totalPages = 1 ;
			int currentRs=0;
			int lastRs=0;	
			int vPageNo = 1;

	String pt=(String)request.getParameter("mv"); 

    String strcpage = (String)request.getAttribute("cpage");
	if(strcpage!=null)
	  cpage  = Integer.parseInt(strcpage);
	  String strcurrentRs  =  (String)request.getAttribute("currentRs");
	if(strcurrentRs!=null)
	  currentRs  = Integer.parseInt(strcurrentRs);
	String strlastRs	 =  (String)request.getAttribute("lastRs");
	if(strlastRs!=null)
	  lastRs = Integer.parseInt(strlastRs);
	String strtotalPages =  (String)request.getAttribute("totalPages");
	if(strtotalPages!=null)
	  totalPages = Integer.parseInt(strtotalPages);
	String strvPageNo	 =  (String)request.getAttribute("vPageNo");
	if(strvPageNo!=null)
	  vPageNo = Integer.parseInt(strvPageNo);
	String strrecPerPage =  (String)request.getAttribute("recPerPage");
	if(strrecPerPage!=null)
	  recPerPage = Integer.parseInt(strrecPerPage);
/*
	int currentRs  = Integer.parseInt((String)request.getAttribute("currentRs"));
	int lastRs     = Integer.parseInt((String)request.getAttribute("lastRs"));
	int totalPages = Integer.parseInt((String)request.getAttribute("totalPages"));
	int vPageNo    = Integer.parseInt((String)request.getAttribute("vPageNo"));
	int recPerPage    = Integer.parseInt((String)request.getAttribute("recPerPage"));

	*/

// Richa Added for merge
	
	String straction = "";
	String stractiondo = "";
	String strOption =   (String)request.getAttribute("Option"); 

	if(strOption==null)
		strOption = "List";
	if(strOption.equalsIgnoreCase("Search"))
	{
		straction = "/EditCustomerfromSearch";
		stractiondo = "/SearchCustomerSubmit.do";
	}
	else if(strOption.equalsIgnoreCase("List"))
	{
		straction = "/ListCustomer";
		stractiondo = "/ListCustomer.do";
	}

// Richa Added for merge


		   int ii=0;
		   int jj=0;
		   int kk=0;
		   int prevloc =0;
           int currLoc =0;
		   int prevcount=0;
		   int rem = 0;
           int maxallowable = 0;
           int count = 0; 
		   HashSet HashCustomer = new HashSet(); //customers
		   ArrayList alist_PrevLoc = new ArrayList();

  if(customers!=null)
  {
  for (int i = 0; i<customers.size(); i++)
        {   

			prevloc = alist_PrevLoc.size();
				//logger.debug(" prevloc == "+prevloc);
			    maxallowable = recPerPage - prevloc;
				prevcount = count;
				count = 1+prevcount; 

				 int diff = currentRs-count;
       
                   kk = cpage-1;
				   if(kk==0)
				   {					
					 //parentIndex = i;
					 HashCustomer.add(customers.get(i));
                     ii = 1;
					 maxallowable = maxallowable-1;
					 jj = maxallowable;

				
				   }
				   else
				   {
					  if(currentRs <=count)
						  {
                          ii = (kk*recPerPage);
					      jj =  ii + recPerPage-1;
						 
							   if(i>0)
							   {
                               ii = (kk*recPerPage)-prevcount;
                               jj =  ii + recPerPage-1;
							   }
					 
					      
						  }
						  else
					      {
                             ii=0;
							 jj=0;
							
						
							   if((prevloc==0)&&(diff==1))
							  {
								   HashCustomer.add(customers.get(i));
								
							  }
					      }

							if(((rem==0)&&(i>0))&&(prevloc>0)&&(maxallowable>0))
					        {
								// logger.debug(" enter (rem==0)&&(i>0))&&(prevloc>0 ");
								 diff = currentRs-prevcount;
								 if((prevloc==1)&&(diff==1))
								{
								  HashCustomer.remove(customers.get(i-1));
								  alist_PrevLoc.remove(prevloc-1);
								}
                                HashCustomer.add(customers.get(i));
                               ii = 1;
					           maxallowable = maxallowable-1;
					           jj = maxallowable;
							 
					       }                       	   
				   }
				                          
			 if(HashCustomer.contains(customers.get(i)))
            	{  
				   alist_PrevLoc.add(customers.get(i));
			       currLoc = prevloc+1;
				}
     

			 currLoc = alist_PrevLoc.size();
		              if (currLoc == recPerPage)
                      break;
		}

  }

%>

<html:html locale="true">
  <head>
   
    <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
	<META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <META Http-Equiv="Expires" Content="0">
   
	<script LANGUAGE="JavaScript" TYPE="text/javascript">

	function deactivateCustomer(customerid)
    {
      var conf1 = confirm('Do you wish to continue and delete the customer?');
      var page = "DeleteCustomer.jsp?customerid=" + customerid + "&soft=true&deactivate=true";
        if (conf1 == true)
        {
          this.location.href.value = page;
        }
    }


   function init(pt,currpage,isnavigate,currentRs,lastRs,totalPages)
			 {
                
	    if ('Netcape' == navigator.appName) document.forms[0].reset();
					
		parent.reload.unlockScroll();				
		parent.reload.doScroll();			
		parent.reload.findInstance();  
        var varOption = "<%=strOption%>";
		if(varOption=="List")
		{
		   parent.reload.setURL('/crm/ListCustomer.do?mv='+pt+'&currentPageNo='+currpage+'&navigate='+isnavigate+ '&currentRs='+currentRs+'&lastRs='+lastRs+'&totalPages='+totalPages);
		}
		else if(varOption=="Search")
		{
		parent.reload.setURL('/crm/SearchCustomerSubmit.do?mv='+pt+'&currentPageNo='+currpage+'&navigate='+isnavigate+ '&currentRs='+currentRs+'&lastRs='+lastRs+'&totalPages='+totalPages);
   	     } 
	        } 


    </script>
  </head>

<body onLoad="init('<%=pt%>','<%=cpage%>','<%="false"%>','<%=currentRs%>','<%=lastRs%>','<%=totalPages%>');">
<%  
    
    HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
    boolean isOperator = false;
    //System.out.println("roles :::::::"+roles);
    if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
if(strOption.equalsIgnoreCase("List")) {
%>
    <h2 class="mainSubHeading"><center><bean:message key="title.list.customer" /></center></h2>
<%}else if(strOption !=null && strOption.equalsIgnoreCase("Search")){%>
    <h2 class="mainSubHeading"><center><bean:message key="title.search.results" /></center></h2>
<%}%>
   <br><font color="red">
   <html:errors/>
   </font></br>

      <html:form  action="<%=straction%>">

	  <input type="hidden" name="navigation" value="true">
<%
	if(strOption.equalsIgnoreCase("Search")){ %>

	 <html:hidden  property="actionflag" value="fromsearch" name="flag"/>
	 <html:hidden  property="soft" value="true" name="soft"/>
	 <html:hidden  property="deactivate" value="" name="deactivate"/>
	
	<%}%>

    <center>
      <table align="center" width="100%" border=0 cellpadding=2 cellspacing=0>
<%         if (customers != null && customers.size() == 1) { %>
        <tr>
          <td class="title"><font color ="white" size="2pt"><bean:message key="msg.one.customer" /></td>
        </tr>
<%         } %>

<%         if (customers != null && customers.size() > 1) { %>
        <tr>
          <td class="title" ><font color ="white" size="2pt">(<%= customers.size() %>) <bean:message key="msg.cust.found" /></td>
		  <!--Added by Richa, 11797-->
		  <td class="title" >
		  <font color ="white" size="1pt"><bean:message key="label.page.service"/> <%=cpage%>/<%=totalPages%></font>
		 </td>
        <td width="5%"class="title"></td>
<%		
				String stsCurrPg = String.valueOf(cpage);
			    String strViewPgNo = String.valueOf(vPageNo);

				HashMap navigationparams = new HashMap();
			  //  navigationparams.put("customerid",customers.get(0)); //CustomerId)
		        navigationparams.put("doResetReload","true");
			  	navigationparams.put("currentPageNo",stsCurrPg);	
				//navigationparams.put("hidautoRefreshOn",autoRefreshOn);
                navigationparams.put("currentRs",String.valueOf(currentRs));
			    navigationparams.put("lastRs",String.valueOf(lastRs));
				navigationparams.put("navigation","true");
%>           

         <input type="hidden" name="doResetReload" value="true">
		 <input type="hidden" name="mv" value="viewpageno">
		 <input type="hidden" name="currentPageNo" value="<%=stsCurrPg%>">
         <input type="hidden" name="viewPageNo" value="<%=strViewPgNo%>">				
         <input type="hidden" name="hidviewPageNo" value="<%=vPageNo%>">

<%
         if(  totalPages > 0)
		  { 
				 navigationparams.put("mv","viewpageno");
				 pageContext.setAttribute("paramsMap", navigationparams);

		%>
                  <td width="25%" class="title" align="Right"> 
				   <html:link  href="javascript:callviewByPageNo();" >
					<font color = "white" size="1pt"><bean:message key="label.gotopage"/></font>
				   </html:link>				   
				   <input type="text" size="3" name="txtviewPageNo" value="<%=String.valueOf(cpage)%>">
				   </td>
										
	   <%          
	   //System.out.println("=======cpage is========"+cpage);
	   } 
	
		   if( cpage >1 )
	         {
		          navigationparams.put("mv","first");
			      pageContext.setAttribute("paramsMap", navigationparams);
 %>
		         <td width="5%" class="title" align="Left">                     
				 <html:link page='<%=stractiondo%>' name="paramsMap" scope="page">
						 <font color = "white" size="1pt"><bean:message key="label.first"/> </font>
				    </html:link>
				</td>  

	<%          }   
				else
				{
	 %>            
	               <td width="5%" class="title" align="Left">   
					 <font color = "#C0C0C0" size="1pt"><bean:message key="label.first"/> </font>
				 </td>

	 <%         } 
	
				if( cpage > 1 )
				{
                       navigationparams.put("mv","prev");
					   pageContext.setAttribute("paramsMap", navigationparams);

	%>				<td  width="8%"class="title"  align="Left">                     
						  <html:link page='<%=stractiondo%>' name="paramsMap" scope="page" >
						 <font color = "white" size="1pt"> <bean:message key="label.prev"/>  </font>
						 </html:link>
					</td>  
	<%          }   
				else
				{
	 %>             <td  width="8%"class="title"  align="Left">   
					    <font color = "#C0C0C0" size="1pt"> <bean:message key="label.prev"/> </font>
					</td>
	 <%         }                                      
				if( cpage < totalPages ) 
				{ 
                       navigationparams.put("mv","next");
					   pageContext.setAttribute("paramsMap", navigationparams);

					
	%>                <td  width="5%"class="title"  align="Right">                                      
     				 <html:link page='<%=stractiondo%>' name="paramsMap" scope="page" >
						  <font color = "white" size="1pt"> <bean:message key="label.next"/> </font>
					   </html:link>
					  </td>
	<%                         
		        } 
				else
				{
	%>            <td width="5%" class="title"  align="Right">
					  <font color = "#C0C0C0" size="1pt"> <bean:message key="label.next"/> </font>
				  </td>
	<%          }

	
				if( cpage < totalPages )
				{
		               navigationparams.put("mv","last");
					   pageContext.setAttribute("paramsMap", navigationparams);
	   %>					
	            <td  width="5%" class="title"  align="Right">                     
				  <html:link page='<%=stractiondo%>' name="paramsMap" scope="page" >
				 <font color = "white" size="1pt"> <bean:message key="label.last"/> </font>
				 </html:link>
				</td> 
	<%       
		          }   
				else
				{
	 %>             <td  width="5%" class="title"  align="Right">   
					 <font color = "#C0C0C0"size="1pt"> <bean:message key="label.last"/> </font>
					 </td> 
	 <%         } 
	
	 %> 
	
        </tr>
<%         } %>

</table>
  <table align="center" width="100%" border="0" cellpadding="2" cellspacing="1">


<%         if (customers == null || customers.size() == 0) { %>
        <tr>
          <td class="title" colspan="7" align="left"><bean:message key="msg.no.customer" /></td>
        </tr>
<%         } %>
       <tr>
         <th class="center" width="13%"><bean:message key="label.customer.id" /></th>
         <th class="center" width="18%"><bean:message key="label.company.name" /></th>
         <th class="center" width="23%"><bean:message key="label.contactperson" /></th>
         <th class="center" width="13%"><bean:message key="label.phone.number" /></th>
         <th class="center" width="8%"><bean:message key="label.services" /></th>&nbsp;
         <th class="center" width="17%"><bean:message key="label.jobs" /></th>&nbsp;	
         <th class="center" width="8%">&nbsp;<bean:message key="label.actions" />&nbsp;</th>
        </tr>
<%
        if (customers == null) {
%>
          <tr>
            <td class="list0" colspan=7 align="center">
              &nbsp;<br>
              <h3><bean:message key="msg.no.cust.found" /><br></h3>
              &nbsp;<br>
            </td>
          </tr>
        </table>
<%
      } else {
	        HashMap params = new HashMap();
		   	// Richa Added for Merge
			if(strOption.equalsIgnoreCase("List"))
			   params.put("actionflag","editfromlist");
			else if(strOption.equalsIgnoreCase("Search"))
				 params.put("actionflag","fromsearch");
        	// Richa Added for Merge
        //David 
        Connection connection = null;
        DatabasePool dbp =  (DatabasePool) session.getAttribute("database_pool");
        connection = (Connection) dbp.getConnection();
        
		for (int i=0;i<alist_PrevLoc.size();i++) //customers
			{
			   customerForm = (CustomerForm) alist_PrevLoc.get( i );

%>
      

          <tr align="left" align="middle">
            <td class="tableCell<%= i % 2 %>" valign="middle" align="center" width="1%">
			   <%
                 customerForm = (CustomerForm) alist_PrevLoc.get( i );	
		         String mv = null;
                 params.put("customerid",customerForm.getCustomerid());
                 params.put("mv",mv);
				         params.put("doResetReload","true");
		             pageContext.setAttribute("paramsMap", params);
			   %>
			<html:link page="/EditCustomerfromList.do" name="paramsMap" scope="page" >
			<%= customerForm.getCustomerid () %></a></td>
			</html:link>
            <td class="tableCell<%= i % 2 %>" valign="middle">
			<%= customerForm.getCompanyname() != null ? Utils.escapeXml(customerForm.getCompanyname()) : "" %></td>
            <td class="tableCell<%= i % 2 %>" valign="middle">
			<%= customerForm.getContactpersonname() == null ? "" : Utils.escapeXml(customerForm.getContactpersonname()) %> 
			<%= customerForm.getContactpersonsurname() == null ? "" : Utils.escapeXml(customerForm.getContactpersonsurname()) %>
			</td>
            <td class="tableCell<%= i % 2 %>" valign="middle" width="1%">
			<%= customerForm.getContactpersonphonenumber() != null ? Utils.escapeXml(customerForm.getContactpersonphonenumber()) : "" %></td>
           <%
		   	if(strOption.equalsIgnoreCase("List")){
			
			%>
			
			<td class="tableCell<%= i % 2 %>" align="center" valign="middle" width="1%">&nbsp;&nbsp;
				<html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
	            <html:img page="/images/Services.gif" border="0" title="Show service" align="center"/>
	           </html:link>
            </td>
          <td class="tableCell<%= i % 2 %>" align="left" valign="middle">
          	<%
          	// Start
          	int total=0;
          	int In_Progress=0;
          	int Waiting_Operator=0;          	
          	
          	Service[] service1 = Service.findByCustomerid(connection, customerForm.getCustomerid(),"(type like '%Attachment' or type like '%Site' or (type like '%VPN' or type like '%VPWS'))");
          	Service[] service2 = Service.findByCustomerid(connection, customerForm.getCustomerid()," (state like '%In_Progress' or state like '%Request_Sent')");
          	Service[] service3 = Service.findByCustomerid(connection, customerForm.getCustomerid()," (state like '%Waiting_Operator' )");
          	if(service1!=null){
          	total=service1.length;
            }
            if(service2!=null){
          	In_Progress=service2.length;
          	}
          	if(service3!=null){          	
          	Waiting_Operator=service3.length;          	
            }
            // End
          	%>
          	  <%= total %><span align=right> <bean:message key="label.job.total" /></span></br>
          	  <%= In_Progress %> <bean:message key="label.job.progress" /></br>
          	  <%
          	  if (Waiting_Operator==0){
          	  %>
          	  <%= Waiting_Operator %>  <bean:message key="label.job.waitoper" />
          	<%}else{
          	  %>          	  
          	  <font color="red"><%= Waiting_Operator %></font>  <bean:message key="label.job.waitoper" />          	          	            	            	  
          </td>   
          <% }%>       
            <td class="tableCell<%= i % 2 %>" align="center" valign="middle" width="1%">
           <%
			 HashMap deleteParams = new HashMap();
		     deleteParams.put("soft","true");
		     deleteParams.put("customerid",customerForm.getCustomerid());
			 deleteParams.put("deactivate","true");
			 pageContext.setAttribute("deleteparamsMap", deleteParams);
			if(isOperator)
			{
 			
             %>    
			  <html:link page="/EditCustomerfromList.do" name="paramsMap" scope="page" >
	          <html:img page="/images/Update.gif" border="0" title="Modify customer" align="left"/>
	          </html:link>

			  <html:link page="/DeleteCustomer.do" name="deleteparamsMap" scope="page" >
	           <html:img page="/images/DeleteCustomer.gif" border="0" title="Delete customer" align="left"/>
	           </html:link>
            <%
     	    }
			   }else if(strOption.equalsIgnoreCase("Search")){
			   	   	
			
			%>
			
			
			
			
				  <td class="list<%= i % 2 %>" align="center" valign="middle">
           &nbsp;
          &nbsp;
            <%
				 if (!customerForm.getStatus().equalsIgnoreCase("deleted"))
	         {
		   %>
               <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
	            <html:img page="/images/Services.gif" border="0" title="Show service" align="center"/>
	           </html:link>

           <%
	         }%>
<td class="tableCell<%= i % 2 %>" align="left" valign="middle">
          	<%
          	//The following logic and SQL should be simplified later.
          	//david Start
          	int total=0;
          	int In_Progress=0;
          	int Waiting_Operator=0;          	
          	
          	Service[] service1 = Service.findByCustomerid(connection, customerForm.getCustomerid()," (type like '%Attachment' or type like '%Site' or(type like '%VPN' or type like '%VPWS'))");
          	Service[] service2 = Service.findByCustomerid(connection, customerForm.getCustomerid()," (state like '%In_Progress' or state like '%Sent')");
          	Service[] service3 = Service.findByCustomerid(connection, customerForm.getCustomerid()," (state like '%Waiting_Operator' )");
          	if(service1!=null){
          	total=service1.length;
            }
            if(service2!=null){
          	In_Progress=service2.length;
          	}
          	if(service3!=null){
          	Waiting_Operator=service3.length;          	
            }
            //david End
          	%>
          	  <%= total %><span align=right> Total</span></br>
          	  <%= In_Progress %> In Progress</br>
          	  <%
          	  if (Waiting_Operator==0){
          	  %>
          	  <%= Waiting_Operator %>  Waiting Operator
          	<%}else{
          	  %>          	  
          	  <font color="red"><%= Waiting_Operator %></font>  Waiting Operator          	          	            	            	  
          </td>   
          <% }%>            	            	  
          
			   <td class="tableCell<%= i % 2 %>" align="center" valign="middle" width="1%">

           <% if(isOperator) { %>    
			   <html:link page="/EditCustomerfromSearch.do" name="paramsMap" scope="page">
	           <html:img page="/images/Update.gif" border="0" title="Modify customer" align="left"/>
	           </html:link>
		
				<% 
					
				HashMap deleteParams = new HashMap();
		        deleteParams.put("soft","true");
		        deleteParams.put("customerid",customerForm.getCustomerid());

				if (!customerForm.getStatus().equalsIgnoreCase("deleted")){ 
					
				 deleteParams.put("deactivate","true");
	             pageContext.setAttribute("deleteparamsMap", deleteParams);
	           
			   %>
		

			<html:link page="/DeleteCustomerfromSearch.do" name="deleteparamsMap" scope="page" >
	        <html:img page="/images/DeleteCustomer.gif" border="0" title="Delete customer" align="left"/>
	        </html:link>

			<%}else{
			
			  pageContext.setAttribute("deleteparamsMap", deleteParams);
			 %>
			<html:link page="/DeleteCustomerfromSearch.do" name="deleteparamsMap" scope="page" >
	        <html:img page="/images/DeleteCustomer.gif" border="0" title="Delete customer" align="left"/>
	        </html:link>
			<% }
			}
		}
	%>
            </td>
          </tr>
<%
        } //for loop
          	//david
            if(connection != null){   
	          dbp.releaseConnection(connection);
	          }        
        
%>

     <!-- </logic:iterate> -->

      </table>
<%
    }// else

%>
   <!-- <center>
      <h2>error</h2>
      <b>Error during search:</b>  -->
	
    <!--  <p><a href="javascript:window.history.back();"><img src="../images/back.gif" border="0" title="Back"></a>
    </center> -->
<%

%>
  </html:form>
      <script>
      	function trim(str){      		
      		return str.replace(/^\s*(.*?)[\s\n]*$/g, '$1'); 
      		}
      	
      	
     function callviewByPageNo()
	{
		
	    var error = false;
		var currentPageNo='<%=cpage%>';	
		var totalNoOfPages='<%=totalPages%>';	
		//document.forms[0].customerid.value = customerid;
		document.forms[0].currentPageNo.value = currentPageNo;
    
		var viewPageNo = trim(document.forms[0].txtviewPageNo.value);
		
		if(viewPageNo==null||viewPageNo=="")
		{
			alert(' <bean:message key="js.enter.number" /> ');
			error = true;
		}
		else
		{
		     if( parseInt(parseFloat(viewPageNo)) > parseInt(parseFloat(totalNoOfPages)))
		    {
			alert('<bean:message key="js.enter.number.hint" />'+viewPageNo+' <bean:message key="js.greater.number" />'+totalNoOfPages);
			error = true;
		     }
		    if(parseInt(parseFloat(viewPageNo))<=0)
		     {
			alert('<bean:message key="js.enter.number.hint" />'+viewPageNo+' <bean:message key="js.unavailable.number" />');
			error = true;
		     }
		}

		if(error==true)
		{
		
	     document.forms[0].txtviewPageNo.select();
         document.forms[0].txtviewPageNo.focus();
	   }
        else
		{
		 document.forms[0].viewPageNo.value = viewPageNo;
		var varOption = "<%=strOption%>";
		if(varOption=="List"){
		var page = "/crm/ListCustomer.do?mv=viewpageno&doResetReload=true&currentPageNo="+currentPageNo+"&viewPageNo="+
        viewPageNo;
		}
		else if(varOption=="Search"){
		var page = "/crm/SearchCustomerSubmit.do?mv=viewpageno&doResetReload=true&currentPageNo="+currentPageNo+"&viewPageNo="+
        viewPageNo+'&navigation=true';		
		}
        self.location.href = page;
		}
	}

   </script>
  </body>
</html:html>
