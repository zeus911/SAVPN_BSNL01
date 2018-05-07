/**************************************************************************************************/
/*                                              Set object                                        */
/**************************************************************************************************/

/**************************************************************************************************/
/* Dependencies:                                                                                  */
/*   - Iterator                                                                                   */
/**************************************************************************************************/

/**
 * PUBLIC Constructor
 * Set object developed in JavaScript with almost the same performing of the original
 * Java object.
 * This object does not allow repetitions of elements.
 */
function Set() {
	/**
	 * PRIVATE
	 * Javascript Array object used to implement the Set object. It is a private attribute
	 * since it is declared as a var attribute of the Vector object.
	 */
	var s = new Array();
	/**
	 * PUBLIC
	 * Ensures that this set contains the specified element (optional operation). Returns
	 * true if this collection changed as a result of the call. (Returns false if this collection
	 * does not permit duplicates and already contains the specified element.)
	 * @param (Object) obj element whose presence in this Set is to be ensured.
	 * @return (boolean) true if this Set changed as a result of the call.
	 */
	this.add = function addObjToSet(obj) {
		var sz = s.length;
		if (!this.contains(obj)) {
			s[s.length] = obj;
		}
		return sz != s.length;
	}
	/**
	 * PUBLIC
	 * Adds all of the elements in the specified collection to this Set (optional operation).
	 * @param (Collection) col elements to be inserted into this Set.
	 * @return (boolean) true if this Set changed as a result of the call
	 */
	this.addAll = function addAllSet(col) {
		var sz = s.length;
		var it = col.iterator();
		while (it.hasNext()) {
			if (!this.contains(obj)) {
				this.add(it.next());
			}
		}
		return sz != s.length;
	}
	/**
	 * PUBLIC
	 * Removes all of the elements from this set (optional operation).
	 */
	this.clear = function clearSet() {
		s.splice(0, s.length);
	}
	/**
	 * PUBLIC
	 * Returns true if this set contains the specified element.
	 * @param (Object) obj element whose presence in this set is to be tested.
	 * @return (boolean) true if this set contains the specified element.
	 */
	this.contains = function containsObjSet(obj) {
		var i;
		for (i = 0; i < s.length && s[i] != obj; i++) ;
		return i < s.length;
	}
	/**
	 * PUBLIC
	 * Returns true if this set contains all of the elements in the specified collection.
	 * @param (Collection) col collection to be checked for containment in this set.
	 * @return (boolean) true if this set contains all of the elements in the specified
	 * collection.
	 */
	this.containsAll = function containsAllSet(col) {
		var it = col.iterator();
		var contained = true;
		while (it.hasNext() && contained) {
			contained = this.contains(it.next());
		}
		return contained;
	}
	/**
	 * PUBLIC
	 * Returns true if this set contains no elements.
	 * @return (boolean) true if this set contains no elements.
	 */
	this.isEmpty = function isEmptySet() {
		return s.length == 0;
	}
	/**
	 * PUBLIC
	 * Returns an iterator over the elements in this set.
	 * @return (Iterator) an Iterator over the elements in this set.
	 */
	this.iterator = function iteratorSet() {
		var it = new Iterator();
		for (var i = 0; i < s.length; i++) {
			it.add(s[i]);
		}
		return it;
	}
	/**
	 * PUBLIC
	 * Removes a single instance of the specified element from this set, if it
	 * is present (optional operation).
	 * @param (Object) obj element to be removed from this set, if present.
	 * @return (boolean) true if this set changed as a result of the call.
	 */
	this.remove = function removeSet(obj) {
		var i;
		for (i = 0; i < s.length && s[i] != obj; i++) ;
		if (i < s.length) {
			s.splice(i,1);
		}
	}
	/**
	 * PUBLIC
	 * Removes all this set's elements that are also contained in the specified
	 * collection (optional operation). After this call returns, this set will
	 * contain no elements in common with the specified collection.
	 * @param (Collection) col elements to be removed from this set.
	 * @return (boolean) true if this set changed as a result of the call.
	 */
	this.removeAll = function removeAllSet(col) {
		var sz = s.length;
		var it = col.iterator();
		while (it.hasNext()) {
			this.remove(it.next());
		}
		return sz != s.length;
	}
	/**
	 * PUBLIC
	 * Retains only the elements in this set that are contained in the
	 * specified collection (optional operation). In other words, removes from this
	 * set all of its elements that are not contained in the specified collection.
	 * @param (Collection) col elements to be retained in this set.
	 * @return (boolean) true if this set changed as a result of the call.
	 */
	this.retainAll = function retainAllSet(col) {
		var sz = s.length;
		for (var i = s.length - 1; i >= 0; i--) {
			if (!col.contains(s[i])) {
				s.splice(i, 1);
			}
		}
		return sz != s.length;
	}
	/**
	 * PUBLIC
	 * Returns the number of elements in this set.
	 * @return (int) the number of elements in this set.
	 */
	this.size = function sizeOfSet() {
		return s.length;
	}
	/**
	 * PUBLIC
	 * Returns an array containing all of the elements in this set.
	 * @return (Array) an array containing all of the elements in this set.
	 */
	this.toArray = function toArraySet() {
		var a = new Array();
		for (var i = 0; i < s.length; i++) {
			a[i] = s[i];
		}
		return a;
	}
}