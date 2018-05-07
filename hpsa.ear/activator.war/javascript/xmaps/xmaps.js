// available events
var SELECT_EVENT = "select";
var UNSELECT_EVENT = "unselect";
var SELECT_MULTIPLE_START_EVENT = "selectmultiplestart";
var SELECT_MULTIPLE_END_EVENT = "selectmultipleend";
var DRAG_START_EVENT = "dragstart";
var DRAG_EVENT = "drag";
var DRAG_END_EVENT = "dragend";
var GROUP_COLLAPSE_EVENT = "collapse";
var GROUP_EXPAND_EVENT = "expand";

function Xline(xportO, xportD, id) {
  Xline.STRAIGHT = 0;
  Xline.DOUBLE_ELBOW = 1;
  Xline.DOUBLE_ELBOW_HORIZONTAL = 2;
  Xline.DOUBLE_ELBOW_VERTICAL = 3;
  Xline.ELBOW_HORIZONTAL = 4;
  Xline.ELBOW_VERTICAL = 5;
  Xline.DOUBLE_ELBOW_TOP = 6;
  Xline.DOUBLE_ELBOW_RIGHT = 7;
  Xline.DOUBLE_ELBOW_LEFT = 8;
  Xline.DOUBLE_ELBOW_BOTTOM = 9;
  var width;
  var color;
  var image;
  var text;
  var tip = null;
  var dash = 0;
  var type = Xline.STRAIGHT;
  var points = new Array();
  var attributes = new Array();
  var operations = new Array();
  var xportOrigin = xportO;
  var xportDestination = xportD;
  var originArrow = false;
  var destinationArrow = false;
  var selected = false;
  var selectable = true;
  var mouseover = false;
  var xem = new XEventManager(this);
  this.setWidth = function (w) {
    width = w == null ? 1 : w;
  }
  this.setColor = function (c) {
    color = c == null ? "black" : c;
  }
  this.setImage = function (img) {
    if (img != null) {
      image = new Image();
      image.src = img;
      image.onerror = function() {image.src = "/activator/images/xmaps/notfound.png";};
    } else {
      image = null;
    }
  }
  this.setText = function (t) {
    text = t;
  }
  this.getText = function () {
    return text;
  }
  this.setDash = function (d) {
    dash = isNaN(d) ? 0 : d;
  }
  this.setWidth(1);
  this.setColor("black");
  this.setImage(null);
  this.setText(null);
  xportOrigin.setXline(this);
  xportDestination.setXline(this);
  this.getId = function () {
    return id;
  }
  this.getTip = function () {
    return tip == null ? "" : tip;
  }
  this.setTip = function (t) {
    tip = t;
  }
  this.setType = function (t) {
    type = t;
  }
  this.getType = function () {
    return type;
  }
  this.setOriginArrow = function (oa) {
    originArrow = oa;
  }
  this.setDestinationArrow = function (da) {
    destinationArrow = da;
  }
  this.setSelected = function(s) {
    selected = s;
    if (selected) {
      xem.fireSelectEvent(this);
    } else {
      xem.fireUnselectEvent(this);
    }
  }
  this.isSelected = function () {
    return selected;
  }
  this.setSelectable = function (s) {
    selectable = s;
    if (!selectable) {
      selected = false;
    }
  }
  this.isSelectable = function () {
    return selectable;
  }
  this.setMouseOver = function(s) {
    mouseover = s;
  }
  this.addEventListener = function (name, target) {
    var ename;
    if (name != null && target != null) {
      ename = name.toLowerCase();
      if (ename == SELECT_EVENT) {
        xem.setOnSelectEvent(target);
      } else if (ename == UNSELECT_EVENT) {
        xem.setOnUnselectEvent(target);
      }
    }
  }
  this.addAttribute = function (name, value) {
    attributes.push({
      name: name,
      value: value
    });
  }
  this.getAttributes = function () {
    return attributes;
  }
  this.addOperation = function (name, action) {
    operations.push({
      name: name,
      action: action
    });
  }
  this.getOperations = function () {
    return operations;
  }
  var calculateDimensions = function () {
    var dimO = xportOrigin.getDimensions();
    var dimD = xportDestination.getDimensions();
    var xO = Math.min(dimO.xO + dimO.w / 2, dimD.xO + dimD.w / 2);
    var yO = Math.min(dimO.yO + dimO.h / 2, dimD.yO + dimD.h / 2);
    var xD = Math.max(dimO.xO + dimO.w / 2, dimD.xO + dimD.w / 2);
    var yD = Math.max(dimO.yO + dimO.h / 2, dimD.yO + dimD.h / 2);
    return({
      xO: xO,
      yO: yO,
      xD: xD,
      yD: yD,
      dimO: dimO,
      dimD: dimD
    });
  }
  this.getDimensions = function () {
    return calculateDimensions();
  }
  var hasCorners = function () {
    return type != Xline.STRAIGHT;
  }
  var getCornersCoordinates = function () {
    var coords = new Array();
    var dim = calculateDimensions();
    var oNode = xportOrigin.getXnode();
    var dNode = xportDestination.getXnode();
    switch (type) {
      case Xline.DOUBLE_ELBOW:
      case Xline.DOUBLE_ELBOW_HORIZONTAL:
      case Xline.DOUBLE_ELBOW_VERTICAL:
        if (xportOrigin.isUpDownSide()) {
          // origin and destination ports located at the top/bottom sides of their nodes
          coords.push({
            x: dim.dimO.xO + 2,
            y: (dim.yO + dim.yD) / 2
          });
          coords.push({
            x: dim.dimD.xO + 2,
            y: (dim.yO + dim.yD) / 2
          });
        } else {
          // origin and destination ports located at the left/right sides of their nodes
          coords.push({
            x: (dim.xO + dim.xD) / 2,
            y: dim.dimO.yO + 2
          });
          coords.push({
            x: (dim.xO + dim.xD) / 2,
            y: dim.dimD.yO + 2
          });
        }
        break;
      case Xline.DOUBLE_ELBOW_TOP:
        coords.push({
          x: dim.dimO.xO + 2,
          y: Math.min(dim.dimO.yO - (oNode.isCenterPorts() ? oNode.getDimensions().h / 2 : 0), dim.dimD.yO - (dNode.isCenterPorts() ? dNode.getDimensions().h / 2 : 0)) - 20
        });
        coords.push({
          x: dim.dimD.xO + 2,
          y: Math.min(dim.dimO.yO - (oNode.isCenterPorts() ? oNode.getDimensions().h / 2 : 0), dim.dimD.yO - (dNode.isCenterPorts() ? dNode.getDimensions().h / 2 : 0)) - 20
        });
        break;
      case Xline.DOUBLE_ELBOW_BOTTOM:
        coords.push({
          x: dim.dimO.xO + 2,
          y: Math.max(dim.dimO.yO + (oNode.isCenterPorts() ? oNode.getDimensions().h / 2 : 0), dim.dimD.yO + (dNode.isCenterPorts() ? dNode.getDimensions().h / 2 : 0)) + 20
        });
        coords.push({
          x: dim.dimD.xO + 2,
          y: Math.max(dim.dimO.yO + (oNode.isCenterPorts() ? oNode.getDimensions().h / 2 : 0), dim.dimD.yO + (dNode.isCenterPorts() ? dNode.getDimensions().h / 2 : 0)) + 20
        });
        break;
      case Xline.DOUBLE_ELBOW_LEFT:
        coords.push({
          x: Math.min(dim.dimO.xO - (oNode.isCenterPorts() ? oNode.getDimensions().w / 2 : 0), dim.dimD.xO - (dNode.isCenterPorts() ? dNode.getDimensions().w / 2 : 0)) - 20,
          y: dim.dimO.yO + 2
        });
        coords.push({
          x: Math.min(dim.dimO.xO - (oNode.isCenterPorts() ? oNode.getDimensions().w / 2 : 0), dim.dimD.xO - (dNode.isCenterPorts() ? dNode.getDimensions().w / 2 : 0)) - 20,
          y: dim.dimD.yO + 2
        });
        break;
      case Xline.DOUBLE_ELBOW_RIGHT:
        coords.push({
          x: Math.max(dim.dimO.xO + (oNode.isCenterPorts() ? oNode.getDimensions().w / 2 : 0), dim.dimD.xO + (dNode.isCenterPorts() ? dNode.getDimensions().w / 2 : 0)) + 20,
          y: dim.dimO.yO + 2
        });
        coords.push({
          x: Math.max(dim.dimO.xO + (oNode.isCenterPorts() ? oNode.getDimensions().w / 2 : 0), dim.dimD.xO + (dNode.isCenterPorts() ? dNode.getDimensions().w / 2 : 0)) + 20,
          y: dim.dimD.yO + 2
        });
        break;
      case Xline.ELBOW_HORIZONTAL:
        coords.push({
          x: dim.dimD.xO + 2,
          y: dim.dimO.yO + 2
        });
        break;
      case Xline.ELBOW_VERTICAL:
        coords.push({
          x: dim.dimO.xO + 2,
          y: dim.dimD.yO + 2
        });
        break;
      default:
        break;
    }
    return coords;
  }
  this.getAngle = function () {
    var coordsO = xportOrigin.getCenterCoordinates();
    var coordsD = xportDestination.getCenterCoordinates();
    return coordsD.x == coordsO.x ? -Math.PI/2 : Math.atan((coordsD.y - coordsO.y) / (coordsD.x - coordsO.x));
  }
  this.isCollapsed = function () {
    return xportOrigin != null && xportOrigin.isCollapsed() && xportDestination != null && xportDestination.isCollapsed();
  }
  this.draw = function() {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var coordsO;
    var coordsD;
    var imageX;
    var imageY;
    var slope;
    var corners;
    var corner;
    var ok = true;
    points = new Array();
    if (!this.isCollapsed()) {
      ctx.save();
      ctx.fillStyle = color;
      ctx.strokeStyle = color;
      ctx.lineWidth = width;
      ctx.beginPath();
      coordsO = xportOrigin.getCenterCoordinates();
      coordsD = xportDestination.getCenterCoordinates();
      corners = getCornersCoordinates();
      if (dash > 0) {
        points.push({x:coordsO.x, y:coordsO.y});
        if (corners == null || corners.length == 0) {
          ctx.dashedLine(coordsO.x, coordsO.y, coordsD.x, coordsD.y, dash);
          points.push({x:coordsD.x, y:coordsD.y});
        } else {
          corner = corners[0];
          ctx.dashedLine(coordsO.x, coordsO.y, corner.x, corner.y, dash);
          points.push({x:corner.x, y:corner.y});
          for (var i = 1; i < corners.length; i++) {
            corner = corners[i];
            ctx.dashedLine(corners[i-1].x, corners[i-1].y, corner.x, corner.y, dash);
            points.push({x:corner.x, y:corner.y});
          }
          corner = corners[corners.length - 1];
          ctx.dashedLine(corner.x, corner.y, coordsD.x, coordsD.y, dash);
          points.push({x:coordsD.x, y:coordsD.y});
        }
      } else {
        ctx.moveTo(coordsO.x, coordsO.y);
        points.push({x:coordsO.x, y:coordsO.y});
        if (corners == null || corners.length == 0) {
          ctx.lineTo(coordsD.x, coordsD.y);
          points.push({x:coordsD.x, y:coordsD.y});
        } else {
          for (var i = 0; i < corners.length; i++) {
            corner = corners[i];
            ctx.lineTo(corner.x, corner.y);
            points.push({x:corner.x, y:corner.y});
          }
          ctx.lineTo(coordsD.x, coordsD.y);
          points.push({x:coordsD.x, y:coordsD.y});
        }
      }
      ctx.stroke();
      ctx.restore();
      if (destinationArrow) {
        drawArrow(points[points.length - 2].x, points[points.length - 2].y, points[points.length - 1].x, points[points.length - 1].y, color);
      }
      if (originArrow) {
        drawArrow(points[points.length - 1].x, points[points.length - 1].y, points[points.length - 2].x, points[points.length - 2].y, color);
      }
      if (mouseover) {
        drawAsRect("orange");
      } else if (selected) {
        drawAsRect("blue");
      }
      if (image != null) {
        if (type == Xline.ELBOW_HORIZONTAL || type == Xline.ELBOW_VERTICAL) {
          imageX = points[1].x - image.width / 2;
          imageY = points[1].y - image.height / 2;
        } else if (type == Xline.DOUBLE_ELBOW_TOP || type == Xline.DOUBLE_ELBOW_BOTTOM) {
          imageX = (points[1].x + points[2].x - image.width) / 2;
          imageY = points[1].y - image.height / 2;
        } else if (type == Xline.DOUBLE_ELBOW_LEFT || type == Xline.DOUBLE_ELBOW_RIGHT) {
          imageX = points[1].x - image.width / 2;
          imageY = (points[1].y + points[2].y - image.height) / 2;
        } else {
          imageX = (Math.abs(coordsO.x + coordsD.x) - image.width) / 2;
          imageY = (Math.abs(coordsO.y + coordsD.y) - image.height) / 2;
        }
        ctx.drawImage(image, imageX, imageY);
        ok = image.width > 0 && image.height > 0;
      }
      if (text != null) {
        ctx.save();
        slope = (coordsD.y - coordsO.y) / (coordsD.x - coordsO.x);
        if (type == Xline.ELBOW_HORIZONTAL || type == Xline.ELBOW_VERTICAL) {
          ctx.translate(points[1].x + (slope <= 0 ? -2 : 2), points[1].y - 2);
        } else if (type == Xline.DOUBLE_ELBOW_TOP || type == Xline.DOUBLE_ELBOW_BOTTOM) {
          ctx.translate((points[1].x + points[2].x) / 2, points[1].y - 2);
        } else if (type == Xline.DOUBLE_ELBOW_LEFT || type == Xline.DOUBLE_ELBOW_RIGHT) {
          ctx.translate(points[1].x - 2, (points[1].y + points[2].y) / 2);
        } else {
          ctx.translate((coordsO.x + coordsD.x) / 2 + (slope <= 0 ? -2 : 2), (coordsO.y + coordsD.y) / 2 - 2);
        }
        if (!hasCorners()) {
          ctx.rotate(this.getAngle());
        } else if (type == Xline.DOUBLE_ELBOW_LEFT || type == Xline.DOUBLE_ELBOW_RIGHT) {
          ctx.rotate(270 * Math.PI / 180);
        }
        ctx.textAlign = "center";
        ctx.fillText(text, 0, 0);
        ctx.restore();
      }
    }
    return ok;
  }
  var defineAsRect = function () {
    var coordsO = xportOrigin.getCenterCoordinates();
    var coordsD = xportDestination.getCenterCoordinates();
    var dx = coordsD.x - coordsO.x; // deltaX used in length and angle calculations 
    var dy = coordsD.y - coordsO.y; // deltaY used in length and angle calculations
    var lineLength = Math.sqrt(dx * dx + dy * dy);
    var lineRadianAngle = Math.atan2(dy, dx);
    var w = width + 2;
    return({
      translateX:coordsO.x,
      translateY:coordsO.y,
      rotation:lineRadianAngle,
      rectX:0,
      rectY:-w/2,
      rectWidth:lineLength,
      rectHeight:w,
      coordsO:coordsO,
      coordsD:coordsD
    });
  }
  var drawAsRect = function (color) {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var r = defineAsRect();
    var point;
    ctx.save();
    ctx.beginPath();
    ctx.lineWidth = 2;
    ctx.strokeStyle = color;
    if (!hasCorners()) {
      ctx.translate(r.translateX, r.translateY);
      ctx.rotate(r.rotation);
      ctx.rect(r.rectX, r.rectY, r.rectWidth, r.rectHeight);
      ctx.translate(-r.translateX, -r.translateY);
      ctx.rotate(-r.rotation);
    } else {
      ctx.moveTo(r.coordsO.x, r.coordsO.y);
      if (type == Xline.DOUBLE_ELBOW_TOP) {
        ctx.lineTo(points[0].x - 2, points[0].y);
        ctx.lineTo(points[1].x - 2, points[1].y - 2);
        ctx.lineTo(points[2].x + 2, points[2].y - 2);
        ctx.lineTo(points[3].x + 2, points[3].y);
        ctx.lineTo(points[3].x - 2, points[3].y);
        ctx.lineTo(points[2].x - 2, points[2].y + 2);
        ctx.lineTo(points[1].x + 2, points[1].y + 2);
        ctx.lineTo(points[0].x + 2, points[0].y);
      } else if (type == Xline.DOUBLE_ELBOW_BOTTOM) {
        ctx.lineTo(points[0].x - 2, points[0].y);
        ctx.lineTo(points[1].x - 2, points[1].y + 2);
        ctx.lineTo(points[2].x + 2, points[2].y + 2);
        ctx.lineTo(points[3].x + 2, points[3].y);
        ctx.lineTo(points[3].x - 2, points[3].y);
        ctx.lineTo(points[2].x - 2, points[2].y - 2);
        ctx.lineTo(points[1].x + 2, points[1].y - 2);
        ctx.lineTo(points[0].x + 2, points[0].y);
      } else if (type == Xline.DOUBLE_ELBOW_LEFT) {
        ctx.lineTo(points[0].x, points[0].y - 2);
        ctx.lineTo(points[1].x - 2, points[1].y - 2);
        ctx.lineTo(points[2].x - 2, points[2].y + 2);
        ctx.lineTo(points[3].x, points[3].y + 2);
        ctx.lineTo(points[3].x, points[3].y - 2);
        ctx.lineTo(points[2].x + 2, points[2].y - 2);
        ctx.lineTo(points[1].x + 2, points[1].y + 2);
        ctx.lineTo(points[0].x, points[0].y + 2);
      } else if (type == Xline.DOUBLE_ELBOW_RIGHT) {
        ctx.lineTo(points[0].x, points[0].y - 2);
        ctx.lineTo(points[1].x + 2, points[1].y - 2);
        ctx.lineTo(points[2].x + 2, points[2].y + 2);
        ctx.lineTo(points[3].x, points[3].y + 2);
        ctx.lineTo(points[3].x, points[3].y - 2);
        ctx.lineTo(points[2].x - 2, points[2].y - 2);
        ctx.lineTo(points[1].x - 2, points[1].y + 2);
        ctx.lineTo(points[0].x, points[0].y + 2);
      } else {
        if (r.coordsO.x <= r.coordsD.x && r.coordsO.y <= r.coordsD.y) {
          for (var i = 0; i < points.length; i++) {
            point = points[i];
            ctx.lineTo(point.x + 2, point.y - 2);
          }
          ctx.lineTo(point.x + 2, point.y + 2);
          for (var i = points.length - 1; i >= 0; i--) {
            point = points[i];
            ctx.lineTo(point.x - 2, point.y + 2);
          }
          ctx.closePath();
        } else if (r.coordsO.x <= r.coordsD.x && r.coordsO.y > r.coordsD.y) {
          for (var i = 0; i < points.length; i++) {
            point = points[i];
            ctx.lineTo(point.x - 2, point.y - 2);
          }
          ctx.lineTo(point.x - 2, point.y + 2);
          for (var i = points.length - 1; i >= 0; i--) {
            point = points[i];
            ctx.lineTo(point.x + 2, point.y + 2);
          }
          ctx.closePath();
        } else if (r.coordsO.x > r.coordsD.x && r.coordsO.y <= r.coordsD.y) {
          for (var i = 0; i < points.length; i++) {
            point = points[i];
            ctx.lineTo(point.x - 2, point.y - 2);
          }
          ctx.lineTo(point.x + 2, point.y + 2);
          for (var i = points.length - 1; i >= 0; i--) {
            point = points[i];
            ctx.lineTo(point.x + 2, point.y + 2);
          }
          ctx.closePath();
        } else {
          for (var i = 0; i < points.length; i++) {
            point = points[i];
            ctx.lineTo(point.x + 2, point.y - 2);
          }
          ctx.lineTo(point.x - 2, point.y + 2);
          for (var i = points.length - 1; i >= 0; i--) {
            point = points[i];
            ctx.lineTo(point.x - 2, point.y + 2);
          }
          ctx.closePath();
        }
      }
    }
    if (color != "transparent") {
      ctx.shadowBlur = 10;
      ctx.shadowColor = color;
      ctx.stroke();
    }
    ctx.restore();
  }
  var addpoint = function (x,y) {
    return "[" + x + ", " + y + "]";
  }
  this.isPointInPath = function(mouseX, mouseY) {
    var isinpath = false;
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    drawAsRect("transparent");
    isinpath = ctx.isPointInPath(mouseX, mouseY);
    return isinpath;
  }
  this.setXportOrigin = function (xport) {
    xportOrigin = xport;
  }
  this.setXportDestination = function (xport) {
    xportDestination = xport;
  }
  this.getXportOrigin = function () {
    return xportOrigin;
  }
  this.getXportDestination = function () {
    return xportDestination;
  }
  var drawArrow = function (x1, y1, x2, y2, color) {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var dx = x2 - x1;
    var dy = y2 - y1;
    // normalize
    var length = Math.sqrt(dx * dx + dy * dy);
    var unitDx = dx / length;
    var unitDy = dy / length;
    // increase this to get a larger arrow head
    var headsize = 5;
    var arrowPoint1 = ({
      x: x2 - unitDx * headsize - unitDy * headsize,
      y: y2 - unitDy * headsize + unitDx * headsize
    });
    var arrowPoint2 = ({
      x: x2 - unitDx * headsize + unitDy * headsize,
      y: y2 - unitDy * headsize - unitDx * headsize
    });
    ctx.beginPath();
    ctx.moveTo(x2,y2);
    ctx.lineTo(arrowPoint1.x,arrowPoint1.y);
    ctx.lineTo(arrowPoint2.x,arrowPoint2.y);
    ctx.lineTo(x2,y2);
    ctx.strokeStyle = color;
    ctx.fillStyle = color;
    ctx.fill();
    ctx.stroke();
  }
}

function Xvline(xgroupO, xgroupD) {
  var color = "#aaaaaa";
  var width = 3;
  var dash = 10;
  this.getOriginXgroup = function () {
    return xgroupO;
  }
  this.getDestinationXgroup = function () {
    return xgroupD;
  }
  this.equals = function (xvline) {
    return xvline != null && xvline.getOriginXgroup() == xgroupO && xvline.getDestinationXgroup() == xgroupD;
  }
  this.draw = function () {
    var canvas;
    var ctx;
    var dimO;
    var dimD;
    var xO;
    var yO;
    var xD;
    var yD;
    if (xgroupO.isCollapsed() && xgroupD.isCollapsed()) {
      canvas = document.getElementById("canvas");
      ctx = canvas.getContext("2d");
      dimO = xgroupO.getDimensions();
      dimD = xgroupD.getDimensions();
      xO = dimO.xO + (dimO.xD - dimO.xO) / 2;
      yO = dimO.yO + (dimO.yD - dimO.yO) / 2;
      xD = dimD.xO + (dimD.xD - dimD.xO) / 2;
      yD = dimD.yO + (dimD.yD - dimD.yO) / 2;
      ctx.save();
      ctx.fillStyle = color;
      ctx.strokeStyle = color;
      ctx.lineWidth = width;
      ctx.beginPath();
      ctx.dashedLine(xO, yO, xD, yD, dash);
      ctx.stroke();
      ctx.restore();
    }
    return true;
  }
}

function Xport(xnode, id) {
  var x = 0;
  var y = 0;
  var width = 5;
  var height = 5;
  var side;
  var text = null;
  var textColor;
  var tip = null;
  var backgroundColor;
  var borderColor;
  var hidden = false;
  var attributes = new Array();
  var operations = new Array();
  var xline;
  var selected = false;
  var selectable = true;
  var mouseover = false;
  var xem = new XEventManager(this);
  this.setBorderColor = function (bc) {
    borderColor = bc == null ? "transaparent" : bc;
  }
  this.setBackgroundColor = function (bc) {
    backgroundColor = bc;
  }
  this.setHidden = function (h) {
    hidden = h;
  }
  this.setText = function (t) {
    text = t;
  }
  this.getText = function () {
    return text;
  }
  this.setTextColor = function (tc) {
    textColor = tc == null ? "#000000" : tc;
  }
  this.setTextColor("#000000");
  this.setBorderColor("blue");
  this.setBackgroundColor("yellow");
  xnode.addXport(this);
  this.getId = function () {
    return id;
  }
  this.getTip = function () {
    return tip == null ? "" : tip;
  }
  this.setTip = function (t) {
    tip = t;
  }
  this.addAttribute = function (name, value) {
    attributes.push({
      name: name,
      value: value
    });
  }
  this.getAttributes = function () {
    return attributes;
  }
  this.addOperation = function (name, action) {
    operations.push({
      name: name,
      action: action
    });
  }
  this.getOperations = function () {
    return operations;
  }
  this.addEventListener = function (name, target) {
    var ename;
    if (name != null && target != null) {
      ename = name.toLowerCase();
      if (ename == SELECT_EVENT) {
        xem.setOnSelectEvent(target);
      } else if (ename == UNSELECT_EVENT) {
        xem.setOnUnselectEvent(target);
      }
    }
  }
  this.setSelected = function(s) {
    selected = s;
    if (selected) {
      xem.fireSelectEvent(this);
    } else {
      xem.fireUnselectEvent(this);
    }
  }
  this.isSelected = function () {
    return selected;
  }
  this.setSelectable = function (s) {
    selectable = s;
    if (!selectable) {
      selected = false;
    }
  }
  this.isSelectable = function () {
    return selectable;
  }
  this.setMouseOver = function(s) {
    mouseover = s;
  }
  this.setCoordinates = function (xcoord, ycoord) {
    x = xcoord;
    y = ycoord;
  }
  this.getCoordinates = function () {
    return({
      x: x,
      y: y
    });
  }
  this.getCenterCoordinates = function () {
    var xgroup = xnode == null ? null : xnode.getXgroup();
    var coords = xgroup == null ? null : xgroup.getCenterCoordinates();
    return this.isCollapsed() ?
    ({
      x: coords.x,
      y: coords.y
    }) :
    ({
      x: x + width / 2,
      y: y + height / 2
    });
  }
  this.getDimensions = function () {
    return({
      xO: x,
      yO: y,
      xD: x + width,
      yD: y + height,
      w: width,
      h: height
    });
  }
  this.setSide = function (s) {
    side = s;
  }
  this.isUpDownSide = function () {
    return side == "up" || side == "down";
  }
  this.isCollapsed = function() {
    return xnode != null && xnode.isCollapsed();
  }
  this.draw = function () {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var align;
    var angle;
    var bgcolor = hidden ? "transparent" : backgroundColor;
    var bdcolor = hidden ? "transparent" : borderColor;
    if (!this.isCollapsed()) {
      ctx.save();
      ctx.beginPath();
      if (backgroundColor != null) {
        ctx.fillStyle = bgcolor;
        ctx.fillRect(x, y, width, height);
        ctx.stroke();
        ctx.restore();
        ctx.save();
      }
      ctx.rect(x, y, width, height);
      ctx.lineWidth = 1;
      ctx.strokeStyle = bdcolor;
      ctx.fillStyle = bdcolor;
      ctx.stroke();
      ctx.restore();
      if (text != null && side != "center") {
        align = side == "right" ? "left" : "right";
        angle = xline.getAngle();
        if (side == "down" && angle > 0 && angle <= Math.PI / 2) {
          align = "left";
        }
        if (side == "up" && angle < 0 && angle >= -Math.PI/2) {
          align = "left";
        }
        ctx.save();
        ctx.translate(x + (angle >= 1 ? 5 : 0), y);
        ctx.rotate(angle);
        ctx.fillStyle = textColor;
        ctx.textAlign = align;
        ctx.fillText(text, 0, 0);
        ctx.restore();
      }
      if (mouseover) {
        drawAsRect("orange");
      } else if (selected) {
        drawAsRect("blue");
      }
    }
    return true;
  }
  this.isPointInPath = function(mouseX, mouseY) {
    var isinpath = false;
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    if (!hidden) {
      drawAsRect("transparent");
      isinpath = ctx.isPointInPath(mouseX, mouseY);
    }
    return isinpath;
  }
  var defineAsRect = function () {
    return({
      rectX:x - 2,
      rectY:y - 2,
      rectWidth:width + 4,
      rectHeight:height + 4
    });
  }
  var drawAsRect = function (color) {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var r = defineAsRect();
    ctx.save();
    ctx.beginPath();
    ctx.rect(r.rectX, r.rectY, r.rectWidth, r.rectHeight);
    ctx.lineWidth = 2;
    ctx.strokeStyle = color;
    if (color != "transparent") {
      ctx.shadowBlur = 10;
      ctx.shadowColor = color;
    }
    ctx.stroke();
    ctx.restore();
  }
  this.getXnode = function () {
    return xnode;
  }
  this.setXline = function (_xline) {
    xline = _xline;
  }
  this.getXline = function () {
    return xline;
  }
}

function Xnode(xcoord, ycoord, w, h, id, txt, img) {
  var x;
  var y;
  var width;
  var height;
  var text;
  var image;
  var tip = null;
  var borderWidth;
  var borderColor;
  var textColor;
  var backgroundColor;
  var layerAttributes = new Array();
  var attributes = new Array();
  var operations = new Array();
  var selectable = true;
  var selected = false;
  var draggable = true;
  var mouseover = false;
  var centerports = false;
  var xports = new Array();
  var xgroup = null;
  var xem = new XEventManager(this);
  this.setCenterPorts = function (cp) {
    centerports = cp == null ? false : cp;
  }
  this.isCenterPorts = function () {
    return centerports;
  }
  this.setCoordinates = function (xcoord, ycoord) {
    x = xcoord == null ? 0 : xcoord;
    y = ycoord == null ? 0 : ycoord;
  }
  this.getCoordinates = function () {
    return({
      x: x,
      y: y
    });
  }
  this.setDimensions = function (w, h) {
    width = w == null ? 0 : w;
    height = h == null ? 0 : h;
  }
  this.getDimensions = function () {
    return({
      xO: x,
      yO: y,
      xD: x + width,
      yD: y + height,
      w: width,
      h: height
    });
  }
  this.setText = function (txt) {
    text = txt;
  }
  this.getText = function () {
    return text;
  }
  this.setImage = function (img) {
    if (img == null) {
      image = null;
    } else {
      image = new Image();
      image.src = img;
      image.onerror = function() {image.src = "/activator/images/xmaps/notfound.png";};
    }
  }
  this.setBorderWidth = function (bw) {
    borderWidth = bw == null ? 1 : bw;
  }
  this.setBorderColor = function (bc) {
    borderColor = bc == null ? "transaparent" : bc;
  }
  this.setTextColor = function (tc) {
    textColor = tc == null ? "black" : tc;
  }
  this.setBackgroundColor = function (bc) {
    backgroundColor = bc;
  }
  this.setXgroup = function (xg) {
    xgroup = xg;
  }
  this.getXgroup = function () {
    return xgroup;
  }
  this.setCoordinates(xcoord, ycoord);
  this.setDimensions(w, h);
  this.setText(txt);
  this.setImage(img);
  this.setBorderWidth(1);
  this.setBorderColor("black"); // default border color is black
  this.setTextColor("black"); // default text color is black
  this.setBackgroundColor("#ecf2fd");
  this.getId = function () {
    return id;
  }
  this.getTip = function () {
    return tip == null ? "" : tip;
  }
  this.setTip = function (t) {
    tip = t;
  }
  this.addLayerAttribute = function (name, value) {
    layerAttributes.push({
      name: name,
      value: value
    });
  }
  this.getLayerAttributes = function () {
    return layerAttributes;
  }
  this.addAttribute = function (name, value) {
    attributes.push({
      name: name,
      value: value
    });
  }
  this.getAttributes = function () {
    return attributes;
  }
  this.addOperation = function (name, action) {
    operations.push({
      name: name,
      action: action
    });
  }
  this.getOperations = function () {
    return operations;
  }
  this.setSelected = function(s) {
    var oldvalue;
    if (selectable) {
      oldvalue = selected;
      selected = s;
      if (oldvalue != selected) {
        if (selected) {
          xem.fireSelectEvent(this);
        } else {
          xem.fireUnselectEvent(this);
        }
      }
    }
  }
  this.isSelected = function () {
    return selected;
  }
  this.setSelectable = function (s) {
    selectable = s;
    if (!selectable) {
      selected = false;
    }
  }
  this.isSelectable = function () {
    return selectable;
  }
  this.setDraggable = function (d) {
    draggable = d;
  }
  this.isDraggable = function () {
    return selectable && draggable;
  }
  this.setMouseOver = function(s) {
    mouseover = s;
  }
  this.addEventListener = function (name, target) {
    var ename;
    if (name != null && target != null) {
      ename = name.toLowerCase();
      if (ename == SELECT_EVENT) {
        xem.setOnSelectEvent(target);
      } else if (ename == UNSELECT_EVENT) {
        xem.setOnUnselectEvent(target);
      } else if (ename == DRAG_START_EVENT) {
      
      } else if (ename == DRAG_EVENT) {
      
      } else if (ename == DRAG_END_EVENT) {
      
      }
    }
  }
  this.isCollapsed = function () {
    return xgroup != null && xgroup.isCollapsed();
  }
  this.draw = function () {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var dimensions = checkDimensions();
    if (!this.isCollapsed()) {
      ctx.save();
      ctx.beginPath();
      ctx.lineWidth = borderWidth;
      ctx.fillStyle = backgroundColor;
      if (backgroundColor != null) {
        ctx.fillRect(x, y, width, height);
      }
      if (borderWidth > 0 && borderColor != "transparent") {
        ctx.strokeStyle = borderColor;
        ctx.strokeRect(x, y, width, height);
      }
      ctx.restore();
      ctx.save();
      if (image != null) {
        ctx.drawImage(image, dimensions.imgx, dimensions.imgy);
      }
      if (text != null) {
        ctx.fillStyle = textColor;
        ctx.fillText(text, dimensions.textx, dimensions.texty);
      }
      ctx.stroke();
      ctx.restore();
      if (mouseover) {
        drawAsRect("orange");
      } else if (selected) {
        drawAsRect("blue");
      }
    }
    return dimensions.ok;
  }
  this.drawScale = function (xrel, yrel) {
    if (!this.isCollapsed()) {
      var canvas = document.getElementById("scanvas");
      var ctx = canvas.getContext("2d");
      var _x = x * xrel;
      var _y = y * yrel;
      var _width = width * xrel;
      var _height = height * yrel;
      ctx.save();
      ctx.beginPath();
      ctx.lineWidth = "1";
      ctx.fillStyle = backgroundColor;
      if (backgroundColor != null) {
        ctx.fillRect(_x, _y, _width, _height);
      }
      ctx.strokeStyle = borderColor != null && borderColor != "transparent" ? borderColor : "black";
      ctx.strokeRect(_x, _y, _width, _height);
      ctx.restore();
      ctx.stroke();
      ctx.restore();
    }
  }
  var checkDimensions = function () {
    var nameWidth = 0;
    var nameHeight = 0;
    var imgWidth = 0;
    var imgHeight = 0;
    var ok = true;
    if (text != null) {
      var oNameTry = ie ? document.body.appendChild(document.createElement("span")) : document.body.appendChild(document.createElement("table"));
      oNameTry.style.position = "absolute";
      oNameTry.style.top = 0;
      oNameTry.style.left = 0;
      oNameTry.style.height = 5;
      oNameTry.style.fontFamily = "Arial";
      oNameTry.style.fontSize = "10px";
      if (ie) {
        oNameTry.innerText = text;
        nameWidth = oNameTry.clientWidth;
        nameHeight = oNameTry.clientHeight;
      } else {
        oNameTry.innerHTML = "<tr><td nowrap id=texter>" + text + "</td></tr>";
        nameWidth = document.getElementById("texter").clientWidth;
        nameHeight = document.getElementById("texter").clientHeight;
      }
      document.body.removeChild(oNameTry);
    }
    if (image != null) {
      imgWidth = image.width;
      imgHeight = image.height;
      ok = imgHeight != 0;
    }
    // Check node width and height
    width = Math.max(Math.max(nameWidth + 10, width), imgWidth + 10);
    height = Math.max(imgHeight + 10, height);
    if (text != null) {
      height = Math.max(height, imgHeight + 10 + nameHeight);
    }
    return({
      ok:ok,
      imgx: x + (width - imgWidth) / 2,
      imgy: y + 3,
      textx: x + (width - nameWidth) / 2,
      texty: imgHeight == 0 ? y + (height - nameHeight) / 2 + 10 : y + imgHeight + 15
    });
  }
  var defineAsRect = function () {
    return({
      rectX:x - 2,
      rectY:y - 2,
      rectWidth:width + 4,
      rectHeight:height + 4
    });
  }
  var drawAsRect = function (color) {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var r = defineAsRect();
    ctx.save();
    ctx.beginPath();
    ctx.rect(r.rectX, r.rectY, r.rectWidth, r.rectHeight);
    ctx.lineWidth = 2;
    ctx.strokeStyle = color;
    if (color != "transparent") {
      ctx.shadowBlur = 10;
      ctx.shadowColor = color;
    }
    ctx.stroke();
    ctx.restore();
  }
  this.isPointInPath = function(mouseX, mouseY) {
    var isinpath = false;
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    drawAsRect("transparent");
    isinpath = ctx.isPointInPath(mouseX, mouseY);
    return isinpath;
  }
  this.addXport = function (xport) {
    xports.push(xport);
  }
  this.arrangeXports = function () {
    var up = new Array();
    var down = new Array();
    var left = new Array();
    var right = new Array();
    var center = new Array();
    var xport;
    var xportRemote;
    var xline;
    var xnodeRemote;
    var coords;
    var coordsRemote;
    var xportx;
    var xporty;
    var nports;
    var slope;
    var dimensions;
    var isOriginPort;
    var lineType;
    if (centerports) {
      for (var i = 0; i < xports.length; i++) {
        xport = xports[i];
        center.push(xport);
        xport.setHidden(true);
      }
    } else {
      for (var i = 0; i < xports.length; i++) {
        xport = xports[i];
        xline = xport.getXline();
        if (xline == null) {
          up.push(xport);
        } else {
          xportRemote = xline.getXportOrigin();
          if (xport == xportRemote) {
            xportRemote = xline.getXportDestination();
            isOriginPort = true;
          } else {
            isOriginPort = false;
          }
          if (xportRemote == null) {
            up.push(xport);
          } else {
            xnodeRemote = xportRemote.getXnode();
            if (xnodeRemote == null) {
              up.push(xport);
            } else {
              lineType = xline.getType();
              if (lineType == null) {
                lineType = Xline.STRAIGHT;
              }
              coords = this.getCoordinates();
              coordsRemote = xnodeRemote.getCoordinates();
              switch (lineType) {
                case Xline.STRAIGHT:
                case Xline.DOUBLE_ELBOW:
                  if (coordsRemote.x == coords.x) {
                    if (coordsRemote.y > coords.y) {
                      down.push(xport);
                    } else {
                      up.push(xport);
                    }
                  } else {
                    slope = (coordsRemote.y - coords.y) / (coordsRemote.x - coords.x);
                    if (slope > -1 && slope < 1) {
                      if (coordsRemote.x > coords.x) {
                        right.push(xport);
                      } else {
                        left.push(xport);
                      }
                    } else {
                      if (coordsRemote.y > coords.y) {
                        down.push(xport);
                      } else {
                        up.push(xport);
                      }
                    }
                  }
                  break;
                case Xline.DOUBLE_ELBOW_HORIZONTAL:
                  if (coords.x <= coordsRemote.x) {
                    right.push(xport);
                  } else {
                    left.push(xport);
                  }
                  break;
                case Xline.DOUBLE_ELBOW_VERTICAL:
                  if (coords.y <= coordsRemote.y) {
                    down.push(xport);
                  } else {
                    up.push(xport);
                  }
                  break;
                case Xline.DOUBLE_ELBOW_TOP:
                  up.push(xport);
                  break;
                case Xline.DOUBLE_ELBOW_LEFT:
                  left.push(xport);
                  break;
                case Xline.DOUBLE_ELBOW_RIGHT:
                  right.push(xport);
                  break;
                case Xline.DOUBLE_ELBOW_BOTTOM:
                  down.push(xport);
                  break;
                case Xline.ELBOW_HORIZONTAL:
                  if (isOriginPort) {
                    if (coords.x <= coordsRemote.x) {
                      right.push(xport);
                    } else {
                      left.push(xport);
                    }
                  } else {
                    if (coords.y <= coordsRemote.y) {
                      down.push(xport);
                    } else {
                      up.push(xport);
                    }
                  }
                  break;
                case Xline.ELBOW_VERTICAL:
                  if (isOriginPort) {
                    if (coords.y <= coordsRemote.y) {
                      down.push(xport);
                    } else {
                      up.push(xport);
                    }
                  } else {
                    if (coords.x <= coordsRemote.x) {
                      right.push(xport);
                    } else {
                      left.push(xport);
                    }
                  }
                  break;
                default:
                  break;
              }
            }
          }
        }
      }
    }
    dimensions = checkDimensions();
    if (centerports) {
      nports = center.length;
      for (var i = 0; i < nports; i++) {
        xportx = x + width / 2;
        xporty = y + height / 2;
        center[i].setCoordinates(xportx, xporty);
        center[i].setSide("center");
      }
    } else {
      nports = up.length;
      for (var i = 0; i < nports; i++) {
        xportx = x + Math.floor(width / (nports + 1) * (i + 1));
        xporty = y - 3;
        up[i].setCoordinates(xportx, xporty);
        up[i].setSide("up");
      }
      nports = down.length;
      for (var i = 0; i < nports; i++) {
        xportx = x + Math.floor(width / (nports + 1) * (i + 1));
        xporty = y + height - 3;
        down[i].setCoordinates(xportx, xporty);
        down[i].setSide("down");
      }
      nports = left.length;
      for (var i = 0; i < nports; i++) {
        xportx = x - 3;
        xporty = y + height / (nports + 1) * (i + 1);
        left[i].setCoordinates(xportx, xporty);
        left[i].setSide("left");
      }
      nports = right.length;
      for (var i = 0; i < nports; i++) {
        xportx = x + width - 3;
        xporty = y + height / (nports + 1) * (i + 1);
        right[i].setCoordinates(xportx, xporty);
        right[i].setSide("right");
      }
    }
    return dimensions.ok;
  }
}

function Xgroup(id, text) {
  var DEFAULT_COLOR = "#003366";
  var xnodes = new Array();
  var color = DEFAULT_COLOR;
  var collapsedColor = DEFAULT_COLOR;
  var textColor = DEFAULT_COLOR;
  var image = new Image();
  image.src = "/activator/images/xmaps/xgroup.png";
  var frontImage = null;
  var collapsed = false;
  var xem = new XEventManager();
  var MARGIN = 5;
  var initx = Number.MAX_VALUE;
  var inity = Number.MAX_VALUE;
  var endx = 0;
  var endy = 0;
  var lastinitx;
  var lastinity;
  var xCoords = new Array();
  this.addXnode = function (xnode) {
    xnodes.push(xnode);
    xnode.setXgroup(this);
  }
  this.setColor = function (c) {
    color = c;
  }
  this.setTextColor = function (c) {
    textColor = c;
  }
  this.setCollapsedColor = function (c) {
    collapsedColor = c;
  }
  this.setCollapsed = function () {
    collapsed = !collapsed;
    if (collapsed) {
      xem.fireCollapseEvent(this);
    } else {
      xem.fireExpandEvent(this);
    }
  }
  this.isCollapsed = function() {
    return collapsed;
  }
  this.setImage = function (img) {
    image.src = img;
    image.onerror = function() {image.src = "/activator/images/xmaps/notfound.png";};
  }
  this.setFrontImage = function (img) {
    frontImage = new Image();
    frontImage.src = img;
    frontImage.onerror = function() {frontImage.src = "/activator/images/xmaps/notfound.png";};
  }
  this.getId = function () {
    return id;
  }
  this.getText = function () {
    return text;
  }
  this.addEventListener = function (name, target) {
    var ename;
    if (name != null && target != null) {
      ename = name.toLowerCase();
      if (ename == GROUP_COLLAPSE_EVENT) {
        xem.setOnCollapseEvent(target);
      } else if (ename == GROUP_EXPAND_EVENT) {
        xem.setOnExpandEvent(target);
      }
    }
  }
  this.draw = function() {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var xnode;
    var dim;
    var r;
    initx = Number.MAX_VALUE;
    inity = Number.MAX_VALUE;
    endx = 0;
    endy = 0;
    for (var i = 0; i < xnodes.length; i++) {
      xnode = xnodes[i];
      dim = xnode.getDimensions();
      initx = Math.min(initx, dim.xO);
      inity = Math.min(inity, dim.yO);
      endx = Math.max(endx, dim.xD);
      endy = Math.max(endy, dim.yD);
    }
    r = defineAsRect();
    ctx.save();
    ctx.beginPath();
    ctx.globalAlpha = 0.5;
    ctx.fillStyle = collapsed ? collapsedColor : color;
    ctx.fillRect(r.rectX, r.rectY, r.rectWidth, r.rectHeight);
    ctx.stroke();
    ctx.restore();
    ctx.save();
    ctx.rect(r.rectX, r.rectY, r.rectWidth, r.rectHeight);
    ctx.lineWidth = 1;
    ctx.strokeStyle = collapsed ? collapsedColor : color;
    ctx.stroke();
    ctx.restore();
    ctx.save();
    if (collapsed) {
      image.width = Math.min(60, image.width);
      image.height = Math.min(30, image.height);
      ctx.drawImage(image, r.rectX + 20, r.rectY + 15, image.width, image.height);
    } else if (frontImage != null) {
      frontImage.width = r.rectWidth - 20;
      frontImage.height = r.rectHeight - 20;
      ctx.drawImage(frontImage, r.rectX + 10, r.rectY + 15, frontImage.width, frontImage.height);
    }
    ctx.translate(collapsed ? r.rectX + r.rectWidth / 2 : r.rectX + r.rectWidth / 2 + MARGIN, r.rectY + MARGIN * 2);
    ctx.fillStyle = textColor;
    ctx.textAlign = "center";
    if (text != null) {
      ctx.fillText(text, 0, 0);
    }
    ctx.restore();
    return true;
  }
  this.drawScale = function (xrel, yrel) {
    var canvas = document.getElementById("scanvas");
    var ctx = canvas.getContext("2d");
    var r = defineAsRect();
    var bgcolor = color == null || color == "transparent" ? DEFAULT_COLOR : color;
    var colcolor = collapsedColor == null || collapsedColor == "transparent" ? bgcolor : collapsedColor;
    ctx.save();
    ctx.beginPath();
    ctx.globalAlpha = 0.5;
    ctx.fillStyle = collapsed ? colcolor : bgcolor;
    ctx.fillRect(r.rectX * xrel, r.rectY * yrel, r.rectWidth * xrel, r.rectHeight * yrel);
    ctx.stroke();
    ctx.restore();
    ctx.save();
    ctx.rect(r.rectX * xrel, r.rectY * yrel, r.rectWidth * xrel, r.rectHeight * yrel);
    ctx.lineWidth = 1;
    ctx.strokeStyle = collapsed ? colcolor : bgcolor;
    ctx.stroke();
    ctx.restore();
  }
  this.getDimensions = function () {
    var r = defineAsRect();
    return ({
      xO:r.rectX,
      yO:r.rectY,
      xD:r.rectX + r.rectWidth,
      yD:r.rectY + r.rectHeight
    });
  }
  this.getLastDimensions = function () {
    var r = defineAsRect();
    return ({
      xO:lastinitx,
      yO:lastinity,
      xD:r.rectX + r.rectWidth,
      yD:r.rectY + r.rectHeight
    });
  }
  var defineAsRect = function () {
    return collapsed ?
    ({
      rectX:(initx + endx) / 2 - 50,
      rectY:(inity + endy) / 2 - 25,
      rectWidth:100,
      rectHeight:50
    }) :
    ({
      rectX:initx - MARGIN,
      rectY:inity - MARGIN * 3,
      rectWidth:endx - initx + MARGIN * 2,
      rectHeight:endy - inity + MARGIN * 4
    });
  }
  var drawAsRect = function (color) {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var r = defineAsRect();
    ctx.save();
    ctx.beginPath();
    ctx.rect(r.rectX, r.rectY, r.rectWidth, r.rectHeight);
    ctx.lineWidth = 1;
    ctx.strokeStyle = color;
    ctx.stroke();
    ctx.restore();
  }
  this.isPointInPath = function(mouseX, mouseY) {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    drawAsRect("transparent");
    return ctx.isPointInPath(mouseX, mouseY);
  }
  this.getCenterCoordinates = function () {
    var r = defineAsRect();
    return ({
      x:r.rectX + r.rectWidth / 2,
      y:r.rectY + r.rectHeight / 2
    });
  }
  this.saveCoordinates = function () {
    lastinitx = initx;
    lastinity = inity;
    xcoords = new Array();
    for (var i = 0; i < xnodes.length; i++) {
      xnode = xnodes[i];
      xcoords.push(xnode.getCoordinates());
    }
  }
  this.setCoordinates = function (xcoord, ycoord) {
    var diffx = xcoord - lastinitx;
    var diffy = ycoord - lastinity;
    var xnode;
    var coords;
    for (var i = 0; i < xnodes.length; i++) {
      xnode = xnodes[i];
      coords = xcoords[i];
      xnode.setCoordinates(coords.x + diffx, coords.y + diffy);
    }
  }
}

function Xselection() {
  var initx = 0;
  var inity = 0;
  var endx = 0;
  var endy = 0;
  var xitem = null;
  var xnodes = new Array();
  var dims = new Array();
  this.setInitCoordinates = function (x, y) {
    initx = x;
    inity = y;
    xnodes.length = 0;
    dims.length = 0;
  }
  this.setEndCoordinates = function (x, y) {
    endx = x;
    endy = y;
  }
  this.getDimensions = function () {
    var xO = Math.min(initx, endx);
    var yO = Math.min(inity, endy);
    var xD = Math.max(initx, endx);
    var yD = Math.max(inity, endy);
    return({
      xO: xO,
      yO: yO,
      xD: xD,
      yD: yD
    });
  }
  this.draw = function () {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    ctx.save();
    ctx.beginPath();
    ctx.fillStyle = "rgba(255, 255, 255, 0.5)";
    ctx.fillRect(initx, inity, endx - initx, endy - inity);
    ctx.stroke();
    ctx.restore();
    ctx.save();
    ctx.rect(initx, inity, endx - initx, endy - inity);
    ctx.lineWidth = 1;
    ctx.strokeStyle = "#003366";
    ctx.fillStyle = "#003366";
    ctx.stroke();
    ctx.restore();
    ctx.save();
  }
  this.setSingleSelectedXitem = function (_xitem) {
    xitem = _xitem;
  }
  this.getSelectedXitems = function () {
    return xnodes.length > 0 ? xnodes : xitem == null ? [] : [xitem];
  }
  this.addSelectedXnode = function (xnode) {
    xnodes.push(xnode);
    dims.push(xnode.getDimensions());
  }
  this.getSelectedXnodes = function () {
    return xnodes;
  }
  this.clearSelectedXnodes = function () {
    xitem = null;
    xnodes.length = 0;
    dims.length = 0;
  }
  this.arrangeSelectedXnodesDimensions = function () {
    dims.length = 0;
    for (var i = 0; i < xnodes.length; i++) {
      dims.push(xnodes[i].getDimensions());
    }
  }
  this.getSelectedXnodesDimensions = function () {
    return dims;
  }
  this.getSingleSelectedXnode = function () {
    var xnode = null;
    var xitems = this.getSelectedXitems();
    if (xitems != null && xitems.length == 1) {
      xnode = xitems[0];
      if (!(xnode instanceof Xnode)) {
        xnode = null;
      }
    }
    return xnode;
  }
}

function Xbgtext(x, y, id, text) {
  var color;
  var font;
  this.getId = function () {
    return id;
  }
  this.setColor = function (c) {
    color = c == null ? "black" : c;
  }
  this.setFont = function (f) {
    font = f;
  }
  this.setColor("black");
  this.setFont("italic 20pt Calibri");
  this.draw = function () {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var oldfont = ctx.font;
    ctx.save();
    ctx.beginPath();
    ctx.font = font;
    ctx.fillStyle = color;
    ctx.fillText(text, x, y);
    ctx.stroke();
    ctx.restore();
    ctx.font = oldfont;
    return true;
  }
}

function Xbgimage(x, y, id, image) {
  var loaded = false;
  var oImage = new Image();
  oImage.src = image;
  oImage.onerror = function() {
    oImage.src = "/activator/images/xmaps/notfound.png";
    loaded = true;
  };
  oImage.onload = function() {
    loaded = true;
    Xcanvas.draw();
  };
  this.getId = function () {
    return id;
  }
  this.draw = function () {
    if (loaded) {
      var canvas = document.getElementById("canvas");
      var ctx = canvas.getContext("2d");
      ctx.save();
      ctx.beginPath();
      ctx.drawImage(oImage, x, y);
      ctx.stroke();
      ctx.restore();
    }
    return true;
  }
}

function Xdock() {
  var hidden = false;
  var filled = false;
  var attsflag = false;
  var scaleflag = false;
  var saveAllowed = false;
  var saveInMemoryAllowed = false;
  var reloadAllowed = false;
  var customops = new Array();
  this.setShowAttributes = function() {
    attsflag = !attsflag;
    filled = false;
    this.draw();
  }
  this.isShowAttributes = function () {
    return attsflag;
  }
  this.setShowScale = function() {
    scaleflag = !scaleflag;
    filled = false;
    this.draw();
  }
  this.isShowScale = function () {
    return scaleflag;
  }
  this.setSaveAllowed = function (allowed) {
    saveAllowed = allowed;
  }
  this.isSaveAllowed = function() {
    return saveAllowed;
  }
  this.setSaveInMemoryAllowed = function (allowed) {
    saveInMemoryAllowed = allowed;
  }
  this.isSaveInMemoryAllowed = function() {
    return saveInMemoryAllowed;
  }
  this.setReloadAllowed = function (allowed) {
    reloadAllowed = allowed;
  }
  this.isReloadAllowed = function() {
    return reloadAllowed;
  }
  this.setHidden = function (h) {
    hidden = h;
  }
  this.addDockOperation = function (img, toggle, defaultToggle, action, alt) {
    customops.push({
      img: img,
      toggle: toggle,
      value: toggle ? defaultToggle : false,
      action: action,
      alt: alt
    });
  }
  this.toggleDockOperation = function (index) {
    var customop = index < customops.length ? customops[index] : null;
    if (customop != null && customop.toggle) {
      customops[index] = ({
        img: customop.img,
        toggle: customop.toggle,
        value: !customop.value,
        action: customop.action,
        alt: customop.alt
      });
      filled = false;
      this.draw();
    }
  }
  this.draw = function () {
    var odiv;
    var html;
    var canvas = document.getElementById("canvas");
    var xcontainer = document.getElementById("xcontainer");
    var dockdiv = document.getElementById("xdock");
    var customop;
    if (!hidden) {
      if (dockdiv == null) {
        odiv = document.createElement("div");
        odiv.setAttribute("id", "xdock");
        dockdiv = document.body.appendChild(odiv);
        dockdiv.style.position = "absolute";
        dockdiv.style.background = Xcanvas.getBoxBackgroundColor();
        dockdiv.style.border = "outset " + Xcanvas.getBoxBorderColor() + " 4px";
      }
      if (!filled) {
        html = "<table style=\"border-collapse:separate; border-spacing:1px;\"><tr>";
        if (saveAllowed) {
          html += "<td style=\"width:20px; height:18px; border:1px solid transparent; cursor:pointer;\" ";
          html += "onmouseover=\"this.style.border='1px solid #003366';this.style.background='#e9edfb'\" ";
          html += "onmouseout=\"this.style.border='1px solid transparent';this.style.background='transparent'\" ";
          html += "onclick=\"Xcanvas.saveCoordinates();\" title=\"Save coordinates in database\">"
          html += "<img src=\"/activator/images/xmaps/save.png\" style=\"position:relative; top:2px; left:2px;\">";
          html += "</td>";
        } else if (saveInMemoryAllowed) {
          html += "<td style=\"width:20px; height:18px; border:1px solid transparent; cursor:pointer;\" ";
          html += "onmouseover=\"this.style.border='1px solid #003366';this.style.background='#e9edfb'\" ";
          html += "onmouseout=\"this.style.border='1px solid transparent';this.style.background='transparent'\" ";
          html += "onclick=\"Xcanvas.saveCoordinates();\" title=\"Save coordinates in memory\">"
          html += "<img src=\"/activator/images/xmaps/savem.png\" style=\"position:relative; top:2px; left:2px;\">";
          html += "</td>";
        }
        if (reloadAllowed) {
          html += "<td style=\"width:20px; height:18px; border:1px solid transparent; cursor:pointer;\" ";
          html += "onmouseover=\"this.style.border='1px solid #003366';this.style.background='#e9edfb'\" ";
          html += "onmouseout=\"this.style.border='1px solid transparent';this.style.background='transparent'\" ";
          html += "onclick=\"Xcanvas.reload();\" title=\"Reload\">"
          html += "<img src=\"/activator/images/xmaps/reload.png\" style=\"position:relative; top:2px; left:2px;\">";
          html += "</td>";
        }
        html += "<td style=\"width:20px; height:18px; cursor:pointer; border:1px solid " + (attsflag ? "#a97b22" : "transparent") + "; background:" + (attsflag ? "#faf2be" : "transparent") + ";\" ";
        html += "onmouseover=\"this.style.border='1px solid " + (attsflag ? "#bcad47" : "#003366") + "';this.style.background='" + (attsflag ? "#fdfbed" : "#e9edfb") + "'\" ";
        html += "onmouseout=\"this.style.border='1px solid " + (attsflag ? "#a97b22" : "transparent") + "';this.style.background='" + (attsflag ? "#faf2be" : "transparent") + "'\" ";
        html += "onclick=\"Xcanvas.showAttributes();\" title=\"" + (attsflag ? "#Hide Attributes View" : "Show Attributes View") + "\">"
        html += "<img src=\"/activator/images/xmaps/atts.png\" style=\"position:relative; top:2px; left:2px;\">";
        html += "</td>";
        html += "<td style=\"width:20px; height:18px; cursor:pointer; border:1px solid " + (scaleflag ? "#a97b22" : "transparent") + "; background:" + (scaleflag ? "#faf2be" : "transparent") + ";\" ";
        html += "onmouseover=\"this.style.border='1px solid " + (scaleflag ? "#bcad47" : "#003366") + "';this.style.background='" + (scaleflag ? "#fdfbed" : "#e9edfb") + "'\" ";
        html += "onmouseout=\"this.style.border='1px solid " + (scaleflag ? "#a97b22" : "transparent") + "';this.style.background='" + (scaleflag ? "#faf2be" : "transparent") + "'\" ";
        html += "onclick=\"Xcanvas.showScale();\" title=\"" + (scaleflag ? "#Hide Scale View" : "Show Scale View") + "\">"
        html += "<img src=\"/activator/images/xmaps/scale.png\" style=\"position:relative; top:2px; left:2px;\">";
        html += "</td>";
        if (Xcanvas.isPrevious()) {
          html += "<td style=\"width:20px; height:18px; border:1px solid transparent; cursor:pointer;\" ";
          html += "onmouseover=\"this.style.border='1px solid #003366';this.style.background='#e9edfb'\" ";
          html += "onmouseout=\"this.style.border='1px solid transparent';this.style.background='transparent'\" ";
          html += "onclick=\"Xcanvas.previous();\" title=\"Go to previous diagram\">"
          html += "<img src=\"/activator/images/xmaps/layer-top.png\" style=\"position:relative; top:2px; left:2px;\">";
          html += "</td>";
        }
        if (Xcanvas.isNext()) {
          html += "<td style=\"width:20px; height:18px; border:1px solid transparent; cursor:pointer;\" ";
          html += "onmouseover=\"this.style.border='1px solid #003366';this.style.background='#e9edfb'\" ";
          html += "onmouseout=\"this.style.border='1px solid transparent';this.style.background='transparent'\" ";
          html += "onclick=\"Xcanvas.next();\" title=\"Go to next diagram\">"
          html += "<img src=\"/activator/images/xmaps/layer-bottom.png\" style=\"position:relative; top:2px; left:2px;\">";
          html += "</td>";
        }
        if (customops.length > 0) {
          html += "<td width:10px; height:18px; border:1px solid transparent; background:transparent;\">"
          html += "<img src=\"/activator/images/xmaps/dot.png\" width=\"6px\" height=\"16px\" style=\"position:relative; top:2px; left:0px;\">";
          html += "</td>";
          for (var i = 0; i < customops.length; i++) {
            customop = customops[i];
            html += "<td " + (customop.alt != null ? "title=\"" + customop.alt + "\"" : "") + " style=\"width:20px; height:18px; cursor:pointer; border:1px solid " + (customop.value ? "#a97b22" : "transparent") + "; background:" + (customop.value ? "#faf2be" : "transparent") + ";\" ";
            html += "onmouseover=\"this.style.border='1px solid " + (customop.value ? "#bcad47" : "#003366") + "';this.style.background='" + (customop.value ? "#fdfbed" : "#e9edfb") + "'\" ";
            html += "onmouseout=\"this.style.border='1px solid " + (customop.value ? "#a97b22" : "transparent") + "';this.style.background='" + (customop.value ? "#faf2be" : "transparent") + "'\" ";
            html += "onclick=\"Xcanvas.toggleDockOperation(" + i + ");" + customop.action + "\">"
            html += "<img src=\"" + customop.img + "\" width=\"16px\" height=\"16px\" style=\"position:relative; top:2px; left:2px;\">";
            html += "</td>";
          }
        }
        html += "</tr></table>";
        dockdiv.innerHTML = html;
        filled = true;
      }
      dockdiv.style.top = ($("#xcontainer").offset().top + xcontainer.clientHeight - 60) + "px";
      dockdiv.style.left = ($("#xcontainer").offset().left + (xcontainer.clientWidth - dockdiv.offsetWidth) / 2) + "px";
    }
  }
  this.setOpacity = function (x, y) {
    var xcontainer = document.getElementById("xcontainer");
    var dockdiv = document.getElementById("xdock");
    if (dockdiv != null) {
      var xdockx = parseInt(dockdiv.style.left + dockdiv.clientWidth/2);
      var xdocky = parseInt(dockdiv.style.top + dockdiv.clientHeight/2);
      var diff = Math.max(Math.abs(x-xdockx-xcontainer.scrollLeft), Math.abs(y-xdocky-xcontainer.scrollTop));
      if (diff > 200) {
        $("#xdock").css({ opacity: 0.0 });
      } else if (diff > 100) {
        diff -= 100;
        $("#xdock").css({ opacity: (1.0-diff/100) });
      } else {
        $("#xdock").css({ opacity: (1.0) });
      }
    }
  }
}

function Xattributes (xdock, xselection) {
  var index = 0;
  this.setXitem = function (xitem) {
    var i;
    var _xitem;
    var xitems = xselection.getSelectedXitems();
    if (xitems != null) {
      for (i = 0; i < xitems.length; i++) {
        _xitem = xitems[i];
        if (_xitem.getId() == xitem.getId()) {
          index = i;
        }
      }
    }
    this.draw();
  }
  this.setIndex = function (i) {
    index = i;
    this.draw();
  }
  this.draw = function() {
    var html;
    var title;
    var attributes;
    var attribute;
    var xitem = null;
    var xitems;
    var width = 208;
    var xcontainer = document.getElementById("xcontainer");
    var x = xcontainer.clientWidth - width - 5;
    var y = 10;
    var h = "95%";
    var height = xcontainer.clientHeight - 15;
    var borderWidth = 4;
    var attdiv = document.getElementById("xatts");
    if (attdiv == null) {
      odiv = document.createElement("div");
      odiv.setAttribute("id", "xatts");
      attdiv = document.body.appendChild(odiv);
      attdiv.style.position = "absolute";
      attdiv.style.top = (y + $("#xcontainer").offset().top) + "px";
      attdiv.style.left = (x + $("#xcontainer").offset().left) + "px";
      attdiv.style.width = width + "px";
      attdiv.style.height = height + "px";
      attdiv.style.background = Xcanvas.getBoxBackgroundColor();
      $('#xatts').hide(0);
    }
    if (xdock.isShowAttributes()) {
      height = xdock.isShowScale() ? xcontainer.clientHeight - 230 : xcontainer.clientHeight - 15;
      attdiv.style.height = height + "px";
      xitems = xselection.getSelectedXitems();
      index = Math.min(index, xitems.length - 1);
      html = "<div style=\"border:outset " + Xcanvas.getBoxBorderColor() + " 4px; width:" + (width - borderWidth * 2) + "px; height:" + (height - borderWidth * 2) + "px; padding:0px; margin:0px; overflow:hidden;\">";
      html += "<table cellspacing=\"1\" cellpadding=\"1\" width=\"100%\" style=\"font-family:Arial,Verdana; font-size:10pt;\">";
      html += "<tr><td height=\"20\" colspan=\"2\" style=\"vertical-align:top; background:" + Xcanvas.getBoxBackgroundColorTitle() + ";\">";
      html += "<div id=\"attheader\" style=\"white-space:nowrap; width:100%; overflow:hidden;\">";
      html += "<img border=\"0\" src=\"/activator/images/xmaps/atts.png\" style=\"position:relative; top:2px; left:2px;\">";
      html += "<span id=\"atttitle\" style=\"margin-left:10px; font-weight:bold; color:#162e63;\"></span>";
      html += "</div>";
      html += "</td></tr>";
      if (xitems != null && xitems.length > 0) {
        if (xitems.length == 1) {
          xitem = xitems[0];
        } else { // xitems must be xnodes
          html += "<tr><td colspan=\"2\" style=\"vertical-align:top;\">";
          html += "<select id=\"xselector\" style=\"width:100%\" onchange=\"this.xattributes.setIndex(this.value);\">"
          for (var i = 0; i < xitems.length; i++) {
            html += "<option value=\"" + i + "\" + " + (index == i ? "selected" : "") + ">" + xitems[i].getText() + "</option>";
            if (index == i) {
              xitem = xitems[i];
            }
          }
          html += "</select>";
          html += "</td></tr>";
          h = "92%";
        }
      }
      html += "</table>";
      html += "<div style=\"width:" + (width - borderWidth * 2) + "px; height:" + h + "; padding:0px; margin:0px; overflow-y:auto;\">";
      html += "<table cellspacing=\"1\" cellpadding=\"1\" width=\"100%\" style=\"font-family:Arial,Verdana; font-size:10pt;\">";
      attributes = xitem == null ? Xcanvas.getAttributes() : xitem.getAttributes();
      if (attributes != null && attributes.length > 0) {
        for (var i = 0; i < attributes.length; i++) {
          attribute = attributes[i];
          html += "<tr height=\"16\" style=\"vertical-align:top; font-size:8pt; background:" + (i % 2 == 0 ? Xcanvas.getBoxBackgroundColorEven() : Xcanvas.getBoxBackgroundColorOdd()) + ";\">";
          html += "<td style=\"font-style: italic;\">" + attribute.name + "</td><td>" + attribute.value + "</td>";
          html += "</tr>";
        }
      }
      html += "<tr><td>&nbsp;</td><td>&nbsp;</td></tr>";
      html += "</table></div></div>";
      attdiv.innerHTML = html;
      if (document.getElementById("xselector")) {
        document.getElementById("xselector").xattributes = this;
      }
      title = xitem == null ? Xcanvas.getTitle() : (xitem.getText() == null ? xitem.getId() : xitem.getText());
      if (title == null) {
        title = xitem == null ? "XMap" : xitem.constructor.name;
      }
      document.getElementById("atttitle").innerHTML = title;
      $('#xatts').fadeIn('slow');
    } else {
      $('#xatts').fadeOut('slow');
    }
  }
}

function Xscale(xdock) {
  var borderWidth = 4;
  var xrel;
  var yrel;
  var eventX = null;
  var eventY = null;
  var xcsctop = null;
  var xcscleft = null;
  this.draw = function (xnodes, xgroups) {
    var html;
    var width = 208;
    var height = 208;
    var xcontainer = document.getElementById("xcontainer");
    var x = xcontainer.clientWidth - width - 5;
    var y = xcontainer.clientHeight - height - 5;
    var canvas;
    var xcontainer;
    var xcwidth;
    var xcheight;
    var attdiv = document.getElementById("xscale");
    if (attdiv == null) {
      odiv = document.createElement("div");
      odiv.setAttribute("id", "xscale");
      attdiv = document.body.appendChild(odiv);
      attdiv.style.position = "absolute";
      attdiv.style.top = (y + $("#xcontainer").offset().top) + "px";
      attdiv.style.left = (x + $("#xcontainer").offset().left) + "px";
      attdiv.style.width = width + "px";
      attdiv.style.height = height + "px";
      attdiv.style.background = Xcanvas.getBackgroundColor();
      $('#xscale').hide(0);
    }
    if (xdock.isShowScale()) {
      canvas = document.getElementById("canvas");
      xcontainer = document.getElementById("xcontainer");
      xcwidth = xcontainer.clientWidth - borderWidth * 2;
      xcheight = xcontainer.clientHeight - borderWidth * 2;
      xrel = (width - 8) / canvas.width;
      yrel = (height - 8) / canvas.height;
      html = "<div style=\"border:outset " + Xcanvas.getBoxBorderColor() + " 4px; width:" + (width - borderWidth * 2) + "px; height:" + (height - borderWidth * 2) + "px; padding:0px; margin:0px;\">";
      html += "<canvas id=\"scanvas\" width=\"200\" height=\"200\"></canvas>";
      html += "</div>";
      attdiv.innerHTML = html;
      drawScaleXgroups(xgroups, xrel, yrel);
      drawScaleXnodes(xnodes, xrel, yrel);
      drawScaleViewArea(xrel, yrel);
      $('#xscale').fadeIn('slow');
    } else {
      $('#xscale').fadeOut('slow');
    }
  }
  var drawScaleXnodes = function (xnodes, xrel, yrel) {
    if (xnodes != null) {
      for (var j = 0; j < xnodes.length; j++) {
        xnodes[j].drawScale(xrel, yrel);
      }
    }
  }
  var drawScaleXgroups = function (xgroups, xrel, yrel) {
    if (xgroups != null) {
      for (var j = 0; j < xgroups.length; j++) {
        xgroups[j].drawScale(xrel, yrel);
      }
    }
  }
  var drawScaleViewArea = function() {
    var xcontainer = document.getElementById("xcontainer");
    var xcwidth = xcontainer.clientWidth - borderWidth * 2;
    var xcheight = xcontainer.clientHeight - borderWidth * 2;
    var sctop = xcontainer.scrollTop;
    var scleft = xcontainer.scrollLeft;
    var canvas = document.getElementById("scanvas");
    var ctx = canvas.getContext("2d");
    var viewDim;
    if (xcontainer.scrollHeight > xcontainer.clientHeight || xcontainer.scrollWidth > xcontainer.clientWidth) {
      viewDim = ({
        x: scleft * xrel,
        y: sctop * yrel,
        w: xcwidth * xrel,
        h: xcheight * yrel
      });
      ctx.save();
      ctx.beginPath();
      ctx.rect(viewDim.x, viewDim.y, viewDim.w, viewDim.h);
      ctx.lineWidth = 1;
      ctx.strokeStyle = "#003366";
      ctx.stroke();
      ctx.restore();
      ctx.save();
      ctx.fillStyle = "#0000ff";
      ctx.globalAlpha = 0.1;
      ctx.fillRect(0, 0, 200, viewDim.y);
      ctx.fillRect(0, viewDim.y, viewDim.x, viewDim.h);
      ctx.fillRect(viewDim.x + viewDim.w, viewDim.y, 200 - viewDim.x + viewDim.w, viewDim.h);
      ctx.fillRect(0, viewDim.y + viewDim.h, 200, 200 - viewDim.y + viewDim.h);
      ctx.restore();
      ctx.save();
      addEvent("mousedown", canvas, Xcanvas.handleMouseDownScale);
      addEvent("mousemove", canvas, Xcanvas.handleMouseMoveScale);
      addEvent("mouseup", canvas, Xcanvas.handleMouseUpScale);
    }
  }
  this.handleMouseDownScale = function (e) {
    var canvasOffset = $("#scanvas").offset(); // get canvas's relative position
    var offsetX = canvasOffset.left;
    var offsetY = canvasOffset.top;
    eventX = parseInt(e.clientX-offsetX);
    eventY = parseInt(e.clientY-offsetY);
    xcsctop = document.getElementById("xcontainer").scrollTop;
    xcscleft = document.getElementById("xcontainer").scrollLeft;
  }
  this.handleMouseMoveScale = function (e) {
    if (eventX != null && eventY != null) {
      var canvasOffset = $("#scanvas").offset(); // get canvas's relative position
      var offsetX = canvasOffset.left;
      var offsetY = canvasOffset.top;
      var mouseX = parseInt(e.clientX-offsetX);
      var mouseY = parseInt(e.clientY-offsetY);
      var incX = mouseX - eventX;
      var incY = mouseY - eventY;
      document.getElementById("xcontainer").scrollLeft = xcscleft + incX / xrel;
      document.getElementById("xcontainer").scrollTop = xcsctop + incY / yrel;
      Xcanvas.debug();
    }
  }
  this.handleMouseUpScale = function (e) {
    eventX = null;
    eventY = null;
    xcsctop = null;
    xcscleft = null;
  }
  this.getInc = function() {
    return [incX, incY, document.getElementById("xcontainer").scrollTop + incY / yrel];
  }
}

function XEvent(name, source) {
  this.getName = function () {
    return name;
  }
  this.getSource = function () {
    return source;
  }
}

function XEventManager (owner) {
  var select = null;
  var unselect = null;
  var selectMultipleStart = null;
  var selectMultipleEnd = null;
  var dragStart = null;
  var drag = null;
  var dragEnd = null;
  var collapse = null;
  var expand = null;
  this.setOnSelectEvent = function (target) {
    select = target;
  }
  this.fireSelectEvent = function (source) {
    var xevent;
    if (select != null) {
      xevent = new XEvent(SELECT_EVENT, source);
      fireEvent(select, window, xevent);
    }
  }
  this.setOnUnselectEvent = function (target) {
    unselect = target;
  }
  this.fireUnselectEvent = function (source) {
    var xevent;
    if (unselect != null) {
      xevent = new XEvent(UNSELECT_EVENT, source);
      fireEvent(unselect, window, xevent);
    }
  }
  this.setOnSelectMultipleStartEvent = function (target) {
    selectMultipleStart = target;
  }
  this.fireSelectMultipleStartEvent = function (source) {
    var xevent;
    if (selectMultipleStart != null) {
      xevent = new XEvent(SELECT_MULTIPLE_START_EVENT, source);
      fireEvent(selectMultipleStart, window, xevent);
    }
  }
  this.setOnSelectMultipleEndEvent = function (target) {
    selectMultipleEnd = target;
  }
  this.fireSelectMultipleEndEvent = function (source) {
    var xevent;
    if (selectMultipleEnd != null) {
      xevent = new XEvent(SELECT_MULTIPLE_END_EVENT, source);
      fireEvent(selectMultipleEnd, window, xevent);
    }
  }
  this.setOnDragStartEvent = function (target) {
    dragStart = target;
  }
  this.fireDragStartEvent = function (source) {
    var xevent;
    if (dragStart != null) {
      xevent = new XEvent(DRAG_START_EVENT, source);
      fireEvent(dragStart, window, xevent);
    }
  }
  this.setOnDragEvent = function (target) {
    drag = target;
  }
  this.fireDragEvent = function (source) {
    var xevent;
    if (drag != null) {
      xevent = new XEvent(DRAG_EVENT, source);
      fireEvent(drag, window, xevent);
    }
  }
  this.setOnDragEndEvent = function (target) {
    dragEnd = target;
  }
  this.fireDragEndEvent = function (source) {
    var xevent;
    if (dragEnd != null) {
      xevent = new XEvent(DRAG_END_EVENT, source);
      fireEvent(dragEnd, window, xevent);
    }
  }
  this.setOnCollapseEvent = function (target) {
    collapse = target;
  }
  this.fireCollapseEvent = function (source) {
    var xevent;
    if (collapse != null) {
      xevent = new XEvent(GROUP_COLLAPSE_EVENT, source);
      fireEvent(collapse, window, xevent);
    }
  }
  this.setOnExpandEvent = function (target) {
    expand = target;
  }
  this.fireExpandEvent = function (source) {
    var xevent;
    if (expand != null) {
      xevent = new XEvent(GROUP_EXPAND_EVENT, source);
      fireEvent(expand, window, xevent);
    }
  }
  var fireEvent = function (functionName, context, event) {
    var namespaces = functionName.split(".");
    var func = namespaces.pop();
    for (var i = 0; i < namespaces.length; i++) {
      context = context[namespaces[i]];
    }
    return context[func] != null ? context[func].apply(context, [event]) : null;
  }
}

function Xcanvas() {
  var MAX_TRIES = 20;
  var WORKING_MODE = 0;
  var SELECTING_MODE = 1;
  var DRAGGING_MODE = 2;
  var mode = WORKING_MODE;
  var DEFAULT_BORDER_COLOR = "#b5affe";
  var DEFAULT_BOX_BACKGROUND_COLOR = "#dce2fc";
  var sessionKey = null;
  var databaseKey = null;
  var dbDiagramName;
  var dbDiagramSolution;
  var title;
  var tip = null;
  var backgroundColor = null;
  var borderColor = null;
  var borderWidth = null;
  var borderStyle = null;
  var boxBackgroundColor = null;
  var boxBackgroundColorTitle = null;
  var boxBackgroundColorOdd = null;
  var boxBackgroundColorEven = null;
  var boxBorderColor = null;
  var attributes = new Array();
  var operations = new Array();
  var xitems = new Array();
  var xnodes = new Array();
  var xports = new Array();
  var xlines = new Array();
  var xvlines = null;
  var xbgtexts = new Array();
  var xbgimages = new Array();
  var xgroups = new Array();
  var xselection = new Xselection();
  var xdock = new Xdock();
  var xattributes = new Xattributes(xdock, xselection);
  var xscale = new Xscale(xdock);
  var dragx = 0;
  var dragy = 0;
  var tries = 0;
  var borderWidth = 4; // border width of the canvas html element (4px)
  var drawn = false;
  var debugMode = false;
  var dragAllowed = true;
  var selectAllowed = true;
  var cancelDrawing = false;
  var draggingXgroup = null;
  var xem = new XEventManager(this);
  var selectMultipleStart = false;
  var dragStart = false;
  var next = false;
  var previous = false;
  var previousRequestParameters = new Array();
  var requestParameters = new Array();
  Xcanvas.setSessionKey = function (key) {
    sessionKey = key;
  }
  Xcanvas.getSessionKey = function () {
    return sessionKey;
  }
  Xcanvas.setDatabaseKey = function (key) {
    databaseKey = key;
  }
  Xcanvas.getDatabaseKey = function () {
    return databaseKey;
  }
  Xcanvas.setDatabaseDiagramName = function (name) {
    dbDiagramName = name;
  }
  Xcanvas.getDatabaseDiagramName = function () {
    return dbDiagramName;
  }
  Xcanvas.setDatabaseDiagramSolution = function (solution) {
    dbDiagramSolution = solution;
  }
  Xcanvas.getDatabaseDiagramSolution = function () {
    return dbDiagramSolution;
  }
  Xcanvas.setTitle = function (ttl) {
    title = ttl;
  }
  Xcanvas.getTitle = function () {
    return title;
  }
  Xcanvas.setBackgroundColor = function (color) {
    backgroundColor = color;
    if (backgroundColor != null) {
      document.getElementById("xcontainer").style.background = backgroundColor;
    }
  }
  Xcanvas.getBackgroundColor = function () {
    return backgroundColor;
  }
  Xcanvas.setBorderColor = function (c) {
    borderColor = c;
  }
  Xcanvas.getBorderColor = function () {
    return borderColor == null ? DEFAULT_BORDER_COLOR : borderColor;
  }
  Xcanvas.getDefaultBorderColor = function () {
    return DEFAULT_BORDER_COLOR;
  }
  Xcanvas.setBorderWidth = function (w) {
    borderWidth = w;
  }
  Xcanvas.setBorderStyle = function (style) {
    borderStyle = style;
  }
  Xcanvas.getBorderStyle = function () {
    return borderStyle;
  }
  Xcanvas.setBoxBackgroundColor = function (color) {
    boxBackgroundColor = color;
  }
  Xcanvas.getBoxBackgroundColor = function () {
    return boxBackgroundColor == null || boxBackgroundColor == "transparent" ? DEFAULT_BOX_BACKGROUND_COLOR : boxBackgroundColor;
  }
  Xcanvas.setBoxBackgroundColorTitle = function (color) {
    boxBackgroundColorTitle = color;
  }
  Xcanvas.getBoxBackgroundColorTitle = function () {
    return boxBackgroundColorTitle == null ? "#a2b3fb" : boxBackgroundColorTitle;
  }
  Xcanvas.setBoxBackgroundColorOdd = function (color) {
    boxBackgroundColorOdd = color;
  }
  Xcanvas.getBoxBackgroundColorOdd = function () {
    return boxBackgroundColorOdd == null ? "#e5e8f5" : boxBackgroundColorOdd;
  }
  Xcanvas.setBoxBackgroundColorEven = function (color) {
    boxBackgroundColorEven = color;
  }
  Xcanvas.getBoxBackgroundColorEven = function () {
    return boxBackgroundColorEven == null ? "#d9def0" : boxBackgroundColorEven;
  }
  Xcanvas.setBoxBorderColor = function (color) {
    boxBorderColor = color;
  }
  Xcanvas.getBoxBorderColor = function () {
    return boxBorderColor == null || boxBorderColor == "transparent" ? DEFAULT_BORDER_COLOR : boxBorderColor;
  }
  Xcanvas.addEventListener = function (name, target) {
    var ename;
    if (name != null && target != null) {
      ename = name.toLowerCase();
      if (ename == SELECT_EVENT) {
        xem.setOnSelectEvent(target);
      } else if (ename == UNSELECT_EVENT) {
        xem.setOnUnselectEvent(target);
      } else if (ename == SELECT_MULTIPLE_START_EVENT) {
        xem.setOnSelectMultipleStartEvent(target);
      } else if (ename == SELECT_MULTIPLE_END_EVENT) {
        xem.setOnSelectMultipleEndEvent(target);
      } else if (ename == DRAG_START_EVENT) {
        xem.setOnDragStartEvent(target);
      } else if (ename == DRAG_EVENT) {
        xem.setOnDragEvent(target);
      } else if (ename == DRAG_END_EVENT) {
        xem.setOnDragEndEvent(target);
      } else if (ename == GROUP_COLLAPSE_EVENT) {
        xem.setOnCollapseEvent(target);
      } else if (ename == GROUP_EXPAND_EVENT) {
        xem.setOnExpandEvent(target);
      }
    }
  }
  Xcanvas.addAttribute = function (name, value) {
    attributes.push({
      name: name,
      value: value
    });
  }
  Xcanvas.getAttributes = function () {
    return attributes;
  }
  Xcanvas.addOperation = function (name, action) {
    operations.push({
      name: name,
      action: action
    });
  }
  Xcanvas.getOperations = function () {
    return operations;
  }
  Xcanvas.setHiddenDock = function (h) {
    xdock.setHidden(h);
  }
  Xcanvas.addDockOperation = function (img, toggle, defaultToggle, action, alt) {
    xdock.addDockOperation(img, toggle, defaultToggle, action, alt);
  }
  Xcanvas.toggleDockOperation = function (index) {
    xdock.toggleDockOperation(index);
  }
  Xcanvas.clear = function() {
    attributes = new Array();
    operations = new Array();
    xitems = new Array();
    xnodes = new Array();
    xports = new Array();
    xlines = new Array();
    xvlines = null;
    xbgtexts = new Array();
    xbgimages = new Array();
    xgroups = new Array();
    xselection = new Xselection();
    xdock = new Xdock();
    xattributes = new Xattributes(xdock, xselection);
    xscale = new Xscale(xdock);
    xem = new XEventManager(this);sessionKey = null;
    databaseKey = null;
    sessionKey = null;
    next = false;
    previous = false;
    previousRequestParameters = new Array();
    requestParameters = new Array();
  }
  Xcanvas.addXnode = function (x, y, w, h, id, text, image) {
    var xnode = new Xnode(x, y, w, h, id, text, image);
    xnodes.push(xnode);
    xitems.push(xnode);
    return xnode;
  }
  Xcanvas.addXport = function (xnode, id) {
    var xport = new Xport(xnode, id);
    xports.push(xport);
    xitems.push(xport);
    return xport;
  }
  Xcanvas.addXline = function (xportO, xportD, id) {
    var xline = new Xline(xportO, xportD, id);
    xlines.push(xline);
    xitems.push(xline);
    return xline;
  }
  Xcanvas.addXbgtext = function (x, y, id, text) {
    var xbgitem = new Xbgtext(x, y, id, text);
    xbgtexts.push(xbgitem);
    return xbgitem;
  }
  Xcanvas.addXbgimage = function (x, y, id, image) {
    var xbgitem = new Xbgimage(x, y, id, image);
    xbgimages.push(xbgitem);
    return xbgitem;
  }
  Xcanvas.addXgroup = function (id, name) {
    var xgroup = new Xgroup(id, name);
    xgroups.push(xgroup);
    return xgroup;
  }
  Xcanvas.getXnodeIds = function () {
    var ids = new Array();
    for (var i = 0; i < xnodes.length; i++) {
      ids.push(xnodes[i].getId());
    }
    return ids;
  }
  Xcanvas.getXnode = function(id) {
    var xitem = null;
    for (var i = 0; i < xnodes.length && xitem == null; i++) {
      xitem = xnodes[i];
      if (xitem.getId() != id) {
        xitem = null;
      }
    }
    return xitem;
  }
  Xcanvas.getXport = function(id) {
    var xitem = null;
    for (var i = 0; i < xports.length && xitem == null; i++) {
      xitem = xports[i];
      if (xitem.getId() != id) {
        xitem = null;
      }
    }
    return xitem;
  }
  Xcanvas.getXline = function(id) {
    var xitem = null;
    for (var i = 0; i < xlines.length && xitem == null; i++) {
      xitem = xlines[i];
      if (xitem.getId() != id) {
        xitem = null;
      }
    }
    return xitem;
  }
  Xcanvas.getXbgtext = function(id) {
    var xitem = null;
    for (var i = 0; i < xbgtexts.length && xitem == null; i++) {
      xitem = xbgtexts[i];
      if (xitem.getId() != id) {
        xitem = null;
      }
    }
    return xitem;
  }
  Xcanvas.getXbgimage = function(id) {
    var xitem = null;
    for (var i = 0; i < xbgimages.length && xitem == null; i++) {
      xitem = xbgimages[i];
      if (xitem.getId() != id) {
        xitem = null;
      }
    }
    return xitem;
  }
  Xcanvas.getXitem = function(id) {
    var xitem = null;
    for (var i = 0; i < xitems.length && xitem == null; i++) {
      xitem = xitems[i];
      if (xitem.getId() != id) {
        xitem = null;
      }
    }
    return xitem;
  }
  Xcanvas.getXgroup = function(id) {
    var xitem = null;
    for (var i = 0; i < xgroups.length && xitem == null; i++) {
      xitem = xgroups[i];
      if (xitem.getId() != id) {
        xitem = null;
      }
    }
    return xitem;
  }
  Xcanvas.getCompatibilityMode = function () {
    return document.compatMode;
  }
  Xcanvas.isCompatibilityMode = function () {
    return Xcanvas.getCompatibilityMode() == "CSS1Compat" && canvas.getContext;
  }
  Xcanvas.draw = function () {
    if (xvlines == null) {
      xvlines = new Array();
      for (var j = 0; j < xlines.length; j++) {
        var xline = xlines[j];
        var xgroupO = xline.getXportOrigin().getXnode().getXgroup();
        var xgroupD = xline.getXportDestination().getXnode().getXgroup();
        if (xgroupO != null && xgroupD != null && xgroupO != xgroupD) {
          var xvline = new Xvline(xgroupO, xgroupD);
          var found = false;
          for (var i = 0; i < xvlines.length && !found; i++) {
            found = xvline.equals(xvlines[i]);
          }
          if (!found) {
            xvlines.push(xvline);
          }
        }
      }
    }
    if (borderWidth != null || borderColor != null || borderStyle != null) {
      var bColor = borderColor == null ? "#b5affe" : borderColor;
      var bWidth = borderWidth == null ? "4px" : borderWidth + "px";
      var bStyle = borderStyle == null ? "inset" : borderStyle;
      document.getElementById("xcontainer").style.border = bStyle + " " + bColor + " " + bWidth;
    }
    if (!Xcanvas.isCompatibilityMode()) {
      if (!cancelDrawing) {
        var cmode = Xcanvas.getCompatibilityMode();
        cancelDrawing = true;
        alert("Your browser does not support HTML5." + (cmode != null ? "\nCompatibility mode is '" + cmode + "'." : ""));
      }
      return;
    }
    var ok = true;
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var xitems = [xvlines, xgroups, xlines, xnodes, xports];
    var xbgitems = [xbgimages, xbgtexts];
    var xarray;
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (var j = 0; j < xbgitems.length; j++) {
      xarray = xbgitems[j];
      for (var i = 0; i < xarray.length; i++) {
        ok = ok && xarray[i].draw();
      }
    }
    for (var j = 0; j < xnodes.length; j++) {
      ok = ok && xnodes[j].arrangeXports();
    }
    for (var j = 0; j < xitems.length; j++) {
      xarray = xitems[j];
      for (var i = 0; i < xarray.length; i++) {
        ok = ok && xarray[i].draw();
      }
    }
    if (mode == SELECTING_MODE) {
      xselection.draw();
    }
    tries++;
    if (!ok && tries < MAX_TRIES) {
      setTimeout("Xcanvas.draw()", 500);
    } else {
      tries = 0;
      if (!drawn) {
        drawn = true;
        Xcanvas.resize();
      }
      xdock.draw();
    }
    var oElem = document.getElementById("__csres");
    if (oElem == null) {
      oElem = document.createElement("img");
      oElem.setAttribute("id", "__csres");
      oElem.setAttribute("src", "/activator/images/primefaces/throbber.gif");
      oElem = document.body.appendChild(oElem);
      oElem.style.position = "fixed";
      oElem.style.right = "5px";
      oElem.style.bottom = "5px";
      oElem.style.width = "32px";
      oElem.style.height = "32px";
      oElem.style.display = "none";
    }
    oElem = document.getElementById("xtitle");
    if (oElem == null) {
      oElem = document.createElement("div");
      oElem.setAttribute("id", "xtitle");
      oElem = document.body.appendChild(oElem);
      oElem.style.position = "absolute";
      oElem.style.top = "0px";
      oElem.style.left = "0px";
      oElem.style.width = "auto";
      oElem.style.height = "10px";
      oElem.style.textAlign = "center";
      oElem.style.whiteSpace = "nowrap";
      oElem.style.fontSize = "7pt";
      oElem.style.fontFamily = "Arial,Verdana";
      oElem.style.border = "1px solid " + Xcanvas.getBoxBorderColor();
      oElem.style.background = Xcanvas.getBoxBackgroundColor();
      oElem.style.paddingLeft = "5px";
      oElem.style.paddingRight = "5px";
      oElem.style.display = "none";
    }
    if (title != null) {
      oElem.innerHTML = title;
      // set top and left here as they depend on the title length
      oElem.style.top = ($("#xcontainer").offset().top + xcontainer.clientHeight - 15 + borderWidth) + "px";
      oElem.style.left = ($("#xcontainer").offset().left + (xcontainer.clientWidth - oElem.offsetWidth) / 2) + "px";
      oElem.style.display = "block";
    } else {
      oElem.style.display = "none";
    }
  }
  Xcanvas.resize = function () {
    var canvas;
    var bWidth = parseInt($("#xcontainer").css("borderLeftWidth")); // borderWidth doesn't seem to work in IE9
    if (bWidth == null || bWidth == 0) {
      bWidth = borderWidth;
    }
    if ($("#xcontainer").parent().is("body")) {
      $("body").css("overflow", "hidden");
      $("#xcontainer").width($(window).width() - bWidth * 2);
      $("#xcontainer").height($(window).height() - bWidth * 2);
    }
    var xcontainer = document.getElementById("xcontainer");
    var width = xcontainer.clientWidth - bWidth * 2;
    var height = xcontainer.clientHeight - bWidth * 2;
    var oldwidth = width;
    var oldheight = height;
    var dim;
    for (var i = 0; i < xitems.length; i++) {
      dim = xitems[i].getDimensions();
      width = Math.max(width, dim.xD + 20);
      height = Math.max(height, dim.yD + 20);
    }
    if (height > $("#xcontainer").height()) {
      if (width < $("#xcontainer").width()) {
        width -= 20;
      }
    }
    if (width > $("#xcontainer").width()) {
      if (height < $("#xcontainer").height()) {
        height -= 20;
      }
    }
    if (bWidth < 3) {
      height -= 5;
    }
    canvas = document.getElementById("canvas");
    canvas.width  = width;
    canvas.height = height;
    canvas.style.width  = width + 'px';
    canvas.style.height = height + 'px';
    $("#canvas").css("borderWidth", "0px");
    Xcanvas.draw();
  }
  Xcanvas.setDragAllowed = function (da) {
    dragAllowed = selectAllowed ? da : false;
  }
  Xcanvas.setSelectAllowed = function (sa) {
    selectAllowed = sa;
    if (!selectAllowed) {
      Xcanvas.setDragAllowed(false);
    }
  }
  Xcanvas.setSaveAllowed = function (sa) {
    xdock.setSaveAllowed(sa);
  }
  Xcanvas.isSaveAllowed = function () {
    return xdock.isSaveAllowed();
  }
  Xcanvas.setSaveInMemoryAllowed = function (sa) {
    xdock.setSaveInMemoryAllowed(sa);
  }
  Xcanvas.isSaveInMemoryAllowed = function () {
    return xdock.isSaveInMemoryAllowed();
  }
  Xcanvas.setReloadAllowed = function (sa) {
    xdock.setReloadAllowed(sa);
  }
  Xcanvas.isReloadAllowed = function () {
    return xdock.isReloadAllowed();
  }
  Xcanvas.reload = function () {
    var url;
    var param;
    onReload();
    url = "/activator/jsp/xmaps/reload.jsp?sessionKey=" + (Xcanvas.getSessionKey() == null ? "" : escape(Xcanvas.getSessionKey())) +
        "&name=" + (Xcanvas.getDatabaseDiagramName() == null ? "" : escape(Xcanvas.getDatabaseDiagramName())) +
        "&solution=" + (Xcanvas.getDatabaseDiagramSolution() == null ? "" : escape(Xcanvas.getDatabaseDiagramSolution()));
    for (var i = 0; i < requestParameters.length; i++) {
      param = requestParameters[i];
      url += "&" + param.name + "=" + param.value;
    }
    window.open(url, "iupdater__");
    setTimeout("Xcanvas.handleReloadSuccess()", 500); // delay it 500 ms so it is visible that the operation has finished
  }
  var onReload = function () {
    showThrobber();
    generateUpdater();
  }
  Xcanvas.handleReloadSuccess = function () {
    hideThrobber();
  }
  Xcanvas.isNext = function () {
    return next;
  }
  Xcanvas.setNext = function (n) {
    next = n;
  }
  Xcanvas.isPrevious = function () {
    return previous;
  }
  Xcanvas.setPrevious = function (p) {
    previous = p;
  }
  Xcanvas.next = function () {
    var url;
    var param;
    var parameters;
    var xnode = xselection.getSingleSelectedXnode();
    if (xnode != null) {
      onLayerReference();
      url = "/activator/jsp/xmaps/layer.jsp?next=true&sessionKey=" + (Xcanvas.getSessionKey() == null ? "" : escape(Xcanvas.getSessionKey()));
      parameters = xnode.getLayerAttributes();
      if (parameters != null) {
        for (var i = 0; i < parameters.length; i++) {
          param = parameters[i];
          url += "&" + param.name + "=" + param.value;
        }
      }
      window.open(url, "iupdater__");
      setTimeout("Xcanvas.handleLayerReferenceSuccess()", 500); // delay it 500 ms so it is visible that the operation has finished
    }
  }
  Xcanvas.previous = function () {
    var url;
    var param;
    onLayerReference();
    url = "/activator/jsp/xmaps/layer.jsp?next=false&sessionKey=" + (Xcanvas.getSessionKey() == null ? "" : escape(Xcanvas.getSessionKey()));
    for (var i = 0; i < previousRequestParameters.length; i++) {
      param = previousRequestParameters[i];
      url += "&" + param.name + "=" + param.value;
    }
    window.open(url, "iupdater__");
    setTimeout("Xcanvas.handleLayerReferenceSuccess()", 500); // delay it 500 ms so it is visible that the operation has finished
  }
  var generateUpdater = function() {
    var ifrm = document.getElementById("iupdater__");
    if (ifrm == null) {
      ifrm = document.createElement("iframe");
      ifrm.style.width = 0 + "px";
      ifrm.style.height = 0 + "px";
      ifrm.style.display = "none";
      ifrm.style.visibility = "hidden";
      ifrm.setAttribute("id", "iupdater__");
      ifrm.setAttribute("name", "iupdater__");
      ifrm = document.body.appendChild(ifrm);
    }
  }
  var onLayerReference = function () {
    showThrobber();
    generateUpdater();
  }
  Xcanvas.handleLayerReferenceSuccess = function () {
    hideThrobber();
  }
  Xcanvas.addPreviousRequestParameter = function (name, value) {
    previousRequestParameters.push({name:name, value:value});
  }
  Xcanvas.addRequestParameter = function (name, value) {
    requestParameters.push({name:name, value:value});
  }
  Xcanvas.getRequetParameters = function () {
    var rps = new Array();
    var p;
    for (var i = 0; i < requestParameters.length; i++) {
      p = requestParameters[i];
      rps.push({name:p.name, value:p.value});
    }
    return rps.length == 0 ? null : rps;
  }
  Xcanvas.handleDoubleClick = function (e) {
    var xgroup;
    var found = false;
    var canvasOffset = $("#canvas").offset(); // get canvas relative position
    var offsetX = canvasOffset.left;
    var offsetY = canvasOffset.top;
    var mouseX = parseInt(e.clientX-offsetX);
    var mouseY = parseInt(e.clientY-offsetY);
    for (var i = 0; !found && i < xgroups.length; i++) {
      xgroup = xgroups[i];
      if (xgroup.isPointInPath(mouseX, mouseY)) {
        found = true;
        if (xgroup.isCollapsed()) {
          xem.fireExpandEvent(xgroup);
        } else {
          xem.fireCollapseEvent(xgroup);
        }
        xgroup.setCollapsed();
      }
    }
    if (found) {
      Xcanvas.draw();
      xscale.draw(xnodes, xgroups);
    }
  }
  Xcanvas.handleMouseDown = function (e) {
    var canvasOffset = $("#canvas").offset(); // get canvas relative position
    var offsetX = canvasOffset.left;
    var offsetY = canvasOffset.top;
    var mouseX = parseInt(e.clientX-offsetX) + $(document).scrollLeft();
    var mouseY = parseInt(e.clientY-offsetY) + $(document).scrollTop();
    var rightclick = e.which == 3;
    var leftclick = e.which == 1;
    var found = false;
    var xitems = [xports, xnodes, xlines];
    var xarray;
    var xitem;
    var dim;
    var selxnodes = xselection.getSelectedXnodes();
    var selxitems = xselection.getSelectedXitems();
    var unselectEventXitemsFired = new Array();
    var fired;
    selectMultipleStart = false;
    dragStart = false;
    for (var i = 0; i < selxnodes.length; i++) {
      xitem = selxnodes[i];
      if (!xitem.isCollapsed() && xitem.isDraggable()) {
        dim = xitem.getDimensions();
        if (dragAllowed && mouseX >= dim.xO && mouseY >= dim.yO && mouseX <= dim.xD && mouseY <= dim.yD) {
          mode = DRAGGING_MODE;
          dragStart = true;
          dragx = mouseX;
          dragy = mouseY;
          xselection.arrangeSelectedXnodesDimensions();
          xattributes.setXitem(xitem);
          if (rightclick) {
            Xcanvas.showOperations(mouseX + borderWidth + 1, mouseY + borderWidth + 1, xitem);
          } else {
            Xcanvas.hideOperations();
          }
        }
      }
    }
    if (mode == WORKING_MODE && selectAllowed) {
      for (var j = 0; j < xitems.length; j++) {
        xarray = xitems[j];
        for (var i = 0; i < xarray.length; i++) {
          xitem = xarray[i];
          if (!xitem.isCollapsed() && xitem.isSelectable()) {
            if (xitem.isSelected()) {
              xem.fireUnselectEvent(xitem);
              unselectEventXitemsFired.push(xitem);
            }
            xitem.setSelected(false);
            if (!found && xitem.isPointInPath(mouseX, mouseY)) {
              found = true;
              if (selxitems != null && selxitems.length > 0) {
                for (var k = 0; k < selxitems.length; k++) {
                  fired = false;
                  for (var kk = 0; kk < selxitems.length && !fired; kk++) {
                    fired = selxitems[k] == unselectEventXitemsFired[kk];
                  }
                  if (!fired) {
                    xem.fireUnselectEvent(selxitems[k]);
                  }
                }
              }
              xem.fireSelectEvent(xitem);
              xitem.setSelected(true);
              xselection.clearSelectedXnodes();
              if (dragAllowed && xitem instanceof Xnode && leftclick && xitem.isDraggable()) {
                mode = DRAGGING_MODE;
                dragStart = true;
                dragx = mouseX;
                dragy = mouseY;
                xselection.addSelectedXnode(xitem);
                Xcanvas.hideOperations();
              } else {
                xselection.setSingleSelectedXitem(xitem);
                if (rightclick) {
                  Xcanvas.showOperations(mouseX + borderWidth + 1, mouseY + borderWidth + 1, xitem);
                }
              }
              xattributes.setXitem(xitem);
            }
          }
        }
      }
      if (!found && leftclick && dragAllowed) {
        for (var i = 0; !found && i < xgroups.length; i++) {
          xitem = xgroups[i];
          if (xitem.isPointInPath(mouseX, mouseY)) {
            found = true;
            draggingXgroup = xitem;
            draggingXgroup.saveCoordinates();
            mode = DRAGGING_MODE;
            dragStart = true;
            dragx = mouseX;
            dragy = mouseY;
            if (selxitems != null && selxitems.length > 0) {
              for (var k = 0; k < selxitems.length; k++) {
                fired = false;
                for (var kk = 0; kk < selxitems.length && !fired; kk++) {
                  fired = selxitems[k] == unselectEventXitemsFired[kk];
                }
                if (!fired) {
                  xem.fireUnselectEvent(selxitems[k]);
                }
              }
            }
            xselection.clearSelectedXnodes();
          }
        }
      }
      if (!found) {
        if (rightclick) {
          Xcanvas.showOperations(mouseX + borderWidth + 1, mouseY + borderWidth + 1, null);
        } else {
          mode = SELECTING_MODE;
          selectMultipleStart = true;
          if (selxitems != null && selxitems.length > 0) {
            for (var k = 0; k < selxitems.length; k++) {
              fired = false;
              for (var kk = 0; kk < selxitems.length && !fired; kk++) {
                fired = selxitems[k] == unselectEventXitemsFired[kk];
              }
              if (!fired) {
                xem.fireUnselectEvent(selxitems[k]);
              }
            }
          }
          xselection.clearSelectedXnodes();
          xselection.setInitCoordinates(mouseX, mouseY);
          Xcanvas.hideOperations();
        }
      }
    }
    Xcanvas.draw();
  }
  Xcanvas.handleMouseUp = function (e) {
    var selxnodes;
    var selxnode;
    var canvasOffset = $("#canvas").offset(); // get canvas's relative position
    var offsetX = canvasOffset.left;
    var offsetY = canvasOffset.top;
    var mouseX = parseInt(e.clientX-offsetX) + $(document).scrollLeft();
    var mouseY = parseInt(e.clientY-offsetY) + $(document).scrollTop();
    var dim;
    selectMultipleStart = false;
    dragStart = false;
    xscale.handleMouseUpScale();
    if (mode == SELECTING_MODE) {
      xselection.setEndCoordinates(mouseX, mouseY);
      selxnodes = xselection.getSelectedXnodes();
      for (var i = 0; i < selxnodes.length; i++) {
        selxnode = selxnodes[i];
        xem.fireSelectEvent(selxnode);
        selxnode.setSelected(true);
      }
      xattributes.draw();
      dim = xselection.getDimensions();
      if (dim.xO != dim.xD || dim.yO != dim.yD) {
        xem.fireSelectMultipleEndEvent(xselection.getSelectedXitems());
      }
    } else if (mode == DRAGGING_MODE) {
      if (!dragStart) {
        xem.fireDragEndEvent(draggingXgroup == null ? xselection.getSelectedXnodes() : draggingXgroup);
      }
    }
    if (draggingXgroup != null) {
      draggingXgroup = null;
    }
    mode = WORKING_MODE;
    Xcanvas.resize();
    xscale.draw(xnodes, xgroups);
  }
  Xcanvas.handleMouseMove = function (e) {
    var canvasOffset = $("#canvas").offset(); // get canvas's relative position
    var offsetX = canvasOffset.left;
    var offsetY = canvasOffset.top;
    var mouseX = parseInt(e.clientX-offsetX) + $(document).scrollLeft();
    var mouseY = parseInt(e.clientY-offsetY) + $(document).scrollTop();
    var found = false;
    var xitems = [xports, xnodes, xlines];
    var xarray;
    var xitem;
    var overitem = null;
    var seldim;
    var dim;
    var seldims;
    var selxnodes;
    var newtip;
    xselection.setEndCoordinates(mouseX, mouseY);
    if (mode == WORKING_MODE && selectAllowed) {
      for (var j = 0; j < xitems.length; j++) {
        xarray = xitems[j];
        for (var i = 0; i < xarray.length; i++) {
          xitem = xarray[i];
          xitem.setMouseOver(false);
          if (!found && xitem.isSelectable() && xitem.isPointInPath(mouseX, mouseY)) {
            found = true;
            xitem.setMouseOver(true);
            overitem = xitem;
          }
        }
      }
      xdock.setOpacity(mouseX, mouseY);
    } else if (mode == SELECTING_MODE) {
      seldim = xselection.getDimensions();
      xselection.clearSelectedXnodes();
      for (var i = 0; i < xnodes.length; i++) {
        xitem = xnodes[i];
        if (xitem.isSelectable()) {
          dim = xitem.getDimensions();
          if (seldim.xO <= dim.xO && seldim.yO <= dim.yO && seldim.xD >= dim.xD && seldim.yD >= dim.yD) {
            xitem.setMouseOver(true);
            xselection.addSelectedXnode(xitem);
            overitem = xitem;
          } else {
            xitem.setMouseOver(false);
          }
        }
      }
      xdock.setOpacity(0, 0);
      if (selectMultipleStart) {
        selectMultipleStart = false;
        xem.fireSelectMultipleStartEvent(xselection.getSelectedXitems());
      }
    } else if (mode == DRAGGING_MODE) {
      if (draggingXgroup == null) {
        seldims = xselection.getSelectedXnodesDimensions();
        selxnodes = xselection.getSelectedXnodes();
        for (var i = 0; i < selxnodes.length; i++) {
          xitem = selxnodes[i];
          if (xitem.isDraggable()) {
            dim = seldims[i];
            var x = dim.xO + mouseX - dragx;
            var y = dim.yO + mouseY - dragy;
            xitem.setCoordinates(x, y);
          }
        }
        if (dragStart) {
          xem.fireDragStartEvent(selxnodes);
        }
        xem.fireDragEvent(selxnodes);
      } else {
        dim = draggingXgroup.getLastDimensions();
        var x = dim.xO + mouseX - dragx;
        var y = dim.yO + mouseY - dragy;
        draggingXgroup.setCoordinates(x, y);
        if (dragStart) {
          xem.fireDragStartEvent(draggingXgroup);
        }
        xem.fireDragEvent(draggingXgroup);
      }
      xdock.setOpacity(0, 0);
      xscale.draw(xnodes, xgroups);
      dragStart = false;
    }
    Xcanvas.draw();
    Xcanvas.debug();
    newtip = overitem != null ? overitem.getTip() : "";
    if (newtip != tip) {
      tip = newtip;
      document.getElementById("xcontainer").title = tip;
    }
  }
  Xcanvas.handleScroll = function (e) {
    xscale.draw(xnodes, xgroups);
  }
  Xcanvas.handleMouseDownScale = function (e) {
    xscale.handleMouseDownScale(e);
  }
  Xcanvas.handleMouseMoveScale = function (e) {
    xscale.handleMouseMoveScale(e);
  }
  Xcanvas.handleMouseUpScale = function (e) {
    xscale.handleMouseUpScale(e);
  }
  Xcanvas.showOperations = function (x, y, xitem) {
    var width = 100;
    var height = 100;
    var odiv;
    var operations;
    var html;
    var opdiv = document.getElementById("xoperations");
    if (opdiv == null) {
      odiv = document.createElement("div");
      odiv.setAttribute("id", "xoperations");
      opdiv = document.body.appendChild(odiv);
      opdiv.style.position = "absolute";
      opdiv.style.top = (y + $("#xcontainer").offset().top - document.getElementById("xcontainer").scrollTop) + "px";
      opdiv.style.left = (x + $("#xcontainer").offset().left - document.getElementById("xcontainer").scrollLeft) + "px";
      opdiv.style.background = "#dce2fc";
      $('#xoperations').hide(0);
    }
    operations = xitem == null ? Xcanvas.getOperations() : xitem.getOperations();
    if (operations != null && operations.length > 0) {
      html = "<div style=\"border:outset #b5affe 2px; padding:3px; margin:0px; font-family:Arial,Verdana; font-size:9pt;\">";
      for (var i = 0; i < operations.length; i++) {
        html += "<div style=\"cursor:pointer;\" onmouseover=\"this.style.background='#b8c1e5';\" onmouseout=\"this.style.background='transparent'\" ";
        html += "onclick=\"Xcanvas.hideOperations();" + operations[i].action + "\">" + operations[i].name + "</div>";
      }
      html += "</div>";
      opdiv.innerHTML = html;
      opdiv.style.top = (y + $("#xcontainer").offset().top - document.getElementById("xcontainer").scrollTop) + "px";
      opdiv.style.left = (x + $("#xcontainer").offset().left - document.getElementById("xcontainer").scrollLeft) + "px";
      $('#xoperations').fadeIn('slow');
    }
  }
  Xcanvas.hideOperations = function () {
    var opdiv = document.getElementById("xoperations");
    if (opdiv != null) {
      $('#xoperations').fadeOut('slow');
    }
  }
  Xcanvas.showAttributes = function () {
    xdock.setShowAttributes();
    xattributes.draw();
    xscale.draw(xnodes, xgroups);
  }
  Xcanvas.showScale = function () {
    xdock.setShowScale();
    xscale.draw(xnodes, xgroups);
    xattributes.draw();
  }
  Xcanvas.isShowScale = function () {
    return xdock.isShowScale();
  }
  Xcanvas.isShowAttributes = function () {
    return xdock.isShowAttributes();
  }
  Xcanvas.selectXitems = function(xitems) {
    var xitem;
    if (xitems != null && xitems.length > 0) {
      if (xitems.length > 1) {
        for (var i = 0; i < xitems.length; i++) {
          xitem = Xcanvas.getXitem(xitems[i].getId());
          if (xitem != null && xitem instanceof Xnode) {
            xselection.addSelectedXnode(xitem);
          }
        }
      } else {
        xitem = Xcanvas.getXitem(xitems[0].getId());
        if (xitem != null && (xitem instanceof Xnode || xitem instanceof Xline || xitem instanceof Xport)) {
          xselection.setSingleSelectedXitem(xitem);
        }
      }
    }
  }
  Xcanvas.getSelectedXItems = function () {
    return xselection.getSelectedXitems();
  }
  Xcanvas.saveCoordinates = function () {
    var dataToBeSent = {
      coordinates: escape(Xcanvas.getCoordinates()),
      databaseKey: Xcanvas.getDatabaseKey() == null ? "" : escape(Xcanvas.getDatabaseKey()),
      sessionKey: Xcanvas.getSessionKey() == null ? "" : escape(Xcanvas.getSessionKey())
    };
    onSaveCoordinates();
    $.ajax({
      url: '/activator/jsp/xmaps/coordinates.jsp',
      data: dataToBeSent,
      type: 'POST',
      dataType: 'html',
      success: function(response) {
        setTimeout("Xcanvas.handleSaveCoordinatesSuccess()", 500); // delay it 500 ms so it is visible that the operation has finished
      },
      error: function(request, textStatus, errorThrown) {
        alert("error: " + errorThrown);
      }
    });
  }
  var onSaveCoordinates = function () {
    showThrobber();
  }
  Xcanvas.handleSaveCoordinatesSuccess = function () {
    hideThrobber();
  }
  var showThrobber = function () {
    var img = document.getElementById("__csres");
    if (img != null) {
      img.style.display = "block";  
    }
  }
  var hideThrobber = function () {
    var img = document.getElementById("__csres");
    if (img != null) {
      img.style.display = "none";
    }
  }
  Xcanvas.getCoordinates = function () {
    var xml = "<Coordinates>";
    var xgroup;
    var xnode;
    var xcoords;
    for (var i = 0; i < xnodes.length; i++) {
      xnode = xnodes[i];
      xcoords = xnode.getCoordinates();
      xml += "<Node id=\"" + xnode.getId() + "\" x=\"" + xcoords.x + "\" y=\"" + xcoords.y + "\" />"; 
    }
    for (var i = 0; i < xgroups.length; i++) {
      xgroup = xgroups[i];
      xml += "<Group id=\"" + xgroup.getId() + "\" collapsed=\"" + xgroup.isCollapsed() + "\" />"
    }
    xml += "</Coordinates>";
    return xml;
  }
  Xcanvas.loadJsFile = function (file) {
    var fileref;
    if (file != null) {
      fileref = document.createElement('script');
      fileref.setAttribute("type", "text/javascript");
      fileref.setAttribute("src", filename);
      if (typeof fileref != "undefined") {
        document.getElementsByTagName("head")[0].appendChild(fileref);
      }
    }
  }
  Xcanvas.logout = function () {
    var dataToBeSent = {
      sessionKey: Xcanvas.getSessionKey() == null ? "" : escape(Xcanvas.getSessionKey())
    };
    $.ajax({
      url: '/activator/jsp/xmaps/session.jsp',
      data: dataToBeSent,
      type: 'POST',
      dataType: 'html'
    });
    return 1+3;
  }
  Xcanvas.setDebugMode = function(dm) {
    debugMode = dm;
  }
  Xcanvas.debug = function () {
    var odiv;
    var html;
    var selxnodes;
    var debugdiv;
    if (debugMode) {
      debugdiv = document.getElementById("debugger");
      if (debugdiv == null) {
        odiv = document.createElement("div");
        odiv.setAttribute("id", "debugger");
        debugdiv = document.body.appendChild(odiv);
        debugdiv.style.position = "absolute";
        debugdiv.style.top = "5px";
        debugdiv.style.left = "5px";
      }
      selxnodes = xselection.getSelectedXnodes();
      html = "<table>";
      html += "<tr><td>mode</td><td>" + mode + "</td></tr>";
      html += "<tr><td>selected nodes</td><td>" + selxnodes.length + "</td></tr>";
      html += "<tr><td>scrollHeight</td><td>" + document.getElementById("xcontainer").scrollHeight + "</td></tr>";
      html += "<tr><td>scrollTop</td><td>" + document.getElementById("xcontainer").scrollTop + "</td></tr>";
      html += "</table>";
      debugdiv.innerHTML = html;
    }
  }
}
new Xcanvas();

var ie = document.all;
$(function() {
  var resizeTime = new Date(1, 1, 2000, 12,00,00);
  var resizeTimeout = false;
  var resizeDelta = 200;
  function handleDoubleClick(e){
    Xcanvas.handleDoubleClick(e);
  }
  function handleMouseDown(e){
    Xcanvas.handleMouseDown(e);
  }
  function handleMouseUp(e){
    Xcanvas.handleMouseUp(e);
  }
  function handleMouseMove(e){
    Xcanvas.handleMouseMove(e);
  }
  function handleDragStart(e){
    Xcanvas.handleMouseDown(e);
  }
  function handleDragOver(e){
    Xcanvas.handleMouseMove(e);
  }
  function handleDragLeave(e){
    Xcanvas.handleMouseUp(e);
  }
  function handleContextMenu(e) {
    if (e.target.id == "xcontainer" || e.target.id == "canvas") {
      e.stopPropagation();
      e.preventDefault();
    }
    return false;
  }
  function handleScroll(e) {
    Xcanvas.handleScroll(e);
  }
  addEvent("dblclick", canvas, handleDoubleClick);
  addEvent("mousedown", canvas, handleMouseDown);
  addEvent("mouseup", canvas, handleMouseUp);
  addEvent("mousemove", canvas, handleMouseMove);
  addEvent("dragstart", canvas, handleDragStart);
  addEvent("dragover", canvas, handleDragOver);
  addEvent("dragleave", canvas, handleDragLeave);
  addEvent("contextmenu", document.body, handleContextMenu);
  addEvent("scroll", document.getElementById("xcontainer"), handleScroll);
  // resize the diagram 200 ms after the resize event has finished
  $(window).resize(function() {
    resizeTime = new Date();
    if (resizeTimeout == false) {
      resizeTimeout = true;
      setTimeout(resizeEnd, resizeDelta);
    }
  });
  function resizeEnd() {
    if (new Date() - resizeTime < resizeDelta) {
      setTimeout(resizeEnd, resizeDelta);
    } else {
      resizeTimeout = false;
      Xcanvas.resize();
    }               
  }
  if (Xcanvas.isCompatibilityMode()) {
    CanvasRenderingContext2D.prototype.dashedLine = function (x1, y1, x2, y2, dashLen) {
      if (dashLen == undefined) dashLen = 2;
      this.moveTo(x1, y1);
      var dX = x2 - x1;
      var dY = y2 - y1;
      var dashes = Math.floor(Math.sqrt(dX * dX + dY * dY) / dashLen);
      var dashX = dX / dashes;
      var dashY = dY / dashes;
      var q = 0;
      while (q++ < dashes) {
        x1 += dashX;
        y1 += dashY;
        this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x1, y1);
      }
      this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x2, y2);
    };
  }
});

function addEvent(evnt, elem, func) {
  if (elem.addEventListener) { // W3C DOM
    elem.addEventListener(evnt,func,false);
  } else if (elem.attachEvent) { // IE DOM
    elem.attachEvent("on"+evnt, func);
  } else { // Not much to do
    elem[evnt] = func;
  }
}

function Animate () {
  var frameRate = 1/40; // Seconds
  var frameDelay = frameRate * 1000; // ms
  var animations = new Array();
  var loopTimer = false;
  Animate.translate = function (id, dx, dy) {
    var xnode = Xcanvas.getXnode(id);
    var xcoords;
    var ox;
    var oy;
    var radius = 15;
    if (xnode != null) {
      xcoords = xnode.getCoordinates();
      ox = xcoords.x;
      oy = xcoords.y;
      var animation = {
        id: id,
        ox: ox,
        oy: oy,
        dx: dx,
        dy: dy,
        ascx: dx > ox,
        ascy: dy > oy,
        position: {x: ox, y: oy},
        velocity: {x: 0, y: 0},
        mass: 0.1, //kg
        radius: radius, // 1px = 1cm
        restitution: -0.7,
        Cd: 0.47,  // Dimensionless
        rho: 1.22, // kg / m^3
        A: Math.PI * radius * radius / 10000, // m^2
        ag: 9.81,  // m / s^2
        increasing: 1,
        finished: false
      }
      if (ox != dx || oy != dy) {
        animations.push(animation);
      }
    }
  }
  Animate.loopTranslate = function () {
    var doNextLoop = false;
    var ball;
    var fx;
    var fy;
    var ax;
    var ay;
    var oldx;
    var oldy;
    var xnode;
    var xcoords;
    var incx;
    var incy;
    var x;
    var y;
    var absx;
    var absy;
    var stop;
    for (var index = 0; index < animations.length; index++) {
      ball = animations[index];
      if (!ball.finished) {
        // Do physics
        // Drag force: Fd = -1/2 * Cd * A * rho * v * v
        fx = -0.5 * ball.Cd * ball.A * ball.rho * ball.velocity.x * ball.velocity.x * ball.velocity.x / Math.abs(ball.velocity.x);
        fy = -0.5 * ball.Cd * ball.A * ball.rho * ball.velocity.y * ball.velocity.y * ball.velocity.y / Math.abs(ball.velocity.y);
        fx = (isNaN(fx) ? 0 : fx);
        fy = (isNaN(fy) ? 0 : fy);
        // Calculate acceleration ( F = ma )
        ax = ball.ag + (fx / ball.mass);
        ay = ball.ag + (fy / ball.mass);
        // Integrate to get velocity
        ball.velocity.x += ax*frameRate * ball.increasing;
        ball.velocity.y += ay*frameRate * ball.increasing;
        oldx = ball.position.x;
        oldy = ball.position.y;
        // Integrate to get position
        ball.position.x += ball.velocity.x * frameRate * 100;
        ball.position.y += ball.velocity.y * frameRate * 100;
        // Draw the ball
        xnode = Xcanvas.getXnode(ball.id);
        xcoords = xnode.getCoordinates();
        incx = ball.position.x - oldx;
        incy = ball.position.y - oldy;
        x = ball.ascx ? xcoords.x + incx : xcoords.x - incx;
        y = ball.ascy ? xcoords.y + incy : xcoords.y - incy;
        absx = Math.abs(ball.dx - x);
        absy = Math.abs(ball.dy - y);
        if (absx > absy) {
          x = (y - ball.oy) * (ball.dx - ball.ox) / (ball.dy - ball.oy) + ball.ox;
          ball.increasing = ball.ascx ? (Math.abs((ball.dx + ball.ox) / 2) < Math.abs(x) ? -1 : 1) : (Math.abs((ball.dx + ball.ox) / 2) < Math.abs(x) ? 1 : -1);
        } else {
          y = (x - ball.ox) * (ball.dy - ball.oy) / (ball.dx - ball.ox) + ball.oy;
          ball.increasing = ball.ascy ? (Math.abs((ball.dy + ball.oy) / 2) < Math.abs(y) ? -1 : 1) : (Math.abs((ball.dy + ball.oy) / 2) < Math.abs(y) ? 1 : -1);
        }
        stop = false;
        if (ball.ascx) {
          if (x > ball.dx || oldx >= x) {
            x = ball.dx;
            y = ball.dy;
            stop = true;
          }
        } else {
          if (x < ball.dx || oldx <= x) {
            x = ball.dx;
            y = ball.dy;
            stop = true;
          }
        }
        if (ball.ascy) {
          if (y > ball.dy || oldy >= y) {
            x = ball.dx;
            y = ball.dy;
            stop = true;
          }
        } else {
          if (y < ball.dy || oldy <= y) {
            x = ball.dx;
            y = ball.dy;
            stop = true;
          }
        }
        if (stop) {
          ball.finished = true;
        } else {
          doNextLoop = true;
        }
        if (x < 0) {
          x = 0;
        }
        if (y < 0) {
          y = 0;
        }
        ball.position.x = x;
        ball.position.y = y;
        xnode.setCoordinates(x, y);
      }
    }
    Xcanvas.draw();
    if (!doNextLoop) {
      clearTimeout(loopTimer);
      animations = new Array();
    }
  }
  Animate.flush = function() {
    loopTimer = setInterval("Animate.loopTranslate()", frameDelay);
  }
}
new Animate();

$(window).on('beforeunload', function() {
  var x = Xcanvas.logout();
  return;
});