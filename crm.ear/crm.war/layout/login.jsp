<%--------------------------------------------------------------------------%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.  --%>
<%--------------------------------------------------------------------------%>

<%@page info="login screen for portal"
        contentType="text/html;charset=UTF-8" language="java"  %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<html:html>
<head>
  <html:base target="_top"/>
  <title><bean:message key="crm.title" /></title>
  <link href="<html:rewrite page="/css/activator.css"/>" rel="stylesheet" type="text/css" />
</head>
<body>
  <html:form action="/LoginSubmit" focus="userId">
  <table width="100%" style="height: 100%">
    <tr>
      <td align="center" valign="middle" class="white">
      <table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top" class=tableHeading><html:img src="../images/tl_corner.gif" width="10" height="20" border="0" alt="corner"/></td>
          <td valign="top" colspan="4" class=tableHeading align="left"> <bean:message key="crm.title"/> </td>
          <td valign="top" class=tableHeading><html:img src="../images/tr_corner.gif" width="10" height="20" border="0" alt="corner"/></td>
        </tr>

        <tr>
	  <td class=tableRow colspan="6" align="middle">&nbsp; </td>
	</tr>

        <tr>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow rowspan="6"><html:img src="../images/HPLogo_main.png" border="0" align="left" />&nbsp;&nbsp;</td>
          <td class=tableRow colspan="4"></td>
        </tr>

        <tr>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow width="100" valign="middle" align="right"> <bean:message key="label.userId"/>&nbsp;&nbsp;</td>
          <td class=tableRow width="260">
	    <html:text property="userId" style="width=80%"/>
	    <html:messages id="errors" property="userId" >
	      <br><font color="red"><bean:write name="errors"/></font></br>
	    </html:messages> 
	  </td>
          <td class=tableRow>&nbsp;</td>
        </tr>
	
        <tr>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow colspan="4">&nbsp;</td>
        </tr>

        <tr>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow width="100" valign="middle" align="right"> <bean:message key="label.passWord"/>&nbsp;&nbsp;</td>
          <td class=tableRow width="260" >
	    <html:password property="passWord" style="width=80%"/>
	    <html:messages id="errors" property="passWord" >
	      <br><font color="red"><bean:write name="errors"/></font></br>
	    </html:messages> 
	  </td>
          <td class=tableRow>&nbsp;</td>
        </tr>
        <tr>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow colspan="4">&nbsp;</td>
        </tr>

        <tr>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow>&nbsp;</td>
          <td class=tableRow>&nbsp;</td>
	  <td class=tableRow align="right">
	    <html:link href="javascript:document.LoginSubmit.submit();">
	      <html:image page="/images/arrow_submit.gif" border="0" align="right"/>
	    </html:link>
	  </td>
          <td class=tableRow>&nbsp;</td>
        </tr>

        <tr>
          <td valign="top" class=tableRow><html:img src="../images/bl_corner.gif" width="10" height="20" border="0" alt="corner"/></td>
          <td class=tableRow colspan="4">&nbsp;</td>
          <td valign="top" class=tableRow><html:img src="../images/br_corner.gif" width="10" height="20" border="0" alt="corner"/></td>
        </tr>
      </table>  
      </td>
    </tr>
  </table>
  </html:form>
</body>
</html:html>

<!-- vim:softtabstop=4:shiftwidth=4:expandtab
-->
