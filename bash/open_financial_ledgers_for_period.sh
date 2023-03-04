#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Missing parameters:"
	echo "Usage: command <year_name> <periodicity_type> <period_number>"
	echo "- year_name - is a string matching the name given to the financial year we want to create ledgers in e.g. '2022-23'"
	echo "- periodicity_type - one of [year|month|quarter]"
	echo "- period_number - A value indicating the period. Number shoud be in the range of [1-12] for monthly or [1-4] for quarterly, etc."
	exit
fi

year=$1
periodicity=$2
number=$3

echo -- START --
# Get the existing financial period and accounts that are needed.
echo "MATCH (fa:FinancialAccount { isActive:true })"
# create FinancialLedgers for a period
echo "MATCH (fy:FinancialYear { name:\"${year}\" })-[]-(fp:FinancialPeriod { number:${number}, periodicity:\"${periodicity}\" }) WITH * CREATE (fa)<-[:ACCOUNT]-(fl:FinancialLedger { closed:false, balance:0.00 })-[:PERIOD]->(fp)"
echo "RETURN fa, fy, fp, fl"
echo -- END --
echo