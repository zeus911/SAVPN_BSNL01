
<%@page info="Creation form for bean RouterInterface"
      import="com.hp.ov.activator.mwfm.WFManager,
              com.hp.ov.activator.mwfm.servlet.Constants,
              com.hp.ov.activator.vpn.inventory.*,
              com.hp.ov.activator.cr.inventory.*,
              com.hp.ov.activator.inventory.facilities.StringFacility,
              com.hp.ov.activator.vpn.parser.IdGenerator,
              javax.sql.DataSource,
              java.sql.*,
              java.util.HashMap,
              java.util.Vector,
              java.util.regex.Matcher"
      session="true"
      contentType="text/html;charset=utf-8"
%>
<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@ page import="java.util.regex.Pattern"%>

<%
    if (session == null || session.getValue(Constants.USER) == null) {
        response.sendRedirect("/activator/jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
  <title>Create Channelized RouterInterface</title>
    <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
  <script language="JavaScript">
    function writeMsgLine(message) {
      var fPtr=parent.messageLine.document;
      fPtr.open();
      fPtr.write("<html>");
      fPtr.write("<link rel='stylesheet' type='text/css' href='/activator/css/inventory.css'>");
      fPtr.write("<body class=invCell><b>");
      fPtr.write(message);
      fPtr.write("</b></body></html>");
      //fPtr.close();
      
    }

    function checkNumValue(input){
      var str = input.value;
      var newStr = "";
      for(i = 0; i < str.length; i++){
        if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
          newStr = newStr + str.charAt(i);
        }
      }
      if(str != newStr || newStr.length == 0) {
        alert('Bad number format');
        input.value = newStr;
        return false;
      }
      return true;
    }


    
    

    //var fPtr=parent.messageLine.document;
    //fPtr.open();
    //fPtr.write("");
    //fPtr.close();
  </script>
</head>

<jsp:useBean id="bean" class="com.hp.ov.activator.cr.inventory.Interface" />
<jsp:setProperty name="bean" property="*"/>
<jsp:useBean id="chanint" scope="session" class="com.hp.ov.activator.cr.inventory.ChannelizedInterface" />
<jsp:setProperty name="chanint" property="*"/>
<%!
  public class JSPException extends Exception
  {
    public JSPException() { super(); }
    public JSPException(String s) { super(s); }
  }

  private boolean ValidateGroups(Connection connection, com.hp.ov.activator.cr.inventory.Interface bean) throws SQLException {
     // Now validate that timeslots are still free
     com.hp.ov.activator.cr.inventory.Interface [] interfaces = (com.hp.ov.activator.cr.inventory.Interface[])com.hp.ov.activator.cr.inventory.Interface.findByEc_id(connection, bean.getEc_id(), "ne_id = " + bean.getNe_id());
     int chn = bean.getName().indexOf(':');
     String pattern = bean.getName().substring(0, chn+1) + "\\d+";
     Pattern p = Pattern.compile(pattern);
     Matcher m;
     boolean[] slots = new boolean[32];
     for (int i=0; i<slots.length; i++) slots[i]=false;
     for (int i=0; i<interfaces.length; i++) {
       m = p.matcher(interfaces[i].getName());
       if (m.matches()) {

         int[] sl = ChannelizedInterface.getTimeslots(interfaces[i].getTimeslots());

         for (int j=0; j<sl.length; j++) {
           // Test if slot already taken
           if (slots[sl[j]])
             return false;
           slots[sl[j]]=true;
         }
       }
     }
     return true;
   }

  private int ChannelsGroupsOnE1(Connection connection, String ec_id, String name) throws SQLException {
     com.hp.ov.activator.cr.inventory.Interface []interfaces = (com.hp.ov.activator.cr.inventory.Interface[])com.hp.ov.activator.cr.inventory.Interface.findByEc_id(connection, ec_id);
     if (interfaces==null) return 0;

     int chn = name.indexOf(':');
     String pattern = name.substring(0, chn+1) + "\\d+";
     Pattern p = Pattern.compile(pattern);
     Matcher m;

     int retVal = 0;
     for (int i=0; i<interfaces.length; i++) {
       m = p.matcher(interfaces[i].getName());
       if (m.matches()) {
         retVal++;
       }
     }
     return retVal;
   }

%>

<%
  String fpc = "";
  String pic = "";

  String name = "";
  String ec_id = "";
  String vendor = "";
  com.hp.ov.activator.cr.inventory.NetworkElement router = null;
  ElementComponent[] ports = null;
  ElementComponent port = null;
  ElementComponent routerSlot;
  boolean[] freeSlots = new boolean[32];
  com.hp.ov.activator.cr.inventory.Interface[] interfaces;

  boolean doCreate = chanint.isDoCreate();

  DataSource dbp = (DataSource)session.getAttribute(Constants.DATASOURCE);
  Connection con = null;

  try {
    con = dbp.getConnection();
    IdGenerator idgen = new IdGenerator(con);

    boolean sonet=true, findPort, noFree=false;
    boolean isCSTM1 = false;
    String NO_SLOTS_MESSAGE = "No free timeslots on E1 controller: ";

    try {
      // Get the router bean
      router = (com.hp.ov.activator.cr.inventory.NetworkElement)com.hp.ov.activator.cr.inventory.NetworkElement.findByPrimaryKey(con, chanint.getNE_ID());
      if ( router != null ) {
        // Get the ports on the router of type Controller
        ports = (ElementComponent[])ElementComponent.findByNe_id(con, chanint.getNE_ID(), "ECType='Controller'");
      } else {
        throw new JSPException("No router found");
      }

      if (ports != null ) {
        if ("".equals(chanint.getEc_name()))
          chanint.setEc_name(ports[0].getName());
      } else
      {
        throw new JSPException("No controllers found");
      }

      ElementComponent[] p = (ElementComponent[])ElementComponent.findByName(con, chanint.getEc_name(), "ne_id="+chanint.getNE_ID());
      if (p!=null) {
        ec_id = p[0].getElementcomponentid();
      } else {
        chanint.setEc_name(ports[0].getName());
        p = (ElementComponent[])ElementComponent.findByName(con, chanint.getEc_name(), "ne_id="+chanint.getNE_ID());
        ec_id = p[0].getElementcomponentid();
      }
      port = (ElementComponent)ElementComponent.findByPrimaryKey(con, ec_id);
      routerSlot = (ElementComponent)ElementComponent.findByPrimaryKey(con, port.getParentec_id());

  
    } catch (JSPException jx) {
      jx.printStackTrace();
%>
      <script>
        writeMsgLine("<%= StringFacility.replaceAllByHTMLCharacter(jx.getMessage())%>")
      </script>
<%    
      chanint.init();
    } catch (Exception ex) {
      ex.printStackTrace();
      
%>
      <script>
        writeMsgLine("Bad input parameters: <%= String.valueOf(String.valueOf(ex.getMessage()).replace('\n',' ').replaceAll("\"","\\\\\"")) %>" );
      </script>
<%    //findPort=false;
      chanint.init();
    }

    if (!doCreate) {
%>
<body>
<center><h2>
Create Channelized RouterInterface
</h2></center>
<center>
<table>


<form name="channelform" method="post" action="/activator/inventory/CRModel/CreationFormChannelizedInterfaceAction.do?neid=<%=port.getNe_id()%>&elementcomponentid=<%=ec_id%>&datasource=inventoryDB"
	onSubmit="parent.messageLine.document.all.submit.disabled=false;">


<input type="hidden" name="createchannel" value="false">
<tr>
   <td><div class="invBField">Router</div></td>
   <td class="invField" colspan="3"><%=router.getName()%></td>
   <td class="invField" colspan="3">Name of the router where interface is created</td>
</tr>

<tr>
  <td class="invBField"><b>Controller</b>&nbsp;&nbsp;</td>
  <td class="invField" colspan="3">
    <select name="ec_name" onchange="document.location='CreateChannel.jsp?ec_name=' + channelform.ec_name.value;">
    
<%  if (ports!=null) {
      for (int i = 0; i < ports.length; i++) {
%>
        <option <%=chanint.getEc_name().equals(ports[i].getName())?"SELECTED ":" "%> value="<%=ports[i].getName()%>" ><%=ports[i].getName()%></option>
<%    }
    }
%>
    </select>
  </td>
  <td class="invField" colspan="3">Select the controller to channelize</td>
</tr>

<tr>
   <td><div class="invBField">Bandwidth</div></td>
   <td class="invField" colspan="3">
     <input type=text name="rateLimitKbps" value="<%=Integer.parseInt(chanint.getRateLimit())/1000+((Integer.parseInt(chanint.getRateLimit())%1000>0)?1:0)%>" size="14" onChange="checkNumValue(this)"></td>
   <td class="invField" colspan="3">Bandwidth specified by creating the site (Kbps)</td>
</tr>

<tr>
   <td><div class="invBField">Timeslots</div></td>
   <td class="invField" colspan="3"><%=chanint.getSlotsnumber()%></td>
   <td class="invField" colspan="3">

   </td>
   <input type=hidden name="slotsnumber" value="<%=chanint.getSlotsnumber()%>">


   
</tr>


<tr>
<td colspan="7" align="center">
   <input type="submit" name="submit" id="submit" value="Submit">&nbsp
   <input type="reset" name="reset" value="Reset"> &nbsp
</td>
</tr>

 <script>
 	
    
  </script>

</form>
</table>
</center>
</body>
<%
  } // End not doCreate
  } catch (Exception e) { 
    e.printStackTrace();

%>
  <script>
    alert("Exception" + "\n" + "<%= String.valueOf(String.valueOf(e.getMessage()).replace('\n',' ').replaceAll("\"","\\\\\"")) %>" );
    window.close();
    
    
  
  </script>
<%
  } finally { 
    try{
      con.close();
    }catch(Throwable th){
    // don't metter
    }
  }
%>



</html>
