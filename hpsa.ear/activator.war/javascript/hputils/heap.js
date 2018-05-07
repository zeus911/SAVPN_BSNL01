/**************************************************************************************************/
/*                                             Heap object                                        */
/**************************************************************************************************/

/**************************************************************************************************/
/* Dependencies:                                                                                  */
/*   - Collection                                                                                 */
/**************************************************************************************************/

/**
 * PUBLIC Constructor
 * Heap object - a LIFO structure.
 */
function Heap() {
	/**
	 * PRIVATE
	 * Javascript Array object used to implement the Heap object. It is a private attribute
	 * since it is declared as a var attribute of the Vector object.
	 */
	var h = new Array();
	/**
	 * PUBLIC
	 * Returns true if this Heap contains the specified element.
	 * @param (Object) obj element whose presence in this Heap is to be tested.
	 * @return (boolean) true if this Heap contains the specified element.
	 */
	this.contains = function containsHeap(obj) {
		var i;
		for (i = 0; i < h.length && h[i] != obj; i++) ;
		return i < h.length;
	}
	/**
	 * PUBLIC
	 * Removes all of the elements from this Heap (optional operation).
	 */
	this.clear = function clearHeap() {
		h.splice(0, h.length);
	}
	/**
	 * PUBLIC
	 * Inserts an object into the Heap.
	 * @param (Object) obj the object to insert.
	 */
	this.push = function pushHeap(obj) {
		h.splice(0, 0, obj);
	}
	/**
	 * PUBLIC
	 * 1. popNumber parameter is null:
	 * Extracts an object from the Heap.
	 * @return (Object) the object to extracted or null if the Heap is empty.
	 * 2. popNumber parameter is not null:
	 * If popNumber is greater than 1 returns a Collection with as many extracted elements
	 * from the Heap as indicated by popNumber.
	 * If popNumber equals 1 the behavior of this method is the same of 1.
	 * If popNumber equals 0 no element is extracted and null is returned.
	 * @param (int) popNumber the number of elements to extract.
	 * @return (Collection) a collection with the extracted elements.
	 */
	this.pop = function popHeap(popNumber) {
		if (popNumber == null || eval(popNumber) == 1) {
			return h.length > 0 ? h.splice(0, 1) : null;
		} else if (eval(popNumber) > 0) {
			var c = new Collection();
			for (var i = 0; i < eval(popNumber); i++) {
				c.add(h.splice(0, 1));
			}
			return c;
		}
		return null;
	}
	/**
	 * PUBLIC
	 * Returns the number of objects inside the Heap.
	 * @return (int) the number of objects inside the Heap.
	 */
	this.size = function sizeOfHeap() {
		return h.length;
	}
}