#! /bin/bash
###############################################################################
#
#   ****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
##############################################################################

###############################################################################
#
# $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/bin/XMLConverter/doPopulateDB.sh,v $
# $Revision: 1.13 $
# $Date: 2011-01-28 09:13:38 $
# $Author: tanye $
#
###############################################################################
#
# <Description> 
#
###############################################################################

if [ -z $DB_USER ] || [ -z $DB_PASSWORD ] ; then
	echo "Enter Database User"
	read userval
	if [ ! -z $userval ]; then
	  DB_USER=$userval
	fi

	echo "Enter Database Password"
	read -s pwdval
	if [ ! -z $pwdval ]; then
	  DB_PASSWORD=$pwdval
	fi

	if [ -z $DB_USER ] || [ -z $DB_PASSWORD ] ; then
		echo "Database User and User Password cannot be empty"
		exit 1;
	fi
fi

user=$DB_USER
password=$DB_PASSWORD

if [ -f ../../etc/config/setenv.savpnsp ] ; then
 . ../../etc/config/setenv.savpnsp
    echo Preparing population of OVSA 
  # Now set User and Password
   HERE=`pwd`
   cd ./../../etc/config/
   #set $(./PrintDBParams.sh )
   user=$DB_USER
   password=$DB_PASSWORD
   sid=`./PrintDBParams.sh -getSID`

   cd $HERE
fi

if [ -f ../../config/setenv.crmportal ] ; then
   . ../../config/setenv.crmportal
    echo Preparing populating of CRM 
   # Now set User and Password
   HERE=`pwd`
   cd ../../config
   #set $(./PrintDBParams.sh )
   user=$DB_USER
   password=$DB_PASSWORD
   sid=`./PrintDBParams.sh -getSID`

   cd $HERE
fi

sid=$(echo "$sid"|cut -d . -f1)

  if [ -z $user ]  ; then
    echo "Database user is not set"	
    exit 1
  fi

  if [ -z $password ]  ; then
    echo "Database password password or sid is not set"	
    exit 1
  fi

  if [ -z $sid ]  ; then
    echo "ORACLE SID is not set"	
    exit 1
  fi

cp ./ctl/*.ctl  ./tmp/
cd tmp

filelist=`cat loadFiles`
echo $filelist

first=1
end=0
table=""

test_for_load() {
  if [ $first = "1" ]; then
    return 1
  fi

  if [ $end = "1" ]; then
    return 0
  fi

  echo -n "Load table $table [y]? "
  read loadval
  if [ ! -z $loadval ]; then
    if [ $loadval = "y" ]; then
      echo -n "Number of element to skip [0] "
      read skipval
      if [ ! -z $skipval ]; then
        skip="skip=$skipval"  
      else
        skip="skip=0"
      fi
      return 1
    else
      end=1
      return 0
    fi
  fi
  return 1
}

if [ ! -z $1 ]; then
  if [ $1 = "again" ]; then
    first=0
  fi
fi

for file in $filelist 
do
  table=`echo $file | cut -f1 -d"."`
  echo loading $table
 test_for_load || sqlldr control=$file direct=true errors=1 $skip userid=$user/$password@$sid
  res=$?
  if [ $res = 1 ]; then
    echo ""
    echo "Oracle table format does not match the control file $table.ctl"
    exit -1
  fi
  if [ $res = 2 ]; then
    echo ""
    echo "Error encountered during load of table $table"
    echo "Check `pwd`/$table.log for details"
    exit -2
  fi
  sleep 1
done
cd ..
./updateSequences.sh
#./generateReport.sh
