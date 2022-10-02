# neo4j-personal-finance
This is an exercise desgined to practice Neo4j database skills such as:
- Modeling data for managing home finances as expense accounts.
- Querying the data in various and useful ways to manage and gain insights into personal finances.

Additionally this project seeks to exercise different methods for interacting with the data:
- Use bash scripts to automate the creation cypher queries for:
  - Creating the financial graph data.
  - Creating reports.
- Create a web application that makes implementes a GUI to access the same graph data created and reported in the bash scripts.


## Current State
- 2022-10-02
  - Bash scripts created to:
    - Manage creation of year, month, and expense accounts nodes and relations.
    - Move balances forward from one month to the next while closing the old expense account.

## Future Plans
- Create a web application using Svelte.js

