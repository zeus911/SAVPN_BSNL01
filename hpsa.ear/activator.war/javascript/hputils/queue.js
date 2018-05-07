/**************************************************************************************************/
/*                                            Queue object                                        */
/**************************************************************************************************/

/**
 * PUBLIC Constructor
 * Queue object - a FIFO structure.
 */
function Queue() {
	/**
	 * PRIVATE
	 * Javascript Array object used to implement the Queue object. It is a private attribute
	 * since it is declared as a var attribute of the Vector object.
	 */
	var q = new Array();
	/**
	 * PUBLIC
	 * Returns true if this queue contains the specified element.
	 * @param (Object) obj element whose presence in this queue is to be tested.
	 * @return (boolean) true if this queue contains the specified element.
	 */
	this.contains = function containsQueue(obj) {
		var i;
		for (i = 0; i < q.length && q[i] != obj; i++) ;
		return i < q.length;
	}
	/**
	 * PUBLIC
	 * Removes all of the elements from this queue (optional operation).
	 */
	this.clear = function clearQueue() {
		q.splice(0, q.length);
	}
	/**
	 * PUBLIC
	 * Inserts an object into the Queue.
	 * @param (Object) obj the object to insert.
	 */
	this.insert = function insertQueue(obj) {
		q[q.length] = obj;
	}
	/**
	 * PUBLIC
	 * Extracts an object from the Queue.
	 * @return (Object) the object to extracted or null if the queue is empty.
	 */
	this.extract = function extractQueue() {
		return q.length > 0 ? q.splice(0, 1) : null;
	}
	/**
	 * PUBLIC
	 * Returns the number of objects inside the queue.
	 * @return (int) the number of objects inside the queue.
	 */
	this.size = function sizeOfQueue() {
		return q.length;
	}
}