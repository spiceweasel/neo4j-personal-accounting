#!/bin/bash

if [[ -x ./env_variables.sh ]]; then
	. ./env_variables.sh	
else
	echo "./env_variables.sh is not executable.  Please 'chmod +x ./env_variables.sh' to make executable before running this script."
	exit
fi

if [ -z "$expense_accounts" ]; then
	echo "'expense_accounts' environment variable not found."
	echo "Please export this variable using the 'env_variables.sh' file."
	exit
fi

account_len=${#expense_accounts[@]}

echo
echo "Accounts:"
for (( i=0; i<$account_len; i++));
do
    echo "- ${expense_accounts[i]}"
done
echo