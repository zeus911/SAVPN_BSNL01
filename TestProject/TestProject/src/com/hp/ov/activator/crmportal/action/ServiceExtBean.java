package com.hp.ov.activator.crmportal.action;

import com.hp.ov.activator.crmportal.bean.Service;

public class ServiceExtBean {
	private Service service;
	private String region;
	private String location;
	private String managed_CE_Router;
	
	public ServiceExtBean(){
		
	}
	
	public ServiceExtBean(Service service, String region,String location, String managed_CE_Router){
		this.service=service;
		this.region=region;
		this.location=location;
		this.managed_CE_Router=managed_CE_Router;	
	}
	
	
	public String getManaged_CE_Router() {
		return managed_CE_Router;
	}

	public void setManaged_CE_Router(String managed_CE_Router) {
		this.managed_CE_Router = managed_CE_Router;
	}

	public Service getService() {
		return service;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	

}
