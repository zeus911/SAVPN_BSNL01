package com.hp.ov.activator.crmportal.action;

import java.io.Serializable;
import java.util.ArrayList;

import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
/**
 * 
 * @author skaria
 *This bean will hold the service atrributes for each service which needs to be access in the display jsp.
 *These atributes are set in the Action bean .
 * 
 */
public class ServiceBean extends Service implements Serializable {


	/**
	 * 
	 */



	public ServiceBean(Service service){
		this.ServiceId =service.getServiceid();
		this.PresName = service.getPresname();
		this.ParentServiceId = service.getParentserviceid();
		this.CustomerId = service.getCustomerid();
		this.SubmitDate =service.getSubmitdate();
		this.ModifyDate =service.getModifydate();
		this.Type =service.getType();
		this.NextOperationTime =service.getNextoperationtime();
		this.EndTime =service.getEndtime();
		this.State=service.getState();
		this.LastUpdateTime=service.getLastupdatetime();
		
		ChildServices=null;
		
	}
	
	public ServiceBean(){
		
	}
	
	/**
	 * actions flag will determine if the acttions icons need to be disaplyes on service . 
	 * Now used only for Layer sites ans attachment services 
	 */
	public Boolean Actionsflag;
	
	/**
	 * pe ce routing protocol used  
	 */
	public String Pe_ce_routingprotocol;
	

	/**
	 * state of the service tree 
	 */
	public String TreeState;
	
	
	/**
	 *   child service beans of a service bean
	 */
	public ArrayList ChildServices;
	
	ServiceParameter [] parameters = null; //richa

	public Boolean getActionsflag() {
		return Actionsflag;
		
	}

	public void setActionsflag(Boolean actionsflag) {
		this.Actionsflag = actionsflag;
	}

	public String getPe_ce_routingprotocol() {
		return Pe_ce_routingprotocol;
	}

	public void setPe_ce_routingprotocol(String pe_ce_routingprotocol) {
		this.Pe_ce_routingprotocol = pe_ce_routingprotocol;
	}

	public ArrayList getChildServices() {
		return ChildServices;
	}
	public ServiceBean[] getChildServicesArray() {
	
		ServiceBean[] array =null;
		if(ChildServices == null)
			return null;
		
		array =new ServiceBean[ChildServices.size()];
		ChildServices.toArray(array);   
		return array;
 }

	public void setChildServices(ArrayList childServices) {
		this.ChildServices = childServices;
	}
	
	void addChildService(ServiceBean service){
		if (ChildServices == null){
			ChildServices =new ArrayList();
		}
		
		ChildServices.add(service);
		
	}

	public String getTreeState() {
		return TreeState;
	}

	public void setTreeState(String treeState) {
		TreeState = treeState;
	}

//richa- 14548
public void setServiceparameters( ServiceParameter [] parameters )
		{
			this.parameters = parameters;
		}

	public ServiceParameter [] getServiceparameters()
		{
			return parameters;
		}
}
