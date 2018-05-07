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


public class igw_qos_ extends CommonBean implements Serializable {
    protected static String[] searchableFieldNames;
    protected static Field[] fields = new Field[3];
    protected static Map field_label_key_equivalency = new HashMap(3 * 3);
    protected static Map field_label_column_equivalency = new HashMap(3 * 3);
    private static ClassLoader class_loader = com.hp.ov.activator.vpn.inventory.igw_qos.class.getClassLoader();
    public static final String ORIGINAL_TABLE = "igw_qos";
    public static final String HISTORY_TABLE = "igw_qosHist";
    public static final String TABLE_ALIAS = "igw_qos";

    // *************************** static init section **************************** //
    static {
        Bean.setIsOracle(true);

        // Filling the searchable fields
        searchableFieldNames = new String[2];
        searchableFieldNames[0] = "NAME";
        searchableFieldNames[1] = "COMMANDS";

        // Filling fields information
        fields[0] = new Field("QOS_ID", "String", null, "Primary key\n", true,
                true, false, true, false && false /* old readOnly */    , true,
                false);
        fields[1] = new Field("NAME", "String", null, "QOS Name\n", true, true,
                false, true, true && true /* old readOnly */    , false, false);
        fields[2] = new Field("COMMANDS", "String", null,
                "QOS commands to be executed\n", true, true, false, true,
                true && true /* old readOnly */    , false, false);

        // Filling the equivalence field label / field data key access
        field_label_key_equivalency.put("QOS_ID", "igw_qos.QOS_ID");
        field_label_key_equivalency.put("NAME", "igw_qos.NAME");
        field_label_key_equivalency.put("COMMANDS", "igw_qos.COMMANDS");

        // Filling the equivalence field label / field column
        field_label_column_equivalency.put("QOS_ID", "QOS_ID");
        field_label_column_equivalency.put("NAME", "NAME");
        field_label_column_equivalency.put("COMMANDS", "COMMANDS");
    }

    // ********************************* Fields ************************************ //
    protected String QOS_ID;
    protected boolean QOS_ID_seq_nextVal = false;
    protected String NAME;
    protected String COMMANDS;

    // ****************************** Constructors *********************************** //

    /**
     * Default constructor.
     */
    public igw_qos_() {
        super();
        initDefault();
        initMandatory();
    }

    /**
     * Constructor
     * TODO generate the params.
     */
    public igw_qos_(String _qOS_ID, String _nAME, String _cOMMANDS) {
        super();

        //Init Reservables
        setQos_id(_qOS_ID);
        setName(_nAME);
        setCommands(_cOMMANDS);

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
     * Findby for the key QOS_ID with full options
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

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
    public static igw_qos findByQos_id(Connection con, String _qOS_ID,
        Map parameters) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_qos.QOS_ID", new QDString(_qOS_ID));

        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        igw_qos[] result = fromBeanArray2igw_qosArray(con,
                findBy(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
                    "QOS_ID", fieldsMap, parameters), history);

        if (result == null) {
            return null;
        } else {
            return result[0];
        }
    }

    /**
     * Findby for the key QOS_ID without pagination.
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByQos_id(Connection con, String _qOS_ID,
        String addlnWhereClause, String addlnFromClause, boolean bHistory)
        throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByQos_id(con, _qOS_ID, parameters);
    }

    /**
     * Count by the key QOS_ID with full options
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

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
    public static int findByQos_idCount(Connection con, String _qOS_ID,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_qos.QOS_ID", new QDString(_qOS_ID));

        return countBy(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            "QOS_ID", fieldsMap, parameters);
    }

    /**
     * Count for the key QOS_ID with full options
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByQos_idCount(Connection con, String _qOS_ID,
        String addlnWhereClause, String addlnFromClause, boolean bHistory)
        throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByQos_idCount(con, _qOS_ID, parameters);
    }

    /**
     * Findby for the key QOS_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByQos_id(Connection con, String _qOS_ID,
        String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByQos_id(con, _qOS_ID, addlnWhereClause, addlnFromClause,
            false);
    }

    /**
     * Count for the key QOS_ID with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByQos_idCount(Connection con, String _qOS_ID,
        String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByQos_idCount(con, _qOS_ID, addlnWhereClause,
            addlnFromClause, false);
    }

    /**
     * Findby for the key QOS_ID with extra where clause
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @param addlnWhereClause user added where clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByQos_id(Connection con, String _qOS_ID,
        String addlnWhereClause) throws SQLException {
        return findByQos_id(con, _qOS_ID, addlnWhereClause, null, false);
    }

    /**
     * Count for the key QOS_ID with extra where clause
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @param addlnWhereClause user added where clause
     * @return int with result count.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByQos_idCount(Connection con, String _qOS_ID,
        String addlnWhereClause) throws SQLException {
        return findByQos_idCount(con, _qOS_ID, addlnWhereClause, null, false);
    }

    /**
     * Findby for the key QOS_ID.
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByQos_id(Connection con, String _qOS_ID)
        throws SQLException {
        return findByQos_id(con, _qOS_ID, null, null, false);
    }

    /**
     * Count for the key QOS_ID.
     * @param con Connection to the DB
           * @param String _qOS_ID  value to do the search for the field QOS_ID

     * @return int with the array count
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByQos_idCount(Connection con, String _qOS_ID)
        throws SQLException {
        return findByQos_idCount(con, _qOS_ID, null, null, false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
           * @param String _qOS_ID  value to do the search for the field QOS_ID

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
    public static int findByQos_idRownumValue(Connection con, String _qOS_ID,
        IndexOfExpressionBean indexOfExpressionBean, Map parameters)
        throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_qos.QOS_ID", new QDString(_qOS_ID));

        return findIndex(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            "QOS_ID", fieldsMap, indexOfExpressionBean, parameters);
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
            result = findByQos_idCount(con, from_String2String(keyFields[0]),
                    null, null, history);
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
    public static igw_qos findByPrimaryKey(Connection con, String primaryKey,
        boolean history) throws SQLException {
        if (primaryKey == null) {
            return null;
        }

        String[] keyFields = primaryKey.split(PRIMARY_KEY_SEPARATOR_REG_EXP);
        igw_qos result = null;

        try {
            result = findByQos_id(con, from_String2String(keyFields[0]), null,
                    null, history);
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
    public static igw_qos findByPrimaryKey(Connection con, String primaryKey)
        throws SQLException {
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
        fieldsMap.put("igw_qos.QOS_ID", new QDString(getQos_id()));

        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        return findIsParent(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            "QOS_ID", fieldsMap, parameters);
    }

    /**
     * Findby for the key NAME with full options
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

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
    public static igw_qos findByName(Connection con, String _nAME,
        Map parameters) throws SQLException {
        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_qos.NAME", new QDString(_nAME));

        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        igw_qos[] result = fromBeanArray2igw_qosArray(con,
                findBy(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
                    "NAME", fieldsMap, parameters), history);

        if (result == null) {
            return null;
        } else {
            return result[0];
        }
    }

    /**
     * Findby for the key NAME without pagination.
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByName(Connection con, String _nAME,
        String addlnWhereClause, String addlnFromClause, boolean bHistory)
        throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByName(con, _nAME, parameters);
    }

    /**
     * Count by the key NAME with full options
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

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
    public static int findByNameCount(Connection con, String _nAME,
        Map parameters) throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_qos.NAME", new QDString(_nAME));

        return countBy(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            "NAME", fieldsMap, parameters);
    }

    /**
     * Count for the key NAME with full options
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @param bHistory true if want to do the search in the history table instead the normal one.
     * @return count of the number of results
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByNameCount(Connection con, String _nAME,
        String addlnWhereClause, String addlnFromClause, boolean bHistory)
        throws SQLException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_EXTRA_FROM_CLAUSE, addlnFromClause);
        parameters.put(PARAMETER_EXTRA_WHERE_CLAUSE, addlnWhereClause);
        parameters.put(PARAMETER_HISTORY, new Boolean(bHistory));

        return findByNameCount(con, _nAME, parameters);
    }

    /**
     * Findby for the key NAME with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByName(Connection con, String _nAME,
        String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByName(con, _nAME, addlnWhereClause, addlnFromClause, false);
    }

    /**
     * Count for the key NAME with extra from and where clauses.
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @param addlnWhereClause user added where clause
     * @param addlnFromClause user added from clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByNameCount(Connection con, String _nAME,
        String addlnWhereClause, String addlnFromClause)
        throws SQLException {
        return findByNameCount(con, _nAME, addlnWhereClause, addlnFromClause,
            false);
    }

    /**
     * Findby for the key NAME with extra where clause
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @param addlnWhereClause user added where clause
     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByName(Connection con, String _nAME,
        String addlnWhereClause) throws SQLException {
        return findByName(con, _nAME, addlnWhereClause, null, false);
    }

    /**
     * Count for the key NAME with extra where clause
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @param addlnWhereClause user added where clause
     * @return int with result count.
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByNameCount(Connection con, String _nAME,
        String addlnWhereClause) throws SQLException {
        return findByNameCount(con, _nAME, addlnWhereClause, null, false);
    }

    /**
     * Findby for the key NAME.
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @return array with the results.
     * @throws SQLException on an error accessing to the DB
     */
    public static igw_qos findByName(Connection con, String _nAME)
        throws SQLException {
        return findByName(con, _nAME, null, null, false);
    }

    /**
     * Count for the key NAME.
     * @param con Connection to the DB
           * @param String _nAME  value to do the search for the field NAME

     * @return int with the array count
     * @throws SQLException on an error accessing to the DB
     */
    public static int findByNameCount(Connection con, String _nAME)
        throws SQLException {
        return findByNameCount(con, _nAME, null, null, false);
    }

    /**
     * Finds the index of the given query.
     * @param con
     *          Connection
           * @param String _nAME  value to do the search for the field NAME

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
    public static int findByNameRownumValue(Connection con, String _nAME,
        IndexOfExpressionBean indexOfExpressionBean, Map parameters)
        throws SQLException {
        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        HashMap fieldsMap = new HashMap(1 * 2);
        fieldsMap.put("igw_qos.NAME", new QDString(_nAME));

        return findIndex(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            "NAME", fieldsMap, indexOfExpressionBean, parameters);
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
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperQos_id(
        igw_qos.SearchBean searchBean, Map operation_parameters) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_qos");
        result.setKeyName("Qos_id");

        // Mixing the searchBean parameter with the @order parameters
        Map search_parameters = searchBean.getInternSearchBeanData();

        // Adding @order parameters
        result.setParameters(search_parameters);

        try {
            result.setOperation_parameters(operation_parameters);
        } catch (ParameterException e) {
            throw new RuntimeException(
                "Error in the linkedSearchParameterWrapperQos_id sql query parameters: " +
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
    public static LinkedSearchParameterWrapper linkedSearchParameterWrapperQos_id(
        igw_qos.SearchBean searchBean, boolean advancedSearch) {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));

        return linkedSearchParameterWrapperQos_id(searchBean, parameters);
    }

    /**
     * count version of linkedSearch{foreign_key_field}
     * @param con Connection to the DB
     * @param searchBean Object that contains the conditions of the search. It has every field of the bean and if one
     * field is null then the select will not add a condition for that field.
     * @return number of results of the normal search.
     *
     */
    public static int linkedSearchQos_idCount(Connection con,
        List linkedSearchParameters, igw_qos.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperQos_id(searchBean,
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
    public static igw_qos[] linkedSearchQos_id(Connection con,
        List linkedSearchParameters, igw_qos.SearchBean searchBean,
        boolean advancedSearch, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        parameters.put(PARAMETER_ADVANCED, new Boolean(advancedSearch));
        parameters.put(PARAMETER_STARTING_INDEX, new Integer(1));
        parameters.put(PARAMETER_NUMBER_OF_RESULTS, new Integer(maxResults));

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperQos_id(searchBean,
                advancedSearch);

        return fromBeanArray2igw_qosArray(con,
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
    public static igw_qos[] linkedSearchQos_id(Connection con,
        List linkedSearchParameters, igw_qos.SearchBean searchBean,
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

        LinkedSearchParameterWrapper parameterWrapper = linkedSearchParameterWrapperQos_id(searchBean,
                advanced);

        return fromBeanArray2igw_qosArray(con,
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
        igw_qos.SearchBean searchBean, boolean advancedSearch) {
        return linkedSearchParameterWrapperQos_id(searchBean, advancedSearch);
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
        List linkedSearchParameters, igw_qos.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        return linkedSearchQos_idCount(con, linkedSearchParameters, searchBean);
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
    public static igw_qos[] linkedSearchPrimaryKey(Connection con,
        List linkedSearchParameters, igw_qos.SearchBean searchBean,
        boolean advancedSearch, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return linkedSearchQos_id(con, linkedSearchParameters, searchBean,
            advancedSearch, maxResults);
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
    public static igw_qos[] linkedSearchPrimaryKey(Connection con,
        List linkedSearchParameters, igw_qos.SearchBean searchBean,
        Map parameters)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return linkedSearchQos_id(con, linkedSearchParameters, searchBean,
            parameters);
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
    public static igw_qos[] findAll(Connection con, Map parameters)
        throws SQLException {
        Boolean bHistory = (Boolean) parameters.get(PARAMETER_HISTORY);
        boolean history = (bHistory == null) ? false : bHistory.booleanValue();

        if ((parameters != null) &&
                !parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_qosArray(con,
            findAll(con, "com.hp.ov.activator.vpn.inventory.igw_qos", parameters),
            history);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @param addlnFromClause Extra from clause
     * @param history true if want to make the search in the history tables.
     * @return array with the results.
     */
    public static igw_qos[] findAll(Connection con, String addlnWhereClause,
        String addlnFromClause, boolean history) throws SQLException {
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
    public static igw_qos[] findAll(Connection con, String addlnWhereClause,
        String addlnFromClause) throws SQLException {
        return findAll(con, addlnWhereClause, addlnFromClause, false);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @param addlnWhereClause Extra where clause
     * @return array with the results.
     */
    public static igw_qos[] findAll(Connection con, String addlnWhereClause)
        throws SQLException {
        return findAll(con, addlnWhereClause, null, false);
    }

    /**
     * Finds all the entries in the table.
     * @param con Connection
     * @return array with the results.
     */
    public static igw_qos[] findAll(Connection con) throws SQLException {
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

        return countAll(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
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

        return findIndex(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
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
    public static int searchCount(Connection con, igw_qos.SearchBean searchBean)
        throws SQLException, LobUsedForSearchException {
        Map parameters = new HashMap();
        parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);

        return countSearch(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
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
    public static igw_qos[] search(Connection con, igw_qos.SearchBean searchBean)
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
    public static igw_qos[] search(Connection con,
        igw_qos.SearchBean searchBean, boolean advanced)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return fromBeanArray2igw_qosArray(con,
            limitedSearch(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
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
    public static igw_qos[] search(Connection con,
        igw_qos.SearchBean searchBean, boolean advanced, int maxResults)
        throws SQLException, ExceededNumberOfRowsException, 
            LobUsedForSearchException {
        return fromBeanArray2igw_qosArray(con,
            limitedSearch(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
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
    public static igw_qos[] search(Connection con,
        igw_qos.SearchBean searchBean, Map parameters)
        throws SQLException, LobUsedForSearchException {
        if (!parameters.containsKey(PARAMETER_JSQL_CLASSLOADER)) {
            parameters.put(PARAMETER_JSQL_CLASSLOADER, class_loader);
        }

        return fromBeanArray2igw_qosArray(con,
            search(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
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
        igw_qos.SearchBean searchBean, boolean advanced) {
        LinkedSearchParameterWrapperImpl result = new LinkedSearchParameterWrapperImpl();
        result.setBeanName("com.hp.ov.activator.vpn.inventory.igw_qos");
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
        String[] result = new String[3];
        Object temp_data = null;
        temp_data = convert2Object(getQos_id());
        result[0] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getName());
        result[1] = (temp_data == null) ? null : temp_data.toString();
        temp_data = convert2Object(getCommands());
        result[2] = (temp_data == null) ? null : temp_data.toString();

        return result;
    }

    /**
     * Returns info about the fields that are contained by the beans.
     */
    public Field[] get_Fields() {
        // Done this way because is generated by velocity
        Object temp_data = null;
        temp_data = convert2Object(getQos_id());
        fields[0].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getName());
        fields[1].setValue((temp_data == null) ? null : temp_data.toString());
        temp_data = convert2Object(getCommands());
        fields[2].setValue((temp_data == null) ? null : temp_data.toString());

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

        if (field.equals("QOS_ID")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("NAME")) {
            fieldInfo[0] = "String";
            fieldInfo[1] = null;

            return fieldInfo;
        }

        if (field.equals("COMMANDS")) {
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

        if (fieldName.equalsIgnoreCase("QOS_ID")) {
            return "QOS_ID";
        }

        if (fieldName.equalsIgnoreCase("NAME")) {
            return "NAME";
        }

        if (fieldName.equalsIgnoreCase("COMMANDS")) {
            return "COMMANDS";
        }

        return null;
    }

    /**
     * Set the QOS_ID
     * @param _qOS_ID "Primary key\n"
     */
    public void setQos_id(String _qOS_ID) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_qos as it's read only");
        }

        this.QOS_ID = _qOS_ID;
    }

    /**
     * Returns the "Primary key\n"
     * @return the "Primary key\n"
     */
    public String getQos_id() {
        return this.QOS_ID;
    }

    /**
     * Returns the description of the field QOS_ID.
     * @return a String with the description of the field QOS_ID or null if there is not description.
     */
    public String getQos_idDescription() {
        return "Primary key\n";
    }

    /**
     * Set the NAME
     * @param _nAME "QOS Name\n"
     */
    public void setName(String _nAME) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_qos as it's read only");
        }

        this.NAME = _nAME;
    }

    /**
     * Returns the "QOS Name\n"
     * @return the "QOS Name\n"
     */
    public String getName() {
        return this.NAME;
    }

    /**
     * Returns the description of the field NAME.
     * @return a String with the description of the field NAME or null if there is not description.
     */
    public String getNameDescription() {
        return "QOS Name\n";
    }

    /**
     * Set the COMMANDS
     * @param _cOMMANDS "QOS commands to be executed\n"
     */
    public void setCommands(String _cOMMANDS) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_qos as it's read only");
        }

        this.COMMANDS = _cOMMANDS;
    }

    /**
     * Returns the "QOS commands to be executed\n"
     * @return the "QOS commands to be executed\n"
     */
    public String getCommands() {
        return this.COMMANDS;
    }

    /**
     * Returns the description of the field COMMANDS.
     * @return a String with the description of the field COMMANDS or null if there is not description.
     */
    public String getCommandsDescription() {
        return "QOS commands to be executed\n";
    }

    /* (non-Javadoc)
     * @see com.hp.ov.activator.inventory.Reservable#getPrimaryKey()
     */
    public String getPrimaryKey() {
        return "" + getQos_id();
    }

    /**
     * Sets the primary key.
     * @param pk String with the primary key fields separated by PRIMARY_KEY_SEPARATOR
     */
    public void setPrimaryKey(String pk) {
        if (isReadOnly()) {
            throw new RuntimeException(
                "You cannot modify the object igw_qos as it's read only");
        }

        String[] keyFields = pk.split(PRIMARY_KEY_SEPARATOR_REG_EXP);
        setQos_id(from_String2String(keyFields[0]));
    }

    /**
     * Returns the fields that compose the primary key.
     * @param Vector (QueryData) with the fields that compose the primary key
     */
    protected Vector getPrimaryKeyFields() {
        Vector v = new Vector();
        v.add(new QDString(getQos_id()));

        return v;
    }

    /**
     * Returns the name of the fields that compose the primary key.
     * @param Vector (String) with the name of the fields that compose the primary key
     */
    public Vector getPrimaryKeyFieldsNames() {
        Vector v = new Vector();
        v.add("QOS_ID");

        return v;
    }

    /**
     * Returns the name of the fields that compose the primary key. Static version of getPrimaryKeyFieldsNames (not removed for compatibility)
     * @param Vector (String) with the name of the fields that compose the primary key
     */
    public static Vector getPrimaryKeyFieldsNamesStatic() {
        Vector v = new Vector();
        v.add("QOS_ID");

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

        store(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            new QueryData[] {
                new QDString(getNextSequenceValue_QOS_ID(con)),
                new QDString(getName()), new QDString(getCommands()),
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

        store(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            new QueryData[] {
                new QDString(getNextSequenceValue_QOS_ID(con)),
                new QDString(getName()), new QDString(getCommands()),
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
                    new QDString(getName()), new QDString(getCommands()),
                    new QDString(getQos_id())
                };

            update(con, "com.hp.ov.activator.vpn.inventory.igw_qos", values,
                false, false, class_loader);
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
        return igw_qos_._deleteStatic(con, primary_key, false, (Map) null);
    }

    /**
     * Deletes the bean in the DB
     * @param con Connection
     * @param parameters
     *          Map of parameters. No parameters accepted at the moment. Used for future new parameters.
     */
    public static boolean delete(Connection con, String primary_key,
        Map parameters) throws SQLException {
        return igw_qos_._deleteStatic(con, primary_key, false, parameters);
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
        igw_qos_ to_delete = (igw_qos_) igw_qos_.findByPrimaryKey(con,
                primary_key, history);

        if (to_delete == null) {
            throw new SQLException("><Not found bean igw_qos with primary key " +
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

            QueryData[] primaryKeys = new QueryData[] { new QDString(getQos_id()) };

            result = delete(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
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

        Bean.updateIsParent(con, "com.hp.ov.activator.vpn.inventory.igw_qos",
            is_parent_value,
            new QueryData[] { new QDString(from_String2String(keyFields[0])) },
            class_loader);
    }

    /**
     * Method that returns the next value of this bean's sequence. It is only possible to have
     * one sequence per bean. The value is recovered from the DB just once. The flag QOS_ID_seq_nextVal tells
     * whether the sequence value has been already recovered.
     * @param con DB connection
     * @return the next value for the igw_qos_SEQ sequence
     */
    protected String getNextSequenceValue_QOS_ID(Connection con) {
        //      if(! QOS_ID_seq_nextVal ) { //If QOS_ID_seq_nextVal == true we have already found the value of the nextValue
        this.QOS_ID = getNextSequenceValueString(con, "igw_qos_SEQ");

        //        this.QOS_ID_seq_nextVal = true;
        //      } 
        return this.QOS_ID;
    }

    /**
     * Returns the actual value of the sequence (if null it calls for the next sequence) as a QueryData object,
     * so can be injected directly in the store. It not recovers a new sequence parameter, it's the user duty to
     * do this.
     * @return the sequence actual value in QueryData form.
     */
    protected QueryData getQueryDataSequenceValue_QOS_ID() {
        return new QDString(this.QOS_ID);
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

        if ((getName() == null) || getName().equals("")) {
            v.addElement("NAME");
        }

        if ((getCommands() == null) || getCommands().equals("")) {
            v.addElement("COMMANDS");
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

        describe = describe + " QOS_ID[" + getQos_id() + "] ";
        describe = describe + " NAME[" + getName() + "] ";
        describe = describe + " COMMANDS[" + getCommands() + "] ";

        return describe;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    public int hashCode() {
        return QDString.hashCode(getQos_id());
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
    protected static igw_qos[] _execFindBy(PreparedStatement pstmt)
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
    protected static igw_qos[] _execFindBy(PreparedStatement pstmt,
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

                    v.add(new igw_qos(var1, var2, var3));
                } while (rset.next());

                igw_qos[] resultArray = new igw_qos[v.size()];
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

        sbSqlCode.append("select " + "igw_qos" + ".QOS_ID" + ", " + "igw_qos" +
            ".NAME" + ", " + "igw_qos" + ".COMMANDS");

        return sbSqlCode.toString() + " ";
    }

    /**
     * Don't deserve to be documented
     * @deprecated for ib 4.0 compatibility. It will disappear in the future.
     */
    protected static String _composeFromClause() {
        StringBuffer sbSqlCode = new StringBuffer("From ");

        sbSqlCode.append("igw_qos");

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
        newData.put("igw_qos.QOS_ID", convert2Object(this.getQos_id()));
        newData.put("igw_qos.NAME", convert2Object(this.getName()));
        newData.put("igw_qos.COMMANDS", convert2Object(this.getCommands()));

        return newData;
    }

    // ******************************** protected *********************************** //

    /**
     * Cast an array of Bean to an array of igw_qos. This method is needed for compatibility
     * reasons, it could just let return Bean[] and do the casting to the object needed.
     * @param con Connection for recover extra info of the DB like the instance extended attributes
     * @param beans array of Bean to be casted
     * @return array of igw_qos
     * @throws SQLException
     */
    protected static igw_qos[] fromBeanArray2igw_qosArray(Connection con,
        Bean[] beans) throws SQLException {
        return (igw_qos[]) fromBeanArray2igw_qosArray(con, beans, false);
    }

    /**
     * Cast an array of Bean to an array of igw_qos. This method is needed for compatibility
     * reasons, it could just let return Bean[] and do the casting to the object needed.
     * @param con Connection for recover extra info of the DB like the instance extended attributes
     * @param beans array of Bean to be casted
     * @param boolean says whether the bean is a History bean (needed for instance attributes)
     * @return array of igw_qos
     * @throws SQLException
     */
    protected static igw_qos[] fromBeanArray2igw_qosArray(Connection con,
        Bean[] beans, boolean history) throws SQLException {
        if (beans.length == 0) {
            return null;
        } else {
            igw_qos[] castedBeans = new igw_qos[beans.length];

            for (int x = 0; x < beans.length; x++) {
                castedBeans[x] = new igw_qos();
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
        setQos_id(bean.get_String("igw_qos.QOS_ID"));
        setName(bean.get_String("igw_qos.NAME"));
        setCommands(bean.get_String("igw_qos.COMMANDS"));
        setInternalMapData(bean.getInternalMapData());
    }

    // **************************** inner classes *********************************** //

    /**
     * Bean used to search
     */
    public class SearchBean extends Bean.SearchBean implements Serializable {
        private static final long serialVersionUID = 1L;
        protected final static String QOS_ID = "QOS_ID";
        protected final static String NAME = "NAME";
        protected final static String COMMANDS = "COMMANDS";
        protected final static int SEARCH_BEAN_SIZE = Bean.SearchBean.SEARCH_BEAN_SIZE +
            3;

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
         * Set the QOS_ID
         * @param _qOS_ID "Primary key\n"
         */
        public void setQos_id(String _qOS_ID) {
            data.put(QOS_ID, from_String2SearchBeanQueryData(_qOS_ID));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfQos_id(String comparator, String compareTo,
            String[] QOS_IDs) {
            data.put(QOS_ID, new QDDynString(comparator, compareTo, QOS_IDs));
        }

        /**
         * Set the NAME
         * @param _nAME "QOS Name\n"
         */
        public void setName(String _nAME) {
            data.put(NAME, from_String2SearchBeanQueryData(_nAME));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfName(String comparator, String compareTo,
            String[] NAMEs) {
            data.put(NAME, new QDDynString(comparator, compareTo, NAMEs));
        }

        /**
         * Set the COMMANDS
         * @param _cOMMANDS "QOS commands to be executed\n"
         */
        public void setCommands(String _cOMMANDS) {
            data.put(COMMANDS, from_String2SearchBeanQueryData(_cOMMANDS));
        }

        // Configurable setters

        /**
         * Set a user defined comparison
         * @param comparator comparator, it could be LIKE, BETWEEN or whatever
         * @param comparateTo String to compare to, it could be "?", "? AND ?" or whatever.
         * @param values values for the ? parameters of the compareTo string. The length has to be the same as the number of ?
         * in the compareTo string.
         */
        public void setConfCommands(String comparator, String compareTo,
            String[] COMMANDSs) {
            data.put(COMMANDS, new QDDynString(comparator, compareTo, COMMANDSs));
        }
    }
}
