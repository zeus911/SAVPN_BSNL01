/**************************************************************************************************/
/*                                       Collection object                                        */
/**************************************************************************************************/

/**************************************************************************************************/
/* Dependencies:                                                                                  */
/*   - Iterator                                                                                   */
/**************************************************************************************************/

/**
 * PUBLIC Constructor
 * Collection object developed in JavaScript with almost the same performing of the original
 * Java object.
 * This object allows repetitions of elements.
 */
function Collection() {
	/**
	 * PRIVATE
	 * Javascript Array object used to implement the Collection object. It is a private attribute
	 * since it is declared as a var attribute of the Vector object.
	 */
	var c = new Array();
	/**
	 * PUBLIC
	 * Ensures that this collection contains the specified element (optional operation). Returns
	 * true if this collection changed as a result of the call. (Returns false if this collection
	 * does not permit duplicates and already contains the specified element.)
	 * @param (Object) obj element whose presence in this collection is to be ensured.
	 * @return (boolean) true if this collection changed as a result of the call.
	 */
	this.add = function addObjToCollection(obj) {
		c[c.length] = obj;
		return true;
	}
	/**
	 * PUBLIC
	 * Adds all of the elements in the specified collection to this collection (optional operation).
	 * @param (Collection) col elements to be inserted into this collection.
	 * @return (boolean) true if this collection changed as a result of the call
	 */
	this.addAll = function addAllCollection(col) {
		var it = col.iterator();
		while (it.hasNext()) {
			this.add(it.next());
		}
		return true;
	}
	/**
	 * PUBLIC
	 * Removes all of the elements from this collection (optional operation).
	 */
	this.clear = function clearCollection() {
		c.splice(0, c.length);
	}
	/**
	 * PUBLIC
	 * Returns true if this collection contains the specified element.
	 * @param (Object) obj element whose presence in this collection is to be tested.
	 * @return (boolean) true if this collection contains the specified element.
	 */
	this.contains = function containsObjCollection(obj) {
		var i;
		for (i = 0; i < c.length && c[i] != obj; i++) ;
		return i < c.length;
	}
	/**
	 * PUBLIC
	 * Returns true if this collection contains all of the elements in the specified collection.
	 * @param (Collection) col collection to be checked for containment in this collection.
	 * @return (boolean) true if this collection contains all of the elements in the specified
	 * collection.
	 */
	this.containsAll = function containsAllCollection(col) {
		var it = col.iterator();
		var contained = true;
		while (it.hasNext() && contained) {
			contained = this.contains(it.next());
		}
		return contained;
	}
	/**
	 * PUBLIC
	 * Returns true if this collection contains no elements.
	 * @return (boolean) true if this collection contains no elements.
	 */
	this.isEmpty = function isEmptyCollection() {
		return c.length == 0;
	}
	/**
	 * PUBLIC
	 * Returns an iterator over the elements in this collection.
	 * @return (Iterator) an Iterator over the elements in this collection.
	 */
	this.iterator = function iteratorCollection() {
		var it = new Iterator();
		for (var i = 0; i < c.length; i++) {
			it.add(c[i]);
		}
		return it;
	}
	/**
	 * PUBLIC
	 * Removes a single instance of the specified element from this collection, if it
	 * is present (optional operation).
	 * @param (Object) obj element to be removed from this collection, if present.
	 * @return (boolean) true if this collection changed as a result of the call.
	 */
	this.remove = function removeCollection(obj) {
		var i;
		for (i = 0; i < c.length && c[i] != obj; i++) ;
		if (i < c.length) {
			c.splice(i,1);
		}
	}
	/**
	 * PUBLIC
	 * Removes all this collection's elements that are also contained in the specified
	 * collection (optional operation). After this call returns, this collection will
	 * contain no elements in common with the specified collection.
	 * @param (Collection) col elements to be removed from this collection.
	 * @return (boolean) true if this collection changed as a result of the call.
	 */
	this.removeAll = function removeAllCollection(col) {
		var sz = c.length;
		var it = col.iterator();
		while (it.hasNext()) {
			this.remove(it.next());
		}
		return sz != c.length;
	}
	/**
	 * PUBLIC
	 * Retains only the elements in this collection that are contained in the
	 * specified collection (optional operation). In other words, removes from this
	 * collection all of its elements that are not contained in the specified collection.
	 * @param (Collection) col elements to be retained in this collection.
	 * @return (boolean) true if this collection changed as a result of the call.
	 */
	this.retainAll = function retainAllCollection(col) {
		var sz = c.length;
		for (var i = c.length - 1; i >= 0; i--) {
			if (!col.contains(c[i])) {
				c.splice(i, 1);
			}
		}
		return sz != c.length;
	}
	/**
	 * PUBLIC
	 * Returns the number of elements in this collection.
	 * @return (int) the number of elements in this collection.
	 */
	this.size = function sizeOfCollection() {
		return c.length;
	}
	/**
	 * PUBLIC
	 * Returns an array containing all of the elements in this collection.
	 * @return (Array) an array containing all of the elements in this collection.
	 */
	this.toArray = function toArrayCollection() {
		var a = new Array();
		for (var i = 0; i < c.length; i++) {
			a[i] = c[i];
		}
		return a;
	}
}