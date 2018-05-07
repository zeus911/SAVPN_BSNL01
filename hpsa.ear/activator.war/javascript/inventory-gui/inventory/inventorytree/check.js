// check empty
function isEmpty(s)
{
    return ((s == null)||(s.length == 0));
}

function isCharsInBag(s, bag)
{
    var i;
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) return false;
    }
    return true;
}

function checkNum(s, digit)
{
  if (s == "0")
  {
  	  return true;
  }
  if (isEmpty(s))
  {
      return false;
  }
  if(!isCharsInBag (s.charAt(0), "+-123456789"))
  {
      return false;
  }
  if(!isCharsInBag (s.substring(1, s.length), "0123456789"))
  {
      return false;
  }
  if (s.charAt(0) == '+' || s.charAt(0) == '-')
  {
      if (s.charAt(1) == '0')
      {
      	return false;
      } 
      if (s.length - 1 > digit)
      {
      	return false;
      }
  } else {
      if (s.length > digit)
      {
      	return false;
      }
  }
    
  return true;
}

function checkDecimal(s, bdigit, adigit)
{
  if (isEmpty(s))
  {
      return false;
  }
  var bdot;
  var adot;
  var index = s.indexOf('.');
  if (index == -1)
  {
      return false;
  }
  var bdot = s.substring(0, index);
  var adot = s.substring(index+1, s.length);
  if (bdot != '0' && bdot != '+0' && bdot!= '-0')
  {
      if (!checkNum(bdot, bdigit))
      {
          return false;
      }
  }
  
  if (adot.indexOf('.') != -1)
  {
      return false;
  }
  if(!isCharsInBag (adot, "0123456789"))
  {
      return false;
  }
  if (adot.length == 0)
  {
      return false;
  }
  if (adot.length > adigit)
  {
      return false;
  }
  return true;
}

// check is it date formate:yyyy-mm-dd
function checkDate(datestr)
{
    if (isEmpty(datestr))
    {
        return false;
    }

    var lthdatestr;
    lthdatestr= datestr.length ;
    var tmpy="";
    var tmpm="";
    var tmpd="";
    var status;
    status=0;

    for (i=0;i<lthdatestr;i++)
    {
        if (datestr.charAt(i)== '/')
        {
            status++;
        }
        if (status>2)
        {
            return false;
        }
        if ((status==0) && (datestr.charAt(i)!='/'))
        {
            tmpy=tmpy+datestr.charAt(i);
        }
        if ((status==1) && (datestr.charAt(i)!='/'))
        {
            tmpm=tmpm+datestr.charAt(i);
        }
        if ((status==2) && (datestr.charAt(i)!='/'))
        {
            tmpd=tmpd+datestr.charAt(i);
        }
    }

    year=new String (tmpy);
    month=new String (tmpm);
    day=new String (tmpd);

    if (!( (1000 <= year) && (9999 >= year) && (1<=month) && (12>=month) && (31>=day) && (1<=day)) )
    {
        return false;
    }
    if (!((year % 4)==0) && (month==2) && (day==29))
    {
        return false;
    }
    if ((month<=7) && ((month % 2)==0) && (day>=31))
    {
        return false;
    }
    if ((month>=8) && ((month % 2)==1) && (day>=31))
    {
        return false;
    }
    if ((month==2) && (day==30))
    {
        return false;
    }
    return true;
}
	
// check if input is a integer
function checkInteger(s)
{
    return checkNum(s, 10)
}

// check if input is a long
function checkLong(s)
{
    return checkNum(s, 17)
}

// check if input is a float
function checkFloat(s)
{
    if (checkNum(s, 39))
    {
    	return true;
    }
    return checkDecimal(s, 39, 7)
}

// check if input is a double
function checkDouble(s)
{
    if (checkNum(s, 308))
    {
    	return true;
    }
    return checkDecimal(s, 308, 15)
}
// input dd/mm/yyyy return Date
// sure about the input format,do not need check

function getAdvancedsearchDate(stringToSplit,format) {
	format = (format) ? format.toUpperCase() : "YYYYMMDD";
	var separator="/";
	var arrayOfStrings = stringToSplit.split(separator);
	if (format=="DDMMYYYY")
		return new Date(arrayOfStrings[2],arrayOfStrings[1],arrayOfStrings[0]);
	else if (format=="MMDDYYYY")
		return new Date(arrayOfStrings[1],arrayOfStrings[2],arrayOfStrings[0]);
	else if (format=="YYYYMMDD")
		return new Date(arrayOfStrings[0],arrayOfStrings[1],arrayOfStrings[2]);
}