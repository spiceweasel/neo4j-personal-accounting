#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
	echo "Missing parameters:"
	echo "Usage: command <from_year> <from_month_num [1-12]> <ending_day_num [1-31]> <to_year> <to_month>" 
	exit
fi

from_year=$1
from_month_num=$2
from_day=$3
to_year=$4
to_month_num=$5
to_day=1

echo "MATCH (y:FinancialYear {name:'${from_year}'})-[]->(m:FinancialMonth {number:${from_month_num}})-[]->(acct:FinancialAccount)"
echo "CALL {"
echo "  WITH acct "
echo "     MATCH (acct)-[]->(d:AccountDebit) return sum(d.amount) as Debits, acct.name as Name"
echo " }"
echo "  WITH Name, Debits, acct"
echo " CALL {"
echo "     WITH acct "
echo "     MATCH (acct)-[]->(d:AccountCredit) return sum(d.amount) as Credits"
echo " }"
echo " WITH Debits - Credits as balance, acct"
echo " MATCH (y2:FinancialYear {name:'${to_year}'})-[]->(m2:FinancialMonth {number:${to_month_num}})-[]->(acct2:FinancialAccount {name:acct.name})"
echo " WITH balance, acct, y2, m2, acct2"
echo " CREATE (acct)-[:ENTRY]->(bfp:AccountCredit {amount:balance, date:date({year:${from_year}, month:${from_month_num}, day:${from_day}}), notes:\"Month ending balance to forward\"})-[:TRANSFER { month_ending:true }]->(bfr:AccountDebit {date:date({year:${to_year}, month:${to_month_num}, day:${to_day}}), amount:balance, notes:\"Balance forwarded\"})<-[:ENTRY]-(acct2)"
echo " SET acct.closed=true "
echo " RETURN acct, bfp, bfr, acct2, y2, m2"