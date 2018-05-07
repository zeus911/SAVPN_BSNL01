<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2009 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->

<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
com.hp.ov.activator.cr.inventory.*,
com.hp.ov.activator.inventory.CRModel.*,
org.apache.struts.util.LabelValueBean,
org.apache.struts.action.Action,
java.text.NumberFormat,
org.apache.struts.action.ActionErrors,
java.sql.Connection,
java.text.NumberFormat,javax.sql.DataSource,com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
com.hp.ov.activator.inventory.facilities.StringFacility " %>

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

%>
<% 
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext());
// module name that can be used as solution name              
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<%
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);    
nfB.setMaximumFractionDigits(6);


String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(ChannelizedInterfaceConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitChannelizedInterfaceAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
exceptionMessage="";
}
if ( location == null ) {
location = "elementcomponentid";
}
%>



<%
com.hp.ov.activator.cr.inventory.ChannelizedInterface beanChannelizedInterface = (com.hp.ov.activator.cr.inventory.ChannelizedInterface) request.getAttribute(ChannelizedInterfaceConstants.CHANNELIZEDINTERFACE_BEAN);
//String ElementComponentID = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getElementcomponentid());
String SlotsNumber = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getSlotsnumber());

String InterfaceName = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getName());
String ChannelGroup = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getChannelGroup());
String Framing = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getFraming());
String ClockSource = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getClockSource());
//@@@@@@@@@@@@@@@@@222not there
//String FreeTimeSlots = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getFreetimeslots());
//String MultiplexingTimeSlots = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getMultiplexingtimeslots());
//String CreateChannel = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getCreatechannel());
//boolean DoCreate = new Boolean(beanChannelizedInterface.getDocreate()).booleanValue();
//boolean Contiguoues = new Boolean(beanChannelizedInterface.isContiguoues()).booleanValue();
//@@@@@@@@@@ends here

boolean Contiguoues = new Boolean(beanChannelizedInterface.isContiguoues()).booleanValue();
boolean showchecked = new Boolean(beanChannelizedInterface.getShowchecked()).booleanValue();
String Ec_Id = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getEC_ID());
String E1_Number = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getE1_number());
String E1 = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getE1());
String NeId = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getNeId());
String Ec_Name = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getEc_name());
String Location = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getLocation());
String RateLimit = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getRateLimit());
String au_4 = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getAu_4());
String Tug_2 = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getTug_2());
String Tug_3 = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getTug_3());
String Id = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getId());
String ChannelGroupLimit = "" + beanChannelizedInterface.getChannelGroupLimit();
ChannelGroupLimit = (ChannelGroupLimit != null && !(ChannelGroupLimit.trim().equals(""))) ? nfA.format(beanChannelizedInterface.getChannelGroupLimit()) : "";
String Au_4_Range = "" + beanChannelizedInterface.getAu_4_range();
Au_4_Range = (Au_4_Range != null && !(Au_4_Range.trim().equals(""))) ? nfA.format(beanChannelizedInterface.getAu_4_range()) : "";
String Tug_3_Range = "" + beanChannelizedInterface.getTug_3_range();
Tug_3_Range = (Tug_3_Range != null && !(Tug_3_Range.trim().equals(""))) ? nfA.format(beanChannelizedInterface.getTug_3_range()) : "";
String Tug_2_Range = "" + beanChannelizedInterface.getTug_2_range();
Tug_2_Range = (Tug_2_Range != null && !(Tug_2_Range.trim().equals(""))) ? nfA.format(beanChannelizedInterface.getTug_2_range()) : "";
String E1_Range = "" + beanChannelizedInterface.getE1_range();
E1_Range = (E1_Range != null && !(E1_Range.trim().equals(""))) ? nfA.format(beanChannelizedInterface.getE1_range()) : "";

boolean UnFramed = new Boolean(beanChannelizedInterface.isUnframed()).booleanValue();

//********************************change the name later
//String temp = (String)session.getAttribute("noFree");
boolean noFree = Boolean.getBoolean(session.getAttribute("noFree").toString());
//boolean isCSTM1 = false;
boolean isCSTM1=Boolean.getBoolean(session.getAttribute("isCSTM1").toString());
String vendor =(String)session.getAttribute("vendor");
ArrayList  au4List= (ArrayList) beanChannelizedInterface.getAu4Set();
ArrayList  Tug3List= (ArrayList) beanChannelizedInterface.getTug3Set();

 ArrayList Tug2List= (ArrayList)  beanChannelizedInterface.getTug2Set();
 ArrayList E1List=  (ArrayList) beanChannelizedInterface.getE1Set();
 boolean[] freeSlots = beanChannelizedInterface.getFreeSlots();
 boolean sonet =  beanChannelizedInterface.getSonet();
 int portNumber = Integer.parseInt((String)session.getAttribute("portNumber"));
 boolean findPort =  true;
String freetimeSlots = (String)session.getAttribute("freetimeSlots");
 if(SlotsNumber.equals(""))
    findPort =false;
 //System.out.println("the value of findPort in jsp page is"+findPort);
// System.out.println("the value Contiguoues"+Contiguoues);
 // System.out.println("beanChannelizedInterface.getSlotsnumber())e"+beanChannelizedInterface.getSlotsnumber());
//beanChannelizedInterface.setSlotsnumber("0");
//*****************************************************


Connection con = null;
boolean isCiscoASR = false;

try
{
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
	if (ds != null)
	{
		con = ds.getConnection();
		
		NetworkElement neObj = NetworkElement.findByNetworkelementid(con, NeId);
		
		if ("CiscoXR".equals(neObj.getOsversion()))
		{
			isCiscoASR = true;
		}
	}             
}
catch(Exception e)
{
	System.out.println("Exception getting network element info from database: "+e);
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

if (sonet && isCiscoASR)
{
	InterfaceName = InterfaceName.replace(".","/");
}

%>



<html>
<head>
<title><bean:message bundle="ChannelizedInterfaceApplicationResources" key="<%= ChannelizedInterfaceConstants.JSP_CREATION_TITLE %>"/></title>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<style type="text/css">
A.nodec { text-decoration: none; }
H1 { color: red; font-size: 13px }
</style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">

<center> 
  <h2>
    <bean:message bundle="ChannelizedInterfaceApplicationResources" key="jsp.creation.title"/>
  </h2> 
</center>

<H1>

<html:errors bundle="ChannelizedInterfaceApplicationResources" property="SlotsNumber"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="ElementComponentID"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="InterfaceName"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="ChannelGroup"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Framing"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="ClockSource"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="FreeTimeSlots"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="MultiplexingTimeSlots"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="CreateChannel"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="NeId"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="E1"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="E1_Number"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Ec_Name"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Ec_Id"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Location"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="RateLimit"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Au_4"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Tug_2"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Tug_3"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Id"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="ChannelGroupLimit"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Au_4_Range"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Tug_3_Range"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Tug_2_Range"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="E1_Range"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="Contiguoues"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="UnFramed"/>
<html:errors bundle="ChannelizedInterfaceApplicationResources" property="DoCreate"/>
</H1>

<html:form action="<%= formAction %>">




<script>
function sendthis(focusthis) {
/*window.document.ChannelizedInterfaceForm.action = '/activator<%=moduleConfig%>/CreationFormChannelizedInterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
window.document.ChannelizedInterfaceForm.submit();*/
}


function checkSlot()
{
    if((window.document.ChannelizedInterfaceForm.slotsnumber.value==null)||(window.document.ChannelizedInterfaceForm.slotsnumber.value==""))
    {
            //var alertMsg = new HPSAAlert('','*"TimeSlot field is mandatory"');
            var alertMsg = new HPSAAlert('','<bean:message bundle="ChannelizedInterfaceApplicationResources" key="message.validate1"/>');
            alertMsg.setBounds(400, 120);
            alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
            alertMsg.show();
            return false;
    }
    else 
    if((window.document.ChannelizedInterfaceForm.slotsnumber.value>0)&&(window.document.ChannelizedInterfaceForm.slotsnumber.value<=32)){
    return true;
    }
    else
    {       
        
            var alertMsg = new HPSAAlert('','<bean:message bundle="ChannelizedInterfaceApplicationResources" key="message.validate2"/>');
            //var alertMsg = new HPSAAlert('','*"TimeSlot field is mandatory"');
            alertMsg.setBounds(400, 120);
            alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
            alertMsg.show();
            return false;
    }

}
function onChangeFun() {
//alert("inside onchange");
        window.document.ChannelizedInterfaceForm.action = '/activator<%=moduleConfig%>/CreationFormChannelizedInterfaceAction.do?datasource=<%= datasource %>&neid=<%=NeId %>&elementcomponentid=<%=Ec_Id%>&rimid=<%= rimid %>';
            window.document.ChannelizedInterfaceForm.submit();
}

function selectInterface(){
    //alert("inside resubmit");
        var flag = checkSlot();
        if(flag)
        {
            window.document.ChannelizedInterfaceForm.action = '/activator<%=moduleConfig%>/CreationFormChannelizedInterfaceAction.do?datasource=<%= datasource %>&neid=<%=NeId %>&elementcomponentid=<%=Ec_Id%>&rimid=<%= rimid %>';
            window.document.ChannelizedInterfaceForm.submit();
        }
}


function checkValue()
{
    window.document.ChannelizedInterfaceForm.showchecked.value=window.document.ChannelizedInterfaceForm.showchecked.checked;
    var flag = checkSlot();
    if(flag)
    {
        
        window.document.ChannelizedInterfaceForm.action = '/activator<%=moduleConfig%>/CreationFormChannelizedInterfaceAction.do?datasource=<%= datasource %>&neid=<%=NeId %>&elementcomponentid=<%=Ec_Id%>&rimid=<%= rimid %>';
        window.document.ChannelizedInterfaceForm.submit();
    }
        
}

function performCommit() {
    var flag = checkSlot();
    if(flag)
    {       
        var falg1=<%=findPort%>;
        if(!falg1)
        {   
            var alertMsg = new HPSAAlert('','<bean:message bundle="ChannelizedInterfaceApplicationResources" key="message.validate3"/>');
            alertMsg.setBounds(400, 120);
            alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
            alertMsg.show();
            
        }
        else
        {
            window.document.ChannelizedInterfaceForm.enviando.disabled='true';
            window.document.ChannelizedInterfaceForm.action = '/activator<%=moduleConfig%>/CreationCommitChannelizedInterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
            window.document.ChannelizedInterfaceForm.submit();
        }
    }

}
</script>


<center>
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
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.slotsnumber.alias"/>
</table:cell>
<table:cell>
<html:text  property="slotsnumber" size="24" value="<%= SlotsNumber%>"/>
</table:cell>
<table:cell>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.slotsnumber.description"/>
</table:cell>
</table:row>
<table:row>
<table:cell>    
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.contiguoues.alias"/>
</table:cell>
<table:cell>
<html:checkbox  name="ChannelizedInterface" property="showchecked" onclick="checkValue()"/>
</table:cell>
<table:cell>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.contiguoues.description"/>
</table:cell>
</table:row>

<%
    //System.out.println("thefindPort"+findPort);
  if (findPort && !noFree) {

      //System.out.println("InterfaceName"+InterfaceName);
%>

<table:row>
<table:cell>    
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.interfacename.alias"/>
</table:cell>
<table:cell>
<%= InterfaceName %>
</table:cell>
<html:hidden property="interfacename" value="<%= InterfaceName%>"/>
<table:cell>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.interfacename.description"/>
</table:cell>
</table:row>
<table:row>
<table:cell>    
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.channelgroup.alias"/>
</table:cell>
<table:cell><%= ChannelGroup %>
<html:hidden  property="channelgroup"  value="<%= ChannelGroup %>"/>
</table:cell>
<table:cell>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.channelgroup.description"/>
</table:cell>
</table:row>

<% 
    int channelResult = Integer.parseInt((String)session.getAttribute("channelResult"));    
if (isCSTM1 || !("Juniper".equals(vendor) && !"0".equals(beanChannelizedInterface.getChannelGroup())) && channelResult==0) {
	
    if ("Huawei".equals(vendor) || !beanChannelizedInterface.isUnframed()) { %>

    <table:row>
<table:cell>    
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.framing.alias"/>
</table:cell>
<table:cell>
<html:select property="framing">
    <html:option value="crc4" >crc4</html:option>
    <html:option value="no-crc4" >no-crc4</html:option>
    </html:select>
</table:cell>
<table:cell>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.framing.description"/>
</table:cell>
</table:row>

<%   } %>

<table:row>
<table:cell>    
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.clocksource.alias"/>
</table:cell>
<table:cell>
<html:select  property="clocksource">
    <html:option value="internal" >internal</html:option>
    <html:option value="line" >line</html:option>
    </html:select>
</table:cell>
<table:cell>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.clocksource.description"/>
</table:cell>
</table:row>

<%
  }
%>

<% if (!showchecked && Integer.parseInt(beanChannelizedInterface.getSlotsnumber()) != 32) { %>

<table:row>
<table:cell>    
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.freetimeslots.alias"/>
</table:cell>
<table:cell>
<%= freetimeSlots%>
</table:cell>
<table:cell>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.freetimeslots.description"/>
</table:cell>
</table:row>

<% } 

%>


<%

if (findPort && !noFree) {
%>
<table:row>
<table:cell>    
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="field.multiplexingtimeslots.alias"/>
</table:cell>

<table:cell>
<%
        //System.out.println("the value of sonet is"+sonet);
  if (sonet) {
%>



<bean:message bundle="ChannelizedInterfaceApplicationResources" key="filed.multiplexingtimeslots.au4"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="filed.multiplexingtimeslots.tug3"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="filed.multiplexingtimeslots.tug2"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="filed.multiplexingtimeslots.e1"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<%
  }
else if (portNumber > 1) {
%>

<bean:message bundle="ChannelizedInterfaceApplicationResources" key="filed.multiplexingtimeslots.e1"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
  }

%>
<bean:message bundle="ChannelizedInterfaceApplicationResources" key="filed.multiplexingtimeslots.timeslots"/></table:cell>
<table:cell> </table:cell>
</table:row>

<table:row>

<table:cell></table:cell>
<table:cell>
<%

  if (sonet) {
%>


<html:select  name="ChannelizedInterface" property="au_4" value="au_4" onchange="onChangeFun()" >
<html:optionsCollection name="ChannelizedInterface" property="au4Set"/>
</html:select>
<html:select  name="ChannelizedInterface" property="tug_3" value="tug_3" onchange="onChangeFun()" >
<html:optionsCollection name="ChannelizedInterface" property="tug3Set"/>
</html:select>
<html:select  name="ChannelizedInterface" property="tug_2" value="tug_2" onchange="onChangeFun()" >
<html:optionsCollection name="ChannelizedInterface" property="tug2Set"/>
</html:select>
<html:select name="ChannelizedInterface" property="e1" value="e1" onchange="onChangeFun()" >
<html:optionsCollection name="ChannelizedInterface" property="e1Set"/>
</html:select>

<%
  } else { // End sonet
    if (portNumber>1) { %>

<html:select name="ChannelizedInterface" property="e1_number" value="e1_number" onchange="onChangeFun()">
<html:optionsCollection name="ChannelizedInterface" property="e1Set"/>
</html:select>


<% }
  } %>




  <%
   int numSlots = Integer.parseInt(beanChannelizedInterface.getSlotsnumber());
 // System.out.println("numSlots"+numSlots);
   if (showchecked) { 
boolean isfreeslotsAvialble = false; %>
 
<html:select  property="timeslots" value="timeslots">
<%
       if (numSlots==32) {
	isfreeslotsAvialble = true;

%>
<html:option  value="0-31">0-31</html:option>

<%
       }
else {
  
       for (int i=1; i<freeSlots.length; i++) {
           if(freeSlots[i]) {
			   isfreeslotsAvialble = true;
             String contSlots;
             if (numSlots==1){
               contSlots = Integer.toString(i);			   
			 }
             else{
               contSlots = i + "-" + (i+numSlots-1);
			 }
                     
//System.out.println("freeslots to display is@@@@@@@@@@@"+contSlots);
%>
<html:option  value="<%= contSlots%>"><%= contSlots%></html:option> 



<%
           }
         }
       }
%>

</html:select>

<%
if(!isfreeslotsAvialble){
		errorMessage = ChannelizedInterfaceConstants.NO_FREETIMESLOTS_ERROR;
		exceptionMessage = ChannelizedInterfaceConstants.NO_FREETIMESLOTS_ERROR;
	}
}
else {	
  boolean[] recSlots = new boolean[32];
  int sn = Integer.parseInt(beanChannelizedInterface.getSlotsnumber());
  for (int i=0, free=0; i<32; i++) {
    if (freeSlots[i] && free < sn) {
        recSlots[i] = freeSlots[i];
        free++;
    } else {
        recSlots[i] = false;
    }
  }
  String recSlotsString = beanChannelizedInterface.getTimeslotsString(recSlots, true);
%>

<html:text  property="timeslots"  value="<%=(numSlots==32)?\"0-31\":recSlotsString%>"  size="14" title="Example: 1-3,4,9,22-24 (no space)"/>

<% } %>
</table:cell>
<table:cell></table:cell>
</table:row>

<%
  } else { 
    // End findPort && !noFree %>

 

<%  }
  }

%>

<html:hidden property="elementcomponentid" value="<%= Ec_Id%>"/>
<html:hidden property="ec_name" value="<%= Ec_Name%>"/>
<html:hidden property="neid" value="<%= NeId%>"/>
<table:row>
<table:cell colspan="3" align="center">
<br>
</table:cell>
</table:row>

<table:row>
<table:cell colspan="3" align="center">
<input type="button" value="<bean:message bundle="ChannelizedInterfaceApplicationResources" key="confirm.add_button.label"/>"  class="ButtonSubmit" onclick="selectInterface();">&nbsp;
</table:cell>
</table:row>

<table:row>
<table:cell colspan="3" align="center">
<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
</table:cell>
</table:row>
</table:table>
</center>
</html:form>

</body>
<%
if ( location != null ) {
%>

<script type="text/javascript">
document.all("<%=location%>").focus();
</script>
<%
}
if ( errorMessage != null && !errorMessage.equals("") ) {

    
%>
<script>
var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="ChannelizedInterfaceApplicationResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
alertMsg.setBounds(400, 120);
alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
alertMsg.show();
</script>
<%
}
%>

</html>
