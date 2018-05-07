<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--																		      --%>
<%--		ChildServiceActions.jsp												  --%>
<%--				This file reffred by the FindAllServices.jsp				  --%>
<!--                  Set actions (delete, force delete, resend, modify, undo modify)-->

<%                  
                           //PR 15068
						   
						   String action_disable="/CommitDisableService.do";							
							String action_commitModifyChild="/CommitModifyService.do";							
							if(searchSite!=null){
								action_disable="/CommitDisableServiceSearch.do";								
								action_commitModifyChild="/CommitModifyServiceSearch.do";	
							}
	                   String curSiteAtt = null;        
	                   int AttachmentsFail = 0;        
                           if((currentService.getType()).equals("Site")){
                           	// We should know which VPN it is
                           	deleteServiceParams.put("parentserviceid",curVPNId);
							resendCreateParams.put("parentserviceid",curVPNId);
                           	modifyServiceParams.put("parentserviceid",curVPNId);
                           	disableServiceParams.put("parentserviceid",curVPNId);
                           	undomodifyParams.put("parentserviceid",curVPNId);
                           	resendModifyParams.put("parentserviceid",curVPNId);
                           	deleteServiceParams.put("type",currentService.getType());
                           	modifyServiceParams.put("type",currentService.getType());
                           	disableServiceParams.put("type",currentService.getType());
                           	undomodifyParams.put("type",currentService.getType());
                           	resendModifyParams.put("type",currentService.getType());
                           	deleteServiceParams.put("curVPNtype",curVPNtype);
                           	modifyServiceParams.put("curVPNtype",curVPNtype);
                           	disableServiceParams.put("curVPNtype",curVPNtype);
                           	undomodifyParams.put("curVPNtype",curVPNtype);
                           	resendModifyParams.put("curVPNtype",curVPNtype);
							undomodifyParams.put("searchSite", searchSite);
							undomodifyParams.put("siteidSearch", serviceid);
                           	//logger.debug("ChildServiceActions.jsp: Site_"+currentService.getPresname()+" 's VPNId is"+curVPNId);
                           	//Also need one siteattachmentid
				
				StringBuffer tmpVPNSite = new StringBuffer(curVPNId+"_"+currentService.getServiceid());
				
				ServiceBean tmpsiteService = (ServiceBean)service_bean_map.get(tmpVPNSite.toString()+"_"+cnt);
				
				if(tmpsiteService!=null){
					ServiceBean[] tmpattachments=tmpsiteService.getChildServicesArray();
				//logger.debug("ChildServiceActions.jsp: For delete and modify: tmpattachments's length is"+tmpattachments.length);
				int att_disabled = 0;
				int ijk = 0;
				//check added to diplay fialure sites with out any attachments-PR:18384
				if(tmpattachments != null){
				for(ijk=0;ijk<tmpattachments.length;ijk++){
					//logger.debug("Site "+currentService.getServiceid()+"'s serBean_child["+ijk+"]'s serviceid is:"+tmpattachments[ijk].getServiceid()+", sername is:"+tmpattachments[ijk].getPresname()+", protocol is "+tmpattachments[ijk].getPe_ce_routingprotocol());	
					String attState = null;
					attState = tmpattachments[ijk].getState();
					
					if (!"PE_Ok".equals(attState) && !"PE_Disabled".equals(attState) && !"PE_CE_Disabled".equals(attState) 
								&& !"Ok".equals(attState) && !"PE_CE_Ok".equals(attState)) {
						AttachmentsFail = 1;
						//logger.debug("ChildServiceActions.jsp: siteAtt["+ijk+"] is not OK, set AttachmentsFail to 1");
					}
					//if ("PE_Disabled".equals(attState)){
					if(attState != null && attState.indexOf("Disabled") != -1){
					//PR 15068, add for disable action don't disable all siteattachments under the VPN and return Ok, so we should judge whether we should show disable 
						att_disabled++;	
					}
				}
				if (att_disabled==ijk) {
					logger.debug("ChildServiceActions.jsp: att_disabled = ijk, set SiteDisabled to 1");
					serviceState = "Disabled";
					isSubDisabled = serviceState.indexOf(disabled) != -1 ||
                            (serviceState.indexOf(disable) != -1 && serviceState.indexOf(failure)!=-1) ||
                              (serviceState.indexOf(enable) != -1 && serviceState.indexOf(failure)!=-1);
					
				}
				curSiteAtt = tmpattachments[0].getServiceid();
				deleteServiceParams.put("attachmentid", curSiteAtt);
				modifyServiceParams.put("attachmentid", curSiteAtt);
                           	disableServiceParams.put("attachmentid", curSiteAtt);
                           	undomodifyParams.put("attachmentid", curSiteAtt);
                           	resendModifyParams.put("attachmentid", curSiteAtt);
				//logger.debug("We will pass VPN_"+curVPNId+", Site_"+currentService.getServiceid()+", SiteAtt_"+curSiteAtt);				
                           }
                           }
						   }
                           //PR 15068
%>                           		
<%               
				     deleteIconChild = "deleteIcon"+currentService.getServiceid();             
			 		 actionsflagval = currentService.getActionsflag();

				 //for Partial_Disabled
				if(serviceState.indexOf(enable) != -1 || serviceState.indexOf("Ok") != -1){
					actionsflagval = true;
				}
				//for CE Setup Ok	
				if(serviceState.indexOf(disable) != -1){
					actionsflagval = false;
				} 
				
				
				
              // System.out.println("============getServiceid() is: "+currentService.getServiceid()+"=======state is ====="+serviceState+"  =======type is======"+currentService.getType());
				
					
      				// this value determines if the actions icons to be displayed for the services  		   
					   if(!(isOperator)|| foreignCustomerId != null)
	                  {// if it is foreign customer or not operator- then no  modifications for him 
				 
%>
                      <td class="<%=rowStyle%>"  valign="middle">&nbsp;</td>
<%
                        
                      } else if (serviceState.indexOf(temporary) == -1 && (exp_siteService.getState().indexOf("Ok")!=-1 ||exp_siteService.getState().indexOf("Disabled")!=-1|| exp_siteService.getState().equals("Partial_Disabled") || currentService.getType().indexOf("Site") !=-1)
					             && ( !currentService.getType().equals(Constants.TYPE_LAYER3_PROTECTION) || allowModifyControlsForProtectionAttachment ) ){
                      //else if (serviceState.indexOf(temporary) == -1 && (exp_siteService.getState().indexOf("Ok")!=-1 ||exp_siteService.getState().indexOf("Disabled")!=-1|| exp_siteService.getState().equals("Partial_Disabled") || currentService.getType().indexOf("Site") !=-1 )){
                     	
		
                      //PR 15068, VPWS no site actions, even if site's attachment failed, no more action.
						
	                 if((actionsflagval == null || actionsflagval.booleanValue()) && !"layer2-VPWS".equals(curVPNtype) && 0==AttachmentsFail){
						

                      if(isSubDisabled ){
                        // Subservice is disabled or disable failed or enable failed
                          disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","disable");
						//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));
						   disableServiceParams.put("searchSite", searchSite);

//richa- PR 11687
		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);                    

                        %>
                        <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
<%              //PR 15068, for if sitestate is Disable_Failure, disable and enable icon both are displayed, too weird.      
		if(serviceState.indexOf("Disable_Failure")==-1 && serviceState.indexOf(failure) != -1 
			//Partial_Disabled  && !(currentService.getType()).equals("layer3-Attachment")
		){ %>
                          <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
						  onmouseover="return setStatus('Disable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                            <html:img page="/images/off.gif" onclick="this.style.visibility='hidden'" border="0" title="Disable service"/>
							</html:link>
<%                      } %>
                        
						<% 
							  disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","Enable");
						//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));
						   disableServiceParams.put("searchSite", searchSite);

//richa- PR 11687
		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);          
	//PR 15068
	//Now only site has disable and enable action
	if((currentService.getType()).equals("Site")){
							%>
						  <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
						  onmouseover="return setStatus('Enable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                            <html:img page="/images/on.gif" onclick="this.style.visibility='hidden'" border="0" title="Enable service"/>
                          </html:link>
						  <%
							  //Partial_Disabled
						  if(serviceState.indexOf("Partial_Disabled") != -1){
							  disableServiceParams.put("action","Disable");
						  %>
<html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
						  onmouseover="return setStatus('Enable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                            <html:img page="/images/off.gif" onclick="this.style.visibility='hidden'" border="0" title="Disable service"/>
                          </html:link>
						  <%
						  
						  }
						  }
	%>
                        </td>
                        <%
                    }else if ( (serviceState.indexOf(ok) != -1 && serviceState.indexOf(sched) == -1) || (serviceState.indexOf("End_Time_Failure") != -1 )) {
					%>		
                    <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">

					
					<%
						
						  if(
							  //Partial_Disabled 
								//!(currentService.getType()).equals("layer3-Attachment")&&
								!(currentService.getType()).equals("layer2-Attachment")&& 
							  !(currentService.getType()).equals("vpws-Attachment")){
						  
						  disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","disable");
					//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));
						   disableServiceParams.put("searchSite", searchSite);

//richa- PR 11687
		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);                    						

//PR 15068
				if(!((currentService.getType()).equals("Site") && curVPNtype.equals("layer2-VPWS"))){	
							%>
 
                       

                          <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
						  onmouseover="return setStatus('Disable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                           <html:img page="/images/off.gif" onclick="this.style.visibility='hidden'" border="0" title="Disable service"/>
						 </html:link>

							<%
				}
//End of PR 15068
						  }
//PR 15068                       
				
						    if((currentService.getType()).equals("Site") && curVPNtype.equals("layer3-VPN") &&  currentService.getChildServicesArray() != null ){
								//don't do any thing special for now 
							}
						    else if((currentService.getType()).equals("Site") && curVPNtype.equals("GIS-VPN") &&  currentService.getChildServicesArray() != null ){
								//don't do any thing special for now 
							}
						    else
								if((currentService.getType()).equals("Site") && curVPNtype.equals("layer2-VPN") &&  currentService.getChildServicesArray() != null ){
								//don't do any thing special for now 
							}else
								if((currentService.getType()).equals("Site") && curVPNtype.equals("layer2-VPWS") &&  currentService.getChildServicesArray() != null ){
								//don't do any thing special for now 
							}else								
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
//chling- PR 15068
				if(!(currentService.getType()).equals("vpws-Attachment") && !(currentService.getType()).equals("Site")){	

							%>

                          <html:link page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
						  onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                           <img src="images/Delete.gif" id="<%= deleteIconChild%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
                          </html:link>
<%
				}
}
						  //Added by divya to fix PR 14421
	if(serviceState.equalsIgnoreCase("PE_Modify_Wait_End_Time_Failure"))
	{
%>


	<html:link page="/UndoModifyService.do" name="undomodifyParamsMap" scope="page"
							onmouseover="return setStatus('Undo modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              <html:img page="/images/undomodify.gif" onclick="this.style.visibility='hidden'" border="0" title="Undo the modify action"/>
							  </html:link>
						


<%                     
	             
							}//PR 14421 fix ends here
				 modifyServiceParams.put("serviceid",currentService.getServiceid());
                 modifyServiceParams.put("customerid",currentService.getCustomerid());   
                 // modified by tanye
                 modifyServiceParams.put("parentserviceid",curVPNId);//put pserviceid here
//richa- PR 11687
				 modifyServiceParams.put("mv","viewpageno");
				 modifyServiceParams.put("currentPageNo",String.valueOf(cpage));
				 modifyServiceParams.put("viewPageNo",String.valueOf(cpage));
				 modifyServiceParams.put("currentRs",String.valueOf(currentRs));
				 modifyServiceParams.put("lastRs",String.valueOf(lastRs));
				 modifyServiceParams.put("totalPages",String.valueOf(totalPages));
				 modifyServiceParams.put("type",(currentService.getType().equals("layer3-Protection"))?"layer3-Attachment":currentService.getType());
				 modifyServiceParams.put("searchSite", searchSite);
				 modifyServiceParams.put("siteidSearch", serviceid);
				 //String l3AttachmentType = (currentService.getType().equals("layer3-Protection"))?"protection":"initial";
//richa- PR 11687
                 pageContext.setAttribute("modifyServiceParamsMap", modifyServiceParams); 
	
					
                    if (((serviceState.indexOf(ok) != -1 || "Partialy_Enabled".equals(serviceState) ||  
//PR 15068
						  "Partialy_Disabled".equals(serviceState)) && !serviceState.equals(ce_ok))&& ((currentService.getType()).equals("layer3-Attachment")|| (currentService.getType()).equals("layer3-Protection")||(currentService.getType()).equals("GIS-Attachment") ||(currentService.getType()).equals("GIS-Protection") || (currentService.getType()).equals("layer2-Attachment"))) { %>

                            <html:link page="/ModifyService.do" name="modifyServiceParamsMap" scope="page"
                             onmouseover="return setStatus('Modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              <html:img page="/images/modify.gif" onclick="this.style.visibility='hidden'" border="0" title="Modify service"/>
							  </html:link>
<%                        } %>

                        </td>
<%                    } else if (serviceState.equals(reuse_failure) && ((currentService.getType()).equals("layer2-Attachment") || (currentService.getType()).equals("layer3-Attachment")||(currentService.getType()).equals("GIS-Attachment"))) {
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
%>
<td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
                              
							   <html:link  page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
							   onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <html:img page="/images/Delete.gif" onclick="this.style.visibility='hidden'" border="0" title="Force delete request to SA"/>
                              </html:link>
                            </td>
<%                            
			}else {
                        if (serviceState.indexOf(modify) != -1 && serviceState.indexOf(failure) != -1 && serviceState.indexOf("End") == -1) { 
							
							
                           /*PR15020 no use now
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
*/
							
							
							%>
                          <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">

<% /* %>                       <!--PR15020  <html:link page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
							onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              <img src="images/Delete.gif" id="<%= deleteIconChild%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
							  </html:link>-->
<% */ %>                            
							<html:link page="/UndoModifyService.do" name="undomodifyParamsMap" scope="page"
							onmouseover="return setStatus('Undo modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              <html:img page="/images/undomodify.gif" onclick="this.style.visibility='hidden'" border="0" title="Undo the modify action"/>
							  </html:link>

<%
                            if (lastModifyAction != null && serviceState.indexOf("Wait_Start_Time_Failure") == -1) 
	                      {  
	                             nextstate = (String)nextStateMap.get(serviceState);						
								resendModifyParams.put("serviceid",currentService.getServiceid());
	                            resendModifyParams.put("customerid",currentService.getCustomerid());        
                                resendModifyParams.put("action",lastModifyAction.getValue());
								resendModifyParams.put("state",nextstate);
								//richa- PR 11687
								 resendModifyParams.put("mv","viewpageno");
								 resendModifyParams.put("currentPageNo",String.valueOf(cpage));
								 resendModifyParams.put("viewPageNo",String.valueOf(cpage));
								 resendModifyParams.put("currentRs",String.valueOf(currentRs));
								 resendModifyParams.put("lastRs",String.valueOf(lastRs));
								 resendModifyParams.put("totalPages",String.valueOf(totalPages));
				//richa- PR 11687
								
	                            pageContext.setAttribute("resendModifyParamsMap", resendModifyParams); 
//PR 15068
				if((currentService.getType()).equals("layer3-Attachment") || (currentService.getType()).equals("layer3-Protection")){	
					//jacqie - PR 15353
					//PR 16590
					//resendModifyParams.put("action","resend_modify");
	%>
                              <!--html:link page="<%=action_commitModifyChild%>" name="resendModifyParamsMap" scope="page" 
							  onmouseover="return setStatus('Resend modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();"-->
                                <!--html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Resend modify request to SA"/--><!--%=lastModifyAction.getValue()%--> <!--Jacqie PR xxxx-->
								<!--/html:link-->
<%				}
                          } %>

                          </td>
<%                      } else {
                          if(serviceState.equals("Wait_Start_Time_Failure") || serviceState.equals("PE_Wait_Start_Time_Failure") || serviceState.equals("PE_CE_Wait_Start_Time_Failure"))
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
                            <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">

                              <html:link page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
							  onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <img src="images/Delete.gif" id="<%= deleteIconChild%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service without request to SA"/>
								</html:link>
                            </td>
                     <%   }
                          else if (serviceState.equals(delete_failure) || serviceState.equals(reuse_failure))
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
                            <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
                              
							   <html:link  page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
							   onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
<%//chling- PR 15068
				if((currentService.getType()).equals("layer3-Attachment") || (currentService.getType()).equals("layer3-Protection")
				||(currentService.getType()).equals("GIS-Attachment") || (currentService.getType()).equals("GIS-Protection")
				//jacqie - PR 15316
				||(currentService.getType()).equals("layer2-Attachment")
				){	%>
                               
								<img src="images/arrow_submit.gif" id="<%= deleteIconChild%>" onclick="this.style.visibility='hidden'" border="0" title="Resend delete request to SA"/>
<!--
								<html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Resend delete request to SA"/> -->
<%}%>                                
                              </html:link>

                            </td>
<%                        } else {
                            Boolean undoModifyButtonShown=false;
                            if((serviceState.indexOf(partial) != -1) && (serviceState.indexOf(modify) != -1))
							{
						
							
								String resend_action= "";
								String undo_action = "";
								Connection con = null;
								DatabasePool dbp = null;
								dbp = (DatabasePool)session.getAttribute(Constants.DATABASE_POOL);
								con = (Connection)dbp.getConnection();
								if ( currentService.getType().equals(Constants.TYPE_LAYER3_ATTACHMENT) ) {
									//For attachements lastModifyAction is never set. With VPN 6.0 release
									//all the modify operations on L3 site (Join, Leave, ConnectivityType and Multicast) 
									// have been moved to L3 attachment. So if these modify operations partially fail
									// we have to display "Send Undo modify Request to SA" and "Resend" option.
									// So we need to find the last modify operation of the L3 attachment.
									ServiceParameter tmplastModifyAction =	ServiceParameter.findByServiceidattribute(con, currentService.getServiceid(), Constants.SERVICE_PARAM_HIDDEN_LASTMODIFYACTION); 
									if ( tmplastModifyAction != null 
										&& ( tmplastModifyAction.getValue().equals(Constants.ACTION_JOIN_VPN)
											  || tmplastModifyAction.getValue().equals(Constants.ACTION_LEAVE_VPN)
											  || tmplastModifyAction.getValue().equals(Constants.ACTION_MODIFYCONNECTIVITYTYPE)
											  || tmplastModifyAction.getValue().equals(Constants.ACTION_MODIFYMULTICAST)
											) 
										)
									{
										//If the attachment last modify operation falls into join, leave, connectivitytype or multicast
										//update the lastModifyAction to display "Send Undo modify Request to SA" and "Resend" option.
										lastModifyAction = tmplastModifyAction;
										//These modify operations are applicable only on initial attachment.
										//So, if there is a failure in these modify operation, then do not show any
										//controls for protection attachment.
										allowModifyControlsForProtectionAttachment=false;
									}
				
								}
								//Added to fix PR 14196
								if(lastModifyAction!=null)
								{
									resend_action =lastModifyAction.getValue();
									undo_action = lastModifyAction.getValue();
								}
								//ends here
								if(resend_action.equals(Constants.ACTION_JOIN_VPN))
										undo_action =Constants.ACTION_LEAVE_VPN;
								if(resend_action.equals(Constants.ACTION_LEAVE_VPN))
										undo_action =Constants.ACTION_JOIN_VPN;

            /*                deleteServiceParams.put("serviceid",currentService.getServiceid());
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
*/
%>
                              <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
<% /* %>								<!--<html:link  page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
								onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                  <img src="images/Delete.gif" id="<%= deleteIconChild%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
								 </html:link> -->
<% */ %>								
							<html:link page="/UndoModifyService.do" name="undomodifyParamsMap" scope="page"
							onmouseover="return setStatus('Undo modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              				<html:img page="/images/undomodify.gif" onclick="this.style.visibility='hidden'" border="0" title="Undo the modify action"/>
								 </html:link>
                              <%
			        undoModifyButtonShown=true;
                    
								String multicastStatusForResend = "enabled";
								String multicastStatusForUndo = "disabled";
								  
								try
								{
									ServiceParameter servParam = ServiceParameter.findByServiceidattribute(con, currentService.getServiceid(), "Site_Service_id"); 
									
									String siteServiceId = servParam.getValue();
  
									com.hp.ov.activator.vpn.inventory.Site siteObj = com.hp.ov.activator.vpn.inventory.Site.findByServiceid(con, siteServiceId);
									
									if (siteObj != null)
									{
										if ("enabled".equals(siteObj.getMulticast()))
										{
											multicastStatusForResend = "disabled";
											multicastStatusForUndo = "enabled";
										}
									}
									else
									{
										com.hp.ov.activator.vpn.inventory.MulticastSite mcastSiteObj = com.hp.ov.activator.vpn.inventory.MulticastSite.findByAttachmentid(con, currentService.getServiceid());
										
										if (mcastSiteObj != null)
										{
											multicastStatusForResend = "disabled";
											multicastStatusForUndo = "enabled";
										}
									}         
								}
								catch (SQLException sqle)
								{ %>
									<%= sqle.getMessage () %>.
									<%  return;
								}
								catch (Exception e) 
								{ %>
									<%= e.getMessage () %>.
									<%  return;
								}
								finally
								{
									if (con != null)
									{
										try 
										{
											con.close();
										}
										catch (Exception rollbackex)
										{
											// Ignore
										}
									}
								}

                                nextstate = (String)nextStateMap.get(serviceState);						
								resendModifyParams.put("serviceid",currentService.getServiceid());
	                            resendModifyParams.put("customerid",currentService.getCustomerid());        
                                resendModifyParams.put("action",undo_action);
								resendModifyParams.put("state",nextstate);
								resendModifyParams.put("MulticastStatus",multicastStatusForUndo);
								resendModifyParams.put("UndoModify","true");
								//richa- PR 11687
								 resendModifyParams.put("mv","viewpageno");
								 resendModifyParams.put("currentPageNo",String.valueOf(cpage));
								 resendModifyParams.put("viewPageNo",String.valueOf(cpage));
								 resendModifyParams.put("currentRs",String.valueOf(currentRs));
								 resendModifyParams.put("lastRs",String.valueOf(lastRs));
								 resendModifyParams.put("totalPages",String.valueOf(totalPages));
								 resendModifyParams.put("searchSite", searchSite);
								resendModifyParams.put("siteidSearch", serviceid);
				//richa- PR 11687
	                            pageContext.setAttribute("resendModifyParamsMap", resendModifyParams); 
							
							 if(lastModifyAction!=null)
							{
							  %>

							  <html:link page="<%=action_commitModifyChild%>" name="resendModifyParamsMap" scope="page" 
							  onmouseover="return setStatus('Send undo modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <html:img page="/images/undomodify.gif" onclick="this.style.visibility='hidden'" border="0" title="Send undo modify request to SA"/>
							  </html:link>	
                             <%
                             
							}
                                nextstate = (String)nextStateMap.get(serviceState.replaceAll(partial, failure)); 
                                //Get last modify multicast status and resend message with the state.

                                ServiceParameter  nextstate2=	ServiceParameter.findByServiceidattribute(con, currentService.getServiceid(), "MulticastStatus"); //David add
								// modified above line for PR17606
								String value=null;
							    if (nextstate2 != null) {

								 value = nextstate2.getValue();

								 } else {
									 value = value;

								 }
                                if(con != null){
				                           dbp.releaseConnection(con);
				                          }
								resendModifyParams.put("serviceid",currentService.getServiceid());
	                            resendModifyParams.put("customerid",currentService.getCustomerid());        
                                resendModifyParams.put("action",resend_action);
								resendModifyParams.put("state",nextstate);
								resendModifyParams.put("MulticastStatus",multicastStatusForResend);
								resendModifyParams.put("UndoModify","false");
								resendModifyParams.put("mv","viewpageno");
								resendModifyParams.put("currentPageNo",String.valueOf(cpage));
								resendModifyParams.put("viewPageNo",String.valueOf(cpage));
								resendModifyParams.put("currentRs",String.valueOf(currentRs));
								resendModifyParams.put("lastRs",String.valueOf(lastRs));
								resendModifyParams.put("totalPages",String.valueOf(totalPages));
								resendModifyParams.put("searchSite", searchSite);
								resendModifyParams.put("siteidSearch", serviceid);
								
	                            pageContext.setAttribute("resendModifyParamsMap", resendModifyParams); 
								if(lastModifyAction!=null)
								{
								
							  %>
							  <html:link page="<%=action_commitModifyChild%>" name="resendModifyParamsMap" scope="page" 
							  onmouseover="return setStatus('Resend modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Resend modify request to SA"/>
							 </html:link>
                                </td>

<%                            }
							}
                            else if (((serviceState.indexOf(failure) != -1) || (serviceState.indexOf(partial) != -1)) && !(serviceState.equals(ce_failure) || serviceState.equals(ce_temp_failure) || serviceState.equals(ce_partial_temp_failure))) { 
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
                              <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
                                <html:link   page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
								onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                  <img src="images/Delete.gif" id="<%= deleteIconChild%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
								  </html:link>

								  <%	
	//jacqie - PR 15297
	
								resendCreateParams.put("serviceid",currentService.getServiceid());
								resendCreateParams.put("customerid",customerid);
								resendCreateParams.put("currentRs",String.valueOf(currentRs));
								resendCreateParams.put("parentserviceid",String.valueOf(currentService.getParentserviceid()));
								resendCreateParams.put("lastRs",String.valueOf(lastRs));
								 resendCreateParams.put("mv","viewpageno");
								 resendCreateParams.put("currentPageNo",String.valueOf(cpage));
								 resendCreateParams.put("viewPageNo",String.valueOf(vPageNo));
								 resendCreateParams.put("totalPages",String.valueOf(totalPages));
								 if(currentService.getType().equals("layer3-Protection"))
                                     resendCreateParams.put("type","layer3-Attachment");
								 else
								     resendCreateParams.put("type",currentService.getType());
								 resendCreateParams.put("subType",currentService.getType());
								 resendCreateParams.put("sort",strSort);
								 resendCreateParams.put("resend","true");
								 if(serviceState.indexOf("PE_CE_") != -1){
									resendCreateParams.put("resend_SP_Activation_Scope","BOTH");
								  }
								  else{
									resendCreateParams.put("resend_SP_Activation_Scope","none");
								  }
								  
								if(currentService.getType().indexOf("Site")!=-1){
									//resendCreateParams.put("state","Request_Sent");
									} else {
								 //resendCreateParams.put("state","PE_Request_Sent");
								 resendCreateParams.put("attachmentid",currentService.getServiceid());
								}
								
								
								 pageContext.setAttribute("resendCreateParamsMap", resendCreateParams);
								 
								
                               if(!(serviceState.indexOf(failure) != -1) && (type.equals("Site"))){								 
%>   

		
                               
								<html:link page="/CreateService.do" name="resendCreateParamsMap" scope="page"
								onmouseover="return setStatus('Resend create', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                  <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Resend request to SA"/>
                                 </html:link>
                                 
                               

                              </td>
<%                          }
                            }
							//Added for Activate CE
							else if ((serviceState.indexOf(failure) != -1) || (serviceState.indexOf(partial) != -1) && (serviceState.equals(ce_failure) || serviceState.equals(ce_temp_failure) || serviceState.equals(ce_partial_temp_failure))) { 
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
                              <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
                                <html:link   page="/DeleteService.do" name="deleteServiceParamsMap" scope="page" onclick='<%= "return deleteService(\'"+ currentService.getServiceid()+"\');"%>'
								onmouseover="return setStatus('Drop', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                  <img src="images/Delete.gif" id="<%= deleteIconChild%>" onclick="this.style.visibility='hidden'" border="0" title="Drop service"/>
								  </html:link>

								  <%	
	//jacqie - PR 15297
								resendModifyParams.put("serviceid",currentService.getServiceid());
								resendModifyParams.put("customerid",customerid);
								resendModifyParams.put("currentRs",String.valueOf(currentRs));
								resendModifyParams.put("parentserviceid",String.valueOf(currentService.getParentserviceid()));
								resendModifyParams.put("lastRs",String.valueOf(lastRs));
								 resendModifyParams.put("mv","viewpageno");
								 resendModifyParams.put("currentPageNo",String.valueOf(cpage));
								 resendModifyParams.put("viewPageNo",String.valueOf(vPageNo));
								 resendModifyParams.put("totalPages",String.valueOf(totalPages));
				
				     		     resendModifyParams.put("type",currentService.getType());
								 resendModifyParams.put("subType",currentService.getType());
								 resendModifyParams.put("sort",strSort);
								 resendModifyParams.put("resend","true");
								 resendModifyParams.put("SP_Activation_Scope","BOTH");
								 resendModifyParams.put("SP_vpnserviceid",curVPNId); // modified by tanye
								 resendModifyParams.put("state","Request_Sent");
							     resendModifyParams.put("next_state","PE_CE_");							   
								 resendModifyParams.put("ce_action","false");
								 resendModifyParams.put("attachmentid",currentService.getServiceid());
								 resendModifyParams.put("searchSite", searchSite);
								 resendModifyParams.put("siteidSearch", serviceid);
								
								 pageContext.setAttribute("resendModifyParamsMap", resendModifyParams);
%>   
                               <input type="hidden" name="SP_Activation_Scope" value="BOTH">
							   <input type="hidden" name="state" value="Request_Sent">
							   <input type="hidden" name="ce_action" value="false">
							   
							   
								<html:link page="<%=action_commitModifyChild%>" name="resendModifyParamsMap" scope="page"
								onmouseover="return setStatus('Resend create', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                                  <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Re configure CE Setup"/>
                                 </html:link>

                              </td>
<%                          }
							//End:Added for Activate CE
							else { %>
                              <td class="<%=rowStyle%>"><bean:message key="label.none"/></td>
<%                          } 
							   //Fix for PR 14991 Divya
							if( !undoModifyButtonShown && (!(currentService.getType()).equals("Site"))&&(serviceState.equalsIgnoreCase("Modify_Partial"))||(serviceState.equalsIgnoreCase("Modify_PE_Partial")))
	{
									
									%>	
									
									
							<html:link page="/UndoModifyService.do" name="undomodifyParamsMap" scope="page"
							onmouseover="return setStatus('Undo modify', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                              <html:img page="/images/undomodify.gif" onclick="this.style.visibility='hidden'" border="0" title="Undo the modify action"/>
							  </html:link>
<%
	}   //ends here

%>
<%                        } %>
<%                      } %>
<%                    } %>
<%                  
								  
							  
	 						  
							  
  }else{
 
							 if(isSubDisabled && !"layer2-VPWS".equals(curVPNtype) 
								 //Partial_Disabled
								 //&& !(currentService.getType()).equals("layer3-Attachment")
								 //&& !(currentService.getType()).equals("layer2-Attachment")
								 && !(currentService.getType()).equals("vpws-Attachment") 
								 //&& !(currentService.getType()).equals("vpws-Attachment") ){								 
								 && !(currentService.getType()).equals("vpws-Attachment") ){
                        // Subservice is disabled or disable failed or enable failed
                          disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","disable");
							//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));
						   disableServiceParams.put("searchSite", searchSite);

//richa- PR 11687
		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);                    


                        %>
                        <td class="<%=rowStyle%>" style="text-align: left; padding-left: 12px;"   valign="middle">
<%                      if(serviceState.indexOf(failure) != -1 && serviceState.indexOf(disable) == -1){  
                                         
%>
                          <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
						  onmouseover="return setStatus('Disable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                            <html:img page="/images/off.gif" onclick="this.style.visibility='hidden'" border="0" title="Disable service"/>
							</html:link>
<%                      } %>
                        
						<% 
							  disableServiceParams.put("serviceid",currentService.getServiceid());
	                      disableServiceParams.put("customerid",currentService.getCustomerid());        
                          disableServiceParams.put("action","Enable");
						 	//richa- PR 11687
						  disableServiceParams.put("mv","viewpageno");
						  disableServiceParams.put("currentPageNo",String.valueOf(cpage));
						  disableServiceParams.put("viewPageNo",String.valueOf(cpage));
						   disableServiceParams.put("searchSite", searchSite);

//richa- PR 11687
		                  pageContext.setAttribute("disableServiceParamsMap", disableServiceParams);  
		     
							%>
						              <html:link page="<%=action_disable%>" name="disableServiceParamsMap" scope="page"
						  onmouseover="return setStatus('Enable', '<%= Utils.escapeXml(currentService.getPresname()) %>'); return true;" onmouseout="return unsetStatus();">
                            <html:img page="/images/on.gif" onclick="this.style.visibility='hidden'" border="0" title="Enable service"/>
                          </html:link>

                        </td>
                        <%
                    }else{
                    	 
if (!"layer2-VPWS".equals(curVPNtype)){
							 %>
                             <td class="<%=rowStyle%>"><bean:message key="label.none"/></td>
             <%           
}else {
%>
                             <td class="<%=rowStyle%>"></td>
<%                             
}             
								 }
						   }

						  } else { 
						
						  	%>
                              <td class="<%=rowStyle%>"><bean:message key="label.none"/></td>
<%                  }
								
 j = i;
%>