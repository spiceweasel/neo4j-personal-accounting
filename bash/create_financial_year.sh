#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Please supply name for your financial year e.g. '2022 or 2022-01-01 2022-12-23'"
	echo "<Financial year name e.g. 2021-22>  <start_date Ymd> <end_date Ymd>"
	exit
fi

year=$1
start_date=$2
end_date=$3

function print_yearly_financial_periods() 
{
	local year_s=$start_date
	local year_e=$(date +%Y-%m-%d -d "${start_date} + 1 year - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp30:FinancialPeriod {name:\"Year\", number:1, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"year\"})"	
	
}

function print_monthly_financial_periods()
{
	local year_s=$start_date
	local year_e=$(date +%Y-%m-%d -d "${start_date} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp1:FinancialPeriod {name:\"January\", number:1, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp2:FinancialPeriod {name:\"February\", number:2, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp3:FinancialPeriod {name:\"March\", number:3, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp4:FinancialPeriod {name:\"April\", number:4, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp5:FinancialPeriod {name:\"May\", number:5, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp6:FinancialPeriod {name:\"June\", number:6, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp7:FinancialPeriod {name:\"July\", number:7, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp8:FinancialPeriod {name:\"August\", number:8, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp9:FinancialPeriod {name:\"September\", number:9, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp10:FinancialPeriod {name:\"October\", number:10, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp11:FinancialPeriod {name:\"November\", number:11, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 1 month - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp12:FinancialPeriod {name:\"December\", number:12, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"month\"})"
}

function print_quarterly_financial_periods() 
{
	local year_s=$start_date
	local year_e=$(date +%Y-%m-%d -d "${start_date} + 3 months - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp21:FinancialPeriod {name:\"Q1\", number:1, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"quarter\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 3 months - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp22:FinancialPeriod {name:\"Q2\", number:2, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"quarter\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 3 months - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp23:FinancialPeriod {name:\"Q3\", number:3, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"quarter\"})"	
	year_s=$(date +%Y-%m-%d -d "${year_e} + 1 day")
	year_e=$(date +%Y-%m-%d -d "${year_s} + 3 months - 1 day")
	echo "CREATE (fy)-[:PERIOD]->(fp24:FinancialPeriod {name:\"Q4\", number:4, start_date:date(\""$year_s"\"), end_date:date(\""$year_e"\"), periodicity:\"quarter\"})"
}

echo -- START --
echo "create (fy:FinancialYear {name:\""$year"\", start_date:date(\""$start_date"\"), end_date:date(\""$end_date"\")})"

print_yearly_financial_periods
print_monthly_financial_periods
print_quarterly_financial_periods

echo "return fy, fp1, fp2, fp3, fp4, fp5, fp6, fp7, fp8, fp9, fp10, fp11, fp12, fp21, fp22, fp23, fp24, fp30"

echo -- END --
echo
