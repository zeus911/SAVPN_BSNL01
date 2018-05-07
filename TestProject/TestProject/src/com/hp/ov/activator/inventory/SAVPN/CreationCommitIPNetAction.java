package com.hp.ov.activator.inventory.SAVPN;

import com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.util.MessageResources;

import java.io.IOException;

import java.sql.Connection;
import java.sql.SQLException;

import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.sql.DataSource;


public class CreationCommitIPNetAction extends Action implements IPNetConstants {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
        HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException, ParseException, Exception {
        // Check if there is a valid session available.
        if ((request.getSession() == null) ||
                (request.getSession().getAttribute(IPNetConstants.USER) == null)) {
            return (mapping.findForward(IPNetConstants.NULL_SESSION));
        }

        IPNetForm formBeanIPNet;
        String target = IPNetConstants.FAILURE;
        Connection con = null;
        MessageResources messageResources = null;

        try {
            formBeanIPNet = (IPNetForm) form;
            messageResources = this.getResources(request);

            String datasource = request.getParameter(IPNetConstants.DATASOURCE);

            if ((datasource == null) || datasource.equals("")) {
                target = IPNetConstants.FAILURE;
                request.setAttribute(IPNetConstants.ERROR_ACTION,
                    request.getRequestURI());
                request.setAttribute(IPNetConstants.ERROR_MESSAGE,
                    "datasource.empty.errorMessage");

                return (mapping.findForward(target));
            }

            DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);

            if (ds != null) {
                con = ds.getConnection();

                con.setAutoCommit(false);

                com.hp.ov.activator.vpn.inventory.IPNet beanIPNet = new com.hp.ov.activator.vpn.inventory.IPNetBSNL();
                int i = 0;

                //beanIPNet.setIpnetaddr(formBeanIPNet.getIpnetaddr());

                //beanIPNet.setPe1_ipaddr(formBeanIPNet.getPe1_ipaddr());

                //beanIPNet.setCe1_ipaddr(formBeanIPNet.getCe1_ipaddr());

                //beanIPNet.setPe2_ipaddr(formBeanIPNet.getPe2_ipaddr());

                //beanIPNet.setCe2_ipaddr(formBeanIPNet.getCe2_ipaddr());

                //beanIPNet.setNetmask(formBeanIPNet.getNetmask());

                //beanIPNet.setHostmask(formBeanIPNet.getHostmask());

                beanIPNet.setPoolname(formBeanIPNet.getPoolname());

                //beanIPNet.setIpnetaddrstr(formBeanIPNet.getIpnetaddrstr());

                beanIPNet.setParentipnetaddr(formBeanIPNet.getParentipnetaddr());

                beanIPNet.setStartaddress(formBeanIPNet.getStartaddress());

                beanIPNet.setNumberofentries(formBeanIPNet.getNumberofentries());

                beanIPNet.setAddressfamily(formBeanIPNet.getAddressfamily());

                try {
                    executeGuiStorage(con, request, response, beanIPNet,
                        formBeanIPNet);

                    String ipNetAddr = beanIPNet.generateAndStoreIPNet(con);
                    executeGuiPostStorage(con, request, response, beanIPNet,
                        formBeanIPNet);
                    //con.commit();
                    request.setAttribute(IPNetConstants.IPNETADDR_FIELD,"" + ipNetAddr);
                    request.setAttribute(IPNetConstants.REFRESH_TREE, "true");
                    target = IPNetConstants.SUCCESS;
                } catch (Exception e) {
					e.printStackTrace();
                    if (con != null) {
                        try {
                            con.rollback();
                        } catch (SQLException rollbackex) {
                            //we don't handle this exception because we think this should be 
                            //corrected manually. System cann't handle this problem by itself.
                        }
                    }

                    request.setAttribute(IPNetConstants.ERROR_ACTION,
                        request.getRequestURI());
                    request.setAttribute(IPNetConstants.ERROR_MESSAGE,
                        "jsp.sql.store.error");

                    String message = e.getMessage();

                    if (message == null) {
                        message = "null";
                    }

                    request.setAttribute(IPNetConstants.EXCEPTION_MESSAGE,
                        message.replace('\n', ' '));
                    target = IPNetConstants.ERROR;
                }
            } else {
                request.setAttribute(IPNetConstants.ERROR_ACTION,
                    request.getRequestURI());
                request.setAttribute(IPNetConstants.ERROR_MESSAGE,
                    "datasource.not_found_in_session.errorMessage");
                target = IPNetConstants.FAILURE;
            }
        } catch (SQLException sqle) {
			sqle.printStackTrace();
            request.setAttribute(IPNetConstants.ERROR_ACTION,
                request.getRequestURI());
            request.setAttribute(IPNetConstants.ERROR_MESSAGE,
                "jsp.sql.store.error");
            request.setAttribute(IPNetConstants.EXCEPTION_MESSAGE,
                sqle.getMessage().replace('\n', ' '));
            target = IPNetConstants.ERROR;
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ignoreIt) {
                //we don't handle this exception because we think this should be 
                //corrected manually. System cann't handle this problem by itself.
            }
        }

        return (mapping.findForward(target));
    }

    public void executeGuiStorage(Connection con, HttpServletRequest request,
        HttpServletResponse response,
        com.hp.ov.activator.vpn.inventory.IPNet bean, IPNetForm formBean)
        throws Exception {
    }

    public void executeGuiPostStorage(Connection con,
        HttpServletRequest request, HttpServletResponse response,
        com.hp.ov.activator.vpn.inventory.IPNet bean, IPNetForm formBean)
        throws Exception {
    }
}
