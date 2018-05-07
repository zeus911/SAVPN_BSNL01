
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.sql.Connection;
import java.sql.SQLException;
/**
 * State Listener is used when needed to make some operations after some responce from OVSA.<br>
 * Sometimes it is not enougth just to change state of service depending on OVSA response.<br>
 * If such situation occures just register you implementation in <code>PortalSyncListener</code>
 * and if serviceid of responce will equal to id of listener then #procceedState() will be fired.<br/>
 * proceedState if fired right after next state have
 *
 */
public interface StateListener {
  public static int REMOVE_AND_CONTINUE = 0;
  public static int REMOVE_AND_BREAK = 1;
  public static int STAY_AND_CONTINUE = 2;
  public static int STAY_AND_BREAK = 3;

  /**
   * Makes listener action
   * @param connection connection to database
   * @param serviceId id of service
   * @param state the next state the service will get
   * @return return one of above constants
   */
  public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception;
}

