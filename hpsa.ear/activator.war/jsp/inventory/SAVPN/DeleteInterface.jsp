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
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(InterfaceConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="InterfaceApplicationResources" key="<%= InterfaceConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.InterfaceForm.action = '/activator<%=moduleConfig%>/DeleteCommitInterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.InterfaceForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="InterfaceApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Interface beanInterface = (com.hp.ov.activator.vpn.inventory.Interface) request.getAttribute(InterfaceConstants.INTERFACE_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TerminationPointId = StringFacility.replaceAllByHTMLCharacter(beanInterface.getTerminationpointid());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanInterface.getName());
                        
                                  
              String NE_Id = (String) request.getAttribute(InterfaceConstants.NE_ID_LABEL);
      NE_Id = StringFacility.replaceAllByHTMLCharacter(NE_Id);
      String NE_Id_key = beanInterface.getNe_id();
      NE_Id_key = StringFacility.replaceAllByHTMLCharacter(NE_Id_key);
          
                                  
                      String NE = StringFacility.replaceAllByHTMLCharacter(beanInterface.getNe());
                        
                                  
              String EC_Id = (String) request.getAttribute(InterfaceConstants.EC_ID_LABEL);
      EC_Id = StringFacility.replaceAllByHTMLCharacter(EC_Id);
      String EC_Id_key = beanInterface.getEc_id();
      EC_Id_key = StringFacility.replaceAllByHTMLCharacter(EC_Id_key);
          
                                  
                      String EC = StringFacility.replaceAllByHTMLCharacter(beanInterface.getEc());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanInterface.getState());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanInterface.getType());
                        
                                  
              String ParentIf = (String) request.getAttribute(InterfaceConstants.PARENTIF_LABEL);
      ParentIf = StringFacility.replaceAllByHTMLCharacter(ParentIf);
      String ParentIf_key = beanInterface.getParentif();
      ParentIf_key = StringFacility.replaceAllByHTMLCharacter(ParentIf_key);
          
                                  
                      String ParentIfC = StringFacility.replaceAllByHTMLCharacter(beanInterface.getParentifc());
                        
                                  
                      String IPAddr = StringFacility.replaceAllByHTMLCharacter(beanInterface.getIpaddr());
                        
                                  
                      String Subtype = StringFacility.replaceAllByHTMLCharacter(beanInterface.getSubtype());
                        
                                  
                      String Encapsulation = StringFacility.replaceAllByHTMLCharacter(beanInterface.getEncapsulation());
                        
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanInterface.getDescription());
                        
                                  
                      String IFIndex = StringFacility.replaceAllByHTMLCharacter(beanInterface.getIfindex());
                        
                                  
                      String ActivationState = StringFacility.replaceAllByHTMLCharacter(beanInterface.getActivationstate());
                        
                                  
                      String UsageState = StringFacility.replaceAllByHTMLCharacter(beanInterface.getUsagestate());
                        
                                  
                      String VLANId = StringFacility.replaceAllByHTMLCharacter(beanInterface.getVlanid());
                        
                                  
                      String VLANMode = StringFacility.replaceAllByHTMLCharacter(beanInterface.getVlanmode());
                        
                                  
                      String DLCI = StringFacility.replaceAllByHTMLCharacter(beanInterface.getDlci());
                        
                                  
                      String BundleKey = StringFacility.replaceAllByHTMLCharacter(beanInterface.getBundlekey());
                        
                                  
                      String BundleId = StringFacility.replaceAllByHTMLCharacter(beanInterface.getBundleid());
                        
                                  
                      String Timeslots = StringFacility.replaceAllByHTMLCharacter(beanInterface.getTimeslots());
                        
                                  
                      String NumberOfSlots = StringFacility.replaceAllByHTMLCharacter(beanInterface.getNumberofslots());
                        
                                  
                      String Bandwidth = StringFacility.replaceAllByHTMLCharacter(beanInterface.getBandwidth());
                        
                                  
                      String LMIType = StringFacility.replaceAllByHTMLCharacter(beanInterface.getLmitype());
                        
                                  
                      String IntfType = StringFacility.replaceAllByHTMLCharacter(beanInterface.getIntftype());
                        
                                  
              String States = (String) request.getAttribute(InterfaceConstants.STATES_LABEL);
      States = StringFacility.replaceAllByHTMLCharacter(States);
      String States_key = beanInterface.getStates();
      States_key = StringFacility.replaceAllByHTMLCharacter(States_key);
          
                                  
                      String OriginalActivationState = StringFacility.replaceAllByHTMLCharacter(beanInterface.getOriginalactivationstate());
                        
                                  
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanInterface.getNnmi_uuid());
                        
                                  
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanInterface.getNnmi_id());
                        
                                  
                      String NNMi_LastUpdate = (beanInterface.getNnmi_lastupdate() == null) ? "" : beanInterface.getNnmi_lastupdate();
        NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                            java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                                String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
                sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                  
                                  
                        String __count = "" + beanInterface.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanInterface.get__count()) : "";
                          
                  if( beanInterface.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="InterfaceApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean OriginalActivationStatePass_Type = true ;

boolean StatesPass_Type = true ;

boolean showType = false;
  if (true && OriginalActivationStatePass_Type && StatesPass_Type ){
showType = true;
}


boolean ParentIfPass_ParentIfC = false ;
ParentIfPass_ParentIfC = java.util.regex.Pattern.compile("^\\S+$").matcher(ParentIf).matches();
boolean showParentIfC = false;
  if (true && ParentIfPass_ParentIfC ){
showParentIfC = true;
}


boolean OriginalActivationStatePass_IPAddr = true ;

boolean showIPAddr = false;
  if (true && OriginalActivationStatePass_IPAddr ){
showIPAddr = true;
}


boolean OriginalActivationStatePass_Subtype = true ;

boolean showSubtype = false;
  if (true && OriginalActivationStatePass_Subtype ){
showSubtype = true;
}


boolean OriginalActivationStatePass_Encapsulation = true ;

boolean StatesPass_Encapsulation = true ;

boolean showEncapsulation = false;
  if (true && OriginalActivationStatePass_Encapsulation && StatesPass_Encapsulation ){
showEncapsulation = true;
}


boolean OriginalActivationStatePass_Description = true ;

boolean showDescription = false;
  if (true && OriginalActivationStatePass_Description ){
showDescription = true;
}


boolean OriginalActivationStatePass_IFIndex = true ;

boolean showIFIndex = false;
  if (true && OriginalActivationStatePass_IFIndex ){
showIFIndex = true;
}


boolean OriginalActivationStatePass_ActivationState = true ;

boolean showActivationState = false;
  if (true && OriginalActivationStatePass_ActivationState ){
showActivationState = true;
}


boolean OriginalActivationStatePass_UsageState = true ;

boolean StatesPass_UsageState = true ;

boolean showUsageState = false;
  if (true && OriginalActivationStatePass_UsageState && StatesPass_UsageState ){
showUsageState = true;
}


boolean OriginalActivationStatePass_VLANId = true ;

boolean showVLANId = false;
  if (true && OriginalActivationStatePass_VLANId ){
showVLANId = true;
}


boolean OriginalActivationStatePass_VLANMode = true ;

boolean showVLANMode = false;
  if (true && OriginalActivationStatePass_VLANMode ){
showVLANMode = true;
}


boolean OriginalActivationStatePass_DLCI = true ;

boolean showDLCI = false;
  if (true && OriginalActivationStatePass_DLCI ){
showDLCI = true;
}


boolean OriginalActivationStatePass_BundleKey = true ;

boolean showBundleKey = false;
  if (true && OriginalActivationStatePass_BundleKey ){
showBundleKey = true;
}


boolean OriginalActivationStatePass_BundleId = true ;

boolean showBundleId = false;
  if (true && OriginalActivationStatePass_BundleId ){
showBundleId = true;
}


boolean OriginalActivationStatePass_Timeslots = true ;

boolean showTimeslots = false;
  if (true && OriginalActivationStatePass_Timeslots ){
showTimeslots = true;
}


boolean OriginalActivationStatePass_NumberOfSlots = true ;

boolean showNumberOfSlots = false;
  if (true && OriginalActivationStatePass_NumberOfSlots ){
showNumberOfSlots = true;
}


boolean OriginalActivationStatePass_Bandwidth = true ;

boolean showBandwidth = false;
  if (true && OriginalActivationStatePass_Bandwidth ){
showBandwidth = true;
}


boolean OriginalActivationStatePass_LMIType = true ;

boolean showLMIType = false;
  if (true && OriginalActivationStatePass_LMIType ){
showLMIType = true;
}


boolean OriginalActivationStatePass_IntfType = true ;

boolean showIntfType = false;
  if (true && OriginalActivationStatePass_IntfType ){
showIntfType = true;
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
      
                                      <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TerminationPointId != null? TerminationPointId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.terminationpointid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.ne.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NE != null? NE : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ne.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.ec.alias"/>
                          </table:cell>
            <table:cell>
                            <%= EC != null? EC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ec.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Up" ,"Up");
                                            valueShowMap.put("Down" ,"Down");
                                            valueShowMap.put("Unknown" ,"Unknown");
                                          if(State!=null)
                     State=(String)valueShowMap.get(State);
              %>
              <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showType){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.type.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                               <%if(showParentIfC){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.parentifc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ParentIfC != null? ParentIfC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.parentifc.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showIPAddr){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.ipaddr.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IPAddr != null? IPAddr : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ipaddr.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showSubtype){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.subtype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Subtype != null? Subtype : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.subtype.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showEncapsulation){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.encapsulation.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Encapsulation != null? Encapsulation : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.encapsulation.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showDescription){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showIFIndex){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.ifindex.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IFIndex != null? IFIndex : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ifindex.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showActivationState){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.activationstate.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Activated" ,"Activated");
                                            valueShowMap.put("Failed" ,"Failed");
                                            valueShowMap.put("Undefined" ,"Undefined");
                                            valueShowMap.put("Ready" ,"Ready");
                                          if(ActivationState!=null)
                     ActivationState=(String)valueShowMap.get(ActivationState);
              %>
              <%= ActivationState != null? ActivationState : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.activationstate.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showUsageState){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.usagestate.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Available" ,"Available");
                                            valueShowMap.put("SubIfPresent" ,"SubIfPresent");
                                            valueShowMap.put("Uplink" ,"Uplink");
                                            valueShowMap.put("Reserved" ,"Reserved");
                                            valueShowMap.put("InBundle" ,"InBundle");
                                            valueShowMap.put("Trunk" ,"Trunk");
                                            valueShowMap.put("ASBRLink" ,"ASBRLink");
                                            valueShowMap.put("SwitchPort" ,"SwitchPort");
                                          if(UsageState!=null)
                     UsageState=(String)valueShowMap.get(UsageState);
              %>
              <%= UsageState != null? UsageState : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.usagestate.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showVLANId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VLANId != null? VLANId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showVLANMode){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanmode.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VLANMode != null? VLANMode : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanmode.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showDLCI){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.dlci.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DLCI != null? DLCI : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.dlci.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showBundleKey){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.bundlekey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= BundleKey != null? BundleKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bundlekey.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showBundleId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.bundleid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= BundleId != null? BundleId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bundleid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showTimeslots){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.timeslots.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Timeslots != null? Timeslots : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.timeslots.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showNumberOfSlots){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.numberofslots.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NumberOfSlots != null? NumberOfSlots : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.numberofslots.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showBandwidth){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.bandwidth.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Bandwidth != null? Bandwidth : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bandwidth.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showLMIType){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.lmitype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LMIType != null? LMIType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.lmitype.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showIntfType){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.intftype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IntfType != null? IntfType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.intftype.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                                                                                                        <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_uuid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_lastupdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.__count.description"/>
                                    <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitInterfaceAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="terminationpointid" value="<%= String.valueOf(TerminationPointId) %>"/>
              </html:form>
  </body>
</html>

