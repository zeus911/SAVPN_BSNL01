function HashSet() {
	var elements = new Array();
	this.add = function addHashSet(obj) {
		if (!this.contains(obj)) {
			elements[elements.length] = obj;
		}
	}
	this.clear = function clearHashSet() {
		elements.splice(0, elements.length);
	}
	this.contains = function containsHashSet(obj) {
		var i;
		for (i = 0; i < elements.length && elements[i] != obj; i++) ;
		return i != elements.length;
	}
	this.isEmpty = function isEmptyHashSet() {
		return elements.length == 0;
	}
	this.iterator = function iteratorHashSet() {
		var it = new Iterator();
		for (var i = 0; i < elements.length; i++) {
			it.add(elements[i]);
		}
		return it;
	}
	this.remove = function removeHashSet(obj) {
		var i;
		var removedElement = null;
		for (i = 0; i < elements.length && elements[i] != obj; i++) ;
		if (i < elements.length) {
			removedElement = elements[i];
			elements.splice(i, 1);
		}
		return removedElement;
	}
	this.size = function sizeHashSet() {
		return elements.length;
	}
}