#!/bin/bash

if [[ -x ./env_variables.sh ]]; then
	. ./env_variables.sh	
else
	echo "./env_variables.sh is not executable.  Please 'chmod +x ./env_variables.sh' to make executable before running this script."
	exit
fi

if [ -z "$financial_account_names" ]; then
	echo "'financial_account_names' environment variable not found."
	echo "Please export this variable using the 'env_variables.sh' file."
	exit
fi

if [ -z "$financial_account_periods" ]; then
	echo "'financial_account_periods' environment variable not found."
	echo "Please export this variable using the 'env_variables.sh' file."
	exit
fi

if [ -z "$financial_account_numbers" ]; then
	echo "'financial_account_periods' environment variable not found."
	echo "Please export this variable using the 'env_variables.sh' file."
	exit
fi

if [ -z "$financial_account_types" ]; then
	echo "'financial_account_periods' environment variable not found."
	echo "Please export this variable using the 'env_variables.sh' file."
	exit
fi

if [ -z "$financial_account_budgets" ]; then
	echo "'financial_account_periods' environment variable not found."
	echo "Please export this variable using the 'env_variables.sh' file."
	exit
fi

account_len=${#financial_account_names[@]}

return_elements=()

echo -- START --
for (( i=0; i<$account_len; i++));
do
	echo "create (fa${i}:FinancialAccount {name:\"${financial_account_names[i]}\", period:\"${financial_account_periods[i]}\", number:\"${financial_account_numbers[i]}\", type:\"${financial_account_types[i]}\", budget_amount:${financial_account_budgets[i]}, description:\"\", isActive:true})"
	return_elements+=( "fa${i}" )
done
echo

ifs_orig=$IFS
IFS=", "

echo "RETURN ${return_elements[*]};"
echo -- END --
echo
