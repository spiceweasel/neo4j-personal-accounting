# BASH scripts usage
These scripts are designed to be executed in a BASH shell. Each script has a different set of parameters which can be discovered by executing the script without any parameters.

When the script completes successfully, it will output a valid Neo4j Cypher query as text to the console.  To utilize the query that was output, copy the text to a running instance of Neo4j using either the Neo4j Browser or neo4j-shell and cause it to be executed.

## Create a Financial Year
Creates a FinancialYear with a FinancialMonth for each month (January through December) allows us to track expense accounts monthly, keeping the quanity of Debit and Credit transactions pointing to any individual minimal so that the graph is visabilly managable when navigating in the browser.

This step should be exectured at the beginning of any calendar year *before* executing any scripts that depend on it.

To create a financial year for the year '2022':
- `$ ./create_financial_year.sh 2022`

A 'FinancialYear' node will be created for the specified year and a 'FinancialMonth' node will be created for every month January through December. Each FinancialMonth will be connected to the FinancialYear using a  relation labeled 'PERIOD'.


## Create Monthly Expense Accounts
Creates a set of Expense Accounts that allow you to categorically track financial spending and saving over a given month.  Each monthly Expense Account is started with the specified budget amount added as a Debit to the account.

This step requires a Financial Year to have been created and expense account information to be specified in the `env_variables.sh` file.

To create an `env_variables.sh` file, copy the template `env_variables.sh.template` file and add entries to the `expense_accounts` and `expense_budgets` arrays for each account you wish to manage for the month. Remember, that each account entry in the expense_accounts array should have a matching budget amount entry *or the script will fail to generate a proper Cypher query!*


For the purposes of this script, each Expense Account will be given a monthly budget which will be added as a Debit to the account automatically for the month.

Expense accounts are created for a month and are used as buckets to track financial outlays for  time period.  

## Features overview
### create_financial_month.sh
- Creates 
- Create expense accounts 