import csv
import sys
import os

print('Number of arguments:', len(sys.argv), 'arguments.')
print('Argument List:', str(sys.argv))

DATE_INDEX = 0
DESC_INDEX = 3
AMT_INDEX = 1
CAT_INDEX = 4
ACCT_INDEX = 5

if len(sys.argv) != 2:
    print("Please supply a file path argument.")
    print("Exiting.")
    sys.exit()

print("Opening {} to read expense account entries.".format(sys.argv[1]))
with open(sys.argv[1], mode='r') as file:
    csvfile = csv.reader(file)
    loop_index = -1
    for row in csvfile:
        loop_index += 1
        if loop_index == 0:
            continue
        
        row_date = row[DATE_INDEX].split('/')
        if not len(row_date) == 3:
            print("Row: ", loop_index)
            print("Error parsing date. ", row[DATE_INDEX])
            print("Exiting")
            break
        entry_month = int(row_date[0])
        entry_day = int(row_date[1])
        entry_year = int(row_date[2]) if len(row_date[2]) == 4 else int("20" + row_date[2])

        if entry_year < 2019: print("Error parsing date row_date[2]", row[DATE_INDEX])

        entry_desc = row[DESC_INDEX].replace("'", " ").strip() or ''
        entry_subcat = row[CAT_INDEX].strip() or 'none'

        entry_account = row[ACCT_INDEX] or 'Misc Spending'
                
        try:
            entry_amount = float(row[AMT_INDEX]) or float(0)
        except:
            print("Row: ", loop_index)
            print("!!! Error parsing amount. \n Exiting.")
            break
        if (entry_amount < 0.0):
            os.system('./credit_financial_account.sh {} {} {} "{}" {} "{}" "{}"'.format(entry_year, entry_month, entry_day, entry_account, abs(entry_amount), entry_subcat, entry_desc))
        else:
            os.system('./debit_financial_account.sh {} {} {} "{}" {} "{}" "{}"'.format(entry_year, entry_month, entry_day, entry_account, entry_amount, entry_subcat, entry_desc))
        print("")

print("\n\nDone")