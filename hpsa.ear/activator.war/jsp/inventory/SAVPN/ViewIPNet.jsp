<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
        com.hp.ov.activator.inventory.facilities.StringFacility,
		javax.sql.DataSource,
		com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
		java.sql.*,
		java.net.*"%>

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

	DataSource dbp = (DataSource) InventoryTreeServlet.getDatasource(request.getParameter(IPNetConstants.DATASOURCE));
    Connection con = null;
String refreshTree = (String) request.getAttribute(IPNetConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="IPNetApplicationResources" key="<%= IPNetConstants.JSP_VIEW_TITLE %>"/></title>
 
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
  
<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.IPAddrPool" />
<%

com.hp.ov.activator.vpn.inventory.IPNet beanIPNet = (com.hp.ov.activator.vpn.inventory.IPNet) request.getAttribute(IPNetConstants.IPNET_BEAN);

String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

      String IPNetAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getIpnetaddr());
              
                                
                      String PE1_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getPe1_ipaddr());
              
                                
                      String CE1_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getCe1_ipaddr());
              
                                
                      String PE2_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getPe2_ipaddr());
              
                                
                      String CE2_IPAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getCe2_ipaddr());
              
                                
                      String Netmask = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getNetmask());
              
                                
                      String Hostmask = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getHostmask());
              
                                
                      String PoolName = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getPoolname());
              
                                
                      String IPNetAddrStr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getIpnetaddrstr());
              
                                
                      String ParentIPNetAddr = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getParentipnetaddr());
              
                                
                      String StartAddress = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getStartaddress());
              
                                
                      String NumberOfEntries = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getNumberofentries());
              
                                
                      String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanIPNet.getAddressfamily());
              
                                
                      String __count = "" + beanIPNet.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanIPNet.get__count()) : "";
                      
              if( beanIPNet.get__count()==Integer.MIN_VALUE)
  __count = "";
	try {
        con = (Connection)dbp.getConnection();
		bean = (com.hp.ov.activator.vpn.inventory.IPAddrPool)com.hp.ov.activator.vpn.inventory.IPAddrPool.findByPrimaryKey( con, PoolName);
		AddressFamily = bean.getAddressfamily();
	}catch(Exception e){%>
		<script>
			alert("Error retrieving information for: Address pool" + "\n" +"<%= e.getMessage()%>" );
		</script>
<%
	}
	finally{
		try{
            con.close();
        }catch(Throwable th){
            // don't matter
        }
	}   
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPNetApplicationResources" key="jsp.view.title"/>
</h2> 

<%
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
               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddr.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= IPNetAddr != null? IPNetAddr.split("@")[1] : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.ipnetaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.pe1_ipaddr.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= PE1_IPAddr != null? PE1_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.pe1_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.ce1_ipaddr.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= CE1_IPAddr != null? CE1_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.ce1_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.pe2_ipaddr.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PE2_IPAddr != null? PE2_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.pe2_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.ce2_ipaddr.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CE2_IPAddr != null? CE2_IPAddr : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.ce2_ipaddr.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.netmask.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Netmask != null? Netmask : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.netmask.description"/>
                                                                              </table:cell>
          </table:row>
            <%if(AddressFamily != null && "IPv4".equals(AddressFamily)){%>                                               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.hostmask.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Hostmask != null? Hostmask : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.hostmask.description"/>
                                                                              </table:cell>
          </table:row>
             <%}%>                                              
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.poolname.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= PoolName != null? PoolName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.poolname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                                                 
                                                 
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="IPNetApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="IPNetApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
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
