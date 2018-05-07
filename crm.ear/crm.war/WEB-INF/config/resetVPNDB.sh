#! /bin/bash
###############################################################################
#
#   ****  COPYRIGHT NOTICE ****
#
#	(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
#
###############################################################################

###############################################################################
#
# <Description> 
#
###############################################################################


#echo "Redeploying portal database..."
#echo "=============================="
#
#cd ../inventory/
#./RemoveCRMTables.sh NoPrompt << EOF
#
#EOF
#./DeployCRMTables.sh NoPrompt << EOF
#
#EOF
#./DeployCRMSequences.sh NoPrompt << EOF
#
#EOF
##DB_USER=""
##DB_PASSWORD=""
if [ ! -e ./setenv.crmportal ]; then
  ./generate_setenv.sh
fi
. ./setenv.crmportal

if [ -z $DB_USER ] || [ -z $DB_PASSWORD ] ; then
	CURRENT_DIR=`pwd`
	cd $SOLUTION/etc/config
	. GetDBParams.sh
	cd "$CURRENT_DIR"
fi

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

export DB_USER DB_PASSWORD

./initVPNDB.sh << EOF

EOF

echo
echo "Load portal data..."
echo "==================="

cd ./sql
./DeployPortalData.sh NoPrompt << EOF

EOF

echo
echo Press enter to continue
read
