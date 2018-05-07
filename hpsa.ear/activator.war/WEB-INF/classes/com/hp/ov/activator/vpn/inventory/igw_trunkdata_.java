// Automatically generated code
// HP Service Activator InventoryBuilder V61.
//
// (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
package com.hp.ov.activator.vpn.inventory;

import com.hp.ov.activator.inventory.SAVPN.CommonBean;
import com.hp.ov.activator.inventorybuilder.ExceededNumberOfRowsException;
import com.hp.ov.activator.inventorybuilder.InventoryException;
import com.hp.ov.activator.inventorybuilder.LobUsedForSearchException;
import com.hp.ov.activator.inventorybuilder.data.*;
import com.hp.ov.activator.inventorybuilder.data.parameters.OperationsParameters;
import com.hp.ov.activator.inventorybuilder.data.parameters.ParameterException;
import com.hp.ov.activator.inventorybuilder.data.parameters.types.IndexOfExpressionBean;
import com.hp.ov.activator.inventorybuilder.utils.Log;
import com.hp.ov.activator.inventorybuilder.utils.jsql.types.*;
import com.hp.ov.activator.inventorybuilder.utils.jsql.types.dynamic.*;

import java.io.Serializable;

import java.net.InetAddress;

import java.sql.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.*;

// imported for giving preference against java.sql.Date
import java.util.Date;


public class igw_trunkdata_ extends CommonBean implements Serializable {
    protected static String[] searchableFieldNames;
    protected static Field[] fields = new Field[32];
    protected static Map field_label_key_equivalency = new HashMap(32 * 3);
    protected static Map field_label_column_equivalency = new HashMap(32 * 3);
    private static ClassLoader class_loader = com.hp.ov.activator.vpn.inventory.igw_trunkdata.class.getClassLoader();
    public static final String ORIGINAL_TABLE = "igw_trunkdata";
    public static final String HISTORY_TABLE = "igw_trunkdataHist";
    public static final String TABLE_ALIAS = "igw_trunkdata";

    // *************************** static init section **************************** //
    static {
        Bean.setIsOracle(true);

        // Filling the searchable fields
        searchableFieldNames = new String[31];
        searchableFieldNames[0] = "PARENT_TRUNKDATA";
        searchableFieldNames[1] = "TRUNK_ID";
        searchableFieldNames[2] = "SIDE_SERVICE_ID";
        searchableFieldNames[3] = "SIDE_NAME";
        searchableFieldNames[4] = "SIDE_SORT_NAME";
        searchableFieldNames[5] = "ROUTER_ID";
        searchableFieldNames[6] = "INTERFACES_ID";
        searchableFieldNames[7] = "IPNET_POOL";
        searchableFieldNames[8] = "IPNET_ADDRESS";
        searchableFieldNames[9] = "IPNET_SUBMASK";
        searchableFieldNames[10] = "SIDE_DESCRIPTION";
        searchableFieldNames[11] = "NEGO_FLAG";
        searchableFieldNames[12] = "LINKPROTOCOL";
        searchableFieldNames[13] = "MTU";
        searchableFieldNames[14] = "PIM_FLAG";
        searchableFieldNames[15] = "OSPFNET_TYPE_FLAG";
        searchableFieldNames[16] = "OSPF_COST";
        searchableFieldNames[17] = "OSPF_PASSWORD";
        searchableFieldNames[18] = "LDP_FLAG";
        searchableFieldNames[19] = "LDP_PASSWORD";
        searchableFieldNames[20] = "INTERFACE_DESCRIPTION";
        searchableFieldNames[21] = "TRAFFIC_POLICYNAME";
        searchableFieldNames[22] = "POLICY_TYPE";
        searchableFieldNames[23] = "IPV6_POOL";
        searchableFieldNames[24] = "IPV6_ADDRESS";
        searchableFieldNames[25] = "ENCAPSULATION";
        searchableFieldNames[26] = "IPBINDING_FLAG";
        searchableFieldNames[27] = "OSPF_PROCESSID";
        searchableFieldNames[28] = "AREA";
        searchableFieldNames[29] = "BANDWIDTH";
        searchableFieldNames[30] = "RSVP_BANDWIDTH";

        // Filling fields information
        fields[0] = new Field("TRUNKDATA_ID", "String", null, "Primary key\n",
                true, true, false, true, false && false /* old readOnly */    ,
                true, false);
        fields[1] = new Field("PARENT_TRUNKDATA", "String", null,
                "Parent relationship for subinterface trunks\n", true, true,
                false, false, true && false /* old readOnly */    , false, false);
        fields[2] = new Field("TRUNK_ID", "String", null, "Foreign key\n",
                true, true, false, false, true && false /* old readOnly */    ,
                false, false);
        fields[3] = new Field("SIDE_SERVICE_ID", "String", null,
                "Trunk side ID\n", true, true, false, true,
                true && true /* old readOnly */    , false, false);
        fields[4] = new Field("SIDE_NAME", "String", null,
                "Name of the trunk side\n", true, true, false, true,
                true && true /* old readOnly */    , false, false);
        fields[5] = new Field("SIDE_SORT_NAME", "String", null,
                "Sort name of the trunk side\n", true, true, false, true,
                true && true /* old readOnly */    , false, false);
        fields[6] = new Field("ROUTER_ID", "String", null, "ROUTER ID\n", true,
                true, false, true, true && true /* old readOnly */    , false,
                false);
        fields[7] = new Field("INTERFACES_ID", "String", null,
                "INTERFACES ID\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[8] = new Field("IPNET_POOL", "String", null, "IP pool\n", true,
                true, false, false, true && true /* old readOnly */    , false,
                false);
        fields[9] = new Field("IPNET_ADDRESS", "String", null, "IP address\n",
                true, true, false, false, true && true /* old readOnly */    ,
                false, false);
        fields[10] = new Field("IPNET_SUBMASK", "String", null, "IP submask\n",
                true, true, false, false, true && true /* old readOnly */    ,
                false, false);
        fields[11] = new Field("SIDE_DESCRIPTION", "String", null,
                "Description of the trunk side\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[12] = new Field("NEGO_FLAG", "boolean", null,
                "Negotiation 'auto' should be true or false\n", true, true,
                false, false, true && true /* old readOnly */    , false, false);
        fields[13] = new Field("LINKPROTOCOL", "String", null,
                "Link protocol for the sides\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[14] = new Field("MTU", "int", null,
                "MTU value by default should be 1700\n", true, true, false,
                false, true && true /* old readOnly */    , false, false);
        fields[15] = new Field("PIM_FLAG", "boolean", null,
                "PIM 'sm' can be true or false\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[16] = new Field("OSPFNET_TYPE_FLAG", "boolean", null,
                "OSPF network type can be true or false\n", true, true, false,
                false, true && true /* old readOnly */    , false, false);
        fields[17] = new Field("OSPF_COST", "int", null,
                "OSPF cost value by default should be 200\n", true, true,
                false, false, true && true /* old readOnly */    , false, false);
        fields[18] = new Field("OSPF_PASSWORD", "String", null,
                "OSPF password\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[19] = new Field("LDP_FLAG", "boolean", null,
                "LDP value can be true or false\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[20] = new Field("LDP_PASSWORD", "String", null,
                "LDP password\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[21] = new Field("INTERFACE_DESCRIPTION", "String", null,
                "Interface description\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[22] = new Field("TRAFFIC_POLICYNAME", "String", null,
                "Traffic policy for the sides\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[23] = new Field("POLICY_TYPE", "String", null,
                "Policy type can be inbond and outbound for the sides\n", true,
                true, false, false, true && true /* old readOnly */    , false,
                false);
        fields[24] = new Field("IPV6_POOL", "String", null, "Ipv6 pool\n",
                true, true, false, false, true && true /* old readOnly */    ,
                false, false);
        fields[25] = new Field("IPV6_ADDRESS", "String", null,
                "Ipv6 address\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[26] = new Field("ENCAPSULATION", "String", null,
                "Encapsulation should be dot1q if subinterfaces for the sides\n",
                true, true, false, false, true && true /* old readOnly */    ,
                false, false);
        fields[27] = new Field("IPBINDING_FLAG", "boolean", null,
                "IP Binding value can be true or false\n", true, true, false,
                false, true && true /* old readOnly */    , false, false);
        fields[28] = new Field("OSPF_PROCESSID", "int", null,
                "OSPF_PROCESSID value default 100\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[29] = new Field("AREA", "String", null, "AREA value\n", true,
                true, false, false, true && true /* old readOnly */    , false,
                false);
        fields[30] = new Field("BANDWIDTH", "String", null,
                "BANDWIDTH value\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);
        fields[31] = new Field("RSVP_BANDWIDTH", "String", null,
                "RSVP_BANDWIDTH value\n", true, true, false, false,
                true && true /* old readOnly */    , false, false);

        // Filling the equivalence field label / field data key access
        field_label_key_equivalency.put("TRUNKDATA_ID",
            "igw_trunkdata.TRUNKDATA_ID");
        field_label_key_equivalency.put("PARENT_TRUNKDATA",
            "igw_trunkdata.PARENT_TRUNKDATA");
        field_label_key_equivalency.put("TRUNK_ID", "igw_trunkdata.TRUNK_ID");
        field_label_key_equivalency.put("SIDE_SERVICE_ID",
            "igw_trunkdata.SIDE_SERVICE_ID");
        field_label_key_equivalency.put("SIDE_NAME", "igw_trunkdata.SIDE_NAME");
        field_label_key_equivalency.put("SIDE_SORT_NAME",
            "igw_trunkdata.SIDE_SORT_NAME");
        field_label_key_equivalency.put("ROUTER_ID", "igw_trunkdata.ROUTER_ID");
        field_label_key_equivalency.put("INTERFACES_ID",
            "igw_trunkdata.INTERFACES_ID");
        field_label_key_equivalency.put("IPNET_POOL", "igw_trunkdata.IPNET_POOL");
        field_label_key_equivalency.put("IPNET_ADDRESS",
            "igw_trunkdata.IPNET_ADDRESS");
        field_label_key_equivalency.put("IPNET_SUBMASK",
            "igw_trunkdata.IPNET_SUBMASK");
        field_label_key_equivalency.put("SIDE_DESCRIPTION",
            "igw_trunkdata.SIDE_DESCRIPTION");
        field_label_key_equivalency.put("NEGO_FLAG", "igw_trunkdata.NEGO_FLAG");
        field_label_key_equivalency.put("LINKPROTOCOL",
            "igw_trunkdata.LINKPROTOCOL");
        field_label_key_equivalency.put("MTU", "igw_trunkdata.MTU");
        field_label_key_equivalency.put("PIM_FLAG", "igw_trunkdata.PIM_FLAG");
        field_label_key_equivalency.put("OSPFNET_TYPE_FLAG",
            "igw_trunkdata.OSPFNET_TYPE_FLAG");
        field_label_key_equivalency.put("OSPF_COST", "igw_trunkdata.OSPF_COST");
        field_label_key_equivalency.put("OSPF_PASSWORD",
            "igw_trunkdata.OSPF_PASSWORD");
        field_label_key_equivalency.put("LDP_FLAG", "igw_trunkdata.LDP_FLAG");
        field_label_key_equivalency.put("LDP_PASSWORD",
            "igw_trunkdata.LDP_PASSWORD");
        field_label_key_equivalency.put("INTERFACE_DESCRIPTION",
            "igw_trunkdata.INTERFACE_DESCRIPTION");
        field_label_key_equivalency.put("TRAFFIC_POLICYNAME",
            "igw_trunkdata.TRAFFIC_POLICYNAME");
        field_label_key_equivalency.put("POLICY_TYPE",
            "igw_trunkdata.POLICY_TYPE");
        field_label_key_equivalency.put("IPV6_POOL", "igw_trunkdata.IPV6_POOL");
        field_label_key_equivalency.put("IPV6_ADDRESS",
            "igw_trunkdata.IPV6_ADDRESS");
        field_label_key_equivalency.put("ENCAPSULATION",
            "igw_trunkdata.ENCAPSULATION");
        field_label_key_equivalency.put("IPBINDING_FLAG",
            "igw_trunkdata.IPBINDING_FLAG");
        field_label_key_equivalency.put("OSPF_PROCESSID",
            "igw_trunkdata.OSPF_PROCESSID");
        field_label_key_equivalency.put("AREA", "igw_trunkdata.AREA");
        field_label_key_equivalency.put("BANDWIDTH", "igw_trunkdata.BANDWIDTH");
        field_label_key_equivalency.put("RSVP_BANDWIDTH",
            "igw_trunkdata.RSVP_BANDWIDTH");

        // Filling the equivalence field label / field column
        field_label_column_equivalency.put("TRUNKDATA_ID", "TRUNKDATA_ID");
        field_label_column_equivalency.put("PARENT_TRUNKDATA",
            "PARENT_TRUNKDATA");
        field_label_column_equivalency.put("TRUNK_ID", "TRUNK_ID");
        field_label_column_equivalency.put("SIDE_SERVICE_ID", "SIDE_SERVICE_ID");
        field_label_column_equivalency.put("SIDE_NAME", "SIDE_NAME");
        field_label_column_equivalency.put("SIDE_SORT_NAME", "SIDE_SORT_NAME");
        field_label_column_equivalency.put("ROUTER_ID", "ROUTER_ID");
        field_label_column_equivalency.put("INTERFACES_ID", "INTERFACES_ID");
        field_label_column_equivalency.put("IPNET_POOL", "IPNET_POOL");
        field_label_column_equivalency.put("IPNET_ADDRESS", "IPNET_ADDRESS");
        field_label_column_equivalency.put("IPNET_SUBMASK", "IPNET_SUBMASK");
        field_label_column_equivalency.put("SIDE_DESCRIPTION",
            "SIDE_DESCRIPTION");
        field_label_column_equivalency.put("NEGO_FLAG", "NEGO_FLAG");
        field_label_column_equivalency.put("LINKPROTOCOL", "LINKPROTOCOL");
        field_label_column_equivalency.put("MTU", "MTU");
        field_label_column_equivalency.put("PIM_FLAG", "PIM_FLAG");
        field_label_column_equivalency.put("OSPFNET_TYPE_FLAG",
            "OSPFNET_TYPE_FLAG");
        field_label_column_equivalency.put("OSPF_COST", "OSPF_COST");
        field_label_column_equivalency.put("OSPF_PASSWORD", "OSPF_PASSWORD");
        field_label_column_equivalency.put("LDP_FLAG", "LDP_FLAG");
        field_label_column_equivalency.put("LDP_PASSWORD", "LDP_PASSWORD");
        field_label_column_equivalency.put("INTERFACE_DESCRIPTION",
            "INTERFACE_DESCRIPTION");
        field_label_column_equivalency.put("TRAFFIC_POLICYNAME",
            "TRAFFIC_POLICYNAME");
        field_label_column_equivalency.put("POLICY_TYPE", "POLICY_TYPE");
        field_label_column_equivalency.put("IPV6_POOL", "IPV6_POOL");
        field_label_column_equivalency.put("IPV6_ADDRESS", "IPV6_ADDRESS");
        field_label_column_equivalency.put("ENCAPSULATION", "ENCAPSULATION");
        field_label_column_equivalency.put("IPBINDING_FLAG", "IPBINDING_FLAG");
        field_label_column_equivalency.put("OSPF_PROCESSID", "OSPF_PROCESSID");
        field_label_column_equivalency.put("AREA", "AREA");
        field_label_column_equivalency.put("BANDWIDTH", "BANDWIDTH");
        field_label_column_equivalency.put("RSVP_BANDWIDTH", "RSVP_BANDWIDTH");
    }

    // ********************************* Fields ************************************ //
    protected String TRUNKDATA_ID;
    protected boolean TRUNKDATA_ID_seq_nextVal = false;
    protected String PARENT_TRUNKDATA;
    protected String TRUNK_ID;
    protected String SIDE_SERVICE_ID;
    protected String SIDE_NAME;
    protected String SIDE_SORT_NAME;
    protected String ROUTER_ID;
    protected String INTERFACES_ID;
    protected String IPNET_POOL;
    protected String IPNET_ADDRESS;
    protected String IPNET_SUBMASK;
    protected String SIDE_DESCRIPTION;
    protected boolean NEGO_FLAG;
    protected String LINKPROTOCOL;
    protected int MTU;
    protected boolean PIM_FLAG;
    protected boolean OSPFNET_TYPE_FLAG;
    protected int OSPF_COST;
    protected String OSPF_PASSWORD;
    protected boolean LDP_FLAG;
    protected String LDP_PASSWORD;
    protected String INTERFACE_DESCRIPTION;
    protected String TRAFFIC_POLICYNAME;
    protected String POLICY_TYPE;
    protected String IPV6_POOL;
    protected String IPV6_ADDRESS;
    protected String ENCAPSULATION;
    protected boolean IPBINDING_FLAG;
    protected int OSPF_PROCESSID;
    protected String AREA;
    protected String BANDWIDTH;
    protected String RSVP_BANDWIDTH;

    // ****************************** Constructors *********************************** //

    /**
     * Default constructor.
     */
    public igw_trunkdata_() {
        super();
        initDefault();
        initMandatory();
    }

    /**
     * Constructor
     * TODO generate the params.
     */
    public igw_trunkdata_(String _tRUNKDATA_ID, String _pARENT_TRUNKDATA,
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
        super();

        //Init Reservables
        setTrunkdata_id(_tRUNKDATA_ID);
        setParent_trunkdata(_pARENT_TRUNKDATA);
        setTrunk_id(_tRUNK_ID);
        setSide_service_id(_sIDE_SERVICE_ID);
        setSide_name(_sIDE_NAME);
        setSide_sort_name(_sIDE_SORT_NAME);
        setRouter_id(_rOUTER_ID);
        setInterfaces_id(_iNTERFACES_ID);
        setIpnet_pool(_iPNET_POOL);
        setIpnet_address(_iPNET_ADDRESS);
        setIpnet_submask(_iPNET_SUBMASK);
        setSide_description(_sIDE_DESCRIPTION);
        setNego_flag(_nEGO_FLAG);
        setLinkprotocol(_lINKPROTOCOL);
        setMtu(_mTU);
        setPim_flag(_pIM_FLAG);
        setOspfnet_type_flag(_oSPFNET_TYPE_FLAG);
        setOspf_cost(_oSPF_COST);
        setOspf_password(_oSPF_PASSWORD);
        setLdp_flag(_lDP_FLAG);
        setLdp_password(_lDP_PASSWORD);
        setInterface_description(_iNTERFACE_DESCRIPTION);
        setTraffic_policyname(_tRAFFIC_POLICYNAME);
        setPolicy_type(_pOLICY_TYPE);
        setIpv6_pool(_iPV6_POOL);
        setIpv6_address(_iPV6_ADDRESS);
        setEncapsulation(_eNCAPSULATION);
        setIpbinding_flag(_iPBINDING_FLAG);
        setOspf_processid(_oSPF_PROCESSID);
        setArea(_aREA);
        setBandwidth(_bANDWIDTH);
        setRsvp_bandwidth(_rSVP_BANDWIDTH);

        initMandatory();
    }

    /**
     * Operations of the cast Constructors. Separated so the extended classes don't need to copy the Cast constructor code when
     * extending (cast constructor is private). For that this method is protected but you DON'T have to call it.
     */
    protected void castBeanOperations(Connection con, Bean bean, boolean history)
        throws SQLException {
        fillLocalFields(bean);
        this.setFetchedFromDB(bean.isFetchedFromDB());

        initMandatory();

        // Loaders
        dbInitCustomCode(con);
    }

    //Check if this bean support extend attribute operation
    public static boolean supportExtendAttibute() {
        return false;
    }

    // ************************* Override candidates *********************************** //

    /**
     * Override this method to add custom code when the bean is fetched from DB.
     * Don't forget the super invocation.
     *
     * @param con DB connection
     * @throws SQLException on error
     */
    protected void dbInitCustomCode(Connection con) throws SQLException {
        super.dbInitCustomCode(con);
    }

    public String getExtendedAttribute(String sAttribute) {
        return "";
    }

    // ******************************** findBys ************************************* //

    /**
     * Findby for the key PARENT_TRUNKDATA with full options
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_MAX_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByParent_trunkdata(Connection con,
        String _pARENT_TRUNKDATA, Map parameters) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.PARENT_TRUNKDATA",
            new QDString(_pARENT_TRUNKDATA));

        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_trunkdataArray(con,
            findBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                "PARENT_TRUNKDATA", fieldsMap, parameters), history);
    }

    /**
     * Findby for the key PARENT_TRUNKDATA without pagination.
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByParent_trunkdata(Connection con,
        String _pARENT_TRUNKDATA, String addlnWhereClause,
        String addlnFromClause, boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByParent_trunkdata(con, _pARENT_TRUNKDATA, parameters);
    }

    /**
     * Count by the key PARENT_TRUNKDATA with full options
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByParent_trunkdataCount(Connection con,
        String _pARENT_TRUNKDATA, Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.PARENT_TRUNKDATA",
            new QDString(_pARENT_TRUNKDATA));

        return countBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            "PARENT_TRUNKDATA", fieldsMap, parameters);
    }

    /**
     * Count for the key PARENT_TRUNKDATA with full options
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByParent_trunkdataCount(Connection con,
        String _pARENT_TRUNKDATA, String addlnWhereClause,
        String addlnFromClause, boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByParent_trunkdataCount(con, _pARENT_TRUNKDATA, parameters);
    }

    /**
     * Findby for the key PARENT_TRUNKDATA with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByParent_trunkdata(Connection con,
        String _pARENT_TRUNKDATA, String addlnWhereClause,
        String addlnFromClause) throws SQLException {
        return findByParent_trunkdata(con, _pARENT_TRUNKDATA, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Count for the key PARENT_TRUNKDATA with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByParent_trunkdataCount(Connection con,
        String _pARENT_TRUNKDATA, String addlnWhereClause,
        String addlnFromClause) throws SQLException {
        return findByParent_trunkdataCount(con, _pARENT_TRUNKDATA,
            addlnWhereClause, addlnFromClause, false);
    }

    /**
     * Findby for the key PARENT_TRUNKDATA with extra where clause
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param addlnWhereClause user added where clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByParent_trunkdata(Connection con,
        String _pARENT_TRUNKDATA, String addlnWhereClause)
        throws SQLException {
        return findByParent_trunkdata(con, _pARENT_TRUNKDATA, addlnWhereClause,
            null, false);
    }

    /**
     * Count for the key PARENT_TRUNKDATA with extra where clause
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param addlnWhereClause user added where clause
     * @return int with result count.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByParent_trunkdataCount(Connection con,
        String _pARENT_TRUNKDATA, String addlnWhereClause)
        throws SQLException {
        return findByParent_trunkdataCount(con, _pARENT_TRUNKDATA,
            addlnWhereClause, null, false);
    }

    /**
     * Findby for the key PARENT_TRUNKDATA.
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByParent_trunkdata(Connection con,
        String _pARENT_TRUNKDATA) throws SQLException {
        return findByParent_trunkdata(con, _pARENT_TRUNKDATA, null, null, false);
    }

    /**
     * Count for the key PARENT_TRUNKDATA.
     * @param con Connection to the DB
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @return int with the array count
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByParent_trunkdataCount(Connection con,
        String _pARENT_TRUNKDATA) throws SQLException {
        return findByParent_trunkdataCount(con, _pARENT_TRUNKDATA, null, null,
            false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
           * @param String _pARENT_TRUNKDATA  value to do the search for the field PARENT_TRUNKDATA

     * @param indexOfExpressionBean
     *          bean representing the expression to compare to recover the index
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return index of the given query.
     */
    public static int findByParent_trunkdataRownumValue(Connection con,
        String _pARENT_TRUNKDATA, IndexOfExpressionBean indexOfExpressionBean,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.PARENT_TRUNKDATA",
            new QDString(_pARENT_TRUNKDATA));

        return findIndex(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            "PARENT_TRUNKDATA", fieldsMap, indexOfExpressionBean, parameters);
    }

    /**
     * Findby for the key TRAFFIC_POLICYNAME with full options
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_MAX_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTraffic_policyname(Connection con,
        String _tRAFFIC_POLICYNAME, Map parameters) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRAFFIC_POLICYNAME",
            new QDString(_tRAFFIC_POLICYNAME));

        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_trunkdataArray(con,
            findBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                "TRAFFIC_POLICYNAME", fieldsMap, parameters), history);
    }

    /**
     * Findby for the key TRAFFIC_POLICYNAME without pagination.
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTraffic_policyname(Connection con,
        String _tRAFFIC_POLICYNAME, String addlnWhereClause,
        String addlnFromClause, boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByTraffic_policyname(con, _tRAFFIC_POLICYNAME, parameters);
    }

    /**
     * Count by the key TRAFFIC_POLICYNAME with full options
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTraffic_policynameCount(Connection con,
        String _tRAFFIC_POLICYNAME, Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRAFFIC_POLICYNAME",
            new QDString(_tRAFFIC_POLICYNAME));

        return countBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            "TRAFFIC_POLICYNAME", fieldsMap, parameters);
    }

    /**
     * Count for the key TRAFFIC_POLICYNAME with full options
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTraffic_policynameCount(Connection con,
        String _tRAFFIC_POLICYNAME, String addlnWhereClause,
        String addlnFromClause, boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByTraffic_policynameCount(con, _tRAFFIC_POLICYNAME,
            parameters);
    }

    /**
     * Findby for the key TRAFFIC_POLICYNAME with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTraffic_policyname(Connection con,
        String _tRAFFIC_POLICYNAME, String addlnWhereClause,
        String addlnFromClause) throws SQLException {
        return findByTraffic_policyname(con, _tRAFFIC_POLICYNAME,
            addlnWhereClause, addlnFromClause, false);
    }

    /**
     * Count for the key TRAFFIC_POLICYNAME with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTraffic_policynameCount(Connection con,
        String _tRAFFIC_POLICYNAME, String addlnWhereClause,
        String addlnFromClause) throws SQLException {
        return findByTraffic_policynameCount(con, _tRAFFIC_POLICYNAME,
            addlnWhereClause, addlnFromClause, false);
    }

    /**
     * Findby for the key TRAFFIC_POLICYNAME with extra where clause
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param addlnWhereClause user added where clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTraffic_policyname(Connection con,
        String _tRAFFIC_POLICYNAME, String addlnWhereClause)
        throws SQLException {
        return findByTraffic_policyname(con, _tRAFFIC_POLICYNAME,
            addlnWhereClause, null, false);
    }

    /**
     * Count for the key TRAFFIC_POLICYNAME with extra where clause
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param addlnWhereClause user added where clause
     * @return int with result count.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTraffic_policynameCount(Connection con,
        String _tRAFFIC_POLICYNAME, String addlnWhereClause)
        throws SQLException {
        return findByTraffic_policynameCount(con, _tRAFFIC_POLICYNAME,
            addlnWhereClause, null, false);
    }

    /**
     * Findby for the key TRAFFIC_POLICYNAME.
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTraffic_policyname(Connection con,
        String _tRAFFIC_POLICYNAME) throws SQLException {
        return findByTraffic_policyname(con, _tRAFFIC_POLICYNAME, null, null,
            false);
    }

    /**
     * Count for the key TRAFFIC_POLICYNAME.
     * @param con Connection to the DB
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @return int with the array count
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTraffic_policynameCount(Connection con,
        String _tRAFFIC_POLICYNAME) throws SQLException {
        return findByTraffic_policynameCount(con, _tRAFFIC_POLICYNAME, null,
            null, false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
           * @param String _tRAFFIC_POLICYNAME  value to do the search for the field TRAFFIC_POLICYNAME

     * @param indexOfExpressionBean
     *          bean representing the expression to compare to recover the index
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return index of the given query.
     */
    public static int findByTraffic_policynameRownumValue(Connection con,
        String _tRAFFIC_POLICYNAME,
        IndexOfExpressionBean indexOfExpressionBean, Map parameters)
        throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRAFFIC_POLICYNAME",
            new QDString(_tRAFFIC_POLICYNAME));

        return findIndex(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            "TRAFFIC_POLICYNAME", fieldsMap, indexOfExpressionBean, parameters);
    }

    /**
     * Findby for the key TRUNK_ID with full options
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_MAX_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTrunk_id(Connection con,
        String _tRUNK_ID, Map parameters) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRUNK_ID", new QDString(_tRUNK_ID));

        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_trunkdataArray(con,
            findBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                "TRUNK_ID", fieldsMap, parameters), history);
    }

    /**
     * Findby for the key TRUNK_ID without pagination.
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTrunk_id(Connection con,
        String _tRUNK_ID, String addlnWhereClause, String addlnFromClause,
        boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByTrunk_id(con, _tRUNK_ID, parameters);
    }

    /**
     * Count by the key TRUNK_ID with full options
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunk_idCount(Connection con, String _tRUNK_ID,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRUNK_ID", new QDString(_tRUNK_ID));

        return countBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            "TRUNK_ID", fieldsMap, parameters);
    }

    /**
     * Count for the key TRUNK_ID with full options
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunk_idCount(Connection con, String _tRUNK_ID,
        String addlnWhereClause, String addlnFromClause, boolean bHistory)
        throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByTrunk_idCount(con, _tRUNK_ID, parameters);
    }

    /**
     * Findby for the key TRUNK_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTrunk_id(Connection con,
        String _tRUNK_ID, String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByTrunk_id(con, _tRUNK_ID, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Count for the key TRUNK_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunk_idCount(Connection con, String _tRUNK_ID,
        String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByTrunk_idCount(con, _tRUNK_ID, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Findby for the key TRUNK_ID with extra where clause
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param addlnWhereClause user added where clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTrunk_id(Connection con,
        String _tRUNK_ID, String addlnWhereClause) throws SQLException {
        return findByTrunk_id(con, _tRUNK_ID, addlnWhereClause, null, false);
    }

    /**
     * Count for the key TRUNK_ID with extra where clause
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param addlnWhereClause user added where clause
     * @return int with result count.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunk_idCount(Connection con, String _tRUNK_ID,
        String addlnWhereClause) throws SQLException {
        return findByTrunk_idCount(con, _tRUNK_ID, addlnWhereClause, null, false);
    }

    /**
     * Findby for the key TRUNK_ID.
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByTrunk_id(Connection con,
        String _tRUNK_ID) throws SQLException {
        return findByTrunk_id(con, _tRUNK_ID, null, null, false);
    }

    /**
     * Count for the key TRUNK_ID.
     * @param con Connection to the DB
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @return int with the array count
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunk_idCount(Connection con, String _tRUNK_ID)
        throws SQLException {
        return findByTrunk_idCount(con, _tRUNK_ID, null, null, false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
           * @param String _tRUNK_ID  value to do the search for the field TRUNK_ID

     * @param indexOfExpressionBean
     *          bean representing the expression to compare to recover the index
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return index of the given query.
     */
    public static int findByTrunk_idRownumValue(Connection con,
        String _tRUNK_ID, IndexOfExpressionBean indexOfExpressionBean,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRUNK_ID", new QDString(_tRUNK_ID));

        return findIndex(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata", "TRUNK_ID",
            fieldsMap, indexOfExpressionBean, parameters);
    }

    /**
     * Findby for the key TRUNKDATA_ID with full options
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_MAX_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata findByTrunkdata_id(Connection con,
        String _tRUNKDATA_ID, Map parameters) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRUNKDATA_ID", new QDString(_tRUNKDATA_ID));

        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        igw_trunkdata[] result = fromBeanArray2igw_trunkdataArray(con,
                findBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                    "TRUNKDATA_ID", fieldsMap, parameters), history);

        if (result == null) {
            return null;
        } else {
            return result[0];
        }
    }

    /**
     * Findby for the key TRUNKDATA_ID without pagination.
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata findByTrunkdata_id(Connection con,
        String _tRUNKDATA_ID, String addlnWhereClause, String addlnFromClause,
        boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByTrunkdata_id(con, _tRUNKDATA_ID, parameters);
    }

    /**
     * Count by the key TRUNKDATA_ID with full options
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunkdata_idCount(Connection con,
        String _tRUNKDATA_ID, Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRUNKDATA_ID", new QDString(_tRUNKDATA_ID));

        return countBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            "TRUNKDATA_ID", fieldsMap, parameters);
    }

    /**
     * Count for the key TRUNKDATA_ID with full options
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunkdata_idCount(Connection con,
        String _tRUNKDATA_ID, String addlnWhereClause, String addlnFromClause,
        boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByTrunkdata_idCount(con, _tRUNKDATA_ID, parameters);
    }

    /**
     * Findby for the key TRUNKDATA_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata findByTrunkdata_id(Connection con,
        String _tRUNKDATA_ID, String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByTrunkdata_id(con, _tRUNKDATA_ID, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Count for the key TRUNKDATA_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunkdata_idCount(Connection con,
        String _tRUNKDATA_ID, String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByTrunkdata_idCount(con, _tRUNKDATA_ID, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Findby for the key TRUNKDATA_ID with extra where clause
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param addlnWhereClause user added where clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata findByTrunkdata_id(Connection con,
        String _tRUNKDATA_ID, String addlnWhereClause)
        throws SQLException {
        return findByTrunkdata_id(con, _tRUNKDATA_ID, addlnWhereClause, null,
            false);
    }

    /**
     * Count for the key TRUNKDATA_ID with extra where clause
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param addlnWhereClause user added where clause
     * @return int with result count.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunkdata_idCount(Connection con,
        String _tRUNKDATA_ID, String addlnWhereClause)
        throws SQLException {
        return findByTrunkdata_idCount(con, _tRUNKDATA_ID, addlnWhereClause,
            null, false);
    }

    /**
     * Findby for the key TRUNKDATA_ID.
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata findByTrunkdata_id(Connection con,
        String _tRUNKDATA_ID) throws SQLException {
        return findByTrunkdata_id(con, _tRUNKDATA_ID, null, null, false);
    }

    /**
     * Count for the key TRUNKDATA_ID.
     * @param con Connection to the DB
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @return int with the array count
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByTrunkdata_idCount(Connection con,
        String _tRUNKDATA_ID) throws SQLException {
        return findByTrunkdata_idCount(con, _tRUNKDATA_ID, null, null, false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
           * @param String _tRUNKDATA_ID  value to do the search for the field TRUNKDATA_ID

     * @param indexOfExpressionBean
     *          bean representing the expression to compare to recover the index
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return index of the given query.
     */
    public static int findByTrunkdata_idRownumValue(Connection con,
        String _tRUNKDATA_ID, IndexOfExpressionBean indexOfExpressionBean,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRUNKDATA_ID", new QDString(_tRUNKDATA_ID));

        return findIndex(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata", "TRUNKDATA_ID",
            fieldsMap, indexOfExpressionBean, parameters);
    }

    /**
     * Count for the primary key
     * @param con Connection to the DB
     * @param primaryKey String with the primary key fields separated with ||
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByPrimaryKeyCount(Connection con, String primaryKey,
        boolean history) throws SQLException {
        if (primaryKey == null) {
            return 0;
        }

        String[] keyFields = primaryKey.split(PRIMARY_KEY_SEPARATOR_REG_EXP);
        int result = -1;

        try {
            result = findByTrunkdata_idCount(con,
                    from_String2String(keyFields[0]), null, null, history);
        } catch (ArrayIndexOutOfBoundsException e) {
            throw new RuntimeException(
                "Wrong primary key, it expects 1 values separated by ||");
        }

        return result;
    }

    /**
     * Count for the primary key
     * @param con Connection to the DB
     * @param primaryKey String with the primary key fields separated with ||
     * @param history true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByPrimaryKeyCount(Connection con, String primaryKey)
        throws SQLException {
        return findByPrimaryKeyCount(con, primaryKey, false);
    }

    /**
     * Findby for the primary key
     * @param con Connection to the DB
     * @param primaryKey String with the primary key fields separated with ||
     * @param history true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata findByPrimaryKey(Connection con,
        String primaryKey, boolean history) throws SQLException {
        if (primaryKey == null) {
            return null;
        }

        String[] keyFields = primaryKey.split(PRIMARY_KEY_SEPARATOR_REG_EXP);
        igw_trunkdata result = null;

        try {
            result = findByTrunkdata_id(con, from_String2String(keyFields[0]),
                    null, null, history);
        } catch (ArrayIndexOutOfBoundsException e) {
            throw new RuntimeException(
                "Wrong primary key, it expects 1 values separated by ||");
        }

        return result;
    }

    /**
     * Findby for the primary key in the actual tables (not history)
     * @param con Connection to the DB
     * @param primaryKey String with the primary key fields separated with ||
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata findByPrimaryKey(Connection con,
        String primaryKey) throws SQLException {
        return findByPrimaryKey(con, primaryKey, false);
    }

    /**
     * Search for the parent flag of the bean trough the primary key. This method will do "FOR UPDATE NOWAIT" select.
     * a database search with the actual bean primary key.
     * @param con Connection to the DB
     * @param primaryKey String with the primary key fields separated with ||
     * @return true if the bean is parent
     * @throws SQLException on an error accessing to the DB
     */
    private boolean findIsParent(Connection con) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.TRUNKDATA_ID",
            new QDString(getTrunkdata_id()));

        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        return findIsParent(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata", "TRUNKDATA_ID",
            fieldsMap, parameters);
    }

    /**
     * Findby for the key ROUTER_ID with full options
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_MAX_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByRouter_id(Connection con,
        String _rOUTER_ID, Map parameters) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.ROUTER_ID", new QDString(_rOUTER_ID));

        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_trunkdataArray(con,
            findBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                "ROUTER_ID", fieldsMap, parameters), history);
    }

    /**
     * Findby for the key ROUTER_ID without pagination.
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByRouter_id(Connection con,
        String _rOUTER_ID, String addlnWhereClause, String addlnFromClause,
        boolean bHistory) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByRouter_id(con, _rOUTER_ID, parameters);
    }

    /**
     * Count by the key ROUTER_ID with full options
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByRouter_idCount(Connection con, String _rOUTER_ID,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.ROUTER_ID", new QDString(_rOUTER_ID));

        return countBy(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            "ROUTER_ID", fieldsMap, parameters);
    }

    /**
     * Count for the key ROUTER_ID with full options
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByRouter_idCount(Connection con, String _rOUTER_ID,
        String addlnWhereClause, String addlnFromClause, boolean bHistory)
        throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByRouter_idCount(con, _rOUTER_ID, parameters);
    }

    /**
     * Findby for the key ROUTER_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByRouter_id(Connection con,
        String _rOUTER_ID, String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByRouter_id(con, _rOUTER_ID, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Count for the key ROUTER_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByRouter_idCount(Connection con, String _rOUTER_ID,
        String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByRouter_idCount(con, _rOUTER_ID, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Findby for the key ROUTER_ID with extra where clause
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param addlnWhereClause user added where clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByRouter_id(Connection con,
        String _rOUTER_ID, String addlnWhereClause) throws SQLException {
        return findByRouter_id(con, _rOUTER_ID, addlnWhereClause, null, false);
    }

    /**
     * Count for the key ROUTER_ID with extra where clause
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param addlnWhereClause user added where clause
     * @return int with result count.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByRouter_idCount(Connection con, String _rOUTER_ID,
        String addlnWhereClause) throws SQLException {
        return findByRouter_idCount(con, _rOUTER_ID, addlnWhereClause, null,
            false);
    }

    /**
     * Findby for the key ROUTER_ID.
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_trunkdata[] findByRouter_id(Connection con,
        String _rOUTER_ID) throws SQLException {
        return findByRouter_id(con, _rOUTER_ID, null, null, false);
    }

    /**
     * Count for the key ROUTER_ID.
     * @param con Connection to the DB
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @return int with the array count
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByRouter_idCount(Connection con, String _rOUTER_ID)
        throws SQLException {
        return findByRouter_idCount(con, _rOUTER_ID, null, null, false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
           * @param String _rOUTER_ID  value to do the search for the field ROUTER_ID

     * @param indexOfExpressionBean
     *          bean representing the expression to compare to recover the index
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return index of the given query.
     */
    public static int findByRouter_idRownumValue(Connection con,
        String _rOUTER_ID, IndexOfExpressionBean indexOfExpressionBean,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_trunkdata.ROUTER_ID", new QDString(_rOUTER_ID));

        return findIndex(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata", "ROUTER_ID",
            fieldsMap, indexOfExpressionBean, parameters);
    }

    // linked select Type 3

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>LINKED_PW_PARAMETER_POINTED_FIELD</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          </ol>
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperParent_trunkdata(
        igw_trunkdata.SearchBean searchBean, Map operation_parameters) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_trunkdata");
        result.setKeyName("Parent_trunkdata");

        // Mixing the searchBean parameter with the @order parameters
        Map search_parameters = searchBean.getInternSearchBeanData();

        // Adding @order parameters
        result.setParameters(search_parameters);

        try {
            result.setOperation_parameters(operation_parameters);
        } catch (ParameterException e) {
            throw new RuntimeException(
                "Error in the linkedSearchParameterWrapperParent_trunkdata sql query parameters: " +
                e.getMessage());
        }

        return result;
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperParent_trunkdata(
        igw_trunkdata.SearchBean searchBean, boolean advancedSearch) {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));

        return linkedSearchParameterWrapperParent_trunkdata(searchBean,
            parameters);
    }

    /**
     * count version of linkedSearch{foreign_key_field}
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int linkedSearchParent_trunkdataCount(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperParent_trunkdata(searchBean,
                false);

        return countLinkedSearch(con, parameterWrapper.getBeanName(),
            parameterWrapper.getKeyName(), linkedSearchParameters,
            parameterWrapper.getParameters(), parameters);
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

    * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param maxResults maximum number of results to return, 0 to unlimited.
     */
    public static igw_trunkdata[] linkedSearchParent_trunkdata(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        boolean advancedSearch, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));
        parameters.put(PARAMETER_STARTING_INDEX, new Integer(1));
        parameters.put(PARAMETER_NUMBER_OF_RESULTS, new Integer(maxResults));

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperParent_trunkdata(searchBean,
                advancedSearch);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

     * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     */
    public static igw_trunkdata[] linkedSearchParent_trunkdata(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        Map parameters)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        boolean advanced = false;
        Boolean sAdvanced = (Boolean) parameters.get(PARAMETER_ADVANCED);

        if (sAdvanced != null) {
            advanced = sAdvanced.booleanValue();
        }

        if (!parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperParent_trunkdata(searchBean,
                advanced);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    // linked select Type 3

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>LINKED_PW_PARAMETER_POINTED_FIELD</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          </ol>
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperTraffic_policyname(
        igw_trunkdata.SearchBean searchBean, Map operation_parameters) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_trunkdata");
        result.setKeyName("Traffic_policyname");

        // Mixing the searchBean parameter with the @order parameters
        Map search_parameters = searchBean.getInternSearchBeanData();

        // Adding @order parameters
        result.setParameters(search_parameters);

        try {
            result.setOperation_parameters(operation_parameters);
        } catch (ParameterException e) {
            throw new RuntimeException(
                "Error in the linkedSearchParameterWrapperTraffic_policyname sql query parameters: " +
                e.getMessage());
        }

        return result;
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperTraffic_policyname(
        igw_trunkdata.SearchBean searchBean, boolean advancedSearch) {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));

        return linkedSearchParameterWrapperTraffic_policyname(searchBean,
            parameters);
    }

    /**
     * count version of linkedSearch{foreign_key_field}
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int linkedSearchTraffic_policynameCount(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTraffic_policyname(searchBean,
                false);

        return countLinkedSearch(con, parameterWrapper.getBeanName(),
            parameterWrapper.getKeyName(), linkedSearchParameters,
            parameterWrapper.getParameters(), parameters);
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

    * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param maxResults maximum number of results to return, 0 to unlimited.
     */
    public static igw_trunkdata[] linkedSearchTraffic_policyname(
        Connection con, List linkedSearchParameters,
        igw_trunkdata.SearchBean searchBean, boolean advancedSearch,
        int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));
        parameters.put(PARAMETER_STARTING_INDEX, new Integer(1));
        parameters.put(PARAMETER_NUMBER_OF_RESULTS, new Integer(maxResults));

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTraffic_policyname(searchBean,
                advancedSearch);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

     * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     */
    public static igw_trunkdata[] linkedSearchTraffic_policyname(
        Connection con, List linkedSearchParameters,
        igw_trunkdata.SearchBean searchBean, Map parameters)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        boolean advanced = false;
        Boolean sAdvanced = (Boolean) parameters.get(PARAMETER_ADVANCED);

        if (sAdvanced != null) {
            advanced = sAdvanced.booleanValue();
        }

        if (!parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTraffic_policyname(searchBean,
                advanced);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    // linked select Type 3

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>LINKED_PW_PARAMETER_POINTED_FIELD</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          </ol>
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperTrunk_id(
        igw_trunkdata.SearchBean searchBean, Map operation_parameters) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_trunkdata");
        result.setKeyName("Trunk_id");

        // Mixing the searchBean parameter with the @order parameters
        Map search_parameters = searchBean.getInternSearchBeanData();

        // Adding @order parameters
        result.setParameters(search_parameters);

        try {
            result.setOperation_parameters(operation_parameters);
        } catch (ParameterException e) {
            throw new RuntimeException(
                "Error in the linkedSearchParameterWrapperTrunk_id sql query parameters: " +
                e.getMessage());
        }

        return result;
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperTrunk_id(
        igw_trunkdata.SearchBean searchBean, boolean advancedSearch) {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));

        return linkedSearchParameterWrapperTrunk_id(searchBean, parameters);
    }

    /**
     * count version of linkedSearch{foreign_key_field}
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int linkedSearchTrunk_idCount(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTrunk_id(searchBean,
                false);

        return countLinkedSearch(con, parameterWrapper.getBeanName(),
            parameterWrapper.getKeyName(), linkedSearchParameters,
            parameterWrapper.getParameters(), parameters);
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

    * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param maxResults maximum number of results to return, 0 to unlimited.
     */
    public static igw_trunkdata[] linkedSearchTrunk_id(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        boolean advancedSearch, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));
        parameters.put(PARAMETER_STARTING_INDEX, new Integer(1));
        parameters.put(PARAMETER_NUMBER_OF_RESULTS, new Integer(maxResults));

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTrunk_id(searchBean,
                advancedSearch);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

     * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     */
    public static igw_trunkdata[] linkedSearchTrunk_id(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        Map parameters)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        boolean advanced = false;
        Boolean sAdvanced = (Boolean) parameters.get(PARAMETER_ADVANCED);

        if (sAdvanced != null) {
            advanced = sAdvanced.booleanValue();
        }

        if (!parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTrunk_id(searchBean,
                advanced);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    // linked select Type 1

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>LINKED_PW_PARAMETER_POINTED_FIELD</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          </ol>
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperTrunkdata_id(
        igw_trunkdata.SearchBean searchBean, Map operation_parameters) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_trunkdata");
        result.setKeyName("Trunkdata_id");

        // Mixing the searchBean parameter with the @order parameters
        Map search_parameters = searchBean.getInternSearchBeanData();

        // Adding @order parameters
        result.setParameters(search_parameters);

        try {
            result.setOperation_parameters(operation_parameters);
        } catch (ParameterException e) {
            throw new RuntimeException(
                "Error in the linkedSearchParameterWrapperTrunkdata_id sql query parameters: " +
                e.getMessage());
        }

        return result;
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperTrunkdata_id(
        igw_trunkdata.SearchBean searchBean, boolean advancedSearch) {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));

        return linkedSearchParameterWrapperTrunkdata_id(searchBean, parameters);
    }

    /**
     * count version of linkedSearch{foreign_key_field}
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int linkedSearchTrunkdata_idCount(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTrunkdata_id(searchBean,
                false);

        return countLinkedSearch(con, parameterWrapper.getBeanName(),
            parameterWrapper.getKeyName(), linkedSearchParameters,
            parameterWrapper.getParameters(), parameters);
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

    * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param maxResults maximum number of results to return, 0 to unlimited.
     */
    public static igw_trunkdata[] linkedSearchTrunkdata_id(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        boolean advancedSearch, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));
        parameters.put(PARAMETER_STARTING_INDEX, new Integer(1));
        parameters.put(PARAMETER_NUMBER_OF_RESULTS, new Integer(maxResults));

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTrunkdata_id(searchBean,
                advancedSearch);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

     * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     */
    public static igw_trunkdata[] linkedSearchTrunkdata_id(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        Map parameters)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        boolean advanced = false;
        Boolean sAdvanced = (Boolean) parameters.get(PARAMETER_ADVANCED);

        if (sAdvanced != null) {
            advanced = sAdvanced.booleanValue();
        }

        if (!parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperTrunkdata_id(searchBean,
                advanced);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    /**
     * Creates an object that wraps the parameter of the primary key LinkedSearch version to an object.
     *  So this way can be passed to a search method at one time.
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperPrimaryKey(
        igw_trunkdata.SearchBean searchBean, boolean advancedSearch) {
        return linkedSearchParameterWrapperTrunkdata_id(searchBean,
            advancedSearch);
    }

    /**
     * count version of linkedSearchPrimaryKey
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int linkedSearchPrimaryKeyCount(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        return linkedSearchTrunkdata_idCount(con, linkedSearchParameters,
            searchBean);
    }

    /**
     * Creates an object that wraps the parameter of a primary key LinkedSearch version to an object.
     * So this way can be passed to a search method at one time.
     * @param con Connection to the DB
     * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param maxResults maximum number of results to return, 0 to unlimited.
     */
    public static igw_trunkdata[] linkedSearchPrimaryKey(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        boolean advancedSearch, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return linkedSearchTrunkdata_id(con, linkedSearchParameters,
            searchBean, advancedSearch, maxResults);
    }

    /**
     * Creates an object that wraps the parameter of a primary key LinkedSearch version to an object.
     * So this way can be passed to a search method at one time.
     * @param con Connection to the DB
     * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
      *          </ol>
     */
    public static igw_trunkdata[] linkedSearchPrimaryKey(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        Map parameters)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return linkedSearchTrunkdata_id(con, linkedSearchParameters,
            searchBean, parameters);
    }

    // linked select Type 3

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>LINKED_PW_PARAMETER_POINTED_FIELD</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          </ol>
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperRouter_id(
        igw_trunkdata.SearchBean searchBean, Map operation_parameters) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_trunkdata");
        result.setKeyName("Router_id");

        // Mixing the searchBean parameter with the @order parameters
        Map search_parameters = searchBean.getInternSearchBeanData();

        // Adding @order parameters
        result.setParameters(search_parameters);

        try {
            result.setOperation_parameters(operation_parameters);
        } catch (ParameterException e) {
            throw new RuntimeException(
                "Error in the linkedSearchParameterWrapperRouter_id sql query parameters: " +
                e.getMessage());
        }

        return result;
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.

     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @return object wrapping the search
     */
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperRouter_id(
        igw_trunkdata.SearchBean searchBean, boolean advancedSearch) {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));

        return linkedSearchParameterWrapperRouter_id(searchBean, parameters);
    }

    /**
     * count version of linkedSearch{foreign_key_field}
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int linkedSearchRouter_idCount(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperRouter_id(searchBean,
                false);

        return countLinkedSearch(con, parameterWrapper.getBeanName(),
            parameterWrapper.getKeyName(), linkedSearchParameters,
            parameterWrapper.getParameters(), parameters);
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

    * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advancedSearch true for the advanced search select.
     * @param maxResults maximum number of results to return, 0 to unlimited.
     */
    public static igw_trunkdata[] linkedSearchRouter_id(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        boolean advancedSearch, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));
        parameters.put(PARAMETER_STARTING_INDEX, new Integer(1));
        parameters.put(PARAMETER_NUMBER_OF_RESULTS, new Integer(maxResults));

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperRouter_id(searchBean,
                advancedSearch);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    /**
     * Creates an object that wraps the parameter of a LinkedSearch to an object. So this way can be passed to a search
     * method at one time.
     * @param con Connection to the DB

     * @param linkedSearchParameters List of LinkedSearchParameterWrapper. This objects contains the information to execute all the
     * linked selects (as SELECT IN). A fast way to creating this object is use the methods linkedSearchParameterWrapperXXXXX. The order
     * of the objects determines the resultant select. first ones are encapsulated by last ones. For example, imagine you pass a List of
     * two elements, the result select will be: SELECT[this search] IN (SELECT[List position 0] IN (SELECT[List position 1])).
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     */
    public static igw_trunkdata[] linkedSearchRouter_id(Connection con,
        List linkedSearchParameters, igw_trunkdata.SearchBean searchBean,
        Map parameters)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        boolean advanced = false;
        Boolean sAdvanced = (Boolean) parameters.get(PARAMETER_ADVANCED);

        if (sAdvanced != null) {
            advanced = sAdvanced.booleanValue();
        }

        if (!parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperRouter_id(searchBean,
                advanced);

        return fromBeanArray2igw_trunkdataArray(con,
            linkedSearch(con, parameterWrapper.getBeanName(),
                parameterWrapper.getKeyName(), linkedSearchParameters,
                parameterWrapper.getParameters(), parameters));
    }

    /**
     * Finds all the entries in the table.
     * @param con
     *          Connection
     * @param bean
     *          Name of the bean associated to the findAll
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_MAX_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_FOR_UPDATE_NOWAIT</li>
     *          <li>PARAMETER_TABLE_ALIAS</li>
     *          </ol>
     * @return array with the results.
     * @throws SQLException
     *           If there is a problem in the execution of the SQL
     */
    public static igw_trunkdata[] findAll(Connection con, Map parameters)
        throws SQLException {
        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_trunkdataArray(con,
            findAll(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                parameters), history);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @param addlnFromClause Extra from clause
     * @param history true if want to make the search in the history tables.
     * @return array with the results.
     */
    public static igw_trunkdata[] findAll(Connection con,
        String addlnWhereClause, String addlnFromClause, boolean history)
        throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(history));

        return findAll(con, parameters);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @param addlnFromClause Extra from clause
     * @return array with the results.
     */
    public static igw_trunkdata[] findAll(Connection con,
        String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findAll(con, addlnWhereClause, addlnFromClause, false);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @return array with the results.
     */
    public static igw_trunkdata[] findAll(Connection con,
        String addlnWhereClause) throws SQLException {
        return findAll(con, addlnWhereClause, null, false);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @return array with the results.
     */
    public static igw_trunkdata[] findAll(Connection con)
        throws SQLException {
        return findAll(con, null, null, false);
    }

    /**
     * Finds the number of all the entries in the table.
     * @param con
     *          Connection
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return number of results.
     * @throws SQLException
     *           If there is a problem in the execution of the sql
     */
    public static int findAllCount(Connection con, Map parameters)
        throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return countAll(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            parameters);
    }

    /**
     * Finds the number of all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @param addlnFromClause Extra from clause
     * @param history true if want to make the search in the history tables.
     * @return number of results.
     */
    public static int findAllCount(Connection con, String addlnWhereClause,
        String addlnFromClause, boolean history) throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(history));

        return findAllCount(con, parameters);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @param addlnFromClause Extra from clause
     * @return number of results.
     */
    public static int findAllCount(Connection con, String addlnWhereClause,
        String addlnFromClause) throws SQLException {
        return findAllCount(con, addlnWhereClause, addlnFromClause, false);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @return number of results.
     */
    public static int findAllCount(Connection con, String addlnWhereClause)
        throws SQLException {
        return findAllCount(con, addlnWhereClause, null, false);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @return number of results.
     */
    public static int findAllCount(Connection con) throws SQLException {
        return findAllCount(con, null, null, false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
     * @param indexOfExpressionBean
     *          bean representing the expression to compare to recover the index
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_HISTORY</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return index of the given query.
     */
    public static int findAllRownumValue(Connection con,
        IndexOfExpressionBean indexOfExpressionBean, Map parameters)
        throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return findIndex(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            indexOfExpressionBean, parameters);
    }

    /**
     * count version of a search
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int searchCount(Connection con,
        igw_trunkdata.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        return countSearch(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            searchBean.getInternSearchBeanData(), parameters);
    }

    /**
     * search with advanced = false
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return array with the parameters found.
     *
     */
    public static igw_trunkdata[] search(Connection con,
        igw_trunkdata.SearchBean searchBean)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return search(con, searchBean, false);
    }

    /**
     * search
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advanced for advanced search (picking the pointed values for a listofvalues)
     * @return array with the parameters found.
     *
     */
    public static igw_trunkdata[] search(Connection con,
        igw_trunkdata.SearchBean searchBean, boolean advanced)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return fromBeanArray2igw_trunkdataArray(con,
            limitedSearch(con,
                "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                searchBean.getInternSearchBeanData(), advanced, class_loader));
    }

    /**
     * limited search with advanced configurable
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advanced for advanced search (picking the pointed values for a listofvalues)
     * @param maxResults maximum number of results to return, 0 to unlimited.
     * @return array with the parameters found.
     *
     */
    public static igw_trunkdata[] search(Connection con,
        igw_trunkdata.SearchBean searchBean, boolean advanced, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return fromBeanArray2igw_trunkdataArray(con,
            limitedSearch(con,
                "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                searchBean.getInternSearchBeanData(), advanced, maxResults,
                class_loader));
    }

    /**
     * search with full options configurable
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param parameters
     *          Map of parameters. Accepting:<br/>
     *          <ol>
     *          <li>PARAMETER_EXTRA_FROM_CLAUSE</li>
     *          <li>PARAMETER_EXTRA_WHERE_CLAUSE</li>
     *          <li>PARAMETER_ADVANCED</li>
     *          <li>PARAMETER_STARTING_INDEX</li>
     *          <li>PARAMETER_NUMBER_OF_RESULTS</li>
     *          <li>PARAMETER_ORDER_BY_FIELDS</li>
     *          <li>PARAMETER_JSQL_CLASSLOADER</li>
     *          </ol>
     * @return array with the parameters found.
     *
     */
    public static igw_trunkdata[] search(Connection con,
        igw_trunkdata.SearchBean searchBean, Map parameters)
        throws SQLException, LobUsedForSearchException {
        if (!parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_trunkdataArray(con,
            search(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                searchBean.getInternSearchBeanData(), parameters));
    }

    /**
     * Creates an object that wraps the parameter of a search to an object. So this way can be passed to a linked select
     * method at one time.
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @param advanced for advanced search (picking the pointed values for a listofvalues)
     * @return object wrapping the search
     *
     */
    public static LinkedSearchParameterWrapper searchParameterWrapper(
        igw_trunkdata.SearchBean searchBean, boolean advanced) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_trunkdata");
        result.setParameters(searchBean.getInternSearchBeanData());
        result.setAdvanced(advanced);

        return result;
    }

    // ******************************** ListOfValues ************************************* //
    // ****************** [GenericDataExtractable] implementation ************* //

    /* (non-Javadoc)
     * @see com.hp.ov.activator.inventorybuilder.interfaces.GenericDataExtractable#get_Values()
     */
    public String[] get_Values() {
        String[] result = new String[32];
        Object temp_data = null;
        temp_data = convert2Object(getTrunkdata_id());
        result[0] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getParent_trunkdata());
        result[1] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getTrunk_id());
        result[2] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getSide_service_id());
        result[3] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getSide_name());
        result[4] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getSide_sort_name());
        result[5] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getRouter_id());
        result[6] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getInterfaces_id());
        result[7] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getIpnet_pool());
        result[8] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getIpnet_address());
        result[9] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getIpnet_submask());
        result[10] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getSide_description());
        result[11] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getNego_flag());
        result[12] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getLinkprotocol());
        result[13] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getMtu());
        result[14] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getPim_flag());
        result[15] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getOspfnet_type_flag());
        result[16] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getOspf_cost());
        result[17] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getOspf_password());
        result[18] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getLdp_flag());
        result[19] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getLdp_password());
        result[20] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getInterface_description());
        result[21] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getTraffic_policyname());
        result[22] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getPolicy_type());
        result[23] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getIpv6_pool());
        result[24] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getIpv6_address());
        result[25] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getEncapsulation());
        result[26] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getIpbinding_flag());
        result[27] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getOspf_processid());
        result[28] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getArea());
        result[29] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getBandwidth());
        result[30] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getRsvp_bandwidth());
        result[31] = (temp_data == null) ? null : temp_data.toString();

        return result;
    }

    /**
     * Returns info about the fields that are contained by the beans.
     */
    public Field[] get_Fields() {
        // Done this way because is generated by velocity
        Object temp_data = null;
        temp_data = convert2Object(getTrunkdata_id());
        fields[0].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getParent_trunkdata());
        fields[1].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getTrunk_id());
        fields[2].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getSide_service_id());
        fields[3].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getSide_name());
        fields[4].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getSide_sort_name());
        fields[5].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getRouter_id());
        fields[6].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getInterfaces_id());
        fields[7].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getIpnet_pool());
        fields[8].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getIpnet_address());
        fields[9].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getIpnet_submask());
        fields[10].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getSide_description());
        fields[11].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getNego_flag());
        fields[12].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getLinkprotocol());
        fields[13].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getMtu());
        fields[14].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getPim_flag());
        fields[15].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getOspfnet_type_flag());
        fields[16].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getOspf_cost());
        fields[17].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getOspf_password());
        fields[18].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getLdp_flag());
        fields[19].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getLdp_password());
        fields[20].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getInterface_description());
        fields[21].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getTraffic_policyname());
        fields[22].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getPolicy_type());
        fields[23].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getIpv6_pool());
        fields[24].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getIpv6_address());
        fields[25].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getEncapsulation());
        fields[26].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getIpbinding_flag());
        fields[27].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getOspf_processid());
        fields[28].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getArea());
        fields[29].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getBandwidth());
        fields[30].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getRsvp_bandwidth());
        fields[31].setValue((temp_data == null) ? null : temp_data.toString());

        return fields;
    }

    // ******************************** Getters *********************************** //

    /**
     * Return the fields' descriptions
     * @return fields' descriptions
     */
    public static Field[] getFieldDescriptions() {
        return fields;
    }

    /**
     * Return SQL column name of a field
     * @param field_name name of the field
     * @return Sql column name
     */
    public static String getSQLColumn(String field_name) {
        return (String) field_label_column_equivalency.get(field_name);
    }

    /**
     * Returns the searchable field names.
     * @return array with the names of the searchable fields.
     */
    public static String[] getFieldNames() {
        return searchableFieldNames;
    }

    /**
     * Returns the searchable field information. Don't ask me why this kind of info.
     * @return searchable field information.
     */
    public static String[] getFieldInformation(String field) {
        String[] fieldInfo = new String[2];

        if (field.equals("TRUNKDATA_ID")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("PARENT_TRUNKDATA")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("TRUNK_ID")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("SIDE_SERVICE_ID")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("SIDE_NAME")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("SIDE_SORT_NAME")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("ROUTER_ID")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("INTERFACES_ID")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("IPNET_POOL")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("IPNET_ADDRESS")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("IPNET_SUBMASK")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("SIDE_DESCRIPTION")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("NEGO_FLAG")) {
            fieldInfo[0] = "boolean";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("LINKPROTOCOL")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("MTU")) {
            fieldInfo[0] = "int";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("PIM_FLAG")) {
            fieldInfo[0] = "boolean";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("OSPFNET_TYPE_FLAG")) {
            fieldInfo[0] = "boolean";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("OSPF_COST")) {
            fieldInfo[0] = "int";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("OSPF_PASSWORD")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("LDP_FLAG")) {
            fieldInfo[0] = "boolean";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("LDP_PASSWORD")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("INTERFACE_DESCRIPTION")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("TRAFFIC_POLICYNAME")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("POLICY_TYPE")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("IPV6_POOL")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("IPV6_ADDRESS")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("ENCAPSULATION")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("IPBINDING_FLAG")) {
            fieldInfo[0] = "boolean";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("OSPF_PROCESSID")) {
            fieldInfo[0] = "int";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("AREA")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("BANDWIDTH")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("RSVP_BANDWIDTH")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        return null;
    }

    /**
     * Returns the names or aliases if they exist of the fields
     * @return the names or aliases if they exist of the fields
     */
    public static String[] getFieldOrAliasNames() {
        String[] fieldOrAliasNames = new String[searchableFieldNames.length];

        for (int i = 0; i < searchableFieldNames.length; i++)
            fieldOrAliasNames[i] = getAlias(searchableFieldNames[i]);

        return fieldOrAliasNames;
    }

    /**
     * Get the alias of a field name
     * @param fieldName name of the field
     * @return alias related to the field
     */
    public static String getAlias(String fieldName) {
        if (fieldName == null) {
            return null;
        }

        if (fieldName.equalsIgnoreCase("TRUNKDATA_ID")) {
            return "TRUNKDATA_ID";
        }

        if (fieldName.equalsIgnoreCase("PARENT_TRUNKDATA")) {
            return "PARENT_TRUNKDATA";
        }

        if (fieldName.equalsIgnoreCase("TRUNK_ID")) {
            return "TRUNK_ID";
        }

        if (fieldName.equalsIgnoreCase("SIDE_SERVICE_ID")) {
            return "SIDE_SERVICE_ID";
        }

        if (fieldName.equalsIgnoreCase("SIDE_NAME")) {
            return "SIDE_NAME";
        }

        if (fieldName.equalsIgnoreCase("SIDE_SORT_NAME")) {
            return "SIDE_SORT_NAME";
        }

        if (fieldName.equalsIgnoreCase("ROUTER_ID")) {
            return "ROUTER_ID";
        }

        if (fieldName.equalsIgnoreCase("INTERFACES_ID")) {
            return "INTERFACES_ID";
        }

        if (fieldName.equalsIgnoreCase("IPNET_POOL")) {
            return "IPNET_POOL";
        }

        if (fieldName.equalsIgnoreCase("IPNET_ADDRESS")) {
            return "IPNET_ADDRESS";
        }

        if (fieldName.equalsIgnoreCase("IPNET_SUBMASK")) {
            return "IPNET_SUBMASK";
        }

        if (fieldName.equalsIgnoreCase("SIDE_DESCRIPTION")) {
            return "SIDE_DESCRIPTION";
        }

        if (fieldName.equalsIgnoreCase("NEGO_FLAG")) {
            return "NEGO_FLAG";
        }

        if (fieldName.equalsIgnoreCase("LINKPROTOCOL")) {
            return "LINKPROTOCOL";
        }

        if (fieldName.equalsIgnoreCase("MTU")) {
            return "MTU";
        }

        if (fieldName.equalsIgnoreCase("PIM_FLAG")) {
            return "PIM_FLAG";
        }

        if (fieldName.equalsIgnoreCase("OSPFNET_TYPE_FLAG")) {
            return "OSPFNET_TYPE_FLAG";
        }

        if (fieldName.equalsIgnoreCase("OSPF_COST")) {
            return "OSPF_COST";
        }

        if (fieldName.equalsIgnoreCase("OSPF_PASSWORD")) {
            return "OSPF_PASSWORD";
        }

        if (fieldName.equalsIgnoreCase("LDP_FLAG")) {
            return "LDP_FLAG";
        }

        if (fieldName.equalsIgnoreCase("LDP_PASSWORD")) {
            return "LDP_PASSWORD";
        }

        if (fieldName.equalsIgnoreCase("INTERFACE_DESCRIPTION")) {
            return "INTERFACE_DESCRIPTION";
        }

        if (fieldName.equalsIgnoreCase("TRAFFIC_POLICYNAME")) {
            return "TRAFFIC_POLICYNAME";
        }

        if (fieldName.equalsIgnoreCase("POLICY_TYPE")) {
            return "POLICY_TYPE";
        }

        if (fieldName.equalsIgnoreCase("IPV6_POOL")) {
            return "IPV6_POOL";
        }

        if (fieldName.equalsIgnoreCase("IPV6_ADDRESS")) {
            return "IPV6_ADDRESS";
        }

        if (fieldName.equalsIgnoreCase("ENCAPSULATION")) {
            return "ENCAPSULATION";
        }

        if (fieldName.equalsIgnoreCase("IPBINDING_FLAG")) {
            return "IPBINDING_FLAG";
        }

        if (fieldName.equalsIgnoreCase("OSPF_PROCESSID")) {
            return "OSPF_PROCESSID";
        }

        if (fieldName.equalsIgnoreCase("AREA")) {
            return "AREA";
        }

        if (fieldName.equalsIgnoreCase("BANDWIDTH")) {
            return "BANDWIDTH";
        }

        if (fieldName.equalsIgnoreCase("RSVP_BANDWIDTH")) {
            return "RSVP_BANDWIDTH";
        }

        return null;
    }

    /**
     * Set the TRUNKDATA_ID
     * @param _tRUNKDATA_ID "Primary key\n"
     */
    public void setTrunkdata_id(String _tRUNKDATA_ID) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.TRUNKDATA_ID = _tRUNKDATA_ID;
    }

    /**
     * Returns the "Primary key\n"
     * @return the "Primary key\n"
     */
    public String getTrunkdata_id() {
        return this.TRUNKDATA_ID;
    }

    /**
     * Returns the description of the field TRUNKDATA_ID.
     * @return a String with the description of the field TRUNKDATA_ID or null if there is not description.
     */
    public String getTrunkdata_idDescription() {
        return "Primary key\n";
    }

    /**
     * Set the PARENT_TRUNKDATA
     * @param _pARENT_TRUNKDATA "Parent relationship for subinterface trunks\n"
     */
    public void setParent_trunkdata(String _pARENT_TRUNKDATA) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.PARENT_TRUNKDATA = _pARENT_TRUNKDATA;
    }

    /**
     * Returns the "Parent relationship for subinterface trunks\n"
     * @return the "Parent relationship for subinterface trunks\n"
     */
    public String getParent_trunkdata() {
        return this.PARENT_TRUNKDATA;
    }

    /**
     * Returns the description of the field PARENT_TRUNKDATA.
     * @return a String with the description of the field PARENT_TRUNKDATA or null if there is not description.
     */
    public String getParent_trunkdataDescription() {
        return "Parent relationship for subinterface trunks\n";
    }

    /**
     * Set the TRUNK_ID
     * @param _tRUNK_ID "Foreign key\n"
     */
    public void setTrunk_id(String _tRUNK_ID) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.TRUNK_ID = _tRUNK_ID;
    }

    /**
     * Returns the "Foreign key\n"
     * @return the "Foreign key\n"
     */
    public String getTrunk_id() {
        return this.TRUNK_ID;
    }

    /**
     * Returns the description of the field TRUNK_ID.
     * @return a String with the description of the field TRUNK_ID or null if there is not description.
     */
    public String getTrunk_idDescription() {
        return "Foreign key\n";
    }

    /**
     * Set the SIDE_SERVICE_ID
     * @param _sIDE_SERVICE_ID "Trunk side ID\n"
     */
    public void setSide_service_id(String _sIDE_SERVICE_ID) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.SIDE_SERVICE_ID = _sIDE_SERVICE_ID;
    }

    /**
     * Returns the "Trunk side ID\n"
     * @return the "Trunk side ID\n"
     */
    public String getSide_service_id() {
        return this.SIDE_SERVICE_ID;
    }

    /**
     * Returns the description of the field SIDE_SERVICE_ID.
     * @return a String with the description of the field SIDE_SERVICE_ID or null if there is not description.
     */
    public String getSide_service_idDescription() {
        return "Trunk side ID\n";
    }

    /**
     * Set the SIDE_NAME
     * @param _sIDE_NAME "Name of the trunk side\n"
     */
    public void setSide_name(String _sIDE_NAME) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.SIDE_NAME = _sIDE_NAME;
    }

    /**
     * Returns the "Name of the trunk side\n"
     * @return the "Name of the trunk side\n"
     */
    public String getSide_name() {
        return this.SIDE_NAME;
    }

    /**
     * Returns the description of the field SIDE_NAME.
     * @return a String with the description of the field SIDE_NAME or null if there is not description.
     */
    public String getSide_nameDescription() {
        return "Name of the trunk side\n";
    }

    /**
     * Set the SIDE_SORT_NAME
     * @param _sIDE_SORT_NAME "Sort name of the trunk side\n"
     */
    public void setSide_sort_name(String _sIDE_SORT_NAME) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.SIDE_SORT_NAME = _sIDE_SORT_NAME;
    }

    /**
     * Returns the "Sort name of the trunk side\n"
     * @return the "Sort name of the trunk side\n"
     */
    public String getSide_sort_name() {
        return this.SIDE_SORT_NAME;
    }

    /**
     * Returns the description of the field SIDE_SORT_NAME.
     * @return a String with the description of the field SIDE_SORT_NAME or null if there is not description.
     */
    public String getSide_sort_nameDescription() {
        return "Sort name of the trunk side\n";
    }

    /**
     * Set the ROUTER_ID
     * @param _rOUTER_ID "ROUTER ID\n"
     */
    public void setRouter_id(String _rOUTER_ID) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.ROUTER_ID = _rOUTER_ID;
    }

    /**
     * Returns the "ROUTER ID\n"
     * @return the "ROUTER ID\n"
     */
    public String getRouter_id() {
        return this.ROUTER_ID;
    }

    /**
     * Returns the description of the field ROUTER_ID.
     * @return a String with the description of the field ROUTER_ID or null if there is not description.
     */
    public String getRouter_idDescription() {
        return "ROUTER ID\n";
    }

    /**
     * Set the INTERFACES_ID
     * @param _iNTERFACES_ID "INTERFACES ID\n"
     */
    public void setInterfaces_id(String _iNTERFACES_ID) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.INTERFACES_ID = _iNTERFACES_ID;
    }

    /**
     * Returns the "INTERFACES ID\n"
     * @return the "INTERFACES ID\n"
     */
    public String getInterfaces_id() {
        return this.INTERFACES_ID;
    }

    /**
     * Returns the description of the field INTERFACES_ID.
     * @return a String with the description of the field INTERFACES_ID or null if there is not description.
     */
    public String getInterfaces_idDescription() {
        return "INTERFACES ID\n";
    }

    /**
     * Set the IPNET_POOL
     * @param _iPNET_POOL "IP pool\n"
     */
    public void setIpnet_pool(String _iPNET_POOL) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.IPNET_POOL = _iPNET_POOL;
    }

    /**
     * Returns the "IP pool\n"
     * @return the "IP pool\n"
     */
    public String getIpnet_pool() {
        return this.IPNET_POOL;
    }

    /**
     * Returns the description of the field IPNET_POOL.
     * @return a String with the description of the field IPNET_POOL or null if there is not description.
     */
    public String getIpnet_poolDescription() {
        return "IP pool\n";
    }

    /**
     * Set the IPNET_ADDRESS
     * @param _iPNET_ADDRESS "IP address\n"
     */
    public void setIpnet_address(String _iPNET_ADDRESS) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.IPNET_ADDRESS = _iPNET_ADDRESS;
    }

    /**
     * Returns the "IP address\n"
     * @return the "IP address\n"
     */
    public String getIpnet_address() {
        return this.IPNET_ADDRESS;
    }

    /**
     * Returns the description of the field IPNET_ADDRESS.
     * @return a String with the description of the field IPNET_ADDRESS or null if there is not description.
     */
    public String getIpnet_addressDescription() {
        return "IP address\n";
    }

    /**
     * Set the IPNET_SUBMASK
     * @param _iPNET_SUBMASK "IP submask\n"
     */
    public void setIpnet_submask(String _iPNET_SUBMASK) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.IPNET_SUBMASK = _iPNET_SUBMASK;
    }

    /**
     * Returns the "IP submask\n"
     * @return the "IP submask\n"
     */
    public String getIpnet_submask() {
        return this.IPNET_SUBMASK;
    }

    /**
     * Returns the description of the field IPNET_SUBMASK.
     * @return a String with the description of the field IPNET_SUBMASK or null if there is not description.
     */
    public String getIpnet_submaskDescription() {
        return "IP submask\n";
    }

    /**
     * Set the SIDE_DESCRIPTION
     * @param _sIDE_DESCRIPTION "Description of the trunk side\n"
     */
    public void setSide_description(String _sIDE_DESCRIPTION) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.SIDE_DESCRIPTION = _sIDE_DESCRIPTION;
    }

    /**
     * Returns the "Description of the trunk side\n"
     * @return the "Description of the trunk side\n"
     */
    public String getSide_description() {
        return this.SIDE_DESCRIPTION;
    }

    /**
     * Returns the description of the field SIDE_DESCRIPTION.
     * @return a String with the description of the field SIDE_DESCRIPTION or null if there is not description.
     */
    public String getSide_descriptionDescription() {
        return "Description of the trunk side\n";
    }

    /**
     * Set the NEGO_FLAG
     * @param _nEGO_FLAG "Negotiation 'auto' should be true or false\n"
     */
    public void setNego_flag(boolean _nEGO_FLAG) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.NEGO_FLAG = _nEGO_FLAG;
    }

    /**
     * Returns the "Negotiation 'auto' should be true or false\n"
     * @return the "Negotiation 'auto' should be true or false\n"
     */
    public boolean getNego_flag() {
        return this.NEGO_FLAG;
    }

    /**
     * Returns the description of the field NEGO_FLAG.
     * @return a String with the description of the field NEGO_FLAG or null if there is not description.
     */
    public String getNego_flagDescription() {
        return "Negotiation 'auto' should be true or false\n";
    }

    /**
     * Set the LINKPROTOCOL
     * @param _lINKPROTOCOL "Link protocol for the sides\n"
     */
    public void setLinkprotocol(String _lINKPROTOCOL) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.LINKPROTOCOL = _lINKPROTOCOL;
    }

    /**
     * Returns the "Link protocol for the sides\n"
     * @return the "Link protocol for the sides\n"
     */
    public String getLinkprotocol() {
        return this.LINKPROTOCOL;
    }

    /**
     * Returns the description of the field LINKPROTOCOL.
     * @return a String with the description of the field LINKPROTOCOL or null if there is not description.
     */
    public String getLinkprotocolDescription() {
        return "Link protocol for the sides\n";
    }

    /**
     * Set the MTU
     * @param _mTU "MTU value by default should be 1700\n"
     */
    public void setMtu(int _mTU) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.MTU = _mTU;
    }

    /**
     * Returns the "MTU value by default should be 1700\n"
     * @return the "MTU value by default should be 1700\n"
     */
    public int getMtu() {
        return this.MTU;
    }

    /**
     * Returns the description of the field MTU.
     * @return a String with the description of the field MTU or null if there is not description.
     */
    public String getMtuDescription() {
        return "MTU value by default should be 1700\n";
    }

    /**
     * Set the PIM_FLAG
     * @param _pIM_FLAG "PIM 'sm' can be true or false\n"
     */
    public void setPim_flag(boolean _pIM_FLAG) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.PIM_FLAG = _pIM_FLAG;
    }

    /**
     * Returns the "PIM 'sm' can be true or false\n"
     * @return the "PIM 'sm' can be true or false\n"
     */
    public boolean getPim_flag() {
        return this.PIM_FLAG;
    }

    /**
     * Returns the description of the field PIM_FLAG.
     * @return a String with the description of the field PIM_FLAG or null if there is not description.
     */
    public String getPim_flagDescription() {
        return "PIM 'sm' can be true or false\n";
    }

    /**
     * Set the OSPFNET_TYPE_FLAG
     * @param _oSPFNET_TYPE_FLAG "OSPF network type can be true or false\n"
     */
    public void setOspfnet_type_flag(boolean _oSPFNET_TYPE_FLAG) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.OSPFNET_TYPE_FLAG = _oSPFNET_TYPE_FLAG;
    }

    /**
     * Returns the "OSPF network type can be true or false\n"
     * @return the "OSPF network type can be true or false\n"
     */
    public boolean getOspfnet_type_flag() {
        return this.OSPFNET_TYPE_FLAG;
    }

    /**
     * Returns the description of the field OSPFNET_TYPE_FLAG.
     * @return a String with the description of the field OSPFNET_TYPE_FLAG or null if there is not description.
     */
    public String getOspfnet_type_flagDescription() {
        return "OSPF network type can be true or false\n";
    }

    /**
     * Set the OSPF_COST
     * @param _oSPF_COST "OSPF cost value by default should be 200\n"
     */
    public void setOspf_cost(int _oSPF_COST) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.OSPF_COST = _oSPF_COST;
    }

    /**
     * Returns the "OSPF cost value by default should be 200\n"
     * @return the "OSPF cost value by default should be 200\n"
     */
    public int getOspf_cost() {
        return this.OSPF_COST;
    }

    /**
     * Returns the description of the field OSPF_COST.
     * @return a String with the description of the field OSPF_COST or null if there is not description.
     */
    public String getOspf_costDescription() {
        return "OSPF cost value by default should be 200\n";
    }

    /**
     * Set the OSPF_PASSWORD
     * @param _oSPF_PASSWORD "OSPF password\n"
     */
    public void setOspf_password(String _oSPF_PASSWORD) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.OSPF_PASSWORD = _oSPF_PASSWORD;
    }

    /**
     * Returns the "OSPF password\n"
     * @return the "OSPF password\n"
     */
    public String getOspf_password() {
        return this.OSPF_PASSWORD;
    }

    /**
     * Returns the description of the field OSPF_PASSWORD.
     * @return a String with the description of the field OSPF_PASSWORD or null if there is not description.
     */
    public String getOspf_passwordDescription() {
        return "OSPF password\n";
    }

    /**
     * Set the LDP_FLAG
     * @param _lDP_FLAG "LDP value can be true or false\n"
     */
    public void setLdp_flag(boolean _lDP_FLAG) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.LDP_FLAG = _lDP_FLAG;
    }

    /**
     * Returns the "LDP value can be true or false\n"
     * @return the "LDP value can be true or false\n"
     */
    public boolean getLdp_flag() {
        return this.LDP_FLAG;
    }

    /**
     * Returns the description of the field LDP_FLAG.
     * @return a String with the description of the field LDP_FLAG or null if there is not description.
     */
    public String getLdp_flagDescription() {
        return "LDP value can be true or false\n";
    }

    /**
     * Set the LDP_PASSWORD
     * @param _lDP_PASSWORD "LDP password\n"
     */
    public void setLdp_password(String _lDP_PASSWORD) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.LDP_PASSWORD = _lDP_PASSWORD;
    }

    /**
     * Returns the "LDP password\n"
     * @return the "LDP password\n"
     */
    public String getLdp_password() {
        return this.LDP_PASSWORD;
    }

    /**
     * Returns the description of the field LDP_PASSWORD.
     * @return a String with the description of the field LDP_PASSWORD or null if there is not description.
     */
    public String getLdp_passwordDescription() {
        return "LDP password\n";
    }

    /**
     * Set the INTERFACE_DESCRIPTION
     * @param _iNTERFACE_DESCRIPTION "Interface description\n"
     */
    public void setInterface_description(String _iNTERFACE_DESCRIPTION) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.INTERFACE_DESCRIPTION = _iNTERFACE_DESCRIPTION;
    }

    /**
     * Returns the "Interface description\n"
     * @return the "Interface description\n"
     */
    public String getInterface_description() {
        return this.INTERFACE_DESCRIPTION;
    }

    /**
     * Returns the description of the field INTERFACE_DESCRIPTION.
     * @return a String with the description of the field INTERFACE_DESCRIPTION or null if there is not description.
     */
    public String getInterface_descriptionDescription() {
        return "Interface description\n";
    }

    /**
     * Set the TRAFFIC_POLICYNAME
     * @param _tRAFFIC_POLICYNAME "Traffic policy for the sides\n"
     */
    public void setTraffic_policyname(String _tRAFFIC_POLICYNAME) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.TRAFFIC_POLICYNAME = _tRAFFIC_POLICYNAME;
    }

    /**
     * Returns the "Traffic policy for the sides\n"
     * @return the "Traffic policy for the sides\n"
     */
    public String getTraffic_policyname() {
        return this.TRAFFIC_POLICYNAME;
    }

    /**
     * Returns the description of the field TRAFFIC_POLICYNAME.
     * @return a String with the description of the field TRAFFIC_POLICYNAME or null if there is not description.
     */
    public String getTraffic_policynameDescription() {
        return "Traffic policy for the sides\n";
    }

    /**
     * Set the POLICY_TYPE
     * @param _pOLICY_TYPE "Policy type can be inbond and outbound for the sides\n"
     */
    public void setPolicy_type(String _pOLICY_TYPE) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.POLICY_TYPE = _pOLICY_TYPE;
    }

    /**
     * Returns the "Policy type can be inbond and outbound for the sides\n"
     * @return the "Policy type can be inbond and outbound for the sides\n"
     */
    public String getPolicy_type() {
        return this.POLICY_TYPE;
    }

    /**
     * Returns the description of the field POLICY_TYPE.
     * @return a String with the description of the field POLICY_TYPE or null if there is not description.
     */
    public String getPolicy_typeDescription() {
        return "Policy type can be inbond and outbound for the sides\n";
    }

    /**
     * Set the IPV6_POOL
     * @param _iPV6_POOL "Ipv6 pool\n"
     */
    public void setIpv6_pool(String _iPV6_POOL) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.IPV6_POOL = _iPV6_POOL;
    }

    /**
     * Returns the "Ipv6 pool\n"
     * @return the "Ipv6 pool\n"
     */
    public String getIpv6_pool() {
        return this.IPV6_POOL;
    }

    /**
     * Returns the description of the field IPV6_POOL.
     * @return a String with the description of the field IPV6_POOL or null if there is not description.
     */
    public String getIpv6_poolDescription() {
        return "Ipv6 pool\n";
    }

    /**
     * Set the IPV6_ADDRESS
     * @param _iPV6_ADDRESS "Ipv6 address\n"
     */
    public void setIpv6_address(String _iPV6_ADDRESS) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.IPV6_ADDRESS = _iPV6_ADDRESS;
    }

    /**
     * Returns the "Ipv6 address\n"
     * @return the "Ipv6 address\n"
     */
    public String getIpv6_address() {
        return this.IPV6_ADDRESS;
    }

    /**
     * Returns the description of the field IPV6_ADDRESS.
     * @return a String with the description of the field IPV6_ADDRESS or null if there is not description.
     */
    public String getIpv6_addressDescription() {
        return "Ipv6 address\n";
    }

    /**
     * Set the ENCAPSULATION
     * @param _eNCAPSULATION "Encapsulation should be dot1q if subinterfaces for the sides\n"
     */
    public void setEncapsulation(String _eNCAPSULATION) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.ENCAPSULATION = _eNCAPSULATION;
    }

    /**
     * Returns the "Encapsulation should be dot1q if subinterfaces for the sides\n"
     * @return the "Encapsulation should be dot1q if subinterfaces for the sides\n"
     */
    public String getEncapsulation() {
        return this.ENCAPSULATION;
    }

    /**
     * Returns the description of the field ENCAPSULATION.
     * @return a String with the description of the field ENCAPSULATION or null if there is not description.
     */
    public String getEncapsulationDescription() {
        return "Encapsulation should be dot1q if subinterfaces for the sides\n";
    }

    /**
     * Set the IPBINDING_FLAG
     * @param _iPBINDING_FLAG "IP Binding value can be true or false\n"
     */
    public void setIpbinding_flag(boolean _iPBINDING_FLAG) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.IPBINDING_FLAG = _iPBINDING_FLAG;
    }

    /**
     * Returns the "IP Binding value can be true or false\n"
     * @return the "IP Binding value can be true or false\n"
     */
    public boolean getIpbinding_flag() {
        return this.IPBINDING_FLAG;
    }

    /**
     * Returns the description of the field IPBINDING_FLAG.
     * @return a String with the description of the field IPBINDING_FLAG or null if there is not description.
     */
    public String getIpbinding_flagDescription() {
        return "IP Binding value can be true or false\n";
    }

    /**
     * Set the OSPF_PROCESSID
     * @param _oSPF_PROCESSID "OSPF_PROCESSID value default 100\n"
     */
    public void setOspf_processid(int _oSPF_PROCESSID) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.OSPF_PROCESSID = _oSPF_PROCESSID;
    }

    /**
     * Returns the "OSPF_PROCESSID value default 100\n"
     * @return the "OSPF_PROCESSID value default 100\n"
     */
    public int getOspf_processid() {
        return this.OSPF_PROCESSID;
    }

    /**
     * Returns the description of the field OSPF_PROCESSID.
     * @return a String with the description of the field OSPF_PROCESSID or null if there is not description.
     */
    public String getOspf_processidDescription() {
        return "OSPF_PROCESSID value default 100\n";
    }

    /**
     * Set the AREA
     * @param _aREA "AREA value\n"
     */
    public void setArea(String _aREA) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.AREA = _aREA;
    }

    /**
     * Returns the "AREA value\n"
     * @return the "AREA value\n"
     */
    public String getArea() {
        return this.AREA;
    }

    /**
     * Returns the description of the field AREA.
     * @return a String with the description of the field AREA or null if there is not description.
     */
    public String getAreaDescription() {
        return "AREA value\n";
    }

    /**
     * Set the BANDWIDTH
     * @param _bANDWIDTH "BANDWIDTH value\n"
     */
    public void setBandwidth(String _bANDWIDTH) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.BANDWIDTH = _bANDWIDTH;
    }

    /**
     * Returns the "BANDWIDTH value\n"
     * @return the "BANDWIDTH value\n"
     */
    public String getBandwidth() {
        return this.BANDWIDTH;
    }

    /**
     * Returns the description of the field BANDWIDTH.
     * @return a String with the description of the field BANDWIDTH or null if there is not description.
     */
    public String getBandwidthDescription() {
        return "BANDWIDTH value\n";
    }

    /**
     * Set the RSVP_BANDWIDTH
     * @param _rSVP_BANDWIDTH "RSVP_BANDWIDTH value\n"
     */
    public void setRsvp_bandwidth(String _rSVP_BANDWIDTH) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        this.RSVP_BANDWIDTH = _rSVP_BANDWIDTH;
    }

    /**
     * Returns the "RSVP_BANDWIDTH value\n"
     * @return the "RSVP_BANDWIDTH value\n"
     */
    public String getRsvp_bandwidth() {
        return this.RSVP_BANDWIDTH;
    }

    /**
     * Returns the description of the field RSVP_BANDWIDTH.
     * @return a String with the description of the field RSVP_BANDWIDTH or null if there is not description.
     */
    public String getRsvp_bandwidthDescription() {
        return "RSVP_BANDWIDTH value\n";
    }

    /* (non-Javadoc)
     * @see com.hp.ov.activator.inventory.Reservable#getPrimaryKey()
     */
    public String getPrimaryKey() {
        return "" + getTrunkdata_id();
    }

    /**
     * Sets the primary key.
     * @param pk String with the primary key fields separated by PRIMARY_KEY_SEPARATOR
     */
    public void setPrimaryKey(String pk) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_trunkdata as it's read only");
        }

        String[] keyFields = pk.split(PRIMARY_KEY_SEPARATOR_REG_EXP);
        setTrunkdata_id(from_String2String(keyFields[0]));
    }

    /**
     * Returns the fields that compose the primary key.
     * @param Vector (QueryData) with the fields that compose the primary key
     */
    protected Vector getPrimaryKeyFields() {
        Vector v = new Vector();
        v.add(new QDString(getTrunkdata_id()));

        return v;
    }

    /**
     * Returns the name of the fields that compose the primary key.
     * @param Vector (String) with the name of the fields that compose the primary key
     */
    public Vector getPrimaryKeyFieldsNames() {
        Vector v = new Vector();
        v.add("TRUNKDATA_ID");

        return v;
    }

    /**
     * Returns the name of the fields that compose the primary key. Static version of getPrimaryKeyFieldsNames (not removed for compatibility)
     * @param Vector (String) with the name of the fields that compose the primary key
     */
    public static Vector getPrimaryKeyFieldsNamesStatic() {
        Vector v = new Vector();
        v.add("TRUNKDATA_ID");

        return v;
    }

    // ******************************** Audit *********************************** //
    // ******************************** Operations *********************************** //

    /**
     * Stores the bean in the DB
     * @param con Connection
     * @param parameters
     *          Map of parameters. No parameters accepted at the moment. Used for future new parameters.
     */
    public void store(Connection con, Map parameters) throws SQLException {
        try {
            OperationsParameters op_param = new OperationsParameters(parameters);

            this.storeWithoutCommitLastChild(con);

            //   If the autocommit is true, we internally set to false for all the operations and turn it to true at the end so we must do commit now
            //   If the autocommit is false, the user don't want to commit the changes.
            if (con.getAutoCommit()) {
                con.setAutoCommit(false);
                con.commit();
                con.setAutoCommit(true);
            }
        } catch (ParameterException e) {
            throw new RuntimeException("Error storing: " + e.getMessage());
        }
    }

    /**
     * Stores the bean in the DB
     * @param con Connection
     */
    public void store(Connection con) throws SQLException {
        this.store(con, (Map) null);
    }

    /**
     * Stores the bean in the DB without committing to the DB. It's used to do a atomic store of all the fathers. We can't use the same
     * method of update and delete because the constraints restrictions.
     * @param con Connection
     */
    protected void storeWithoutCommit(Connection con) throws SQLException {
        validate(con, true);

        store(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            new QueryData[] {
                new QDString(getNextSequenceValue_TRUNKDATA_ID(con)),
                new QDString(getParent_trunkdata()), new QDString(getTrunk_id()),
                new QDString(getSide_service_id()), new QDString(getSide_name()),
                new QDString(getSide_sort_name()), new QDString(getRouter_id()),
                new QDString(getInterfaces_id()), new QDString(getIpnet_pool()),
                new QDString(getIpnet_address()),
                new QDString(getIpnet_submask()),
                new QDString(getSide_description()),
                new QDboolean(getNego_flag()), new QDString(getLinkprotocol()),
                new QDint(getMtu()), new QDboolean(getPim_flag()),
                new QDboolean(getOspfnet_type_flag()), new QDint(getOspf_cost()),
                new QDString(getOspf_password()), new QDboolean(getLdp_flag()),
                new QDString(getLdp_password()),
                new QDString(getInterface_description()),
                new QDString(getTraffic_policyname()),
                new QDString(getPolicy_type()), new QDString(getIpv6_pool()),
                new QDString(getIpv6_address()),
                new QDString(getEncapsulation()),
                new QDboolean(getIpbinding_flag()),
                new QDint(getOspf_processid()), new QDString(getArea()),
                new QDString(getBandwidth()), new QDString(getRsvp_bandwidth()),
                new QDboolean(true)
            }, true, false, class_loader);
    }

    /**
     * Start the storage of a bean as if this bean is the top level one (so the parent column will not be marked)
     * @param con Connection
     */
    protected void storeWithoutCommitLastChild(Connection con)
        throws SQLException {
        validate(con, true);

        store(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
            new QueryData[] {
                new QDString(getNextSequenceValue_TRUNKDATA_ID(con)),
                new QDString(getParent_trunkdata()), new QDString(getTrunk_id()),
                new QDString(getSide_service_id()), new QDString(getSide_name()),
                new QDString(getSide_sort_name()), new QDString(getRouter_id()),
                new QDString(getInterfaces_id()), new QDString(getIpnet_pool()),
                new QDString(getIpnet_address()),
                new QDString(getIpnet_submask()),
                new QDString(getSide_description()),
                new QDboolean(getNego_flag()), new QDString(getLinkprotocol()),
                new QDint(getMtu()), new QDboolean(getPim_flag()),
                new QDboolean(getOspfnet_type_flag()), new QDint(getOspf_cost()),
                new QDString(getOspf_password()), new QDboolean(getLdp_flag()),
                new QDString(getLdp_password()),
                new QDString(getInterface_description()),
                new QDString(getTraffic_policyname()),
                new QDString(getPolicy_type()), new QDString(getIpv6_pool()),
                new QDString(getIpv6_address()),
                new QDString(getEncapsulation()),
                new QDboolean(getIpbinding_flag()),
                new QDint(getOspf_processid()), new QDString(getArea()),
                new QDString(getBandwidth()), new QDString(getRsvp_bandwidth()),
                new QDboolean(false)
            }, true, false, class_loader);
    }

    /**
     * Updates the bean in the DB
     * @param con Connection
     * @param parameters
     *          Map of parameters. No parameters accepted at the moment. Used for future new parameters.
     */
    public void update(Connection con, Map parameters)
        throws SQLException {
        validate(con);

        try {
            OperationsParameters op_param = new OperationsParameters(parameters);

            QueryData[] values = new QueryData[] {
                    new QDString(getParent_trunkdata()),
                    new QDString(getTrunk_id()),
                    new QDString(getSide_service_id()),
                    new QDString(getSide_name()),
                    new QDString(getSide_sort_name()),
                    new QDString(getRouter_id()),
                    new QDString(getInterfaces_id()),
                    new QDString(getIpnet_pool()),
                    new QDString(getIpnet_address()),
                    new QDString(getIpnet_submask()),
                    new QDString(getSide_description()),
                    new QDboolean(getNego_flag()),
                    new QDString(getLinkprotocol()), new QDint(getMtu()),
                    new QDboolean(getPim_flag()),
                    new QDboolean(getOspfnet_type_flag()),
                    new QDint(getOspf_cost()), new QDString(getOspf_password()),
                    new QDboolean(getLdp_flag()),
                    new QDString(getLdp_password()),
                    new QDString(getInterface_description()),
                    new QDString(getTraffic_policyname()),
                    new QDString(getPolicy_type()), new QDString(getIpv6_pool()),
                    new QDString(getIpv6_address()),
                    new QDString(getEncapsulation()),
                    new QDboolean(getIpbinding_flag()),
                    new QDint(getOspf_processid()), new QDString(getArea()),
                    new QDString(getBandwidth()),
                    new QDString(getRsvp_bandwidth()),
                    new QDString(getTrunkdata_id())
                };

            update(con, "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                values, false, false, class_loader);
        } catch (ParameterException e) {
            throw new RuntimeException("Error updating: " + e.getMessage());
        }
    }

    /**
     * Updates the bean in the DB
     *
     * @param con Connection
     */
    public void update(Connection con) throws SQLException {
        this.update(con, (Map) null);
    }

    /**
     * Removes the bean in the DB
     * @param con Connection
     * @param parameters
     *          Map of parameters. No parameters accepted at the moment. Used for future new parameters.
     */
    public boolean delete(Connection con, Map parameters)
        throws SQLException {
        return this._delete(con, false, parameters);
    }

    /**
     * Removes the bean in the DB
     * @param con Connection
     */
    public boolean delete(Connection con) throws SQLException {
        return this._delete(con, false, (Map) null);
    }

    /**
     * Deletes the bean in the DB
     * @param con Connection
     * @param primary_key primary key of the bean to delete.
     */
    public static boolean delete(Connection con, String primary_key)
        throws SQLException {
        return igw_trunkdata_._deleteStatic(con, primary_key, false, (Map) null);
    }

    /**
     * Deletes the bean in the DB
     * @param con Connection
     * @param parameters
     *          Map of parameters. No parameters accepted at the moment. Used for future new parameters.
     */
    public static boolean delete(Connection con, String primary_key,
        Map parameters) throws SQLException {
        return igw_trunkdata_._deleteStatic(con, primary_key, false, parameters);
    }

    /**
     * Deletes the bean in the DB
     * @param con Connection
     * @param primary_key primary key of the bean to delete.
     * @param history true for do the deletion in the history table
     * @param parameters
     *          Map of parameters. No parameters accepted at the moment. Used for future new parameters.
     */
    private static boolean _deleteStatic(Connection con, String primary_key,
        boolean history, Map parameters) throws SQLException {
        igw_trunkdata_ to_delete = (igw_trunkdata_) igw_trunkdata_.findByPrimaryKey(con,
                primary_key, history);

        if (to_delete == null) {
            throw new SQLException(
                "><Not found bean igw_trunkdata with primary key " +
                primary_key);
        }

        return to_delete._delete(con, history, parameters);
    }

    /**
     * Deletes the bean in the DB
     * @param con Connection
     * @param history true for do the deletion in the history table
     * @param parameters
     *          Map of parameters. No parameters accepted at the moment. Used for future new parameters.
     */
    protected boolean _delete(Connection con, boolean history, Map parameters)
        throws SQLException {
        try {
            boolean result = false;
            OperationsParameters op_param = new OperationsParameters(parameters);

            QueryData[] primaryKeys = new QueryData[] {
                    new QDString(getTrunkdata_id())
                };

            result = delete(con,
                    "com.hp.ov.activator.vpn.inventory.igw_trunkdata",
                    primaryKeys, history, false, false, class_loader);

            return result;
        } catch (ParameterException e) {
            throw new RuntimeException("Error deleting: " + e.getMessage());
        }
    }

    // ******************************** Partial Operations *********************************** //

    /**
     * Informs if the bean can be upgrade to a child type one. To be override by the children.
     * @param con connection
     * @return if the bean cannot be extended because the isParent__ value
     * @throws InventoryException if the bean cannot be extended because the generation method of it or its parents
     * @throws SQLException
     */
    public boolean canBePartiallyExtended(Connection con)
        throws InventoryException, SQLException {
        return !findIsParent(con);
    }

    /**
     * Update the isParent__ column of the database.
     * @param primary_key String with the primary key fields separated with ||
     * @param is_parent_value new value of the isParent__ column
     * @throws SQLException when a problem accessing the database occurs
     */
    public static void updateIsParent(Connection con, String primary_key,
        boolean is_parent_value) throws SQLException {
        if (primary_key == null) {
            throw new RuntimeException(
                "Error trying to update the parent column, the primary key is null");
        }

        String[] keyFields = primary_key.split(PRIMARY_KEY_SEPARATOR_REG_EXP);

        Bean.updateIsParent(con,
            "com.hp.ov.activator.vpn.inventory.igw_trunkdata", is_parent_value,
            new QueryData[] { new QDString(from_String2String(keyFields[0])) },
            class_loader);
    }

    /**
     * Method that returns the next value of this bean's sequence. It is only possible to have
     * one sequence per bean. The value is recovered from the DB just once. The flag TRUNKDATA_ID_seq_nextVal tells
     * whether the sequence value has been already recovered.
     * @param con DB connection
     * @return the next value for the igw_trunkdata_SEQ sequence
     */
    protected String getNextSequenceValue_TRUNKDATA_ID(Connection con) {
        //      if(! TRUNKDATA_ID_seq_nextVal ) { //If TRUNKDATA_ID_seq_nextVal == true we have already found the value of the nextValue
        this.TRUNKDATA_ID = getNextSequenceValueString(con, "igw_trunkdata_SEQ");

        //        this.TRUNKDATA_ID_seq_nextVal = true;
        //      } 
        return this.TRUNKDATA_ID;
    }

    /**
     * Returns the actual value of the sequence (if null it calls for the next sequence) as a QueryData object,
     * so can be injected directly in the store. It not recovers a new sequence parameter, it's the user duty to
     * do this.
     * @return the sequence actual value in QueryData form.
     */
    protected QueryData getQueryDataSequenceValue_TRUNKDATA_ID() {
        return new QDString(this.TRUNKDATA_ID);
    }

    // ***************************** History Operations ****************************** //
    // ******************************** Validations *********************************** //
    protected void validate(Connection con) throws RuntimeException {
        validate(con, true);
    }

    /**
     * Validates the bean data
     * @param con Connection
     * @param validate_parents
     *          true to validate also the data of the parent bean. false only validates
     *          the fields stored by its own database table.
     */
    protected void validate(Connection con, boolean validate_parents)
        throws RuntimeException {
        Vector v = new Vector();

        if ((getSide_service_id() == null) || getSide_service_id().equals("")) {
            v.addElement("SIDE_SERVICE_ID");
        }

        if ((getSide_name() == null) || getSide_name().equals("")) {
            v.addElement("SIDE_NAME");
        }

        if ((getSide_sort_name() == null) || getSide_sort_name().equals("")) {
            v.addElement("SIDE_SORT_NAME");
        }

        if ((getRouter_id() == null) || getRouter_id().equals("")) {
            v.addElement("ROUTER_ID");
        }

        if (!v.isEmpty()) {
            throw new RuntimeException("Parameters " + v + " are mandatory");
        }
    }

    // ******************************** Loaders *********************************** //
    // **************************** [Bean] overrides **************************** //

    /**
     * Returns the map with the label key equivalence. Must be override by the
     * children
     *
     * @return the map with the label key equivalence
     */
    protected Map getLabel_key_equivalency() {
        return field_label_key_equivalency;
    }

    // **************************** [Object] overrides **************************** //

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    public String toString() {
        String describe = "";

        describe = describe + " TRUNKDATA_ID[" + getTrunkdata_id() + "] ";
        describe = describe + " PARENT_TRUNKDATA[" + getParent_trunkdata() +
            "] ";
        describe = describe + " TRUNK_ID[" + getTrunk_id() + "] ";
        describe = describe + " SIDE_SERVICE_ID[" + getSide_service_id() +
            "] ";
        describe = describe + " SIDE_NAME[" + getSide_name() + "] ";
        describe = describe + " SIDE_SORT_NAME[" + getSide_sort_name() + "] ";
        describe = describe + " ROUTER_ID[" + getRouter_id() + "] ";
        describe = describe + " INTERFACES_ID[" + getInterfaces_id() + "] ";
        describe = describe + " IPNET_POOL[" + getIpnet_pool() + "] ";
        describe = describe + " IPNET_ADDRESS[" + getIpnet_address() + "] ";
        describe = describe + " IPNET_SUBMASK[" + getIpnet_submask() + "] ";
        describe = describe + " SIDE_DESCRIPTION[" + getSide_description() +
            "] ";
        describe = describe + " NEGO_FLAG[" + getNego_flag() + "] ";
        describe = describe + " LINKPROTOCOL[" + getLinkprotocol() + "] ";
        describe = describe + " MTU[" + getMtu() + "] ";
        describe = describe + " PIM_FLAG[" + getPim_flag() + "] ";
        describe = describe + " OSPFNET_TYPE_FLAG[" + getOspfnet_type_flag() +
            "] ";
        describe = describe + " OSPF_COST[" + getOspf_cost() + "] ";
        describe = describe + " OSPF_PASSWORD[" + getOspf_password() + "] ";
        describe = describe + " LDP_FLAG[" + getLdp_flag() + "] ";
        describe = describe + " LDP_PASSWORD[" + getLdp_password() + "] ";
        describe = describe + " INTERFACE_DESCRIPTION[" +
            getInterface_description() + "] ";
        describe = describe + " TRAFFIC_POLICYNAME[" + getTraffic_policyname() +
            "] ";
        describe = describe + " POLICY_TYPE[" + getPolicy_type() + "] ";
        describe = describe + " IPV6_POOL[" + getIpv6_pool() + "] ";
        describe = describe + " IPV6_ADDRESS[" + getIpv6_address() + "] ";
        describe = describe + " ENCAPSULATION[" + getEncapsulation() + "] ";
        describe = describe + " IPBINDING_FLAG[" + getIpbinding_flag() + "] ";
        describe = describe + " OSPF_PROCESSID[" + getOspf_processid() + "] ";
        describe = describe + " AREA[" + getArea() + "] ";
        describe = describe + " BANDWIDTH[" + getBandwidth() + "] ";
        describe = describe + " RSVP_BANDWIDTH[" + getRsvp_bandwidth() + "] ";

        return describe;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    public int hashCode() {
        return QDString.hashCode(getTrunkdata_id());
    }

    //Check if this bean support release/reserve operation
    public static boolean supportReleaseReserve() {
        return false;
    }

    // ******************************** misc *********************************** //

    /**
     * Don't deserve to be documented
     * @deprecated for ib 4.0 compatibility. It will disappear in the future.
     */
    protected static igw_trunkdata[] _execFindBy(PreparedStatement pstmt)
        throws SQLException {
        try {
            return _execFindBy(pstmt, 0);
        } catch (ExceededNumberOfRowsException e) {
            return null;
        }
    }

    /**
     * Don't deserve to be documented
     * @deprecated for ib 4.0 compatibility. It will disappear in the future.
     */
    protected static igw_trunkdata[] _execFindBy(PreparedStatement pstmt,
        int maxReturnValues) throws SQLException, ExceededNumberOfRowsException {
        ResultSet rset = null;

        try {
            rset = pstmt.executeQuery();

            if (maxReturnValues > 0) {
                rset.last();

                int totalElements = rset.getRow();
                rset.beforeFirst();

                if (totalElements > maxReturnValues) {
                    throw new ExceededNumberOfRowsException();
                }
            }

            if (rset.next()) {
                // here we gather the result set
                Vector v = new Vector();

                do {
                    String var1 = rset.getString(1);

                    String var2 = rset.getString(2);

                    String var3 = rset.getString(3);

                    String var4 = rset.getString(4);

                    String var5 = rset.getString(5);

                    String var6 = rset.getString(6);

                    String var7 = rset.getString(7);

                    String var8 = rset.getString(8);

                    String var9 = rset.getString(9);

                    String var10 = rset.getString(10);

                    String var11 = rset.getString(11);

                    String var12 = rset.getString(12);

                    boolean var13 = rset.getBoolean(13);

                    String var14 = rset.getString(14);

                    int var15 = rset.getInt(15);

                    // check if the field is null in oracle
                    if (rset.wasNull()) {
                        var15 = Integer.MIN_VALUE;
                    }

                    boolean var16 = rset.getBoolean(16);

                    boolean var17 = rset.getBoolean(17);

                    int var18 = rset.getInt(18);

                    // check if the field is null in oracle
                    if (rset.wasNull()) {
                        var18 = Integer.MIN_VALUE;
                    }

                    String var19 = rset.getString(19);

                    boolean var20 = rset.getBoolean(20);

                    String var21 = rset.getString(21);

                    String var22 = rset.getString(22);

                    String var23 = rset.getString(23);

                    String var24 = rset.getString(24);

                    String var25 = rset.getString(25);

                    String var26 = rset.getString(26);

                    String var27 = rset.getString(27);

                    boolean var28 = rset.getBoolean(28);

                    int var29 = rset.getInt(29);

                    // check if the field is null in oracle
                    if (rset.wasNull()) {
                        var29 = Integer.MIN_VALUE;
                    }

                    String var30 = rset.getString(30);

                    String var31 = rset.getString(31);

                    String var32 = rset.getString(32);

                    v.add(new igw_trunkdata(var1, var2, var3, var4, var5, var6,
                            var7, var8, var9, var10, var11, var12, var13,
                            var14, var15, var16, var17, var18, var19, var20,
                            var21, var22, var23, var24, var25, var26, var27,
                            var28, var29, var30, var31, var32));
                } while (rset.next());

                igw_trunkdata[] resultArray = new igw_trunkdata[v.size()];
                v.copyInto(resultArray);

                return resultArray;
            }
        } finally {
            if (rset != null) {
                rset.close();
            }
        }

        return null;
    }

    /**
     * Don't deserve to be documented
     * @deprecated for ib 4.0 compatibility. It will disappear in the future.
     */
    protected static String _composeSelectClause() {
        StringBuffer sbSqlCode = new StringBuffer();

        sbSqlCode.append("select " + "igw_trunkdata" + ".TRUNKDATA_ID" + ", " +
            "igw_trunkdata" + ".PARENT_TRUNKDATA" + ", " + "igw_trunkdata" +
            ".TRUNK_ID" + ", " + "igw_trunkdata" + ".SIDE_SERVICE_ID" + ", " +
            "igw_trunkdata" + ".SIDE_NAME" + ", " + "igw_trunkdata" +
            ".SIDE_SORT_NAME" + ", " + "igw_trunkdata" + ".ROUTER_ID" + ", " +
            "igw_trunkdata" + ".INTERFACES_ID" + ", " + "igw_trunkdata" +
            ".IPNET_POOL" + ", " + "igw_trunkdata" + ".IPNET_ADDRESS" + ", " +
            "igw_trunkdata" + ".IPNET_SUBMASK" + ", " + "igw_trunkdata" +
            ".SIDE_DESCRIPTION" + ", " + "igw_trunkdata" + ".NEGO_FLAG" + ", " +
            "igw_trunkdata" + ".LINKPROTOCOL" + ", " + "igw_trunkdata" +
            ".MTU" + ", " + "igw_trunkdata" + ".PIM_FLAG" + ", " +
            "igw_trunkdata" + ".OSPFNET_TYPE_FLAG" + ", " + "igw_trunkdata" +
            ".OSPF_COST" + ", " + "igw_trunkdata" + ".OSPF_PASSWORD" + ", " +
            "igw_trunkdata" + ".LDP_FLAG" + ", " + "igw_trunkdata" +
            ".LDP_PASSWORD" + ", " + "igw_trunkdata" +
            ".INTERFACE_DESCRIPTION" + ", " + "igw_trunkdata" +
            ".TRAFFIC_POLICYNAME" + ", " + "igw_trunkdata" + ".POLICY_TYPE" +
            ", " + "igw_trunkdata" + ".IPV6_POOL" + ", " + "igw_trunkdata" +
            ".IPV6_ADDRESS" + ", " + "igw_trunkdata" + ".ENCAPSULATION" + ", " +
            "igw_trunkdata" + ".IPBINDING_FLAG" + ", " + "igw_trunkdata" +
            ".OSPF_PROCESSID" + ", " + "igw_trunkdata" + ".AREA" + ", " +
            "igw_trunkdata" + ".BANDWIDTH" + ", " + "igw_trunkdata" +
            ".RSVP_BANDWIDTH");

        return sbSqlCode.toString() + " ";
    }

    /**
     * Don't deserve to be documented
     * @deprecated for ib 4.0 compatibility. It will disappear in the future.
     */
    protected static String _composeFromClause() {
        StringBuffer sbSqlCode = new StringBuffer("From ");

        sbSqlCode.append("igw_trunkdata");

        return sbSqlCode.toString() + " ";
    }

    /**
     * Don't deserve to be documented
     * @deprecated for ib 4.0 compatibility. It will disappear in the future.
     */
    protected static String _composeSelect() {
        StringBuffer sbSqlCode = new StringBuffer();

        sbSqlCode.append(_composeSelectClause());
        sbSqlCode.append(_composeFromClause());

        return sbSqlCode.toString();
    }

    /**
     * Building a data map form fields.
     * This are done because the IB 5 first was developed with a generic internal data but for
     * compatibility it has to convert this data to fields.
     *
     */
    public HashMap regenerateData() {
        HashMap newData = super.regenerateData();
        newData.put("igw_trunkdata.TRUNKDATA_ID",
            convert2Object(this.getTrunkdata_id()));
        newData.put("igw_trunkdata.PARENT_TRUNKDATA",
            convert2Object(this.getParent_trunkdata()));
        newData.put("igw_trunkdata.TRUNK_ID", convert2Object(this.getTrunk_id()));
        newData.put("igw_trunkdata.SIDE_SERVICE_ID",
            convert2Object(this.getSide_service_id()));
        newData.put("igw_trunkdata.SIDE_NAME",
            convert2Object(this.getSide_name()));
        newData.put("igw_trunkdata.SIDE_SORT_NAME",
            convert2Object(this.getSide_sort_name()));
        newData.put("igw_trunkdata.ROUTER_ID",
            convert2Object(this.getRouter_id()));
        newData.put("igw_trunkdata.INTERFACES_ID",
            convert2Object(this.getInterfaces_id()));
        newData.put("igw_trunkdata.IPNET_POOL",
            convert2Object(this.getIpnet_pool()));
        newData.put("igw_trunkdata.IPNET_ADDRESS",
            convert2Object(this.getIpnet_address()));
        newData.put("igw_trunkdata.IPNET_SUBMASK",
            convert2Object(this.getIpnet_submask()));
        newData.put("igw_trunkdata.SIDE_DESCRIPTION",
            convert2Object(this.getSide_description()));
        newData.put("igw_trunkdata.NEGO_FLAG",
            convert2Object(this.getNego_flag()));
        newData.put("igw_trunkdata.LINKPROTOCOL",
            convert2Object(this.getLinkprotocol()));
        newData.put("igw_trunkdata.MTU", convert2Object(this.getMtu()));
        newData.put("igw_trunkdata.PIM_FLAG", convert2Object(this.getPim_flag()));
        newData.put("igw_trunkdata.OSPFNET_TYPE_FLAG",
            convert2Object(this.getOspfnet_type_flag()));
        newData.put("igw_trunkdata.OSPF_COST",
            convert2Object(this.getOspf_cost()));
        newData.put("igw_trunkdata.OSPF_PASSWORD",
            convert2Object(this.getOspf_password()));
        newData.put("igw_trunkdata.LDP_FLAG", convert2Object(this.getLdp_flag()));
        newData.put("igw_trunkdata.LDP_PASSWORD",
            convert2Object(this.getLdp_password()));
        newData.put("igw_trunkdata.INTERFACE_DESCRIPTION",
            convert2Object(this.getInterface_description()));
        newData.put("igw_trunkdata.TRAFFIC_POLICYNAME",
            convert2Object(this.getTraffic_policyname()));
        newData.put("igw_trunkdata.POLICY_TYPE",
            convert2Object(this.getPolicy_type()));
        newData.put("igw_trunkdata.IPV6_POOL",
            convert2Object(this.getIpv6_pool()));
        newData.put("igw_trunkdata.IPV6_ADDRESS",
            convert2Object(this.getIpv6_address()));
        newData.put("igw_trunkdata.ENCAPSULATION",
            convert2Object(this.getEncapsulation()));
        newData.put("igw_trunkdata.IPBINDING_FLAG",
            convert2Object(this.getIpbinding_flag()));
        newData.put("igw_trunkdata.OSPF_PROCESSID",
            convert2Object(this.getOspf_processid()));
        newData.put("igw_trunkdata.AREA", convert2Object(this.getArea()));
        newData.put("igw_trunkdata.BANDWIDTH",
            convert2Object(this.getBandwidth()));
        newData.put("igw_trunkdata.RSVP_BANDWIDTH",
            convert2Object(this.getRsvp_bandwidth()));

        return newData;
    }

    // ******************************** protected *********************************** //

    /**
     * Cast an array of Bean to an array of igw_trunkdata. This method is needed for compatibility
     * reasons, it could just let return Bean[] and do the casting to the object needed.
     * @param con Connection for recover extra info of the DB like the instance extended attributes
     * @param beans array of Bean to be casted
     * @return array of igw_trunkdata
     * @throws SQLException
     */
    protected static igw_trunkdata[] fromBeanArray2igw_trunkdataArray(
        Connection con, Bean[] beans) throws SQLException {
        return (igw_trunkdata[]) fromBeanArray2igw_trunkdataArray(con, beans,
            false);
    }

    /**
     * Cast an array of Bean to an array of igw_trunkdata. This method is needed for compatibility
     * reasons, it could just let return Bean[] and do the casting to the object needed.
     * @param con Connection for recover extra info of the DB like the instance extended attributes
     * @param beans array of Bean to be casted
     * @param boolean says whether the bean is a History bean (needed for instance attributes)
     * @return array of igw_trunkdata
     * @throws SQLException
     */
    protected static igw_trunkdata[] fromBeanArray2igw_trunkdataArray(
        Connection con, Bean[] beans, boolean history)
        throws SQLException {
        if (beans.length == 0) {
            return null;
        } else {
            igw_trunkdata[] castedBeans = new igw_trunkdata[beans.length];

            for (int x = 0; x < beans.length; x++) {
                castedBeans[x] = new igw_trunkdata();
                castedBeans[x].castBeanOperations(con, beans[x], history);
            }

            return castedBeans;
        }
    }

    // ******************************** private *********************************** //

    /**
     * Initialize the default fields
     */
    protected void initDefault() {
    }

    /**
     * Initialize the mandatory fields
     */
    protected void initMandatory() {
    }

    /**
     * Transform the stored data from the original HashTable to local fields.
     * @param bean original bean to copy the parameters from.
     */
    protected void fillLocalFields(Bean bean) {
        setTrunkdata_id(bean.get_String("igw_trunkdata.TRUNKDATA_ID"));
        setParent_trunkdata(bean.get_String("igw_trunkdata.PARENT_TRUNKDATA"));
        setTrunk_id(bean.get_String("igw_trunkdata.TRUNK_ID"));
        setSide_service_id(bean.get_String("igw_trunkdata.SIDE_SERVICE_ID"));
        setSide_name(bean.get_String("igw_trunkdata.SIDE_NAME"));
        setSide_sort_name(bean.get_String("igw_trunkdata.SIDE_SORT_NAME"));
        setRouter_id(bean.get_String("igw_trunkdata.ROUTER_ID"));
        setInterfaces_id(bean.get_String("igw_trunkdata.INTERFACES_ID"));
        setIpnet_pool(bean.get_String("igw_trunkdata.IPNET_POOL"));
        setIpnet_address(bean.get_String("igw_trunkdata.IPNET_ADDRESS"));
        setIpnet_submask(bean.get_String("igw_trunkdata.IPNET_SUBMASK"));
        setSide_description(bean.get_String("igw_trunkdata.SIDE_DESCRIPTION"));
        setNego_flag(bean.get_boolean("igw_trunkdata.NEGO_FLAG"));
        setLinkprotocol(bean.get_String("igw_trunkdata.LINKPROTOCOL"));
        setMtu(bean.get_int("igw_trunkdata.MTU"));
        setPim_flag(bean.get_boolean("igw_trunkdata.PIM_FLAG"));
        setOspfnet_type_flag(bean.get_boolean("igw_trunkdata.OSPFNET_TYPE_FLAG"));
        setOspf_cost(bean.get_int("igw_trunkdata.OSPF_COST"));
        setOspf_password(bean.get_String("igw_trunkdata.OSPF_PASSWORD"));
        setLdp_flag(bean.get_boolean("igw_trunkdata.LDP_FLAG"));
        setLdp_password(bean.get_String("igw_trunkdata.LDP_PASSWORD"));
        setInterface_description(bean.get_String(
                "igw_trunkdata.INTERFACE_DESCRIPTION"));
        setTraffic_policyname(bean.get_String(
                "igw_trunkdata.TRAFFIC_POLICYNAME"));
        setPolicy_type(bean.get_String("igw_trunkdata.POLICY_TYPE"));
        setIpv6_pool(bean.get_String("igw_trunkdata.IPV6_POOL"));
        setIpv6_address(bean.get_String("igw_trunkdata.IPV6_ADDRESS"));
        setEncapsulation(bean.get_String("igw_trunkdata.ENCAPSULATION"));
        setIpbinding_flag(bean.get_boolean("igw_trunkdata.IPBINDING_FLAG"));
        setOspf_processid(bean.get_int("igw_trunkdata.OSPF_PROCESSID"));
        setArea(bean.get_String("igw_trunkdata.AREA"));
        setBandwidth(bean.get_String("igw_trunkdata.BANDWIDTH"));
        setRsvp_bandwidth(bean.get_String("igw_trunkdata.RSVP_BANDWIDTH"));
        setInternalMapData(bean.getInternalMapData());
    }

    // **************************** inner classes *********************************** //

    /**
     * Bean used to search
     */
    public class SearchBean extends Bean.SearchBean implements Serializable {
        private static final long serialVersionUID = 1L;
        protected final static String TRUNKDATA_ID = "TRUNKDATA_ID";
        protected final static String PARENT_TRUNKDATA = "PARENT_TRUNKDATA";
        protected final static String TRUNK_ID = "TRUNK_ID";
        protected final static String SIDE_SERVICE_ID = "SIDE_SERVICE_ID";
        protected final static String SIDE_NAME = "SIDE_NAME";
        protected final static String SIDE_SORT_NAME = "SIDE_SORT_NAME";
        protected final static String ROUTER_ID = "ROUTER_ID";
        protected final static String INTERFACES_ID = "INTERFACES_ID";
        protected final static String IPNET_POOL = "IPNET_POOL";
        protected final static String IPNET_ADDRESS = "IPNET_ADDRESS";
        protected final static String IPNET_SUBMASK = "IPNET_SUBMASK";
        protected final static String SIDE_DESCRIPTION = "SIDE_DESCRIPTION";
        protected final static String NEGO_FLAG = "NEGO_FLAG";
        protected final static String LINKPROTOCOL = "LINKPROTOCOL";
        protected final static String MTU = "MTU";
        protected final static String PIM_FLAG = "PIM_FLAG";
        protected final static String OSPFNET_TYPE_FLAG = "OSPFNET_TYPE_FLAG";
        protected final static String OSPF_COST = "OSPF_COST";
        protected final static String OSPF_PASSWORD = "OSPF_PASSWORD";
        protected final static String LDP_FLAG = "LDP_FLAG";
        protected final static String LDP_PASSWORD = "LDP_PASSWORD";
        protected final static String INTERFACE_DESCRIPTION = "INTERFACE_DESCRIPTION";
        protected final static String TRAFFIC_POLICYNAME = "TRAFFIC_POLICYNAME";
        protected final static String POLICY_TYPE = "POLICY_TYPE";
        protected final static String IPV6_POOL = "IPV6_POOL";
        protected final static String IPV6_ADDRESS = "IPV6_ADDRESS";
        protected final static String ENCAPSULATION = "ENCAPSULATION";
        protected final static String IPBINDING_FLAG = "IPBINDING_FLAG";
        protected final static String OSPF_PROCESSID = "OSPF_PROCESSID";
        protected final static String AREA = "AREA";
        protected final static String BANDWIDTH = "BANDWIDTH";
        protected final static String RSVP_BANDWIDTH = "RSVP_BANDWIDTH";
        protected final static int SEARCH_BEAN_SIZE = Bean.SearchBean.SEARCH_BEAN_SIZE +
            32;

        // ******************* Constructors *********************** //

        /**
         * Protected constructor, not for the user.
         * @param size number of fields of the bean
         */
        protected SearchBean(int size) {
            super(size);
        }

        public SearchBean() {
            super(SEARCH_BEAN_SIZE);
        }

        // ****************** Setters ******************** //

        /**
         * Set the TRUNKDATA_ID
         * @param _tRUNKDATA_ID "Primary key\n"
         */
        public void setTrunkdata_id(String _tRUNKDATA_ID) {
            data.put(TRUNKDATA_ID,
                from_String2SearchBeanQueryData(_tRUNKDATA_ID));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfTrunkdata_id(String comparator, String compareTo,
            String[] TRUNKDATA_IDs) {
            data.put(TRUNKDATA_ID,
                new QDDynString(comparator, compareTo, TRUNKDATA_IDs));
        }

        /**
         * Set the PARENT_TRUNKDATA
         * @param _pARENT_TRUNKDATA "Parent relationship for subinterface trunks\n"
         */
        public void setParent_trunkdata(String _pARENT_TRUNKDATA) {
            data.put(PARENT_TRUNKDATA,
                from_String2SearchBeanQueryData(_pARENT_TRUNKDATA));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfParent_trunkdata(String comparator,
            String compareTo, String[] PARENT_TRUNKDATAs) {
            data.put(PARENT_TRUNKDATA,
                new QDDynString(comparator, compareTo, PARENT_TRUNKDATAs));
        }

        /**
         * Set the TRUNK_ID
         * @param _tRUNK_ID "Foreign key\n"
         */
        public void setTrunk_id(String _tRUNK_ID) {
            data.put(TRUNK_ID, from_String2SearchBeanQueryData(_tRUNK_ID));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfTrunk_id(String comparator, String compareTo,
            String[] TRUNK_IDs) {
            data.put(TRUNK_ID, new QDDynString(comparator, compareTo, TRUNK_IDs));
        }

        /**
         * Set the SIDE_SERVICE_ID
         * @param _sIDE_SERVICE_ID "Trunk side ID\n"
         */
        public void setSide_service_id(String _sIDE_SERVICE_ID) {
            data.put(SIDE_SERVICE_ID,
                from_String2SearchBeanQueryData(_sIDE_SERVICE_ID));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfSide_service_id(String comparator, String compareTo,
            String[] SIDE_SERVICE_IDs) {
            data.put(SIDE_SERVICE_ID,
                new QDDynString(comparator, compareTo, SIDE_SERVICE_IDs));
        }

        /**
         * Set the SIDE_NAME
         * @param _sIDE_NAME "Name of the trunk side\n"
         */
        public void setSide_name(String _sIDE_NAME) {
            data.put(SIDE_NAME, from_String2SearchBeanQueryData(_sIDE_NAME));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfSide_name(String comparator, String compareTo,
            String[] SIDE_NAMEs) {
            data.put(SIDE_NAME,
                new QDDynString(comparator, compareTo, SIDE_NAMEs));
        }

        /**
         * Set the SIDE_SORT_NAME
         * @param _sIDE_SORT_NAME "Sort name of the trunk side\n"
         */
        public void setSide_sort_name(String _sIDE_SORT_NAME) {
            data.put(SIDE_SORT_NAME,
                from_String2SearchBeanQueryData(_sIDE_SORT_NAME));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfSide_sort_name(String comparator, String compareTo,
            String[] SIDE_SORT_NAMEs) {
            data.put(SIDE_SORT_NAME,
                new QDDynString(comparator, compareTo, SIDE_SORT_NAMEs));
        }

        /**
         * Set the ROUTER_ID
         * @param _rOUTER_ID "ROUTER ID\n"
         */
        public void setRouter_id(String _rOUTER_ID) {
            data.put(ROUTER_ID, from_String2SearchBeanQueryData(_rOUTER_ID));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfRouter_id(String comparator, String compareTo,
            String[] ROUTER_IDs) {
            data.put(ROUTER_ID,
                new QDDynString(comparator, compareTo, ROUTER_IDs));
        }

        /**
         * Set the INTERFACES_ID
         * @param _iNTERFACES_ID "INTERFACES ID\n"
         */
        public void setInterfaces_id(String _iNTERFACES_ID) {
            data.put(INTERFACES_ID,
                from_String2SearchBeanQueryData(_iNTERFACES_ID));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfInterfaces_id(String comparator, String compareTo,
            String[] INTERFACES_IDs) {
            data.put(INTERFACES_ID,
                new QDDynString(comparator, compareTo, INTERFACES_IDs));
        }

        /**
         * Set the IPNET_POOL
         * @param _iPNET_POOL "IP pool\n"
         */
        public void setIpnet_pool(String _iPNET_POOL) {
            data.put(IPNET_POOL, from_String2SearchBeanQueryData(_iPNET_POOL));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfIpnet_pool(String comparator, String compareTo,
            String[] IPNET_POOLs) {
            data.put(IPNET_POOL,
                new QDDynString(comparator, compareTo, IPNET_POOLs));
        }

        /**
         * Set the IPNET_ADDRESS
         * @param _iPNET_ADDRESS "IP address\n"
         */
        public void setIpnet_address(String _iPNET_ADDRESS) {
            data.put(IPNET_ADDRESS,
                from_String2SearchBeanQueryData(_iPNET_ADDRESS));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfIpnet_address(String comparator, String compareTo,
            String[] IPNET_ADDRESSs) {
            data.put(IPNET_ADDRESS,
                new QDDynString(comparator, compareTo, IPNET_ADDRESSs));
        }

        /**
         * Set the IPNET_SUBMASK
         * @param _iPNET_SUBMASK "IP submask\n"
         */
        public void setIpnet_submask(String _iPNET_SUBMASK) {
            data.put(IPNET_SUBMASK,
                from_String2SearchBeanQueryData(_iPNET_SUBMASK));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfIpnet_submask(String comparator, String compareTo,
            String[] IPNET_SUBMASKs) {
            data.put(IPNET_SUBMASK,
                new QDDynString(comparator, compareTo, IPNET_SUBMASKs));
        }

        /**
         * Set the SIDE_DESCRIPTION
         * @param _sIDE_DESCRIPTION "Description of the trunk side\n"
         */
        public void setSide_description(String _sIDE_DESCRIPTION) {
            data.put(SIDE_DESCRIPTION,
                from_String2SearchBeanQueryData(_sIDE_DESCRIPTION));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfSide_description(String comparator,
            String compareTo, String[] SIDE_DESCRIPTIONs) {
            data.put(SIDE_DESCRIPTION,
                new QDDynString(comparator, compareTo, SIDE_DESCRIPTIONs));
        }

        /**
         * Set the NEGO_FLAG
         * @param _nEGO_FLAG "Negotiation 'auto' should be true or false\n"
         */
        public void setNego_flag(String _nEGO_FLAG) {
            data.put(NEGO_FLAG, from_boolean2SearchBeanQueryData(_nEGO_FLAG));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfNego_flag(String comparator, String compareTo,
            String[] NEGO_FLAGs) {
            data.put(NEGO_FLAG,
                new QDDynboolean(comparator, compareTo, NEGO_FLAGs));
        }

        /**
         * Set the LINKPROTOCOL
         * @param _lINKPROTOCOL "Link protocol for the sides\n"
         */
        public void setLinkprotocol(String _lINKPROTOCOL) {
            data.put(LINKPROTOCOL,
                from_String2SearchBeanQueryData(_lINKPROTOCOL));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfLinkprotocol(String comparator, String compareTo,
            String[] LINKPROTOCOLs) {
            data.put(LINKPROTOCOL,
                new QDDynString(comparator, compareTo, LINKPROTOCOLs));
        }

        /**
         * Set the MTU
         * @param _mTU "MTU value by default should be 1700\n"
         */
        public void setMtu(String _mTU) {
            data.put(MTU, from_int2SearchBeanQueryData(_mTU));
        }

        // Methods for MTU range values

        /**
         * Sets a range of values for the MTU
         * @param start__mTU Start of the "MTU value by default should be 1700\n"
         * @param end__mTU End of the "MTU value by default should be 1700\n"
         */
        public void setMtu(String start__mTU, String end__mTU) {
            data.put(MTU, from_int2SearchBeanQueryData(start__mTU, end__mTU));
        }

        // End of methods for MTU range values
        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfMtu(String comparator, String compareTo,
            String[] MTUs) {
            data.put(MTU, new QDDynint(comparator, compareTo, MTUs));
        }

        /**
         * Set the PIM_FLAG
         * @param _pIM_FLAG "PIM 'sm' can be true or false\n"
         */
        public void setPim_flag(String _pIM_FLAG) {
            data.put(PIM_FLAG, from_boolean2SearchBeanQueryData(_pIM_FLAG));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfPim_flag(String comparator, String compareTo,
            String[] PIM_FLAGs) {
            data.put(PIM_FLAG,
                new QDDynboolean(comparator, compareTo, PIM_FLAGs));
        }

        /**
         * Set the OSPFNET_TYPE_FLAG
         * @param _oSPFNET_TYPE_FLAG "OSPF network type can be true or false\n"
         */
        public void setOspfnet_type_flag(String _oSPFNET_TYPE_FLAG) {
            data.put(OSPFNET_TYPE_FLAG,
                from_boolean2SearchBeanQueryData(_oSPFNET_TYPE_FLAG));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfOspfnet_type_flag(String comparator,
            String compareTo, String[] OSPFNET_TYPE_FLAGs) {
            data.put(OSPFNET_TYPE_FLAG,
                new QDDynboolean(comparator, compareTo, OSPFNET_TYPE_FLAGs));
        }

        /**
         * Set the OSPF_COST
         * @param _oSPF_COST "OSPF cost value by default should be 200\n"
         */
        public void setOspf_cost(String _oSPF_COST) {
            data.put(OSPF_COST, from_int2SearchBeanQueryData(_oSPF_COST));
        }

        // Methods for OSPF_COST range values

        /**
         * Sets a range of values for the OSPF_COST
         * @param start__oSPF_COST Start of the "OSPF cost value by default should be 200\n"
         * @param end__oSPF_COST End of the "OSPF cost value by default should be 200\n"
         */
        public void setOspf_cost(String start__oSPF_COST, String end__oSPF_COST) {
            data.put(OSPF_COST,
                from_int2SearchBeanQueryData(start__oSPF_COST, end__oSPF_COST));
        }

        // End of methods for OSPF_COST range values
        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfOspf_cost(String comparator, String compareTo,
            String[] OSPF_COSTs) {
            data.put(OSPF_COST, new QDDynint(comparator, compareTo, OSPF_COSTs));
        }

        /**
         * Set the OSPF_PASSWORD
         * @param _oSPF_PASSWORD "OSPF password\n"
         */
        public void setOspf_password(String _oSPF_PASSWORD) {
            data.put(OSPF_PASSWORD,
                from_String2SearchBeanQueryData(_oSPF_PASSWORD));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfOspf_password(String comparator, String compareTo,
            String[] OSPF_PASSWORDs) {
            data.put(OSPF_PASSWORD,
                new QDDynString(comparator, compareTo, OSPF_PASSWORDs));
        }

        /**
         * Set the LDP_FLAG
         * @param _lDP_FLAG "LDP value can be true or false\n"
         */
        public void setLdp_flag(String _lDP_FLAG) {
            data.put(LDP_FLAG, from_boolean2SearchBeanQueryData(_lDP_FLAG));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfLdp_flag(String comparator, String compareTo,
            String[] LDP_FLAGs) {
            data.put(LDP_FLAG,
                new QDDynboolean(comparator, compareTo, LDP_FLAGs));
        }

        /**
         * Set the LDP_PASSWORD
         * @param _lDP_PASSWORD "LDP password\n"
         */
        public void setLdp_password(String _lDP_PASSWORD) {
            data.put(LDP_PASSWORD,
                from_String2SearchBeanQueryData(_lDP_PASSWORD));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfLdp_password(String comparator, String compareTo,
            String[] LDP_PASSWORDs) {
            data.put(LDP_PASSWORD,
                new QDDynString(comparator, compareTo, LDP_PASSWORDs));
        }

        /**
         * Set the INTERFACE_DESCRIPTION
         * @param _iNTERFACE_DESCRIPTION "Interface description\n"
         */
        public void setInterface_description(String _iNTERFACE_DESCRIPTION) {
            data.put(INTERFACE_DESCRIPTION,
                from_String2SearchBeanQueryData(_iNTERFACE_DESCRIPTION));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfInterface_description(String comparator,
            String compareTo, String[] INTERFACE_DESCRIPTIONs) {
            data.put(INTERFACE_DESCRIPTION,
                new QDDynString(comparator, compareTo, INTERFACE_DESCRIPTIONs));
        }

        /**
         * Set the TRAFFIC_POLICYNAME
         * @param _tRAFFIC_POLICYNAME "Traffic policy for the sides\n"
         */
        public void setTraffic_policyname(String _tRAFFIC_POLICYNAME) {
            data.put(TRAFFIC_POLICYNAME,
                from_String2SearchBeanQueryData(_tRAFFIC_POLICYNAME));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfTraffic_policyname(String comparator,
            String compareTo, String[] TRAFFIC_POLICYNAMEs) {
            data.put(TRAFFIC_POLICYNAME,
                new QDDynString(comparator, compareTo, TRAFFIC_POLICYNAMEs));
        }

        /**
         * Set the POLICY_TYPE
         * @param _pOLICY_TYPE "Policy type can be inbond and outbound for the sides\n"
         */
        public void setPolicy_type(String _pOLICY_TYPE) {
            data.put(POLICY_TYPE, from_String2SearchBeanQueryData(_pOLICY_TYPE));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfPolicy_type(String comparator, String compareTo,
            String[] POLICY_TYPEs) {
            data.put(POLICY_TYPE,
                new QDDynString(comparator, compareTo, POLICY_TYPEs));
        }

        /**
         * Set the IPV6_POOL
         * @param _iPV6_POOL "Ipv6 pool\n"
         */
        public void setIpv6_pool(String _iPV6_POOL) {
            data.put(IPV6_POOL, from_String2SearchBeanQueryData(_iPV6_POOL));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfIpv6_pool(String comparator, String compareTo,
            String[] IPV6_POOLs) {
            data.put(IPV6_POOL,
                new QDDynString(comparator, compareTo, IPV6_POOLs));
        }

        /**
         * Set the IPV6_ADDRESS
         * @param _iPV6_ADDRESS "Ipv6 address\n"
         */
        public void setIpv6_address(String _iPV6_ADDRESS) {
            data.put(IPV6_ADDRESS,
                from_String2SearchBeanQueryData(_iPV6_ADDRESS));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfIpv6_address(String comparator, String compareTo,
            String[] IPV6_ADDRESSs) {
            data.put(IPV6_ADDRESS,
                new QDDynString(comparator, compareTo, IPV6_ADDRESSs));
        }

        /**
         * Set the ENCAPSULATION
         * @param _eNCAPSULATION "Encapsulation should be dot1q if subinterfaces for the sides\n"
         */
        public void setEncapsulation(String _eNCAPSULATION) {
            data.put(ENCAPSULATION,
                from_String2SearchBeanQueryData(_eNCAPSULATION));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfEncapsulation(String comparator, String compareTo,
            String[] ENCAPSULATIONs) {
            data.put(ENCAPSULATION,
                new QDDynString(comparator, compareTo, ENCAPSULATIONs));
        }

        /**
         * Set the IPBINDING_FLAG
         * @param _iPBINDING_FLAG "IP Binding value can be true or false\n"
         */
        public void setIpbinding_flag(String _iPBINDING_FLAG) {
            data.put(IPBINDING_FLAG,
                from_boolean2SearchBeanQueryData(_iPBINDING_FLAG));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfIpbinding_flag(String comparator, String compareTo,
            String[] IPBINDING_FLAGs) {
            data.put(IPBINDING_FLAG,
                new QDDynboolean(comparator, compareTo, IPBINDING_FLAGs));
        }

        /**
         * Set the OSPF_PROCESSID
         * @param _oSPF_PROCESSID "OSPF_PROCESSID value default 100\n"
         */
        public void setOspf_processid(String _oSPF_PROCESSID) {
            data.put(OSPF_PROCESSID,
                from_int2SearchBeanQueryData(_oSPF_PROCESSID));
        }

        // Methods for OSPF_PROCESSID range values

        /**
         * Sets a range of values for the OSPF_PROCESSID
         * @param start__oSPF_PROCESSID Start of the "OSPF_PROCESSID value default 100\n"
         * @param end__oSPF_PROCESSID End of the "OSPF_PROCESSID value default 100\n"
         */
        public void setOspf_processid(String start__oSPF_PROCESSID,
            String end__oSPF_PROCESSID) {
            data.put(OSPF_PROCESSID,
                from_int2SearchBeanQueryData(start__oSPF_PROCESSID,
                    end__oSPF_PROCESSID));
        }

        // End of methods for OSPF_PROCESSID range values
        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfOspf_processid(String comparator, String compareTo,
            String[] OSPF_PROCESSIDs) {
            data.put(OSPF_PROCESSID,
                new QDDynint(comparator, compareTo, OSPF_PROCESSIDs));
        }

        /**
         * Set the AREA
         * @param _aREA "AREA value\n"
         */
        public void setArea(String _aREA) {
            data.put(AREA, from_String2SearchBeanQueryData(_aREA));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfArea(String comparator, String compareTo,
            String[] AREAs) {
            data.put(AREA, new QDDynString(comparator, compareTo, AREAs));
        }

        /**
         * Set the BANDWIDTH
         * @param _bANDWIDTH "BANDWIDTH value\n"
         */
        public void setBandwidth(String _bANDWIDTH) {
            data.put(BANDWIDTH, from_String2SearchBeanQueryData(_bANDWIDTH));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfBandwidth(String comparator, String compareTo,
            String[] BANDWIDTHs) {
            data.put(BANDWIDTH,
                new QDDynString(comparator, compareTo, BANDWIDTHs));
        }

        /**
         * Set the RSVP_BANDWIDTH
         * @param _rSVP_BANDWIDTH "RSVP_BANDWIDTH value\n"
         */
        public void setRsvp_bandwidth(String _rSVP_BANDWIDTH) {
            data.put(RSVP_BANDWIDTH,
                from_String2SearchBeanQueryData(_rSVP_BANDWIDTH));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfRsvp_bandwidth(String comparator, String compareTo,
            String[] RSVP_BANDWIDTHs) {
            data.put(RSVP_BANDWIDTH,
                new QDDynString(comparator, compareTo, RSVP_BANDWIDTHs));
        }
    }
}
