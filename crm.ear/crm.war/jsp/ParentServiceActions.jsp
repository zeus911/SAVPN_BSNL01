 <%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                --%>
<%-- FindAllServices.jsp                                            --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<!--              Set actions (delete, force delete, resend, modify, undo modify)        -->

  <input type="hidden" name="currentRs" value="<%=currentRs%>">
  <input type="hidden" name="lastRs" value="<%=lastRs%>">		
  <input type="hidden" name="totalPages" value="<%=totalPages%>">		

<%	 

String deleteIcon = "deleteIcon"+currentService.getServiceid();
String action_disable="/CommitDisableService.do";
String action_commitModify="/CommitModifyService.do";
if(searchSite!=null){
	action_disable="/CommitDisableServiceSearch.do";	
	action_commitModify="/CommitModifyServiceSearch.do";
}






if(!isOperator || foreignCustomerId != null)
	             { 
	               // if it is foreign customer - then no modifications for him	
%>
                 
 
				
			
					<td class="<%=serviceRowStyle%>"  valign="middle">
                      &nbsp;
                    </td>
<%
      
	  }else if (serviceState.indexOf(temporary) == -1)
						{
                        if(isServiceDisabled)
							{
                        	 if (!curVPNtype.equals("GIS-VPN")){
%>
                    <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;" valign="middle">

<%                     
//PR 15068, If disable_failure, still need disable; If enable_failure, still need enable.	
					if(serviceState.indexOf("Enable_Failure")==-1 && ( serviceState.indexOf(failure) != -1 || allowDisableVPN)  && ((String)service_bean_map.get(curVPNId+"_AllnotinProgress")).equals("Yes"))
	                   {
	                      disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","disable");
//richa- PR 11687
						  disableServiceParams.put("mv",pt);
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));					  
						  disableServiceParams.put("searchSite", searchSite);
						  disableServiceParams.put("siteidSearch", serviceid);
//richa- PR 11687
		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);
						 
	%>
                      <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page" 
					  onmouseover="return setStatus('Disable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                        
						 <html:img page="/images/off.gif"  onclick="this.style.visibility='hidden'" border="0" title="Disable service"/> 
						</html:link>
<%                      
					}else if (serviceState.indexOf("Disable_Failure")==-1){
						  disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","enable");
                          disableServiceParams.put("state",serviceState);
//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));						   
						   disableServiceParams.put("searchSite", searchSite);
						    disableServiceParams.put("siteidSearch", serviceid);
//richa- PR 11687
		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);						 
						 
	 %>
                     
					    <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"  
						onmouseover="return setStatus('Enable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                      
						 <html:img page="/images/on.gif"  onclick="this.style.visibility='hidden'" border="0"  title="Enable service"/> 
						</html:link>
                    
					</td>
<%
// GNAT 10483: Please Check here
%>
<%
}
                        	 }   } else
                        		 
		              if (serviceState.equals("Partialy_Enabled") || serviceState.equals(ok) && (serviceState.indexOf(sched) == -1)||((serviceState.indexOf("End_Time_Failure") != -1))) 
{
%>
                    <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
                    
					 <%
                           disableServiceParams.put("serviceid",currentService.getServiceid());
	                       disableServiceParams.put("customerid",currentService.getCustomerid());        
                           disableServiceParams.put("action","disable");
//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));						  
						   disableServiceParams.put("searchSite", searchSite);
						   disableServiceParams.put("siteidSearch", serviceid);
//richa- PR 11687
		                   pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);                    
if(serviceState.indexOf("Enable_Failure")==-1  && ((String)service_bean_map.get(curVPNId+"_AllnotinProgress")).equals("Yes") &&  (!curVPNtype.equals("GIS-VPN"))) {
	                  %>


					  <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
					  onmouseover="return setStatus('Disable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                       <html:img page="/images/off.gif"  onclick="this.style.visibility='hidden'" border="0" title="Disable service"/> 
					  </html:link>

<%
}else if(serviceState.indexOf("Disable_Failure")==-1 && allowEnableVPN) {
	                       
						  disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","enable");
	//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));						 
						   disableServiceParams.put("searchSite", searchSite);
						    disableServiceParams.put("siteidSearch", serviceid);

//richa- PR 11687

		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);  
	            
	%>
                      <html:link  page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
					  onmouseover="return setStatus('Enable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                         <html:img page="/images/on.gif" onclick="this.style.visibility='hidden'" border="0" title="Enable service"/>
					  </html:link>

<%                    }
                           deleteServiceParams.put("serviceid",currentService.getServiceid());

	                       deleteServiceParams.put("customerid",currentService.getCustomerid());        
                           deleteServiceParams.put("sendSaDeleteRequest","true");
			
//richa- PR 11687
						   deleteServiceParams.put("mv",pt);
						   deleteServiceParams.put("currentPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("viewPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("currentRs",String.valueOf(currentRs));
						   deleteServiceParams.put("lastRs",String.valueOf(lastRs));
						   deleteServiceParams.put("totalPages",String.valueOf(totalPages));

//richa- PR 11687
		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams);  
						   session.setAttribute("deleteParam",deleteServiceParams);

	%>
					  <html:link  page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
					  onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                        <img src="images/Delete.gif" id="<%= deleteIcon%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
					 </html:link>


<%    
			if (!currentService.getType().equals("GIS-VPN")){
						   modifyServiceParams.put("serviceid",currentService.getServiceid());
                           modifyServiceParams.put("customerid",currentService.getCustomerid());        
                           modifyServiceParams.put("parentserviceid",pServiceid);
//richa- PR 11687
						   modifyServiceParams.put("mv","viewpageno");
						   modifyServiceParams.put("currentPageNo",String.valueOf(cpage));
						   modifyServiceParams.put("viewPageNo",String.valueOf(cpage));
						   modifyServiceParams.put("searchSite", searchSite);
						   modifyServiceParams.put("siteidSearch", serviceid);
//richa- PR 11687

                           pageContext.setAttribute("modifyServiceParamsMap", modifyServiceParams);                    						  
  %>
                      <html:link page="/ModifyService.do" name="modifyServiceParamsMap" scope="page"
                      onmouseover="return setStatus('Modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                        <html:img page="/images/modify.gif" onclick="this.style.visibility='hidden'" border="0" title="Modify service"/>
					 </html:link>
                    </td>

<%               } } else {
                           deleteServiceParams.put("serviceid",currentService.getServiceid());
	                       deleteServiceParams.put("customerid",currentService.getCustomerid());        
                           deleteServiceParams.put("sendSaDeleteRequest","true");
//richa- PR 11687
						   deleteServiceParams.put("mv",pt);
						   deleteServiceParams.put("currentPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("viewPageNo",String.valueOf(cpage));
		   				   deleteServiceParams.put("currentRs",String.valueOf(currentRs));
						   deleteServiceParams.put("lastRs",String.valueOf(lastRs));
						   deleteServiceParams.put("totalPages",String.valueOf(totalPages));
//richa- PR 11687
		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams);                    

                       if (serviceState.equals(failure) || serviceState.equals(partial)) { %>
					  <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">

<input type="hidden" name="serviceid" value="<%= currentService.getServiceid()%>"/>

                        <html:link page="/DeleteService.do" name="deleteServiceParamsMap" scope="page"  onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
						onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                          <img src="images/Delete.gif"  id="<%= deleteIcon%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
						 </html:link>  <!--Richa added to hide button; 11978 -->


<%                    if (!currentService.getType().equals("layer2-VPWS") || !serviceState.equals(partial)) 
	                 { 
	
	                    resendCreateParams.put("serviceid",currentService.getServiceid());
								resendCreateParams.put("customerid",customerid);
								resendCreateParams.put("currentRs",String.valueOf(currentRs));
								resendCreateParams.put("lastRs",String.valueOf(lastRs));
								 resendCreateParams.put("mv","viewpageno");
								 resendCreateParams.put("currentPageNo",String.valueOf(cpage));
								 resendCreateParams.put("viewPageNo",String.valueOf(vPageNo));
								 resendCreateParams.put("totalPages",String.valueOf(totalPages));
								 resendCreateParams.put("type",currentService.getType());
								 resendCreateParams.put("sort",strSort);
								 resendCreateParams.put("resend","true");
								 pageContext.setAttribute("resendCreateParamsMap", resendCreateParams);
	%>
                        <html:link page="/CreateService.do" name="resendCreateParamsMap" scope="page" 
						onmouseover="return setStatus('Resend create', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                    <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" 
					title="Resend request to SA"/></html:link>  <!--Richa added to hide button; 11978 -->

<%                    } 

%>
                      </td>
<%                  } else {

                      if (serviceState.equals(delete_failure) || serviceState.equals(reuse_failure) )
						  {
						   deleteServiceParams.put("serviceid",currentService.getServiceid());
	                       deleteServiceParams.put("customerid",currentService.getCustomerid());        
                           deleteServiceParams.put("sendSaDeleteRequest","true");
//richa- PR 11687
						   deleteServiceParams.put("mv",pt);
						   deleteServiceParams.put("currentPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("viewPageNo",String.valueOf(cpage));
		   				   deleteServiceParams.put("currentRs",String.valueOf(currentRs));
						   deleteServiceParams.put("lastRs",String.valueOf(lastRs));
						   deleteServiceParams.put("totalPages",String.valueOf(totalPages));
//richa- PR 11687
		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams); 
						if(serviceState.equals(delete_failure)) 
							{
						  %>
                        <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
<input type="hidden" name="serviceid" value="<%= currentService.getServiceid()%>"/>

                          <html:link  page="/DeleteService.do" name="deleteServiceParamsMap" scope="page"  onclick="return deleteService();"
						  onmouseover="return setStatus('Drop','<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                            <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Force delete request to SA"/>  <!--Richa added to hide button; 11978 -->
							</html:link>

                        </td>
<%                    } 
						else {
						%>
						 <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
<input type="hidden" name="serviceid" value="<%= currentService.getServiceid()%>"/>

                          <html:link  page="/DeleteService.do" name="deleteServiceParamsMap" scope="page"  onclick="return deleteService();"
						  onmouseover="return setStatus('Drop','<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                            <html:img page="/images/Delete.gif" onclick="this.style.visibility='hidden'" border="0" title="Force delete request to SA"/>  <!--Richa added to hide button; 11978 -->
							</html:link>

                        </td>
						<%
						}
						  }
						else {
                            deleteServiceParams.put("serviceid",currentService.getServiceid());
	                        deleteServiceParams.put("customerid",currentService.getCustomerid());        
                            deleteServiceParams.put("sendSaDeleteRequest","true");
//richa- PR 11687
						    deleteServiceParams.put("mv",pt);
						    deleteServiceParams.put("currentPageNo",String.valueOf(cpage));
						    deleteServiceParams.put("viewPageNo",String.valueOf(cpage));
		   				    deleteServiceParams.put("currentRs",String.valueOf(currentRs));
						    deleteServiceParams.put("lastRs",String.valueOf(lastRs));
						    deleteServiceParams.put("totalPages",String.valueOf(totalPages));
//richa- PR 11687
		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams); 

                        if (serviceState.indexOf(modify) != -1 && serviceState.indexOf(failure) != -1) {
	%>
                          <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">

						  <input type="hidden" name="serviceid" value="<%= currentService.getServiceid()%>"/>

                            <html:link page="/DeleteService.do" name="deleteServiceParamsMap" scope="page"  onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
							onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              <img src="images/Delete.gif" id="<%= deleteIcon%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
							  </html:link> <!--Richa added to hide button; 11978 -->

                            <html:link page="/UndoModifyService.do" name="undomodifyParamsMap" scope="page" 
							onmouseover="return setStatus('Undo modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              <html:img page="/images/undomodify.gif" onclick="this.style.visibility='hidden'" border="0" title="Undo the modify action"/> <!--Richa added to hide button; 11978 -->
							  </html:link>

<%                      
                            if (lastModifyAction != null) 
	                        {
	                            
								nextstate = (String)nextStateMap.get(serviceState);									
								resendModifyParams.put("serviceid",currentService.getServiceid());
	                            resendModifyParams.put("customerid",currentService.getCustomerid());        
                                resendModifyParams.put("action",lastModifyAction.getValue());
								resendModifyParams.put("state",nextstate);
								resendModifyParams.put("mv","viewpageno");
								resendModifyParams.put("currentPageNo",String.valueOf(cpage));
								resendModifyParams.put("viewPageNo",String.valueOf(cpage));
								resendModifyParams.put("currentRs",String.valueOf(currentRs));
								resendModifyParams.put("lastRs",String.valueOf(lastRs));
								resendModifyParams.put("totalPages",String.valueOf(totalPages));
								resendModifyParams.put("searchSite", searchSite);
								resendModifyParams.put("siteidSearch", serviceid);
								
	                            pageContext.setAttribute("resendModifyParamsMap", resendModifyParams); 

	                   
	%>
                              <html:link page="<%=action_commitModify%>" name="resendModifyParamsMap" scope="page"
							  onmouseover="return setStatus('Resend modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Resend modify request to SA"/>
								</html:link> <!--Richa added to hide button; 11978 -->
<%                          } %>
                        
						  </td>

<%                      } else {
                            if(serviceState.equals("Wait_Start_Time_Failure"))
								{
						   deleteServiceParams.put("serviceid",currentService.getServiceid());
	                       deleteServiceParams.put("customerid",currentService.getCustomerid());        
                           deleteServiceParams.put("sendSaDeleteRequest","false");
//richa- PR 11687
						   deleteServiceParams.put("mv",pt);
						   deleteServiceParams.put("currentPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("viewPageNo",String.valueOf(cpage));
		   				   deleteServiceParams.put("currentRs",String.valueOf(currentRs));
						   deleteServiceParams.put("lastRs",String.valueOf(lastRs));
						   deleteServiceParams.put("totalPages",String.valueOf(totalPages));
//richa- PR 11687	
		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams); 							
%>
                            <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
							<input type="hidden" name="serviceid" value="<%= currentService.getServiceid()%>"/>

                              <html:link   page="/DeleteService.do" name="deleteServiceParamsMap" scope="page"  onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
							  onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <img src="images/Delete.gif"  id="<%= deleteIcon%>"  onclick="this.style.visibility='hidden'" border="0" title="Drop service without request to SA"/>
                                 </html:link> <!--Richa added to hide button; 11978 -->
                            </td>

        <%                  } else{
                               if(serviceState.equals(modify_partial))
								   {
                                 
						   deleteServiceParams.put("serviceid",currentService.getServiceid());
	                       deleteServiceParams.put("customerid",currentService.getCustomerid());        
                           deleteServiceParams.put("sendSaDeleteRequest","true");
		//richa- PR 11687
						   deleteServiceParams.put("mv",pt);
						   deleteServiceParams.put("currentPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("viewPageNo",String.valueOf(cpage));
		   				   deleteServiceParams.put("currentRs",String.valueOf(currentRs));
						   deleteServiceParams.put("lastRs",String.valueOf(lastRs));
						   deleteServiceParams.put("totalPages",String.valueOf(totalPages));
		//richa- PR 11687	
		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams); 
         %>
                              <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
							<input type="hidden" name="serviceid" value="<%= currentService.getServiceid()%>"/>

                               <html:link page="/DeleteService.do" name="deleteServiceParamsMap" scope="page"  onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
								onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                 <img src="images/Delete.gif" id="<%= deleteIcon%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/> <!--Richa added to hide button; 11978 -->
							  </html:link>
                               
                           <%
                                nextstate = (String)nextStateMap.get(serviceState.replaceAll(partial, failure));						
								resendModifyParams.put("serviceid",currentService.getServiceid());
	                            resendModifyParams.put("customerid",currentService.getCustomerid());        
                                resendModifyParams.put("action",lastModifyAction.getValue());
								resendModifyParams.put("state",nextstate);
								resendModifyParams.put("mv","viewpageno");
								resendModifyParams.put("currentPageNo",String.valueOf(cpage));
								resendModifyParams.put("viewPageNo",String.valueOf(cpage));
								resendModifyParams.put("currentRs",String.valueOf(currentRs));
								resendModifyParams.put("lastRs",String.valueOf(lastRs));
								resendModifyParams.put("totalPages",String.valueOf(totalPages));
								resendModifyParams.put("searchSite", searchSite);
								resendModifyParams.put("siteidSearch", serviceid);
								
								resendModifyParams.put("UndoModify","true");
	                            pageContext.setAttribute("resendModifyParamsMap", resendModifyParams); 
						   %>

                              <html:link page="/UndoModifyService.do" name="undomodifyParamsMap" scope="page" 
							  onmouseover="return setStatus('Send undo modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <html:img page="/images/undomodify.gif" onclick="this.style.visibility='hidden'" border="0" title="Send undo modify request to SA"/> <!--Richa added to hide button; 11978 -->
							  </html:link>

                              <html:link page="<%=action_commitModify%>" name="resendModifyParamsMap" scope="page" 
							  onmouseover="return setStatus('Resend modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Resend modify request to SA"/> <!--Richa added to hide button; 11978 -->
								</html:link>
                                </td>

                               <% }else{ 
                               	//System.out.println("The state is="+serviceState);
                                    if(serviceState.equals("MSG_Failure")){
                                    
                                    
                           deleteServiceParams.put("serviceid",currentService.getServiceid());
	                         deleteServiceParams.put("customerid",currentService.getCustomerid());        
                           deleteServiceParams.put("sendSaDeleteRequest","true");
			

						   deleteServiceParams.put("mv",pt);
						   deleteServiceParams.put("currentPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("viewPageNo",String.valueOf(cpage));
						   deleteServiceParams.put("currentRs",String.valueOf(currentRs));
						   deleteServiceParams.put("lastRs",String.valueOf(lastRs));
						   deleteServiceParams.put("totalPages",String.valueOf(totalPages));

		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams);  
						   session.setAttribute("deleteParam",deleteServiceParams);
%>         
           <td class="<%=serviceRowStyle%>" style="text-align: left; padding-left: 12px;" valign="middle">                           
           <html:link  page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
					  onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                        <img src="images/Delete.gif" id="<%= deleteIcon%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
					 </html:link>
<%              resendCreateParams.put("serviceid",currentService.getServiceid());
								resendCreateParams.put("customerid",customerid);
								resendCreateParams.put("currentRs",String.valueOf(currentRs));
								resendCreateParams.put("lastRs",String.valueOf(lastRs));
								 resendCreateParams.put("mv","viewpageno");
								 resendCreateParams.put("currentPageNo",String.valueOf(cpage));
								 resendCreateParams.put("viewPageNo",String.valueOf(vPageNo));
								 resendCreateParams.put("totalPages",String.valueOf(totalPages));
								 resendCreateParams.put("type",currentService.getType());
								 resendCreateParams.put("sort",strSort);
								 resendCreateParams.put("resend","true");
								 pageContext.setAttribute("resendCreateParamsMap", resendCreateParams);
	%>
                        <html:link page="/CreateService.do" name="resendCreateParamsMap" scope="page" 
						onmouseover="return setStatus('Resend create', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                    <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" 
					title="Resend request to SA"/></html:link>  <!--Richa added to hide button; 11978 -->

				 </td>                    
<%                                  }else{               	
                               	%>

                                    <td class="<%=serviceRowStyle%>">None</td>
<%                                     } 
                               }
                            }
                        } %>
<%                    } %>
<%                  } %>
<%                }
%>

	  <%                 } else {
	  	//System.out.println("========================================"+serviceState);
	  	 %>
                              <td class="<%=serviceRowStyle%>">None</td>
<%                } %>

