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


public class igw_trunkdata extends igw_trunkdata_ {
    // ****************************** Constructors *********************************** //

    /**
     * Default constructor.
     */
    public igw_trunkdata() {
        super();
    }

    /**
     * Constructor
     * TODO generate the params.
     */
    public igw_trunkdata(String _tRUNKDATA_ID, String _pARENT_TRUNKDATA,
        String _tRUNK_ID, String _sIDE_SERVICE_ID, String _sIDE_NAME,
        String _sIDE_SORT_NAME, String _rOUTER_ID, String _iNTERFACES_ID,
        String _iPNET_POOL, String _iPNET_ADDRESS, String _iPNET_SUBMASK,
        String _sIDE_DESCRIPTION, boolean _nEGO_FLAG, String _lINKPROTOCOL,
        int _mTU, boolean _pIM_FLAG, boolean _oSPFNET_TYPE_FLAG,
        int _oSPF_COST, String _oSPF_PASSWORD, boolean _lDP_FLAG,
        String _lDP_PASSWORD, String _iNTERFACE_DESCRIPTION,
        String _tRAFFIC_POLICYNAME, String _pOLICY_TYPE, String _iPV6_POOL,
        String _iPV6_ADDRESS, String _eNCAPSULATION, boolean _iPBINDING_FLAG,
        int _oSPF_PROCESSID, String _aREA, String _bANDWIDTH,
        String _rSVP_BANDWIDTH) {
        super(_tRUNKDATA_ID, _pARENT_TRUNKDATA, _tRUNK_ID, _sIDE_SERVICE_ID,
            _sIDE_NAME, _sIDE_SORT_NAME, _rOUTER_ID, _iNTERFACES_ID,
            _iPNET_POOL, _iPNET_ADDRESS, _iPNET_SUBMASK, _sIDE_DESCRIPTION,
            _nEGO_FLAG, _lINKPROTOCOL, _mTU, _pIM_FLAG, _oSPFNET_TYPE_FLAG,
            _oSPF_COST, _oSPF_PASSWORD, _lDP_FLAG, _lDP_PASSWORD,
            _iNTERFACE_DESCRIPTION, _tRAFFIC_POLICYNAME, _pOLICY_TYPE,
            _iPV6_POOL, _iPV6_ADDRESS, _eNCAPSULATION, _iPBINDING_FLAG,
            _oSPF_PROCESSID, _aREA, _bANDWIDTH, _rSVP_BANDWIDTH);
    }

    // **************************** inner classes *********************************** //

    /**
     * Bean used to search.
     */
    public class SearchBean extends igw_trunkdata_.SearchBean
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
