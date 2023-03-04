# neo4j-personal-finance
This is an exercise desgined to practice Neo4j database skills such as:
- Modeling data for managing home finances as expense accounts.
- Querying the data in various and useful ways to manage and gain insights into personal finances.

Additionally this project seeks to exercise different methods of interacting with the data stored in the database.  Herein we will:
- Use bash scripts to automate the creation cypher queries for:
  - Creating the financial graph data.
  - Creating reports.
- Create a one or more web applications (using popular frameworks) that implement a Graphical User Interface (GUI) to Create, Read, Update, or Delete (CRUD) the financial data stored in our graph database.

## Current State
- 2023-03-04
  - Changed schema for all nodes to better accomodate scripted queries and provide a single point of reference for data.
  - Can now create financial year, create financial accounts, and open financial ledgers for a given period with the updated schema.
  - Updated credit and debit scripts to match new schema.
- 2022-10-02
  - Bash scripts created to:
    - Manage creation of year, month, and expense accounts nodes and relations.
    - Move balances forward from one month to the next while closing the old expense account.
- 2022-10-06
  - Created Python csv batch import script to generate cypher queries for Account Debits/Credits.
 
## Future Plans
- Create a web application using Svelte.js
