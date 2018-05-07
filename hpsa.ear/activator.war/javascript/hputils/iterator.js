/**************************************************************************************************/
/*                                       Iterator object                                          */
/**************************************************************************************************/

/**
 * PUBLIC Constructor
 * Iterator object developed in JavaScript with almost the same performing of the original
 * Java object.
 */
function Iterator() {
	/**
	 * PRIVATE
	 * A counter to establish the actually next element of this Iterator.
	 */
	var counter = 0;
	/**
	 * PRIVATE
	 * Javascript Array object used to implement the Iterator object. It is a private
	 * attribute since it is declared as a var attribute of the iterator object.
	 */
	var it = new Array();
	/**
	 * PUBLIC
	 * Tests if this Iterator contains more elements.
	 * @return (boolean) true if and only if this iterator object contains at least
	 * one more element to provide; false otherwise.
	 */
	this.hasNext = function hasNextIterator() {
		return counter < it.length;
	}
	/**
	 * PUBLIC
	 * Returns the next element of this iterator if this iterator object has at
	 * least one more element to provide.
	 * @return (Object) the next element of this iterator.
	 */
	this.next = function nextIterator() {
		return it[counter++];
	}
	/**
	 * PUBLIC
	 * Removes from the underlying collection the last element returned by the
	 * iterator (optional operation). This method can be called only once per call
	 * to next. The behavior of an iterator is unspecified if the underlying
	 * collection is modified while the iteration is in progress in any way other
	 * than by calling this method.
	 */
	this.remove = function removeIterator() {
		try {
			it.splice(counter - 1, 1);
		} catch (e) {
			throw ("IllegalStateException");
		}
	}
	/**
	 * PROTECTED
	 * Adds an object to this iterator. Since this method is protected it can only
	 * be invoked from other object of this API to fill it.
	 * @param (Object) obj the object to insert into the iterator.
	 */
	this.add = function addToIterator(obj) {
		it[it.length] = obj;
	}
}