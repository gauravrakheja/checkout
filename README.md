just do `bundle install`

the problem stated below has been coded in the file called spec/test_case_spec.rb
I thought the best way to show the different components I created would be to make 
a test case that takes the input given by the question itself

Vinterior Coding Test
The test should take around 3 hours but is not strictly timed.
Our client is an online marketplace, here is a sample of some of the products available on our site:
Product code  | Name                   | Price
----------------------------------------------------------
001           | Very Cheap Chair
002           | Little table
003           | Funky light
| £9.25
| £45.00
| £19.95
Our marketing team want to offer promotions as an incentive for our customers to purchase these items.
If you spend over £60, then you get 10% off of your purchase. If you buy 2 or more very cheap chairs then the price drops to £8.50.
Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.
The interface to our checkout looks like this (shown in Ruby):
co = Checkout .new (promotional_rules) co .scan (item)
co .scan (item)
price = co .total
Implement a checkout system that fulfills these requirements. Do this outside of any frameworks. You should use TDD.
Please use git and commit regularly so we can see your thought process. We will review the code and discuss your approach when you have finished.
Test data
---------
Basket: 001,002,003
Total price expected: £66.78
Basket: 001,003,001
Total price expected: £36.95
-----------------------------------------------
the project comprises of the following architecture


```
CHECKOUT
`Checkout` is responsible for maintaining a list of `line items`
and `rules`

#scan
the scan method takes in an item and if a corresponding line item already exists
it calls add on the line method which increments the quantity of the line item
otherwise it creates a new line item for the given product

#total
the total method starts with calculating the total value of all the items
without applying any offers, then it loops over the rules which are rule objects
that all respond to applicable and apply, apply mutates the total price according to 
the conditions according to the rule so even if we add a lot more rules tomorrow
the checkout class will not change

#quantity_for
this method gives the quantity present for a given item by accessing the line item
default is 0

#items
this just fetches the items from the line items
the reason checkout does not all the items is to avoid duplication
```

```
ITEM
this is an ADT(Abstract Data Type) for the products
```
```
LINE_ITEM
this is a representation of an item in the checkout
this stores the item and the quantity

#add
this increases the quantity of the line item

#product_code, price
accessors for the item price and product code
```

```
PROMOTIONAL_RULE
this enforces developers to implement 
the apply and applicable method in the rule classes
so that the checkout does not break
```
```
MULTIPLE_ITEMS_RULE
this is a generic rule that takes an item, a minimum
of items and the new price to assign if that quantity is met

#applicable?
it returns true if the checkout has more or equal items
present than the minimum quantity

#apply
it takes the checkout and title, and loops over the line items
if the line item has the same product code as the rule's item,
it subtracts the amount that had been added to the total for that product
and replace that by the new amount
````
```
TOTAL_PRICE_RULE
this is a generic rule that applies on the total price of a checkout.
It takes a minimum amount and a discount

#applicable?
the method only considers the price of the checkout without any other rules
because if we try to loop over the rules when we are trying to check the applicability
of this rule, it will get stuck in a loop, and this gives a close enough 
idea of whether the rule will apply(could also be a business requirement to have it this way)

#apply
this just subtracts the discounted amount from the total given
```


