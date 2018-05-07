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


echo "Clear portal database..."
echo "========================"

cd ../src/inventory/
./RemoveCRMTables.sh NoPrompt << EOF

EOF

echo
echo "Deploy portal database..."
echo "========================="

./DeployCRMTables.sh NoPrompt << EOF

EOF
./DeployCRMSequences.sh NoPrompt << EOF

EOF

echo
echo "Load portal initial data..."
echo "==========================="

cd ../../config/sql
./DeployPortalInitData.sh NoPrompt << EOF

EOF

cd ..

echo
echo Press enter to continue
read
