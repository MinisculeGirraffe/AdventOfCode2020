step 1:
Text parsing. Things we care about

Parent, Child split by contains

The child can have either bag or bags as an identifier 
Children are always seperates by "," when more than one

Remove all non essentials. Bags, Bag,"."

Use the first occourance of a number as the starting place in the child string.

" plaid magenta "
Remove all extra spaces from the child bag by splitting into an array by " ".
"

plaid
magenta

"
Once split remove all items in the array that are only a space.
"
plaid
magenta
"
Join back into a string by spaces. 
"plaid magenta"

Opted to add the parents as well as a calculated property for easy writing later on

step 2: sorting

After parsing the bags, we can access the number of sub bags X contains. Starting with zero we want to find our base bags
