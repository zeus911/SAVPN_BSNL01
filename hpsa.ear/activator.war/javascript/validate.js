/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.

**********************************************************************/


//checks for emailserver format
function validate(form1)
{

	var emailServer = form1.emailserver.value;
	var alertMessage = "The correct format for EmailServer is:- smtp:<mailHost>";
	
		var emailArray = emailServer.split(":");
		if(emailArray.length>1)
		{
			if(!(emailArray[0].toLowerCase() == "smtp"))
			{
				alert(alertMessage);
				form1.emailserver.focus();
				return false;
			}
			if(emailArray[1].length<=0)
			{
				alert(alertMessage);
				form1.emailserver.focus();
				return false;
			}
			
		}
		else
		{
			alert(alertMessage);
			form1.emailserver.focus();
			return false;
		
		}
				
	return true;
}

//check for web server format and email format

function validateAddress(form1)
{
	var webAlert ="The correct format for WebServer is:- user@host/dir";
	var emailAlert= "The correct format for Email is:-  user@host";
	
	//web Address 
	var webAddress = form1.webserver.value ;
		
	//email Address
	var emailAddress = form1.email.value;
	
	//Check for web server address format is user@host/dir
	if(webAddress.length>0)
	{
		var webArray = webAddress.split("@")
		if(webArray.length>1)
		{
			var webArray1 =	webArray[1].split("/");
			if((webArray1.length<=1)||(webArray[0].length<=0)||(webArray1[0].length<=0)
				||(webArray1[1].length<=0))
			{
				alert(webAlert);
				form1.webserver.focus();
				return false;
			}
					
		
		}
		else
		{
			alert(webAlert);
			form1.webserver.focus();
			return false;
		}
	}
	//web server validation ends here
	
	//Check for email address format is user@host

	if(emailAddress.length>0)
	{
		var emailArray = emailAddress.split("@");
		if((emailArray.length <=1)||(emailArray[0].length<=0)||(emailArray[1].length<=0))
		{
		
			alert(emailAlert);
			form1.email.focus();
			return false;
		}
	}
	//email address validation ends here
	
	return true;		
	 
}


                     