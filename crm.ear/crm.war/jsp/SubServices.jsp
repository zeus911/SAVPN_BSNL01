<!-- add subServices (drop down with subservice types + submit button)-->
            
 <!--  <html:form action="/ModifyService.do">-->

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
				HashMap  modifyservicepageParams = new HashMap();		
				String action_commitModify="/CommitModifyService.do";							
							if(searchSite!=null){
								action_commitModify="/CommitModifyServiceSearch.do";	
							}

				servicebean = (ServiceBean)service_bean_map.get(currentService.getServiceid());
				if(servicebean != null){
				actionsflagval = servicebean.getActionsflag();
				}				
				
				StringBuffer sstmpVPNSite = new StringBuffer(curVPNId+"_"+currentService.getServiceid()+"_"+cnt);
				ServiceBean sstmpsiteService = (ServiceBean)service_bean_map.get(sstmpVPNSite.toString());

				ServiceBean[] sstmpattachments = null;
				sstmpattachments = sstmpsiteService.getChildServicesArray();
				String sstmpState = "";
				String sstmpRoutingProtocol ="";
				if (null!=sstmpattachments && 1==sstmpattachments.length) {
					sstmpState = sstmpattachments[0].getState();
					sstmpRoutingProtocol = sstmpattachments[0].getPe_ce_routingprotocol(); //added for pr18384
				}
				
				if(!isOperator || foreignCustomerId != null){//if its foreign customer or not operator- then no subservices for him
				%>
				<td class="<%=rowStyle%>">&nbsp;</td>
				<td class="<%=rowStyle%>">&nbsp;</td>
				<%
				}
				
				else if (null!=sstmpsiteService && (( type.equals("Site") && curVPNtype.equals("layer2-VPN") && currentService.getChildServicesArray() == null) || (type.equals("Site") && curVPNtype.equals("layer3-VPN") && sstmpRoutingProtocol !=null && (sstmpRoutingProtocol.equalsIgnoreCase("BGP")) && (sstmpState.equals("PE_Ok") || sstmpState.equals("Ok") || sstmpState.equals("PE_CE_Ok")) ))) {
					
		%>
		<!--adding the subservices list box for --layer3site-->

				<td class="<%=rowStyle%>">

					<%                         
					

					HashMap createpageParams = new HashMap();	
					String subServicename = null;
					if (subServiceTypes == null) 
					{
					
					%>
					<i><bean:message key="msg.no.subservices"/></i>
					<td class="<%=rowStyle%>">&nbsp;</td>
					<% } else {


						if ((serviceState.indexOf(ok) != -1 || serviceState.indexOf(partial) != -1) && serviceState.indexOf(sched) == -1){
						
						%>
						<select name="type<%=i%>">
						<%if (subServiceTypes != null) {
									for (int jj=0; jj<subServiceTypes.length; jj++) { %>
											<option value="<%= Utils.escapeXml(subServiceTypes[jj].getName()) %>">
											<%= Utils.escapeXml(_replace (subServiceTypes[jj].getName())) %>
											</option>
											<% subServicename = Utils.escapeXml(subServiceTypes[jj].getName());
											}
						 }
				        
 %>
                            </select>
							  <input type="hidden" name="type" value="<%= type %>">
							<td class="<%=serviceRowStyle%>">
					<%
	                      if(subServicename == null) { subServicename =  type ; }
	                      
	                      
	                      ServiceBean[] satmpAttachments=sstmpsiteService.getChildServicesArray();
	                      if(satmpAttachments!=null && (1==satmpAttachments.length)) {
	                      		createpageParams.put("attachmentid", satmpAttachments[0].getServiceid());
	                      		//logger.debug("=========Mark4======= David===== protection attachmentid====="+satmpAttachments[0].getServiceid()+"=======attach status is:"+satmpAttachments[0].getState());
	                      		//logger.debug("SubServices.jsp: protection attachmentid is"+satmpAttachments[0].getServiceid());
	                      }
						 createpageParams.put("customerid",customerid);
						 createpageParams.put("mv","viewpageno");
                         if(sstmpattachments[0].getPe_ce_routingprotocol() !=null && (sstmpattachments[0].getPe_ce_routingprotocol().equalsIgnoreCase("BGP")))
						    createpageParams.put("SP_RoutingProtocol","BGP");
						 createpageParams.put("currentPageNo",String.valueOf(cpage));
						 createpageParams.put("viewPageNo",String.valueOf(cpage));
						 createpageParams.put("SP_vpnserviceid",curVPNId); // modified by chenling
            			 createpageParams.put("parentserviceid",services[i].getServiceid());
            			 if (type.equals("Site") && curVPNtype.equals("layer3-VPN")) {
                           createpageParams.put("type","layer3-Attachment");
            			 }
            			 else if (type.equals("Site") && curVPNtype.equals("GIS-VPN")) {
                             createpageParams.put("type","GIS-Attachment");
              			 } 
            			 else {
            			   createpageParams.put("type","layer2-Attachment");
            			 }
						 createpageParams.put("subType",subServicename);
						 createpageParams.put("searchSite", searchSite);
						 createpageParams.put("siteidSearch", serviceid);
			             pageContext.setAttribute("createpageParamsMap", createpageParams);						 
                   %>
							
                            <html:link  page="/CreateService.do" name="createpageParamsMap" scope="page">
							<html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Submit"/>
							</html:link>
                            </td>
<%                        } 

						else{ //serviceState.indexOf(ok) != -1


%>

				<td class="<%=rowStyle%>" colspan=1>&nbsp;</td>
				<%
				} //serviceState.indexOf(ok) != -1


				}	//type.equals("layer3-Site"	

				%>
				</td>                 

				<!--adding the subservices list box for --layer3site-->


			<%

			} else if (serviceState.indexOf(ok) != -1 && serviceState.indexOf(ok) != -1 && serviceState.indexOf(sched) == -1)
	                { 
						
		
					%>

  
<%                        
						 modifyservicepageParams.put("customerid",customerid);
            			 modifyservicepageParams.put("parentserviceid",pServiceid); 
                         modifyservicepageParams.put("serviceid",services[i].getServiceid());
						 
						  if (serviceState.equals(pe_ok) && !type.equals(Constants.TYPE_SITE))
							  {
							 
							   
%>
                            <input type="hidden" name="SP_Activation_Scope" value="CE_ONLY">
                            <input type="hidden" name="state" value="Request_Sent">
                            <td align="center" class="<%=rowStyle%>"><bean:message key="label.ce.activation"/></td>
                            <td align="center" class="<%=rowStyle%>">
				<%
                               modifyservicepageParams.put("SP_Activation_Scope","CE_ONLY");
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

<%                          if (serviceState.equals(ce_ok) && !type.equals(Constants.TYPE_SITE)) 
	{ %>
                              <input type="hidden" name="SP_Activation_Scope" value="BOTH">
                              <input type="hidden" name="state" value="Request_Sent">
                              <td align="center" class="<%=rowStyle%>"><bean:message key="label.pe.ce.activation"/></td>
                              <td align="center" class="<%=rowStyle%>">

					 <%
                               modifyservicepageParams.put("SP_Activation_Scope","BOTH");
            			       modifyservicepageParams.put("state","Request_Sent"); 
							   modifyservicepageParams.put("searchSite", searchSite);
							   modifyservicepageParams.put("siteidSearch", serviceid);
							   pageContext.setAttribute("modifyservicepageParamsMap", modifyservicepageParams);

	                %>
                               <html:link  page="<%=action_commitModify%>" name="modifyservicepageParamsMap" scope="page">
                                  <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Submit"/>
                               </html:link>

                              </td>
<%                          } else { %>

                              <td class="<%=rowStyle%>" valign="middle">&nbsp;</td>
                              <td class="<%=rowStyle%>" valign="middle">&nbsp;</td>
<%                          } // if %>
<%                        } // if %>
<%                    } else { %>


                        <td class="<%=rowStyle%>" colspan=2>&nbsp;</td>
<%                    }
							  
							  
						  
  %>
               
			    <!--</html:form>-->
