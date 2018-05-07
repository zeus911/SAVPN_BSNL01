/**************************************************************************************************/
/*                                      HashMap object                                            */
/**************************************************************************************************/

/**************************************************************************************************/
/* Dependencies:                                                                                  */
/*   - Collection                                                                                 */
/*   - Set                                                                                        */
/**************************************************************************************************/


/**
 * PROTECTED Constructor
 * Each key - value pair of the HashMap object is stored under this structure.
 * @param (Object) key the key of the associated value.
 * @param (Object) value the value associated to the key.
 */
function HashMapEntry(key, value) {
	this.key = key;
	this.value = value;
}

/**
 * PUBLIC Constructor
 * HashMap object developed in JavaScript with almost the same performing of the original
 * Java object.
 */
function HashMap() {
	var hm = new Array();
	/**
	 * PUBLIC
	 * Removes every key - value pair from this HashMap.
	 */
	this.clear = function clearHashMap() {
		hm.splice(0, hm.length);
	}
	/**
	 * PUBLIC
	 * Returns true if this HashMap contains a mapping for the specified key.
	 * @param (Object) key key whose presence in this HashMap is to be tested.
	 * return (boolean) true if this HashMap contains a mapping for the specified key.
	 */
	this.containsKey = function containsKeyHashMap(key) {
		var i;
		for (i = 0; i < hm.length && hm[i].key != key; i++) ;
		return i < hm.length;
	}
	/**
	 * PUBLIC
	 * Returns true if this HashMap maps one key to the specified value.
	 * @param (Object) value value whose presence in this HashMap is to be tested.
	 * return (boolean) true if this HashMap maps one key to the specified value.
	 */
	this.containsValue = function containsValueHashMap(value) {
		var i;
		for (i = 0; i < hm.length && hm[i].value != value; i++) ;
		return i < hm.length;
	}
	/**
	 * PUBLIC
	 * Returns a Set view of the keys contained in this HashMap.
	 * return (Set) a Set view of the keys contained in this HashMap.
	 */
	this.keySet = function keySetOfHashMap() {
		var set = new Set();
		for (var i = 0; i < hm.length; i++) {
			set.add(hm[i].key);
		}
		return set;
	}
	/**
	 * PUBLIC
	 * Returns the value to which this HashMap maps the specified key. Returns null if
	 * the HashMap contains no mapping for this key. A return value of null does not
	 * necessarily indicate that the HashMap contains no mapping for the key; it's also
	 * possible that the HashMap explicitly maps the key to null. The containsKey
	 * operation may be used to distinguish these two cases.
	 * @param (Object) key key whose associated value is to be returned.
	 * return (Object) the value to which this HashMap maps the specified key.
	 */
	this.get = function getHashMapEntry(key) {
		var i;
		for (i = 0; i < hm.length && hm[i].key != key; i++) ;
		return i < hm.length ? hm[i].value : null;
	}
	/**
	 * PUBLIC
	 * Returns true if this HashMap contains no key-value mappings.
	 * return (boolean) true if this HashMap contains no key-value mappings.
	 */
	this.isEmpty = function isEmptyHashMap() {
		return this.size() == 0;
	}
	/**
	 * PUBLIC
	 * Associates the specified value with the specified key in this map. If the map
	 * previously contained a mapping for this key, the old value is replaced.
	 * @param (Object) key key with which the specified value is to be associated.
	 * @param (Object) value value to be associated with the specified key.
	 * @return (Object) previous value associated with specified key, or null if there
	 * was no mapping for key. A null return can also indicate that the HashMap
	 * previously associated null with the specified key.
	 */
	this.put = function putHashMapEntry(key, value) {
		var oldValue = this.remove(key);
		hm[hm.length] = new HashMapEntry(key, value);
		return oldValue;
	}
	/**
	 * PUBLIC
	 * Removes the mapping for this key from this HashMap if present.
	 * @param (Object) key key whose mapping is to be removed from the HashMap.
	 * return (Object) previous value associated with specified key, or null if there
	 * was no mapping for key. A null return can also indicate that the HashMap previously
	 * associated null with the specified key.
	 */
	this.remove = function removeHashMapEntry(key) {
		var i;
		var removedValue = null;
		for (i = 0; i < hm.length && hm[i].key != key; i++) ;
		if (i < hm.length) {
			removedValue = hm[i];
			hm.splice(i, 1);
		}
		return removedValue;
	}
	/**
	 * PUBLIC
	 * Returns the number of key-value mappings in this HashMap.
	 * return (int) the number of key-value mappings in this HashMap.
	 */
	this.size = function getHashMapSize() {
		return hm.length;
	}
	/**
	 * PUBLIC
	 * Returns a Collection view of the values contained in this HashMap.
	 * return (Collection) a Collection view of the values contained in this HashMap.
	 */
	this.values = function valuesOfHashmap() {
		var c = new Collection();
		for (var i = 0; i < hm.length; i++) {
			c.add(hm[i].value);
		}
		return c;
	}
}