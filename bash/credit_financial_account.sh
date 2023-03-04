#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
	echo "Missing parameters:"
	echo "Usage: command <year> <month [1-12]> <day_num [1-31]> <account_name> <amount> [<transaction_info>] [<notes>]" 
	exit
fi

year=$1
month=$2
day=$3
account=$4
amount=$5
transaction_info=$6 || "none"
notes=$7 || ""

echo "MATCH (fa:FinancialAccount {name: '${account}'})<-[:ACCOUNT]-(fl:FinancialLedger)-[:PERIOD]->(fp:FinancialPeriod) WHERE fp.start_date < date('${year}-${month}-${day}') <= fp.end_date AND (fl.closed is null or fl.closed = false)"
echo "WITH fa, fl, fp CREATE (fl)-[:ENTRY]->(cred:AccountCredit {date: date('${year}-${month}-${day}'), amount:${amount}, transactionInfo: '${transaction_info}', notes:'${notes}'}) return fa,fl,fp,cred;"