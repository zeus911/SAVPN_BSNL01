
var _combos = new Array();

/**
 * PUBLIC CONSTRUCTOR
 * This object is a merge between a text field and a combo box.
 * It allows to type into the text field and as the characters are
 * being typed it suggests the options which matches with them.
 * @param name the ComboText name attribute. This is the name which
 * will be used when the form is submitted. It is a mandatory parameter.
 * @param containerId the HTML element identifier where the ComboText
 * has to be placed into.
 */
function ComboText(name, containerId) {
   var index = _combos.length;
   _combos[_combos.length] = this;
   ComboText.NAME = "COMBOTEXT";
   /**
    * PRIVATE
    * Array with the ComboText options.
    */
   var options = new Array();
   /**
    * PRIVATE
    * Array with the options which matches the typed characters.
    */
   var visibleOptions = new Array();
   /**
    * PRIVATE
    * The ComboText with attribute. Default value is 200 pixels.
    * @see ComboText#setWidth(String/int)
    */
   var width = 200;
   /**
    * PRIVATE
    * String with the ComboText unique identifier. It can be specified
    * by the developer. If not, default value is composed using the
    * "COMBOTEXT" string and the randomly generated number.
    * @see ComboText#setId(String)
    */
   var id = ComboText.NAME + index;
   var idOptions = "optionsmolongas" + index;
   var idOption = "opt" + index + "_";
   /**
    * PRIVATE
    * Integer which indicates the selected option between the
    * visible ones. A negative value indicates that there is no
    * option actually selected.
    * @see ComboText#selectOption(int)
    */
   var selectedOption = -1;
   /**
    * PRIVATE
    * String with the initial ComboText value, if any.
    * @see ComboText#setInitialValue(String)
    */
   var initialValue = null;
   /**
    * PRIVATE FINAL
    * The height of each displayed option.
    */
   var OPTIONHEIGHT = 13;
   /**
    * PRIVATE FINAL
    * The maximum height of the spam element containing the
    * dispayed options.
    */
   var OPTIONSHEIGHT = 123;
   /**
    * PRIVATE
    * The height of the spam element containing the
    * dispayed options. Its maximmum value may be OPTIONSHEIGHT
    * @see ComboText#OPTIONSHEIGHT
    */
   var oHeight = OPTIONSHEIGHT;
   /**
    * PRIVATE FINAL
    * The selected option colour.
    */
   var SELECTIONCOLOR = "#e3e3e3";
   /**
    * PRIVATE FINAL
    * The onmouseover option colour.
    */
   var MOUSECOLOR = "#f3f3f3";
   /**
    * PRIVATE
    * Stores the combotext's current value. Only used when
    * onchangeFunction is not null;
    * @see ComboText#onchangeFunction
    */
   var cmValue = null;
   /**
    * PRIVATE
    * Name of a javascript function to be invoked when the
    * combotext's value is modified.
    * @see ComboText#setOnChange(String)
    */
   var onchangeFunction = null;
   /**
    * PRIVATE
    * Identifier of the combotext where it has been detected the
    * on key down event and the pressed key was the tab. In this
    * case this is used to avoid the on key up event on the same
    * combotext.
    */
   var kdid = null;
   /**
    * PUBLIC
    * Sets a javascript function to be invoked when the
    * combotext's value is modified.
    * @param functionName The javascript function to be invoked
    * when the combotext¡s value is modified. Examples:
    *       combotext.setOnChange("myFunction()");
    *       combotext.setOnChange("myFunction();myOtherFunction()");
    *       combotext.setOnChange("myfunction('myFinalString')");
    *       combotext.setOnChange("myfunction(\"myFinalString\")");
    *       combotext.setOnChange("myfunction(myVar)"); -- In this
    *                          case the variable myVar must exist.
    */
   this.setOnChange = function (functionName) {
   	onchangeFunction = functionName;
   }
   /**
    * PRIVATE
    * Checks if the given option index is selected. This is done
    * by comparing the selectedOption value with the given index.
    * @return a boolean value indicating if the option is selected.
    */
   this.isSelectedOption = function (index) {
      return selectedOption == index;
   }
   /**
    * PUBLIC
    * Sets the initial value for this ComboText instance.
    */
   this.setInitialValue = function (iv) {
      initialValue = iv;
   }
   /**
    * PUBLIC
    * Sets the width of this ComboText instance.
    */
   this.setWidth = function (w) {
      if (!isNaN(w)) {
         width = w;
      }
   }
   /**
    * PROTECTED
    * Gets the identifier of the span element which contains the
    * combotext.
    * @return the identifier of the span element which contains the
    * combotext
    */
   this.getContainerId = function () {
      return containerId;
   }
   /**
    * PUBLIC
    * Sets the id of this ComboText instance.
    */
   this.setId = function (ctid) {
      id = ctid;
   }
   this.setMaxOptionsHeight = function (moh) {
      OPTIONSHEIGHT = moh;
   }
   /**
    * PUBLIC
    * Adds a new option for this ComboText instance.
    */
   this.addOption = function (opt) {
      options[options.length] = opt;
   }
   /**
    * PUBLIC
    * Generates the ComboText HTML code and displays it on the web page.
    * This method can be invoked only one time per instance.
    */
   this.show = function () {
      options.sort(function (a, b) {return a < b ? -1 : 1});
      var html = "";
      html += "<input id=" + id + " name=" + name + " type=text autocomplete=off ";
      if (initialValue != null) {
         html += "value=\"" + initialValue + "\" ";
      }
      html += "onclick=\"this.cm.displayOptions()\" ";
      html += "style=\"position:absolute; top:0; left:0; width=" + width + "; \">";
      html += "<iframe id=" + idOptions + "ifr ";
      html += "style=\"border-width:0; border-style:solid; width:" + (width + 1) + "; height:" + (OPTIONSHEIGHT + 1) + "; ";
      html += "position:absolute; top:21; left:0; overflow:auto; z-index:10; visibility:hidden;\"></iframe>";
      html += "<span id=" + idOptions + " ";
      html += "style=\"border-width:1; border-style:solid; border-color:#003366; width:" + width + "; height:" + OPTIONSHEIGHT + "; ";
      html += "position:absolute; top:21; left:0; overflow:auto; z-index:10; background-color:#ffffff; "
      html += "color:#003366; font-family:Arial; font-size:10; visibility:hidden;\"></span>";
      document.getElementById(containerId).innerHTML = html;
      document.getElementById(id).cm = this;
      document.getElementById(id).onkeyup = checkKeyUp;
      document.getElementById(id).onkeydown = checkKeyDown;
      document.body.onclick = onclick;
   }
   /**
    * PRIVATE
    * Method which fires when the ComboText object looses the focus.
    * In this case the options span is hidden.
    */
   this.checkBlur = function (e) {
      var elid = document.all ? event.srcElement.id : e.target.id;
      if (elid.indexOf(idOption) != 0 && elid != id) {
         if (document.getElementById(id) != null && document.getElementById(id).cm != null) {
            document.getElementById(id).cm.hideOptions();
         }
      }
   }
   /**
    * PRIVATE
    * Method fired when a key is pressed and the focus
    * is placed on the ComboText.
    */
   this.checkKeyUp = function (e) {
      var keycode = document.all ? event.keyCode : e.which;
      switch (keycode) {
      case 13: // Enter
         document.getElementById(idOptions).style.visibility == "visible" ? this.hideOptions() : this.displayOptions(true);
         break;
      case 27: // Esc
         this.hideOptions();
         document.getElementById(id).value = "";
         break;
      case 38: // Arrow up
         this.previous();
         break;
      case 40: // Arrow down
         this.next();
         break;
      case 9:  // Tab
         if (id == kdid) {
            break;
         }
      default:
         this.displayOptions(true);
      }
      kdid = null;
      if (cmValue != document.getElementById(id).value && onchangeFunction != null) {
         eval(onchangeFunction);
         cmValue = document.getElementById(id).value;
      }
   }
   this.checkKeyDown = function (e) {
      var keycode = document.all ? event.keyCode : e.which;
      switch (keycode) {
      case 9: // Tab
         kdid = id;
         this.hideOptions();
      }
   }
    /**
    * PRIVATE
    * Displays the HTML element with the options that matches the
    * typed characters in the ComboText.
    */
   this.displayOptions = function (forceDisplay) {
      for (var i = 0; i < _combos.length; i++) {
         if (_combos[i] != this) {
            _combos[i].hideOptions();
         }
      }
      if (forceDisplay || document.getElementById(idOptions).style.visibility == "hidden") {
         var html = "";
         var seed = document.getElementById(id).value;
         visibleOptions = new Array();
         for (var i = 0; i < options.length; i++) {
            if (options[i].toUpperCase().indexOf(seed.toUpperCase()) == 0) {
               html += "<div id=" + idOption + visibleOptions.length;
               html += " style=\"white-space:nowrap; width:100%; background-color:#ffffff; z-index:10; height:" + OPTIONHEIGHT + "; cursor:pointer;\" ";
               html += "onmouseover=\"this.style.backgroundColor='#f3f3f3'\" ";
               html += "onmouseout=\"this.style.backgroundColor=";
               html += "document.getElementById('" + id + "').cm.isSelectedOption('" + visibleOptions.length + "') ? '#e3e3e3' : '#ffffff'\" ";
               html += "onclick=\"document.getElementById('" + id + "').cm.selectOption(" + visibleOptions.length + ");";
               html += "document.getElementById('" + id + "').cm.hideOptions()\">";
               html += "&nbsp;" + options[i] + "</div>";
               visibleOptions[visibleOptions.length] = options[i];
            }
         }
         oHeight = Math.min(OPTIONSHEIGHT, visibleOptions.length * (OPTIONHEIGHT + 1));
         document.getElementById(idOptions).innerHTML = html;
         if (oHeight < OPTIONSHEIGHT) {
            if (parseInt(document.getElementById(idOptions).style.width) < document.getElementById(idOptions).scrollWidth) {
               oHeight += 20;
               document.getElementById(idOptions).style.height = oHeight;
            }
            document.getElementById(idOptions).style.overflowY = "hidden";
         } else {
            document.getElementById(idOptions).style.height = oHeight;
            document.getElementById(idOptions).style.overflowY = "auto";
         }
         document.getElementById(idOptions).style.visibility = "visible";
         document.getElementById(idOptions + "ifr").style.height = document.getElementById(idOptions).style.height;
         document.getElementById(idOptions + "ifr").style.visibility = "visible";
         document.getElementById(idOptions + "ifr").style.zIndex = 10000000;
         document.getElementById(idOptions).style.zIndex = 10000001;
         document.getElementById(containerId).style.zIndex = 11;
         selectedOption = -1;
      }
   }
   /**
    * PRIVATE
    * Hides the HTML element with the options that matches the
    * typed characters in the ComboText.
    */
   this.hideOptions = function () {
      document.getElementById(idOptions).style.visibility = "hidden";
      document.getElementById(idOptions + "ifr").style.visibility = "hidden";
      document.getElementById(containerId).style.zIndex = 0;
   }
   /**
    * PRIVATE
    * Method fired when the options are displayed and the
    * down arrow key is pressed.
    * It selects the next option and changes the ComboText
    * value with the option's value.
    */
   this.next = function () {
      if (selectedOption < visibleOptions.length - 1) {
         if (document.getElementById(idOptions).style.visibility == "hidden") {
            this.displayOptions();
         }
         this.selectOption(selectedOption + 1);
      }
   }
   /**
    * PRIVATE
    * Method fired when the options are displayed and the
    * up arrow key is pressed.
    * It selects the previous option and changes the ComboText
    * value with the option's value.
    */
   this.previous = function () {
      if (selectedOption > 0) {
         if (document.getElementById(idOptions).style.visibility == "hidden") {
            this.displayOptions();
         }
         this.selectOption(selectedOption - 1);
      }
   }
   /**
    * PRIVATE
    * Selects the given option (identified by its index between the options
    * that matches the typed characters).
    */
   this.selectOption = function (index) {
      if (selectedOption >= 0 && document.getElementById(idOption + selectedOption)) {
         document.getElementById(idOption + selectedOption).style.backgroundColor = "#ffffff";
      }
      selectedOption = index;
      if (document.getElementById(idOption + selectedOption)) {
         document.getElementById(idOption + selectedOption).style.backgroundColor = "#e3e3e3";
         document.getElementById(id).value = visibleOptions[selectedOption];
         if (document.getElementById(idOptions).scrollTop > index * OPTIONHEIGHT) {
            document.getElementById(idOptions).scrollTop = index * OPTIONHEIGHT;
         } else if (document.getElementById(idOptions).scrollTop + OPTIONSHEIGHT - 30 < index * OPTIONHEIGHT) {
            document.getElementById(idOptions).scrollTop = index * OPTIONHEIGHT - (OPTIONSHEIGHT - 30);
         }
      }
      document.getElementById(id).focus();
      if (cmValue != document.getElementById(id).value && onchangeFunction != null) {
         eval(onchangeFunction);
         cmValue = document.getElementById(id).value;
      }
   }
   /**
    * PUBLIC
    * Removes the combotext.
    */
   this.remove = function () {
      if (document.getElementById(containerId)) {
         document.getElementById(containerId).innerHTML = "";
      }
      _combos.splice(index, 1);
   }
}
/**
 * PROTECTED
 * Method fired when the onclick event is detected in the web page.
 * It invokes the checkBlur method of each ComboText defined in the page.
 */
function onclick (e) {
   for (var i = 0; i < _combos.length; i++) {
      _combos[i].checkBlur(e);
   }
}
function checkKeyUp (e) {
   var id = document.all ? event.srcElement.id : e.target.id;//alert("UP: " + id);
   document.getElementById(id).cm.checkKeyUp(e);
}

function checkKeyDown (e) {
   var id = document.all ? event.srcElement.id : e.target.id;
   document.getElementById(id).cm.checkKeyDown(e);
}