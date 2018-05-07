/*****************************************************************************************/
/**                                      List Object                                    **/
/*****************************************************************************************/
/**
 * PUBLIC
 * An ordered list of elements. These elements can belong to any type. This structure is
 * very similar to the Java Iterator object.
 */
function List() {
	this.counter = 0;
	this.list = new Array();
	this.add = addObjToList;
	this.get = getObjFromList;
	this.getLength = getNumberOfObjs;
	this.contains = containsObj;
	this.remove = removeObjFromList;
	this.insertAt = insertObjIntoListAt;
	this.indexOf = getIndexOf;
}
/**
 * PUBLIC
 * Adds an object to the List. If the setId parameter is true, the object's setId method is
 * invoked with the numeric position of this object inside the List.
 * @param (any object type) obj the object to allocate.
 * @param (String or boolean) setId indicates whether the object's setId method must be incoked.
 */
function addObjToList(obj, setId) {
	if (eval(setId)) {
		obj.setId(this.counter++);
	}
	this.list[this.list.length] = obj;
}
/**
 * PUBLIC
 * Gets the object allocated at the specified position.
 * @param (String or int) i the position of the desired object.
 * @return (any object type) the object at the specified position.
 */
function getObjFromList(i) {
	return this.list[i];
}
/**
 * PUBLIC
 * Gets the length of the list. In other words, the number of objects allocated inside the List.
 * @return (int) the length of the List.
 */
function getNumberOfObjs() {
	return this.list.length;
}
/**
 * PUBLIC
 * Checks whether the List contains the specified object or not.
 * @param (any object type) obj the object which is needed to search.
 * @return (boolean) true if the object is allocated inside the List. False other way.
 */
function containsObj(obj) {
	var found = false;
	for (var i = 0; i < this.list.length && !found; i++) {
		found = (this.list[i] == obj);
	}
	return found;
}
/**
 * PUBLIC
 * Removes an object of the List.
 * @param (String or int) i the index of the object which is going to be removed.
 * @return the removed object.
 */
function removeObjFromList(i) {
	return this.list.splice(eval(i), 1);
}
/**
 * PUBLIC
 * Inserts an object into the List at the specified position. Any other subsequent objects of
 * the List are displaced a position.
 * @param (String or int) i the index where the object must be inserted.
 * @param (Object) obj the object which is going to be inserted.
 * @param (String or boolean) setId indicates whether the object's setId method must be incoked.
 */
function insertObjIntoListAt(i, obj, setId) {
	if (eval(setId)) {
		obj.setId(this.counter++);
	}
	this.list.splice(eval(i), 0, obj);
}
/**
 * PUBLIC
 * Returns the index of an object inside the List.
 * @param (Object) obj the object which index is looked for.
 * @return the object's index inside the List.
 */
function getIndexOf(obj) {
	var i = 0;
	var found = false;
	var length = this.getLength();
	while (i < length && !found) {
		if (this.get(i) == obj) {
			found = true;
		} else {
			i++;
		}
	}
	return i == length ? null : i;
}