<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%             
	//logger.debug("-----------Entry of SiteAttachments.jsp----------");			

	String strManaged_CE_Router = "";
				String ManagedCeRouter_value = "";
	String action_commitModify="/CommitModifyService.do";							
							if(searchSite!=null){
								action_commitModify="/CommitModifyServiceSearch.do";	
							}

			
			// The logic for attachment subsservices has to go in here -- Jimmi 

	allowModifyControlsForProtectionAttachment = true;
	if(treeState.equals("expanded")){ //need to display the attachments only if the state is "exapanded"


		if(service_bean_map != null)	{
		
		 //Get the site service in the service_bean_map which has attachment childs populated
//PR 15068

				StringBuffer VPNSite = new StringBuffer(curVPNId+"_"+currentService.getServiceid()+"_"+cnt);
				//logger.debug("SiteAttachments.jsp: VPNSite is "+VPNSite.toString());

		  //ServiceBean siteService = (ServiceBean)service_bean_map.get(services[i].getServiceid());
		  ServiceBean siteService = (ServiceBean)service_bean_map.get(VPNSite.toString());
				if(siteService != null){
					actionsflagval = siteService.getActionsflag();
					ServiceParameter[] parameters = siteService.getServiceparameters();
					if(parameters!=null)
					{
						for (int ii = 0; ii < parameters.length; ii++)
						{
						   ServiceParameter parameter = parameters[ii]; 
						   strManaged_CE_Router = parameter.getAttribute();
						   if(strManaged_CE_Router!=null && strManaged_CE_Router.equalsIgnoreCase("Managed_CE_Router"))
							  ManagedCeRouter_value = parameter.getValue();
	//						System.out.println("RRRRRRRRRRRRRR"+ parameter.getValue());
			   
						}
					}
				}


//				servicebean = (ServiceBean)service_bean_map.get(VPNSite.toString());
//				servicebean = (ServiceBean)service_bean_map.get(currentService.getServiceid());
//End of PR 15068
   
		 if(foreignCustomerId == null && siteService != null ) {
			 //don't display the attachments for the extranet customer
				  
			//ServiceBean[] attachments=null;
			
			ServiceBean[] attachments=siteService.getChildServicesArray();


			//logger.debug("SiteAttachments.jsp: attachments is "+attachments+", length is"+attachments.length);
					//for(int ijk=0;ijk<attachments.length;ijk++){
					//	logger.debug("Site "+services[i].getServiceid()+"'s serBean_child["+ijk+"]'s serviceid is:"+attachments[ijk].getServiceid()+", sername is:"+attachments[ijk].getPresname()+", protocol is "+attachments[ijk].getPe_ce_routingprotocol());	
						//System.out.println("Site "+services[i].getServiceid()+"'s serBean_child["+ijk+"]'s serviceid is:"+attachments[ijk].getServiceid()+", sername is:"+attachments[ijk].getPresname()+", protocol is "+attachments[ijk].getPe_ce_routingprotocol());	
					//}

		
			if(attachments!=null && attachments.length!=0)	{
						
				for(int attachment_index=0;attachment_index<attachments.length;attachment_index++){
					serviceState=attachments[attachment_index].getState();
				    isSubDisabled = serviceState.indexOf(disabled) != -1 || (serviceState.indexOf(disable) != -1 && serviceState.indexOf(failure)!=-1) 
					||(serviceState.indexOf(enable) != -1 && serviceState.indexOf(failure)!=-1);

					 pServiceid=services[i].getServiceid();
					 
					 
					 //this is very important 
					 currentService=attachments[attachment_index];

					 undomodifyParams.put("serviceid",attachments[attachment_index].getServiceid());
                     undomodifyParams.put("customerid",attachments[attachment_index].getCustomerid());
					 // Richa 11687
		 undomodifyParams.put("mv","viewpageno");
		 undomodifyParams.put("currentPageNo",String.valueOf(cpage));
		 undomodifyParams.put("viewPageNo",String.valueOf(vPageNo));

		 undomodifyParams.put("currentRs",String.valueOf(currentRs));
		 undomodifyParams.put("lastRs",String.valueOf(lastRs));
 		 undomodifyParams.put("totalPages",String.valueOf(totalPages));
 		 undomodifyParams.put("sort",strSort);
// Richa 11687
					 pageContext.setAttribute("undomodifyParamsMap", undomodifyParams);
				  %>
					
					<tr  align="center" align="middle">
					<td class="<%=rowStyle%>" valign="middle"></td>

                      <td class="<%=rowStyle%>" valign="middle">

                    <html:link page="/ShowServiceParameters.do" name="undomodifyParamsMap" scope="page">   
					<%=attachments[attachment_index].getServiceid()%>&nbsp;</html:link>
                     </td>
			<td class="<%=rowStyle%>" valign="middle" align="left">-&nbsp;</td>	
			
			<td class="<%=rowStyle%>"  valign="middle"><%= _replace (attachments[attachment_index].getState()) %>&nbsp;</td>
            <td class="<%=rowStyle%>"  valign="middle"><%= _replace (attachments[attachment_index].getType()) %>&nbsp;</td>
            <td class="<%=rowStyle%>"  valign="middle"><%= attachments[attachment_index].getSubmitdate() %>&nbsp;</td>		
			
<%          if(!(currentService.getType()).equals("vpws-Attachment")){ %>					  					  
		      <%@ include file="ChildServiceActions.jsp" %>
<%          } else {
%>
              <td class="<%=rowStyle%>"  valign="middle"></td>
<%          }
%>			
				

			


<%                 
	                 HashMap  modifyservicepageParams = new HashMap();
					 if (serviceState.indexOf(ok) != -1 && serviceState.indexOf(ok) != -1 
						 //&& serviceState.indexOf(sched) == -1
					 )
	                { %>

                          
<%                        
						 modifyservicepageParams.put("customerid",customerid);
            			 modifyservicepageParams.put("parentserviceid",pServiceid); 
                         modifyservicepageParams.put("serviceid",attachments[attachment_index].getServiceid());
						 // Richa 11687
		 modifyservicepageParams.put("mv","viewpageno");
		 modifyservicepageParams.put("currentPageNo",String.valueOf(cpage));
		 modifyservicepageParams.put("viewPageNo",String.valueOf(vPageNo));

		 modifyservicepageParams.put("currentRs",String.valueOf(currentRs));
		 modifyservicepageParams.put("lastRs",String.valueOf(lastRs));
 		 modifyservicepageParams.put("totalPages",String.valueOf(totalPages));
 		 modifyservicepageParams.put("sort",strSort);
// Richa 11687
if(!isOperator || foreignCustomerId != null){//if its foreign customer or not operator- then no subservices for him
%>	
      <td class="<%=rowStyle%>">&nbsp;</td>
			<td class="<%=rowStyle%>">&nbsp;</td>
<%
//PR 15068
								 
//						  if (serviceState.equals(pe_ok)&& !type.equals("layer2-Site"))//for layer2 site's subservice, do not need to do ce activation-add by pp
			}else if (serviceState.indexOf(pe_ok)!=-1&& ((attachments[attachment_index].getType()).equals("layer3-Attachment") || (attachments[attachment_index].getType()).equals("layer3-Protection")||(attachments[attachment_index].getType()).equals("GIS-Attachment") || (attachments[attachment_index].getType()).equals("GIS-Protection")))
//End of PR 15068						  
							  {
							   
%>
                            <input type="hidden" name="SP_Activation_Scope" value="BOTH">
                            <input type="hidden" name="state" value="Request_Sent">
							<input type="hidden" name="ce_action" value="false">
                            <td align="center" class="<%=rowStyle%>"><bean:message key="label.ce.setup"/></td>
                            <td align="center" class="<%=rowStyle%>">
				<%
                               modifyservicepageParams.put("SP_Activation_Scope","BOTH");
					           modifyservicepageParams.put("SP_vpnserviceid",curVPNId); // modified by tanye
					           modifyservicepageParams.put("attachmentid",attachments[attachment_index].getServiceid()); // modified by tanye
							   modifyservicepageParams.put("state","Request_Sent");
							   modifyservicepageParams.put("ce_action","false");
							   modifyservicepageParams.put("next_state","PE_CE_");
							   modifyservicepageParams.put("searchSite", searchSite);
							   modifyservicepageParams.put("siteidSearch", serviceid);
							   pageContext.setAttribute("modifyservicepageParamsMap", modifyservicepageParams);

	            %>
                           <html:link  page="<%=action_commitModify%>" name="modifyservicepageParamsMap" scope="page">
                                <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Submit"/>
                             </html:link>

                            </td>
<%                          } 
					else { %>

<%                          if (serviceState.indexOf(ce_ok)!=-1) 
	{ %>
                              <input type="hidden" name="SP_Activation_Scope" value="BOTH">
                              <input type="hidden" name="state" value="Request_Sent">
                              <input type="hidden" name="ce_action" value="false">

								<td align="center" class="<%=rowStyle%>"><bean:message key="label.pe.activation"/></td>
                               <td align="center" class="<%=rowStyle%>">

					 <%
                               modifyservicepageParams.put("SP_Activation_Scope","BOTH");
                               /*PR 15149*/
							   modifyservicepageParams.put("SP_vpnserviceid",curVPNId);
							   modifyservicepageParams.put("attachmentid",attachments[attachment_index].getServiceid());
							   /*End of PR 15149*/    
				               modifyservicepageParams.put("state","Request_Sent");
							   modifyservicepageParams.put("ce_action","false");							   
							   modifyservicepageParams.put("next_state","PE_CE_");
							   modifyservicepageParams.put("searchSite", searchSite);
							   modifyservicepageParams.put("siteidSearch", serviceid);
							   pageContext.setAttribute("modifyservicepageParamsMap", modifyservicepageParams);

	                %>
                               <html:link  page="<%=action_commitModify%>" name="modifyservicepageParamsMap" scope="page">
                                  <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Submit"/>
                               </html:link>

                              </td>
<%                          }
				else if (serviceState.indexOf(ok)!=-1 && ManagedCeRouter_value.equalsIgnoreCase("true") && !serviceState.equals(ok)) 
	{ %>

							  <input type="hidden" name="state" value="Request_Sent">
							  <input type="hidden" name="ce_action" value="true">
							  
							  <td align="center" class="<%=rowStyle%>"><bean:message key="label.ce.activation"/></td>
		
                              <td align="center" class="<%=rowStyle%>">

					 <%
                               modifyservicepageParams.put("ce_action","true");
							   modifyservicepageParams.put("SP_vpnserviceid",curVPNId);
							   modifyservicepageParams.put("attachmentid",attachments[attachment_index].getServiceid());
				               modifyservicepageParams.put("state","Request_Sent");
							   modifyservicepageParams.put("searchSite", searchSite);
							   modifyservicepageParams.put("siteidSearch", serviceid);							   
							   pageContext.setAttribute("modifyservicepageParamsMap", modifyservicepageParams);

	                %>
                               <html:link  page="<%=action_commitModify%>" name="modifyservicepageParamsMap" scope="page">
                                  <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Submit"/>
                               </html:link>

                              </td>
<%                          }
							else { %>
                              <td class="<%=rowStyle%>" valign="middle">&nbsp;</td>
                              <td class="<%=rowStyle%>" valign="middle">&nbsp;</td>
<%                          } // if %>
<%                        } // if %>
<%                    } else { %>
                        <td class="<%=rowStyle%>" colspan=2>&nbsp;</td>
<%                    } %>
               
			

		</tr>

<%
					
					
				}//for(int attachment_index=0;attachment_index<attachments.length;attachment_index++)
			
				
			}//if(attachments!=null && attachments.length!=0)
	 } //  if(foreignCustomerId ==null)
			
			
	
			
		}//if(service_bean_map != null)	
			
}//if(treeState.equals("expanded"))
		

		   // The logic for attachment subsservices has to go in here -- Jimmi 
			   

%>	