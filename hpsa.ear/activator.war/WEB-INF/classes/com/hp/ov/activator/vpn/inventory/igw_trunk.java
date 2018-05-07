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


public class igw_trunk extends igw_trunk_ {
    // ****************************** Constructors *********************************** //

    /**
     * Default constructor.
     */
    public igw_trunk() {
        super();
    }

    /**
     * Constructor
     * TODO generate the params.
     */
    public igw_trunk(String _tRUNK_ID, String _tRUNKTYPE_ID, String _nAME,
        String _lINK_TYPE, String _sTATUS, String _sUBMIT_DATA) {
        super(_tRUNK_ID, _tRUNKTYPE_ID, _nAME, _lINK_TYPE, _sTATUS, _sUBMIT_DATA);
    }

    // **************************** inner classes *********************************** //

    /**
     * Bean used to search.
     */
    public class SearchBean extends igw_trunk_.SearchBean
        implements Serializable {
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
