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


public class CreationCommitIPHostAction extends Action
    implements IPHostConstants {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
        HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException, ParseException, Exception {
        // Check if there is a valid session available.
        if ((request.getSession() == null) ||
                (request.getSession().getAttribute(IPHostConstants.USER) == null)) {
            return (mapping.findForward(IPHostConstants.NULL_SESSION));
        }

        IPHostForm formBeanIPHost;
        String target = IPHostConstants.FAILURE;
        Connection con = null;
        MessageResources messageResources = null;

        try {
            formBeanIPHost = (IPHostForm) form;
            messageResources = this.getResources(request);

            String datasource = request.getParameter(IPHostConstants.DATASOURCE);

            if ((datasource == null) || datasource.equals("")) {
                target = IPHostConstants.FAILURE;
                request.setAttribute(IPHostConstants.ERROR_ACTION,
                    request.getRequestURI());
                request.setAttribute(IPHostConstants.ERROR_MESSAGE,
                    "datasource.empty.errorMessage");

                return (mapping.findForward(target));
            }

            DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);

            if (ds != null) {
                con = ds.getConnection();

                con.setAutoCommit(false);

                com.hp.ov.activator.vpn.inventory.IPHost beanIPHost = new com.hp.ov.activator.vpn.inventory.IPHostBSNL();
                int i = 0;

                //beanIPHost.setIp(formBeanIPHost.getIp());

                beanIPHost.setPoolname(formBeanIPHost.getPoolname());

                //beanIPHost.setIpstr(formBeanIPHost.getIpstr());

                beanIPHost.setParentipnetaddr(formBeanIPHost.getParentipnetaddr());

                beanIPHost.setStartaddress(formBeanIPHost.getStartaddress());

                beanIPHost.setNumberofentries(formBeanIPHost.getNumberofentries());

                beanIPHost.setAddressfamily(formBeanIPHost.getAddressfamily());

                try {
                    executeGuiStorage(con, request, response, beanIPHost,
                        formBeanIPHost);
					String ipHostAddr = beanIPHost.generateAndStoreIPHost(con);
                    //beanIPHost.store(con);
                    executeGuiPostStorage(con, request, response, beanIPHost,
                        formBeanIPHost);
                    //con.commit();

                    request.setAttribute(IPHostConstants.IP_FIELD,
                        "" + ipHostAddr);
                    request.setAttribute(IPHostConstants.REFRESH_TREE, "true");
                    target = IPHostConstants.SUCCESS;
                } catch (Exception e) {
                    if (con != null) {
                        try {
                            con.rollback();
                        } catch (SQLException rollbackex) {
                            //we don't handle this exception because we think this should be 
                            //corrected manually. System cann't handle this problem by itself.
                        }
                    }

                    request.setAttribute(IPHostConstants.ERROR_ACTION,
                        request.getRequestURI());
                    request.setAttribute(IPHostConstants.ERROR_MESSAGE,
                        "jsp.sql.store.error");

                    String message = e.getMessage();

                    if (message == null) {
                        message = "null";
                    }

                    request.setAttribute(IPHostConstants.EXCEPTION_MESSAGE,
                        message.replace('\n', ' '));
                    target = IPHostConstants.ERROR;
                }
            } else {
                request.setAttribute(IPHostConstants.ERROR_ACTION,
                    request.getRequestURI());
                request.setAttribute(IPHostConstants.ERROR_MESSAGE,
                    "datasource.not_found_in_session.errorMessage");
                target = IPHostConstants.FAILURE;
            }
        } catch (SQLException sqle) {
            request.setAttribute(IPHostConstants.ERROR_ACTION,
                request.getRequestURI());
            request.setAttribute(IPHostConstants.ERROR_MESSAGE,
                "jsp.sql.store.error");
            request.setAttribute(IPHostConstants.EXCEPTION_MESSAGE,
                sqle.getMessage().replace('\n', ' '));
            target = IPHostConstants.ERROR;
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
        com.hp.ov.activator.vpn.inventory.IPHost bean, IPHostForm formBean)
        throws Exception {
    }

    public void executeGuiPostStorage(Connection con,
        HttpServletRequest request, HttpServletResponse response,
        com.hp.ov.activator.vpn.inventory.IPHost bean, IPHostForm formBean)
        throws Exception {
    }
}
