# BASH scripts usage
These scripts are designed to be executed in a BASH shell. Each script has a different set of parameters which can be discovered by executing the script without parameters.

When the script completes successfully, it will output a valid Neo4j Cypher query as text to the console.  To utilize the query that was output, copy the text to a running instance of Neo4j using either the Neo4j Browser or neo4j-shell and cause it to be executed.

## Create a Financial Year
Creates one or more FinancialPeriod nodes for each type of periodicity, the FinancialYear to which each period is related, and a :PERIOD relation between each.  

The script creates all of the individual period nodes for the entire year.  This provides reliability in the setup of FinancialLedger nodes where periods are guaranteed to exist for the year whether or not they are useful to the database operator.

FinancialPeriod's are used to track the offical start and end time of an accounting period. This script should be used at the beginning of any calendar year and it's output should be loaded into the database *before* attempting to create FinancialLedgers for a given period.

To create a financial year for the year '2022':
- `$ ./create_financial_year.sh 2022-23 20230101 20231231`

Example output:
-- START --
CREATE (fy:FinancialYear {name:"2024-25", start_date:date("20240101"), end_date:date("20241231")})
CREATE (fy)-[:PERIOD]->(fp30:FinancialPeriod {name:"Year", number:1, start_date:date("20240101"), end_date:date("2024-12-31"), periodicity:"year"})
CREATE (fy)-[:PERIOD]->(fp1:FinancialPeriod {name:"January", number:1, start_date:date("20240101"), end_date:date("2024-01-31"), periodicity:"month"})
...
-- END --

## Create Financial Accounts
Creates a set of named financial accounts to track the details associated with the account.  The account's name, type, number, periodicity, and budget amount are specified in a separate file `env_variables.sh` and are used to populated the properties of each FinancialAccount node.

Each FinancialAccount node will have the following properties:
- name: The name for the account. 
- type: One of the standard financial account types ['asset', 'expense', 'liability', 'revenue', 'equity']
- budget_amount: The starting amount that an expense account should be debited each period.
- number: The number for the account in standard accounting form e.g. "001-203829-2039" or any other unique string identifier for the account.
- description: A description of what the account is used for or other account details important to the database operator.
- isActive: A boolean flag indicating whether this account should be considered active.

Before this script can be ran successfully a `env_variables.sh` file must be created and populated with the account details.  Use the template file `env_variables.sh.template` as an example adding entries to the `expense_accounts` and `expense_budgets` arrays for each account you wish to manage for the month. Remember, that each account entry in the expense_accounts array should have a matching budget amount entry *or the script will fail to generate a proper Cypher query!*

To create FinancialAccount nodes for all accounts listed in `env_variables.sh`:
- `$ ./create_financial_accounts.sh`

Example output:
-- START --
CREATE (fa0:FinancialAccount {name:"Car Maintenance", period:"quarter", number:"2-001-01", type:"expense", budget_amount:100.00, description:"", isActive:true})
CREATE (fa1:FinancialAccount {name:"County Taxes - Auto", period:"year", number:"2-002-01", type:"expense", budget_amount:128.00, description:"", isActive:true})
...
-- END --

## Create Financial Ledgers
Creates a set of ledgers for each active financial account for the given financial period. The ledger is used for tracking all credits and debits during a given financial period.

Each FinancialLedger node will have the following properties:
- closed: a flag indicating that this ledger is officailly closed for transaction activity.
- balance: a decimal value indicating the current balance within this financial ledger.

To create FinancialLedgers for all active accounts:
 - `$./open_financial_ledgers_for_periods.sh <year name> <periodicity type> <period number>`

Example output:
-- START --
MATCH (fa:FinancialAccount { isActive:true })
MATCH (fy:FinancialYear { name:"2023" })-[]-(fp:FinancialPeriod { number:1, periodicity:"quarter" }) WITH * CREATE (fa)<-[:ACCOUNT]-(fl:FinancialLedger { closed:false, balance:0.00 })-[:PERIOD]->(fp)
RETURN fa, fy, fp, fl
-- END --
