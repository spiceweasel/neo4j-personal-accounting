#!/bin/bash

if [ -z "$1" ]; then
	echo "Please supply name for your financial year e.g. '2022 or 2022-23'"
	echo "<Financial year name> <periodicity [year|month|week|quarter]> <start_date Ymd> <end_date Ymd>"
	exit
fi

year=$1
periodicity=$2
start_date=$3
end_date=$4

function print_yearly_financial_periods() 
{
	local year_s=$start_date
	local year_e=$(date +%Y%m%d -d "${start_date} + 1 year - 1 day")
	echo "(fy)-[:PERIOD]->(fp1:FinancialPeriod {name:\"Accounting Period ${year}\", number:1, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	echo "return fy, fp1"
}

function print_monthly_financial_periods() 
{
	local year_s=$start_date
	local year_e=$(date +%Y%m%d -d "${start_date} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp1:FinancialPeriod {name:\"January\", number:1, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp2:FinancialPeriod {name:\"February\", number:2, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp3:FinancialPeriod {name:\"March\", number:3, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp4:FinancialPeriod {name:\"April\", number:4, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp5:FinancialPeriod {name:\"May\", number:5, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp6:FinancialPeriod {name:\"June\", number:6, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp7:FinancialPeriod {name:\"July\", number:7, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp8:FinancialPeriod {name:\"August\", number:8, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp9:FinancialPeriod {name:\"September\", number:9, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp10:FinancialPeriod {name:\"October\", number:10, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp11:FinancialPeriod {name:\"November\", number:11, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 1 month - 1 day")
	echo "(fy)-[:PERIOD]->(fp12:FinancialPeriod {name:\"December\", number:12, start_date=\""$year_s"\", end_date=\""$year_e"\"})"
	echo "return fy, fp1, fp2, fp3, fp4, fp5, fp6, fp7, fp8, fp9, fp10, fp11, fp12"
}

function print_quarterly_financial_periods() 
{
	local year_s=$start_date
	local year_e=$(date +%Y%m%d -d "${start_date} + 3 months - 1 day")
	echo "(fy)-[:PERIOD]->(fp1:FinancialPeriod {name:\"${year} Q1\", number:1, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 3 months - 1 day")
	echo "(fy)-[:PERIOD]->(fp2:FinancialPeriod {name:\"${year} Q2\", number:2, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 3 months - 1 day")
	echo "(fy)-[:PERIOD]->(fp3:FinancialPeriod {name:\"${year} Q3\", number:3, start_date=\""$year_s"\", end_date=\""$year_e"\"})"	
	year_s=$(date +%Y%m%d -d "${year_e} + 1 day")
	year_e=$(date +%Y%m%d -d "${year_s} + 3 months - 1 day")
	echo "(fy)-[:PERIOD]->(fp4:FinancialPeriod {name:\"${year} Q4\", number:4, start_date=\""$year_s"\", end_date=\""$year_e"\"})"
	echo "return fy, fp1, fp2, fp3, fp4"
}

echo -- START --
echo "create (fy:FinancialYear {name:\""$year"\", start_date=\""$start_date"\", end_date=\""$end_date"\"})"

if [ "$periodicity" == "year" ]; then
	print_yearly_financial_periods
elif [ "$periodicity" == "month" ]; then
	print_monthly_financial_periods
elif [ "$periodicity" == "week" ]; then
	echo "Error: ${periodicity}ly periodicity not implemented yet."
	exit
elif [ "$periodicity" == "quarter" ]; then
	print_quarterly_financial_periods
else
	echo "Error: unknown periodicity. Exiting."
	exit
fi

echo -- END --
echo
