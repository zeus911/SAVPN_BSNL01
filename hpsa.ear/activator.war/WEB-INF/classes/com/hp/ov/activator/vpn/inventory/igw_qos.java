// Automatically generated code
// HP Service Activator InventoryBuilder V61.
//
// (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
package com.hp.ov.activator.vpn.inventory;

import com.hp.ov.activator.inventorybuilder.data.*;

import java.io.Serializable;

import java.sql.*;

import java.util.*;

// imported for giving preference against java.sql.Date
import java.util.Date;


public class igw_qos extends igw_qos_ {
    // ****************************** Constructors *********************************** //

    /**
     * Default constructor.
     */
    public igw_qos() {
        super();
    }

    /**
     * Constructor
     * TODO generate the params.
     */
    public igw_qos(String _qOS_ID, String _nAME, String _cOMMANDS) {
        super(_qOS_ID, _nAME, _cOMMANDS);
    }

    // **************************** inner classes *********************************** //

    /**
     * Bean used to search.
     */
    public class SearchBean extends igw_qos_.SearchBean implements Serializable {
        // ******************* Constructors *********************** //

        /**
         * Protected constructor, not for the user.
         * @param size number of fields of the bean
         */
        protected SearchBean(int size) {
            super(size);
        }

        public SearchBean() {
            super();
        }
    }
}
