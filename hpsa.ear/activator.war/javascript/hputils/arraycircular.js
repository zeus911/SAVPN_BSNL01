/**
 * PUBLIC Constructor
 * Circular array of objects. Objects are appended at the end of the circular
 * array and gotten (and removed) from the first to the last.
 * @param (int) size the size of the array. Mandatory parameter.
 */
function ArrayCircular(size) {
	/**
	 * PRIVATE
	 * (Array) the array implementation of the circular array.
	 */
	var ac = new Array(size);
	/**
	 * PRIVATE
	 * (int) indicates the position of the first object added to the array.
	 * If the array is empty, it's value is set to -1.
	 */
	var next = -1;
	/**
	 * PRIVATE
	 * (int) indicates the position of the last added object.
	 * If the array is empty, it's value is set to -1.
	 */
	var last = -1;
	/**
	 * PUBLIC
	 * Adds a new element to the circular array. The element is appended after
	 * the last added object of the circular array. If the circular array is
	 * empty, it is located at the first position and while any other object
	 * is not added the next and the last elements of the circular array are
	 * the same.
	 * @param (Object) obj the object to be added. null value is admitted.
	 */
	this.addElement = function(obj) {
		if (last < 0) {
			last++;
		} else {
			last = (last + 1) % size;
		}
		ac[last] = obj;
		if (next < 0) {
			next++;
		}
	}
	/**
	 * PUBLIC
	 * Gets the next element of the circular array and removes it from the array.
	 * @return (Object) the object allocated at the first position of the circular
	 * array, or null if the circular array was empty.
	 */
	this.getNextElement = function() {
		var nextElement;
		if (this.size() == 0) {
			nextElement = null;
		} else {
			nextElement = ac[next];
			if (last == next) {
				last = -1;
				next = -1;
			} else {
				next = (next + 1) % size;
			}
		}
		return nextElement;
	}
	/**
	 * PUBLIC
	 * Gets the last object of the circular array, but it is not removed.
	 * @return (Object) the last object of the array.
	 */
	this.lookUpLastElement = function() {
		if (last >= 0) {
			return ac[last];
		}
	}
	/**
	 * PUBLIC
	 * Gets the next object of the circular array, but it is not removed (as
	 * it happens with the getNextElement method).
	 * @return (Object) the next object of the array.
	 */
	this.lookUpNextElement = function() {
		if (next >= 0) {
			return ac[next];
		}
	}
	/**
	 * PUBLIC
	 * Gets the number of objects allocated into the circular array.
	 * @return (int) the number of objects allocated into the array.
	 */
	this.size = function() {
		if (last < 0) {
			return 0;
		} else if (last == next) {
			return 1;
		} else if (last > next) {
			return last - next;
		} else {
			return size - next + last + 1;
		}
	}
}