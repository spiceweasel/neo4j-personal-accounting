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
    Match (acct)-[]->(d:AccountCredit) return sum(d.amount) as Debits, acct.name as Name

}
RETURN Name, Debits



MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount)
CALL {
    MATCH (acct)-[]->(c:AccountCredit) WITH sum(d.amount) - sum(c.amount) as Amount 
    RETURN acct.name as Name, Amount
}
RETURN Name, Amount

MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct2:FinancialAccount), (acct2)-[]->(d:AccountDebit) RETURN acct.name, Amount, acct2.name, sum(d.amount)

MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct:FinancialAccount), (acct)-[]->(c:AccountCredit), (acct)-[]->(d:AccountDebit) WITH acct, sum(d.amount) - sum(c.amount) as Amount 
MATCH (y:FinancialYear {name:'2022'})-[]->(m:FinancialMonth {name:'September'})-[]->(acct2:FinancialAccount), (acct2)-[]->(d:AccountDebit) RETURN acct.name, Amount, acct2.name, sum(d.amount)



