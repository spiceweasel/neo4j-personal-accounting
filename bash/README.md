# bash scripts usage
These scripts are designed to be executed in a BASH shell. Each script has a different set of parameters which can be discovered by executing the script without any parameters.

When the script completes successfully, it will output a valid Neo4j Cypher query as text to the bash console.  To utilize the query, copy the text to a running instance of Neo4j using either the Neo4j Browser or neo4j-shell and execute.

## Create a Financial Year
A 'FinancialYear' node will be created for the given year and a 'FinancialMonth' node will be created for every month January through December with a ':PERIOD' relation associating the year to the given month.

Creating a FinancialMonth for each month allows us to track expense accounts monthly, keeping the quanity of Debit and Credit transactions pointing to any individual minimal so that the graph visabilly managable when navigating in the browser.

To create a financial year for the year '2022':
- `$ ./create_financial_year.sh 2022`


## Create Monthly Expense Accounts
Expense accounts are created for a month and are used as buckets to track financial outlays for  time period.  

## Features overview
### create_financial_month.sh
- Creates 
- Create expense accounts 