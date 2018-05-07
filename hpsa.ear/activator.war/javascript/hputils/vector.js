/**************************************************************************************************/
/*                                       Vector object                                            */
/**************************************************************************************************/

/**************************************************************************************************/
/* Dependencies:                                                                                  */
/*   - Enumeration                                                                                */
/*   - Iterator                                                                                   */
/**************************************************************************************************/



/**
 * PUBLIC Constructor
 * Vector object developed in JavaScript with almost the same performing of the original
 * Java object.
 */
function Vector() {
	/**
	 * PRIVATE
	 * Javascript Array object used to implement the Vector object. It is a private attribute since it
	 * is declared as a var attribute of the Vector object.
	 */
	var v = new Array();
	/**
	 * PUBLIC
	 * Inserts the specified element at the specified position in this Vector. Shifts the element
	 * currently at that position (if any) and any subsequent elements to the right (adds one to their indices).
	 * If no position is specified, the element at the objOrPos parameter is appended to the Vector.
	 * @param (int or Object) objOrPos index at which the specified element is to be inserted (when the obj
	 * parameter is null or not specified); otherway, it is the element to be appended at the end of the Vector.
	 * @param (Object) obj element to be inserted. If null, the object to be inserted is specified at the
	 * objOrPos parameter.
	 */
	this.add = function addObjToVector(objOrPos, obj) {
		if (obj == null) {
			v[v.length] = objOrPos;
		} else {
			try {
				var i = eval(objOrPos);
				if (i >= v.length) {
					v[i] = obj;
				} else {
					v.splice(i, 0, obj);
				}
			} catch (e) {
				alert("[Vector]: Attempting to add object failed. Possibly index is not an integer value.");
			}
		}
	}
	/**
	 * PUBLIC
	 * Adds the specified component to the end of this vector, increasing its size by one.
	 * @param (Object) obj the component to be added.
	 */
	this.addElement = function addElementToVector(obj) {
		v[v.length] = obj;
	}
	/**
	 * PUBLIC
	 * Removes all of the elements from this Vector.
	 */
	this.clear = function clearVector() {
		v.splice(0, v.length);
	}
	/**
	 * PUBLIC
	 * Tests if the specified object is a component in this vector.
	 * @param (Object) elem an object.
	 * @return (boolean) true if and only if the specified object is the same as a component
	 * in this vector; false otherwise.
	 */
	this.contains = function containsVector(elem) {
		for (var i = 0; i < v.length && v[i] != elem; i++) ;
		return i < v.length;
	}
	/**
	 * PUBLIC
	 * Returns the component at the specified index. This method is identical in functionality
	 * to the get method.
	 * @param (int) index an index into this vector.
	 * @return (Object) the component at the specified index.
	 */
	this.elementAt = function elementAtVector(index) {
		return v[eval(index)];
	}
	/**
	 * PUBLIC
	 * Returns an enumeration of the components of this vector. The returned Enumeration object
	 * will generate all items in this vector. The first item generated is the item at index 0,
	 * then the item at index 1, and so on.
	 * @return (Enumeration) an enumeration of the components of this vector.
	 */
	this.elements = function elementsOfVector() {
		var e = new Enumeration();
		for (var i = 0; i < v.length; i++) {
			e.add(v[i]);
		}
		return e;
	}
	/**
	 * PUBLIC
	 * Returns the first component (the item at index 0) of this vector.
	 * @return (Object) the first component of this vector.
	 */
	this.firstElement = function firstElementOfVector() {
		return v.length > 0 ? v[0] : null;
	}
	/**
	 * PUBLIC
	 * Returns the component at the specified index. This method is identical in functionality
	 * to the elementAt method.
	 * @param (int) index an index into this vector.
	 * @return (Object) the component at the specified index.
	 */
	this.get = function getVector(index) {
		return v[eval(index)];
	}
	/**
	 * PUBLIC
	 * Searches for the first occurence of the given argument, beginning the search at index or at
	 * the beginning of the Vector if no index is specified.
	 * @param (Object) obj an object.
	 * @param (int) index the non-negative index to start searching from.
	 * @return (int) the index of the first occurrence of the object argument in this vector at
	 * position index or later in the vector
	 */
	this.indexOf = function indexOfVector(obj, index) {
		var i = index == null ? 0 : eval(index);
		for (; i < v.length && v[i] != obj; i++) ;
		return i < v.length ? i : -1;
	}
	/**
	 * PUBLIC
	 * Inserts the specified object as a component in this vector at the specified index.
	 * Each component in this vector with an index greater or equal to the specified index is
	 * shifted upward to have an index one greater than the value it had previously.
	 * The index must be a value greater than or equal to 0 and less than or equal to the current
	 * size of the vector. (If the index is equal to the current size of the vector, the new
	 * element is appended to the Vector.)
	 * This method is identical in functionality to the add(Object, int) method (which is part
	 * of the List interface). Note that the add method reverses the order of the parameters,
	 * to more closely match array usage.
	 * @param (Object) obj an object to insert.
	 * @param (int) index where to insert the new component.
	 */
	this.insertElementAt = function insertElementAtVector(obj, index) {
		this.add(index, obj);
	}
	/**
	 * PUBLIC
	 * Tests if this vector has no components.
	 * @return (boolean) true if and only if this vector has no components, that is, its size
	 * is zero; false otherwise.
	 */
	this.isEmpty = function isEmptyVector() {
		return v.length == 0;
	}
	/**
	 * PUBLIC
	 * Returns an iterator over the elements in this vector in proper sequence.
	 * @return (Iterator) an iterator over the elements in this vector in proper sequence.
	 * is zero; false otherwise.
	 */
	this.iterator = function iteratorVector() {
		var it = new Iterator();
		for (var i = 0; i < v.length; i++) {
			it.add(v[i]);
		}
		return it;
	}
	/**
	 * PUBLIC
	 * Returns the last component of the vector.
	 * @return (Object) the last component of the vector, i.e., the component at index size() - 1.
	 */
	this.lastElement = function lastElementOfVector() {
		return v.length > 0 ? v[length - 1] : null;
	}
	/**
	 * PUBLIC
	 * Searches backwards for the specified object, starting from the specified index, and
	 * returns an index to it. If no index is specified, the search process begins at the
	 * end of the Vector.
	 * @param (Object) obj an object.
	 * @param (int) index the index to start searching from. Can be null.
	 * @return (int) the index of the last occurrence of the specified object in this vector
	 * at position less than or equal to index in the vector.
	 */
	this.lastIndexOf = function lastIndexOfVector(obj, index) {
		var i = index == null ? v.length - 1 : eval(index);
		for (; i >= 0 && v[i] != obj; i--) ;
		return i;
	}
	/**
	 * PUBLIC
	 * 1. Case objOrPos is instance of Object:
	 * Removes the first occurrence of the specified element in this Vector.
	 * If the Vector does not contain the element, it is unchanged.
	 * @param (Object or int) objOrPos element to be removed from this Vector, if present.
	 * @return (boolean) true if the Vector contained the specified element.
	 * 2. Case objOrPos is an int:
	 * Removes the element at the specified position in this Vector. shifts any subsequent
	 * elements to the left (subtracts one from their indices). Returns the element that
	 * was removed from the Vector.
	 * @param (Object or int) objOrPos the index of the element to remove.
	 * @return (Object) the element that was removed from the Vector.
	 */
	this.remove = function removeObjFromVector(objOrPos) {
		if (eval(objOrPos) >= 0 && eval(objOrPos) < v.length) {
			v.splice(objOrPos, 1);
			return true;
		} else {
			var i = this.indexOf(objOrPos);
			if (i >= 0) {
				v.splice(i, 1);
				return true;
			} else {
				return false;
			}
		}
	}
	/**
	 * PUBLIC
	 * Removes all components from this vector and sets its size to zero.
	 * This method is identical in functionality to the clear method.
	 */
	this.removeAllElements = function removeAllVector() {
		this.clear();
	}
	/**
	 * PUBLIC
	 * Removes the first (lowest-indexed) occurrence of the argument from this vector.
	 * If the object is found in this vector, each component in the vector with an index
	 * greater or equal to the object's index is shifted downward to have an index one
	 * smaller than the value it had previously.
	 * This method is identical in functionality to the remove(Object) method.
	 * @param (Object) obj the component to be removed.
	 * @return (boolean) true if the argument was a component of this vector; false otherwise.
	 */
	this.removeElement = function removeElementOfVector(obj) {
		return this.remove(obj);
	}
	/**
	 * PUBLIC
	 * Deletes the component at the specified index. Each component in this vector with an
	 * index greater or equal to the specified index is shifted downward to have an index
	 * one smaller than the value it had previously. The size of this vector is decreased by 1.
	 * The index must be a value greater than or equal to 0 and less than the current size of the vector.
	 * This method is identical in functionality to the remove method.
	 * @param (int) index the index of the object to remove.
	 */
	this.removeElementAt = function removeElementAtVector(index) {
		this.remove(eval(index));
	}
	/**
	 * PUBLIC
	 * Removes from this Vector all of the elements whose index is between fromIndex, inclusive and
	 * toIndex, exclusive. Shifts any succeeding elements to the left (reduces their index).
	 * @param (int) fromIndex index of first element to be removed.
	 * @param (int) toIndex index after last element to be removed.
	 */
	this.removeRange = function removeRangeOfVector(fromIndex, toIndex) {
		var startIndex = Math.min(eval(fromIndex), eval(toIndex));
		var endIndex = Math.max(eval(fromIndex), eval(toIndex));
		if (endIndex >= v.length) {
			endIndex = v.length;
		}
		v.splice(startIndex, endIndex - startIndex);
	}
	/**
	 * PUBLIC
	 * Replaces the element at the specified position in this Vector with the specified element.
	 * @param (int) index index of element to replace.
	 * @param (Object) obj element to be stored at the specified position.
	 * @return (Object) the element previously at the specified position.
	 */
	this.set = function setObjAtVector(index, obj) {
		return v.splice(index, 1, obj);
	}
	/**
	 * PUBLIC
	 * Sets the component at the specified index of this vector to be the specified object.
	 * The previous component at that position is discarded. The index must be a value greater
	 * than or equal to 0 and less than the current size of the vector.
	 * This method is identical in functionality to the set method.
	 * @param (int) index index of element to replace.
	 * @param (Object) obj element to be stored at the specified position.
	 */
	this.setElementAt = function setElementAtVector(obj, index) {
		this.set(index, obj);
	}
	/**
	 * PUBLIC
	 * Returns the number of components in this vector.
	 * @return (int) the number of components in this vector.
	 */
	this.size = function sizeOfVector() {
		return v.length;
	}
	/**
	 * PUBLIC
	 * Returns an array containing all of the elements in this Vector in the correct order.
	 */
	this.toArray = function vectorToArray() {
		var vv = new Array();
		for (var i = 0; i < v.length; i++) {
			vv[i] = v[i];
		}
		return vv;
	}
	/**
	 * PUBLIC
	 * Returns a string representation of this Vector.
	 */
	this.toString = function vectorToString() {
		var str = "[";
		for (var i = 0; i < v.length; i++) {
			if (i > 0) {
				str += ", ";
			}
			str += v[i];
		}
		return str + "]";
	}
}