#!/bin/bash
# Close the existing ledger and move it's balance forward.
# If no matching forward ledger exists then 
# - close the ledger 
# - leave the balance pending
# - notify the user by printing the unforwarded ledgers in a table

# 
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Missing parameters:"
	echo "Usage: command <periodicity type> <start year name> <start period number> <end year name> <end period number>"
	echo "Period number shoudld be in the range of [1-12] for monthly or [1-4] for quarterly."
	exit
fi

periodicity=$1
start_year=$2
start_number=$3
end_year=$4
end_number=$5

echo -- START --
# Get the existing financial period and accounts that are needed.
echo "MATCH (fa:FinancialAccount { isActive:true })"

# create FinancialLedgers for a period
echo "MATCH (fy:FinancialYear { name:\"${year}\" })-[]-(fp:FinancialPeriod { number:${number}, periodicity:\"${periodicity}\" }) WITH * CREATE (fa)<-[:ACCOUNT]-(fl:FinancialLedger { closed:false, balance:0.00 })-[:PERIOD]->(fp)"
echo "RETURN fa, fy, fp, fl"
echo -- END --
echo