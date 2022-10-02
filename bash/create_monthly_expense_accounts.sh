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

if [ -z "$expense_budgets" ]; then
	echo "'expense_budgets' environment variable not found."
	echo "Please export this variable using the 'env_variables.sh' file."
	exit
fi

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Missing parameters:"
	echo "Usage: command <year> <month_num [1-12]>"
	exit
fi

months=(" " "January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December")

year=$1
month=${months[$2]}
month_num=$2
account_len=${#expense_accounts[@]}
debit_note="Initial budget amount."

return_elements=("fy" "fm" "lp")

echo -- START --
echo "match (fy:FinancialYear {name:\"$year\"})-[lp:PERIOD]->(fm:FinancialMonth {name:\"$month\"})"

for (( i=0; i<$account_len; i++));
do
	echo "create (fm)-[la${i}:ACCOUNT]->(fa${i}:FinancialAccount {name:\"${expense_accounts[i]}\", budget_amount:${expense_budgets[i]}, type:\"expense\"}),"
	echo "(fa${i})-[le${i}:ENTRY]->(fe${i}:AccountDebit {date: date({year:${year} , month: ${month_num} , day: 1, notes:\"${debit_note}\"}), amount:${expense_budgets[i]}})"
	return_elements+=( "la${i}" ) 
	return_elements+=( "fa${i}" )
	return_elements+=( "le${i}" )
        return_elements+=( "fe${i}" )

done
echo

ifs_orig=$IFS
IFS=", "

echo "RETURN ${return_elements[*]};"
echo -- END --
echo
