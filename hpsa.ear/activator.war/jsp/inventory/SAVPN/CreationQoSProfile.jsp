<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
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
String datasource = (String) request.getParameter(QoSProfileConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitQoSProfileAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "qosprofilename";
                                                                  }
%>

    <script>
    function sendthis(focusthis)
    {
      window.document.QoSProfileForm.action = '/activator<%=moduleConfig%>/CreationFormQoSProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.QoSProfileForm.submit();
    }
    function performCommit()
    {
      window.document.QoSProfileForm.action = '/activator<%=moduleConfig%>/CreationCommitQoSProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.QoSProfileForm.submit();
    }

  function performCommit() {

        var profile_out=  document.all("profilename_out").value;
		var submitObj = document.getElementById('submitbutton');
   if(profile_out.length>37)
      {
       alert(" Profile name " + profile_out + " should not be more than 37 characters");
       document.getElementById("prefix").focus();
	   document.getElementById("prefix").select();
	   submitObj.disabled = false;
      }else{
   	  var counter=0;
	  while(true) {
		classCombo=eval("document.QoSProfileForm.class"+counter);
		classPercentageCombo=eval("document.QoSProfileForm.class"+counter+"Percent");
		if ( classCombo == null && classPercentageCombo == null ) {
			break;
		}
		if ( classCombo.value.replace(/\s/g,"") === "" && classPercentageCombo.value > 0 ) {
			alert("Select Class classifer");
			classCombo.focus();
			submitObj.disabled = false;
			return;
		}
		counter++;
	  }
    window.document.QoSProfileForm.action = '/activator<%=moduleConfig%>/CreationCommitQoSProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
    window.document.QoSProfileForm.submit();
  }

    }
</script>

<html>
  <head>
    <title><bean:message bundle="QoSProfileApplicationResources" key="<%= QoSProfileConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
      <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
  </head>
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">
<%

com.hp.ov.activator.vpn.inventory.QoSProfile beanQoSProfile = (com.hp.ov.activator.vpn.inventory.QoSProfile) request.getAttribute(QoSProfileConstants.QOSPROFILE_BEAN);

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
<%
    //chling modified at 2008.0306 for move java logic from jsp to FormAction.      
    TrafficClassifier[] customerClassifiers = (TrafficClassifier[])request.getAttribute("CUSTOMERCLASSIFIERSARRAY");
    TrafficClassifier[] globalClassifiers = (TrafficClassifier[])request.getAttribute("GLOBALCLASSIFIERSARRAY");
    EXPMapping[] expMappings = (EXPMapping[])request.getAttribute("EXPMAPPINGSARRAY");
      
    final int mappingsLength = expMappings == null ? 0 : expMappings.length;
    //End of customization
%>
      
<script>
    function init()
    {
<%
if ( _location_ != null ) {
%>
      var elems = document.getElementsByName("<%=_location_%>");
      var elem = elems == null || elems.length == 0 ? null : elems[0];
      if (elem != null) {
        elem.focus();
      }
<%
}
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }

    function countPercents(id){
      var sum = 0;

      for(i=0; i<<%=mappingsLength%>; i++){
        box = this.document.getElementById('class'+i+'Percent');
        sum = sum + parseInt(box.value);
      }
          
      var lastBox = document.getElementById('class<%=mappingsLength-1%>Percent');
      var reminder = sum - parseInt(lastBox.value);
      
      if(sum <= 100 || reminder <=100){
        document.getElementById("optC<%=mappingsLength-1%>P"+(100 - reminder)).selected = true;
      }else{
         var editedBox = document.getElementById("class"+id + "Percent");
         var editedValue = parseInt(editedBox.value);
         editedValue = editedValue - (reminder - 100);
         document.getElementById("optC" + id + "P" + editedValue).selected = true;
         document.getElementById("optC<%=mappingsLength-1%>P0").selected = true;
      }
    }
      
    function generateName(){
      //var name = "";
      var name = document.all("prefix").value;
      var custId = '<%=CustomerId%>';
	  var addressfam = '<%=AddressFamily%>';
	  var ipv6_suffix = "v6";
	  
      if(custId != "" && custId != "null"){
        name = name +"_"+custId;
      }
      var suffix = "";
      for(i=0; i<<%=mappingsLength%>; i++){
      
        box = this.document.getElementById('class'+i+'Percent');
      
        if(i != 0)
          suffix = suffix + ".";
        else
          suffix = suffix + "_";
      
        suffix = suffix + parseInt(box.value);
      }
      name = name + suffix;
      
	  if(addressfam =='IPv6'){
		
		name = name + "_" + ipv6_suffix;
	   }
      
	  document.all("nameText").value=name;
	  document.all("qosprofilename").value=name;
      document.all("suffix").value=suffix;
      document.all("profilename_in").value=name + "_in_<RL>";
      document.all("profilename_out").value=name + "_out_<RL>";
      document.getElementById("pro_in").innerHTML=name + "_in_&lt;RL&gt;";
      document.getElementById("pro_out").innerHTML=name + "_out_&lt;RL&gt;";

    }
          
    function prepare(){
<%
  if(mappingsLength > 0){
%>
        box = this.document.getElementById('class0Percent');
        box.options[box.length - 1].selected = true;
        countPercents(); generateName();
<%
  }%>

    }
</script>

<center> 
  <h2>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="QoSProfileApplicationResources" key="jsp.creation.title"/>
</h2> 


<H1>
      <html:errors bundle="QoSProfileApplicationResources" property="CustomerId"/>
        <html:errors bundle="QoSProfileApplicationResources" property="QoSProfileName"/>
        <html:errors bundle="QoSProfileApplicationResources" property="Prefix"/>
        <html:errors bundle="QoSProfileApplicationResources" property="Layer"/>
        <html:errors bundle="QoSProfileApplicationResources" property="PEQoSProfileName"/>
        <html:errors bundle="QoSProfileApplicationResources" property="Profilename_in"/>
        <html:errors bundle="QoSProfileApplicationResources" property="Profilename_out"/>
        <html:errors bundle="QoSProfileApplicationResources" property="Compliant"/>
        <html:errors bundle="QoSProfileApplicationResources" property="Description"/>
        <html:errors bundle="QoSProfileApplicationResources" property="AddressFamily"/>
  </H1>
<script>
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
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
      
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.qosprofilename.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text disabled="true" property="nameText" size="24" value="" />
                                                </table:cell>
              <table:cell>
                <bean:message bundle="QoSProfileApplicationResources" key="field.qosprofilename.description"/>
                              </table:cell>
            </table:row>

        <%
  if(CustomerId != null && !"".equals(CustomerId)){
%>

                                                      <table:row>
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.customerid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="QoSProfileApplicationResources" key="field.customerid.description"/>
                              </table:cell>
            </table:row>
        <%
  }
%>
        <html:hidden property="customerid"
            value="<%= CustomerId == null? \"\" : CustomerId %>" />
        
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.prefix.alias"/>
                              </table:cell>
              <table:cell>
                <html:text property="prefix" size="24" onchange="generateName()"
                    value="<%=Prefix == null ? \"\" : Prefix%>" />
                                                </table:cell>
			
              <table:cell>
                <bean:message bundle="QoSProfileApplicationResources" key="field.prefix.description"/>
                              </table:cell>
            </table:row>
			<%
						System.out.println("layer" + Layer);
					if("layer 3".equalsIgnoreCase(Layer)) {
					
				%>

                                                      <table:row>
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.addressfamily.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(AddressFamily==null||AddressFamily.trim().equals("")) {
                          selValue="IPv4";
                        } else {
                          selValue=AddressFamily.toString();
                        }    
                    %>
				
                    <html:select  property="addressfamily" value="<%= selValue %>" onchange="generateName();sendthis(this);" >
                                            <html:option value="IPv4" >IPv4</html:option>
                                            <html:option value="IPv6" >IPv6</html:option>
                                          </html:select>
                                                </table:cell>
											
									
              <table:cell>
                <bean:message bundle="QoSProfileApplicationResources" key="field.addressfamily.description"/>
                              </table:cell>
            </table:row>

				<%
					} %>
        <%  if(request.getParameter("modifyLayer") == null){ %>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.layer.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Layer==null||Layer.trim().equals("")) {
                        selValue = "${field.listOfValueSelected}";
                        } else {
                          selValue=Layer.toString();
                        }    
                    %>

                    <html:select  property="layer" value="<%= selValue %>" >
                                            <html:option value="layer 3" >layer 3</html:option>
                                            <html:option value="layer 2" >layer 2</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="QoSProfileApplicationResources" key="field.layer.description"/>
                              </table:cell>
            </table:row>
        <%  }else{ %>
        <html:hidden property="layer" value="<%=Layer%>" />
        <html:hidden property="modifyLayer" value="<%=request.getParameter(\"modifyLayer\")%>" />
        <%}%>
        
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
  for(int classIndex = 0 ; classIndex < mappingsLength; classIndex++){
%>
                                                      <table:row>
              <table:cell>  
                &nbsp;&nbsp;&nbsp;&nbsp;<%=expMappings[classIndex].getClassname()%>
                <input type="hidden" name="class<%=classIndex%>Exp"
                    value="<%=expMappings[classIndex].getExpvalue()%>">
                <input type="hidden" name="class<%=classIndex%>Dscp"
                    value="<%=expMappings[classIndex].getDscpvalue()%>">
                <input type="hidden" name="class<%=classIndex%>Position"
                    value="<%=expMappings[classIndex].getPosition()%>">
                <input type="hidden" name="class<%=classIndex%>Plp"
                    value="<%=expMappings[classIndex].getPlp()%>">
                <input type="hidden" name="class<%=classIndex%>queuenum"
                    value="<%=expMappings[classIndex].getQueuename()%>">
                <input type="hidden" name="class<%=classIndex%>Cosname"
                    value="<%=expMappings[classIndex].getClassname()%>">
            </table:cell>
            <table:cell>
                <select name="class<%=classIndex%>">
                    <option value=" "></option>
                    <% for(int i=0; i < customerClassifiers.length; i++){ 
						//System.out.println("Customer class  "+i+"   "+customerClassifiers[i].getName());
					%>
						<option
							value="<%=StringFacility.replaceAllByHTMLCharacter(customerClassifiers[i].getName())%>">
						<%=StringFacility.replaceAllByHTMLCharacter(customerClassifiers[i].getName())%>
						</option>
                    <%  } %>
                    <% for(int i=0; i < globalClassifiers.length; i++){
						//System.out.println("GLobal class  "+i+"   "+globalClassifiers[i].getName());
					%>
                    <option
                        value="<%=StringFacility.replaceAllByHTMLCharacter(globalClassifiers[i].getName())%>">
                    <%=StringFacility.replaceAllByHTMLCharacter(globalClassifiers[i].getName())%>
                    </option>
                    <%  }
					%>

                </select>
                              </table:cell>
              <table:cell>
                <select id="class<%=classIndex%>Percent"
                    name="class<%=classIndex%>Percent"
                    onChange="countPercents('<%=classIndex%>');generateName();">
                    <%    for (int i = 0; i <= 100; i+=5) { %>
                    <option id="optC<%=classIndex%>P<%=i%>" value="<%=i%>"><%=i%></option>
                    <%
                          // if it L2 VPWS then only 100% is available
                          if("l2vpws".equals(Layer))
                            i += 95;
                          }
                    %>
                </select>
                <%
                      if(classIndex == mappingsLength -1){
                    %>
                        autogenerated
                    <%
                      }
                    %>
                                                </table:cell>
        </table:row>
        <%
  }
%>

        <table:row>
            <table:cell colspan="3" align="center">
                <br>
                              </table:cell>
            </table:row>

                                                      <table:row>
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_in.alias"/>
                              </table:cell>
            <table:cell id="pro_in">
                <%= Profilename_in %>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_in.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_out.alias"/>
                              </table:cell>
            <table:cell id="pro_out">

                <%= Profilename_out %>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="QoSProfileApplicationResources" key="field.profilename_out.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
        <html:hidden property="profilename_in" value="<%= Profilename_in %>" />
        <html:hidden property="profilename_out" value="<%= Profilename_out %>" />
        <html:hidden property="compliant" value="compliant" />
        <html:hidden property="qosprofilename" value="" />
        <html:hidden property="suffix" value="" />
        <html:hidden property="classNumber"
            value="<%=String.valueOf(mappingsLength)%>" />
              <table:cell>  
                <bean:message bundle="QoSProfileApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
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
      <table:row>
        <table:cell colspan="3" align="center">
          <input type="button" name="submitbutton" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
          <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset" onClick="document.QoSProfileForm.reset();prepare();">
        </table:cell>
      </table:row>
    </table:table>
  </html:form>

  </body>

</html>
