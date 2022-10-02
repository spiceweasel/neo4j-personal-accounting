#!/bin/bash

if [ -z "$1" ]; then
	echo "Please supply a year e.g. '2022'"
	exit
fi

echo -- START --
echo "create (fy:FinancialYear {name:\""$1"\"})-[:PERIOD]->(fm1:FinancialMonth {name:\"January\", number:1}),"
echo "(fy)-[:PERIOD]->(fm2:FinancialMonth {name:\"February\", number:2}),"
echo "(fy)-[:PERIOD]->(fm3:FinancialMonth {name:\"March\", number:3}),"
echo "(fy)-[:PERIOD]->(fm4:FinancialMonth {name:\"April\", number:4}),"
echo "(fy)-[:PERIOD]->(fm5:FinancialMonth {name:\"May\", number:5}),"
echo "(fy)-[:PERIOD]->(fm6:FinancialMonth {name:\"June\", number:6}),"
echo "(fy)-[:PERIOD]->(fm7:FinancialMonth {name:\"July\", number:7}),"
echo "(fy)-[:PERIOD]->(fm8:FinancialMonth {name:\"August\", number:8}),"
echo "(fy)-[:PERIOD]->(fm9:FinancialMonth {name:\"September\", number:9}),"
echo "(fy)-[:PERIOD]->(fm10:FinancialMonth {name:\"October\", number:10}),"
echo "(fy)-[:PERIOD]->(fm11:FinancialMonth {name:\"November\", number:11}),"
echo "(fy)-[:PERIOD]->(fm12:FinancialMonth {name:\"December\", number:12}) return fy, fm1, fm2, fm3, fm4, fm5, fm6, fm7, fm8, fm9, fm10, fm11, fm12"
echo -- END --
echo
