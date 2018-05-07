<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");
//System.out.println("refreshTreeRimid:"+refreshTreeRimid );

String refreshTree = (String) request.getAttribute(QoSProfileConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="QoSProfileApplicationResources" key="<%= QoSProfileConstants.JSP_VIEW_TITLE %>"/></title>
 
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( refreshTree != null && refreshTree.equalsIgnoreCase("true") ) {
%>
      parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">
  

<%
com.hp.ov.activator.vpn.inventory.QoSProfile beanQoSProfile = (com.hp.ov.activator.vpn.inventory.QoSProfile) request.getAttribute(QoSProfileConstants.QOSPROFILE_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getCustomerid());
                      String QoSProfileName = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getQosprofilename());
                      String Prefix = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getPrefix());
                      String Layer = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getLayer());
                      String PEQoSProfileName = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getPeqosprofilename());
                      String Profilename_in = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getProfilename_in());
                      String Profilename_out = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getProfilename_out());
                      String Compliant = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getCompliant());
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getDescription());
                      String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanQoSProfile.getAddressfamily());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="QoSProfileApplicationResources" key="jsp.view.title"/>
</h2> 

<%

boolean CustomerIdPass_CustomerId = false ;
CustomerIdPass_CustomerId = java.util.regex.Pattern.compile("^\\S+$").matcher(CustomerId).matches();
boolean showCustomerId = false;
  if (true && CustomerIdPass_CustomerId ){
showCustomerId = true;
}

%>

    <div style="width:100%; text-align:center;">
    <table:table>
      <table:header>
        <table:cell>
          <bean:message bundle="InventoryResources" key="name.heading"/>
        </table:cell>
        <table:cell>
          <bean:message bundle="InventoryResources" key="value.heading"/>
        </table:cell>
        <table:cell>
          <bean:message bundle="InventoryResources" key="description.heading"/>
        </table:cell>
      </table:header>
      <%if(showCustomerId){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.customerid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.customerid.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.qosprofilename.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= QoSProfileName != null? QoSProfileName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.qosprofilename.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.prefix.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Prefix != null? Prefix : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.prefix.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.layer.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("layer 3" ,"layer 3");
                                            valueShowMap.put("layer 2" ,"layer 2");
                                          if(Layer!=null)
                     Layer=(String)valueShowMap.get(Layer);
              %>
              <%= Layer != null? Layer : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.layer.description"/>
                                                                              </table:cell>
          </table:row>
                                                           

                                 <table:row>
            <table:cell>  
            <b><bean:message bundle="QoSProfileApplicationResources"
                key="field.class.alias" /></b>
                          </table:cell>
            <table:cell>
            <b><bean:message bundle="QoSProfileApplicationResources"
                key="field.classifier.alias" /></b>
                          </table:cell>
            <table:cell>
            <b><bean:message bundle="QoSProfileApplicationResources"
                key="field.percentage.alias" /></b>
                                                                              </table:cell>
          </table:row>
    <% 
//chling added at 2008.0305 for move java logic from jsp to FormAction.
    PolicyMapping[] policyMappings = null;
    EXPMapping[] expMappings = null;
    
    policyMappings = (PolicyMapping[])request.getAttribute("POLICYMAPPINGSARRAY");  
    expMappings = (EXPMapping[])request.getAttribute("EXPMAPPINGSARRAY");   

        java.util.Hashtable policyTable = new java.util.Hashtable(policyMappings.length);
        for (int i = 0; i < policyMappings.length; i++)
            policyTable.put(policyMappings[i].getPosition(), policyMappings[i]);

        for (int i = 0; i < expMappings.length; i++) {
            EXPMapping expMapping = expMappings[i];
            PolicyMapping policyMapping = (PolicyMapping) policyTable.get(expMapping.getPosition());
            if(policyMapping == null)
                continue;
//End               
%>
    <table:row>
        <table:cell>
            &nbsp;&nbsp;&nbsp;&nbsp;<%=expMapping.getClassname()%>
                          </table:cell>
            <table:cell>
            <%= policyMapping.getTclassname() == null ? "" : policyMapping.getTclassname() %>
        </table:cell>
        <table:cell>
            <%= policyMapping.getPercentage() == null ? "" : policyMapping.getPercentage() %> %
                                                                              </table:cell>
          </table:row>
<%
        }
%>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_in.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Profilename_in != null? Profilename_in : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_in.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_out.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Profilename_out != null? Profilename_out : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_out.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.compliant.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("compliant" ,"compliant");
                                            valueShowMap.put("partial compliant" ,"partial compliant");
                                            valueShowMap.put("non compliant" ,"non compliant");
                                          if(Compliant!=null)
                     Compliant=(String)valueShowMap.get(Compliant);
              %>
              <%= Compliant != null? Compliant : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.compliant.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QoSProfileApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QoSProfileApplicationResources" key="field.description.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                                    
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

  </body>
</html>
