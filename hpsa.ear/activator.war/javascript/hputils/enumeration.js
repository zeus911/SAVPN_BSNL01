/**************************************************************************************************/
/*                                       Enumeration object                                       */
/**************************************************************************************************/

/**
 * PUBLIC Constructor
 * Enumeration object developed in JavaScript with almost the same performing of the original
 * Java object.
 */
function Enumeration() {
	/**
	 * PRIVATE
	 * A counter to establish the actually next element of this Enumeration.
	 */
	var counter = 0;
	/**
	 * PRIVATE
	 * Javascript Array object used to implement the Enumeration object. It is a private
	 * attribute since it is declared as a var attribute of the Enumeration object.
	 */
	var e = new Array();
	/**
	 * PUBLIC
	 * Tests if this enumeration contains more elements.
	 * @return (boolean) true if and only if this enumeration object contains at least
	 * one more element to provide; false otherwise.
	 */
	this.hasMoreElements = function hasMoreElementsEnumeration() {
		return counter < e.length;
	}
	/**
	 * PUBLIC
	 * Returns the next element of this enumeration if this enumeration object has at
	 * least one more element to provide.
	 * @return (Object) the next element of this enumeration.
	 */
	this.nextElement = function nextElementEnumeration() {
		return e[counter++];
	}
	/**
	 * PROTECTED
	 * Adds an object to this enumeration. Since this method is protected it can only
	 * be invoked from other object of this API to fill it.
	 * @param (Object) obj the object to insert into the enumeration.
	 */
	this.add = function addToEnumeration(obj) {
		e[e.length] = obj;
	}
}