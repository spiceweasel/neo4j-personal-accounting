MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount), (acct)-[]->(c:AccountCredit), (acct)-[]->(d:AccountDebit) 

RETURN acct.id, acct.name, sum(d.amount) - sum(c.amount) as Amount 
UNION MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount), (acct)-[]->(d:AccountDebit) RETURN acct.id, acct.name, sum(d.amount) as Amount

## Unwind example (working)
MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount {name:"Power Bill"}) with [(acct)-[]->(d:AccountDebit) | d.amount] as Debits, [(acct)-->(c:AccountCredit) | c.amount] as Credits unwind Credits as credit with Debits, Credits, sum(credit) as CreditTotal return Debits, Credits, CreditTotal

## call with unwind
MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount)
CALL {
    MATCH (acct) with [(acct)-[]->(d:AccountDebit) | d.amount] as Debits, [(acct)-->(c:AccountCredit) | c.amount] as Credits unwind Credits as credit with Debits, Credits, sum(credit) as CreditTotal return Debits, Credits, CreditTotal
    
}
RETURN Debits, Credits, CreditTotal

## Match account and call for each acct row
MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount)
CALL {
    with acct 
    Match (acct)-[]->(d:AccountDebit) return  sum(d.amount) as Debits, acct.name as Name

}
with Name, Debits, acct
CALL {
    with acct 
    Match (acct)-[]->(d:AccountCredit) return  sum(d.amount) as Credits

}
return Name,Credits,Debits, Debits - Credits as balance, acct


MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount)
CALL {
    MATCH (acct)-[]->(c:AccountCredit) WITH sum(d.amount) - sum(c.amount) as Amount 
    RETURN acct.name as Name, Amount
}
RETURN Name, Amount

MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct2:FinancialAccount), (acct2)-[]->(d:AccountDebit) RETURN acct.name, Amount, acct2.name, sum(d.amount)

MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount), (acct)-[]->(c:AccountCredit), (acct)-[]->(d:AccountDebit) WITH acct, sum(d.amount) - sum(c.amount) as Amount 
MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct2:FinancialAccount), (acct2)-[]->(d:AccountDebit) RETURN acct.name, Amount, acct2.name, sum(d.amount)

MERGE (y:FinancialYear {name:'2022'})-[:PERIOD]->(m:FinancialMonth {name:'October', number:10}) return y,m
MERGE (y:FinancialYear {name:'2022'}) CREATE (y)-[:PERIOD]->(m:FinancialMonth {name:'October', number:10}) return y,m

## Account forwarding
### Accounts with no credits 

MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount), 
      (acct)-[]->(dbt:AccountDebit) 
      WHERE NOT ((acct)-[:ENTRY]->(:AccountCredit)) 
      WITH y, m, acct, sum(dbt.amount) as amount set acct.amount_ending=amount 
      WITH y, m, acct, amount
      MATCH (y)-[:PERIOD]->(mdest:FinancialMonth {name:'October'})
      WITH y,m,acct,mdest,amount
      CREATE (mdest)-[:ACCOUNT]->(acct2:FinancialAccount {name:acct.name, amount_starting:amount, type:"expense", budget_amount:acct.budget_amount})-[:ENTRY]->(dbt:AccountDebit {date: date({year:2022, month: 10, day: 1, notes:"Initial budget amount", amount:acct.budget_amount})})

      return y, m, acct, mdest, acct2, dbt

MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount), 
      (acct)-[]->(dbt:AccountDebit) 
      WHERE NOT ((acct)-[:ENTRY]->(:AccountCredit)) 
      WITH y, m, acct, sum(dbt.amount) as amount set acct.amount_ending=amount 
      WITH y, m, acct, amount
      MATCH (y)-[:PERIOD]->(mdest:FinancialMonth {name:'October'})
      WITH y,m,acct,mdest,amount
      CREATE (mdest)-[:ACCOUNT]->(acct2:FinancialAccount {name:acct.name, amount_starting:amount, type:"expense", budget_amount:acct.budget_amount})-[:ENTRY]->(dbt:AccountDebit {date: date({year:2022, month: 10, day: 1}), notes:"Initial budget amount", amount:acct.budget_amount})

      return y, m, acct, mdest, acct2, dbt

MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount), 
      (acct)-[]->(dbt:AccountDebit), (acct)-[]->(cdt:AccountCredit) 
       WITH y, m, acct, sum(dbt.amount) as dbt_amount, sum(cdt.amount) as cdt_amount set acct.amount_ending=dbt_amount - cdt_amount
       return acct.name, dbt_amount, cdt_amount


MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount)
    WITH y, m, acct
    MATCH (acct)-[]->(dbt:AccountDebit), (acct)-[]->(cdt:AccountCredit) 
       WITH y, m, acct, sum(dbt.amount) as dbt_amount, sum(cdt.amount) as cdt_amount set acct.amount_ending=dbt_amount - cdt_amount
       return acct.name, dbt_amount, cdt_amount


### Accounts with credits

