function getXDiagramWindow() {
	var previous;
	var where = "window";
	var found = false;
  var error = false;
  var wdw;
	do {
		try {
			wdw = eval(where + ".Xcanvas");
      if (wdw == null) {
        error = true;
      } else {
        found = true;
      }
    } catch (e) {
			error = true;
		}
    if (error) {
      error = false;
      previous = where;
			try {
				wdw = eval(where + ".opener.window");
        where += wdw == null ? ".parent" : ".opener.window";
			} catch (e1) {
				where += ".parent";
			}
    }
	} while (!found && eval(where) != eval(previous));
  return eval(where);
}