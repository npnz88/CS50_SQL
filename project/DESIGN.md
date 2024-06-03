# Design Document

Solution Design CSSuperMarket - A Rewards Program Database

By Nehang Patel

npnz88 and Nehang_88

Auckland, New Zealand

3rd June 2024

Video overview: <https://studio.youtube.com/video/yhQ7JLir-Wk/edit>

## Scope

The purpose of this database is to store application data for a rewards program which shoppers can take advantage of by using the card and it's applications when shopping at selected supermarket store.

* Shoppers, including basic information for identification
* Cards, including the details of each registered card
* Products, including promotional products which provide shoppers with a cetain number of points
* Bonuses, including promotional bonuses for cetain shoppers
* Transactions, including the transaction history of shoppers purchasing products

## Out of scope

* The integration to other IOT systems such as EFT machines is out of scope for this database

## Functional Requirements

* A user of the database can facilitate the CRUD operations for all key tables
* Tracking the total points collected by a shopper
* Tracking the bonus points gained by a shopper when purchasing promotional products
* Tracking the items purchased by a shopper
* Tracking of point usage for 'shopper's cashback'

## Representation

### Entities

#### Shoppers
* `id` indicates the unique identification of shoppers as a number, hence `INT` is used. This is a `PRIMARY` key, which is also a `NOT NULL` value, hence it must always exist. This value should also `AUTO_INCREMENT`, automatically adding an id for each shopper.
* `email-address` will contain special characters, hence the `TEXT` type is used. This will allow for customer service teams communciate with shoppers for queries, and also confirm identity for users when signing up. This is a `NOT NULL` value, hence it must always exist. It should be a unique value, and employ `UNIQUE`. Email checks for `@, "gmail", "icloud", "outlook", "hotmail", "xtra"` should all be employed to confirm email identity.
* `name` for shopper names should be of `VARCHAR(32)`, and this field should also always exist for each row, hence `NOT NULL`.
* `phone-number` is a `TEXT` type field as there may be other values entered, such as a '+' or a '-' by users.
* `local` will be a `ENUM` type field, listing the local supermarkts in the users area. This will be the store where their transactions are made.
* `card_id` is a `INT` type field that is `NOT NULL`. This is the `FORIGEN KEY` that relates this table to cards with a one-to-one relationship between cards and shoppers.
* `total-points` is an `INT` that is `DEFAULT` set to 0, where it the total points column in the transactions table babsed on the transaction-id and the

#### Bonus
* This table will be created using a stored procedure over the products table, where a 'promotional' column in the products table will use a `TINYINT` to store a `1` or `0` value. This will allow for a common queries to access a promotional product view to be displayed within the application.
* `id` indicates the unique identification of each bonus available with type `INT`. This is a `PRIMARY` key, which is also a `NOT NULL` value. This key should also `AUTO_INCREMENT`, automatically adding an id for each card created via the application.
* `product_id` is the `foriegn` key for the products table as one can have one promotion running at any given time.
* `bonus-points` is an `NOT NULL`, `INT` type value which defines how many points are gained in addition to exisiting points when ubying this product.

#### Cards
* `id` indicates the unique identification of each card with type `INT`. This is a `PRIMARY` key, which is also a `NOT NULL` value. This key should also `AUTO_INCREMENT`, automatically adding an id for each card created via the application.
* `card_id` is a unique value using type `CHAR(12)` as a `NOT NULL` value. This will be a value suffixed with `"CS"` and followed by 10 other digits from 0-9. This is also a `FORIEGN KEY` that relates each card to a shopper with a one-to-one relationship.
* `issue-date` is the date at which the card was issued, this is `DATE` type and a `NOT NULL` value.
* `expiry-date` is the date at which the care will expire. This is `DATE` type and a `NOT NULL` value. It will default to three years after the `"issue-date"`.

#### Products
* `id` indicates the unique identification of each product with type `INT`. This is a `PRIMARY` key, which is also a `NOT NULL` value. This key should also `AUTO_INCREMENT`, automatically adding an id for each product added to this table.
* `name` is a `VARCHAR(100)` value that is NOT NULL, identifying the name of the product.
* `description` is a TEXT field that will describe the product.
* `price` is a `DECMIAL` value for the product listing its price. This value should help users describe the cost-benefit of using the rewards program.
* `points` is a `INT`, `NOT NULL` value that can be used to track the value of points gained when buying the product.
* `promotional` is a `TINYINT` value that will be `NOT NULL`, indicating if the product is promotional and provides extra points when purchases.

#### Transactions
* `id` indicates the unique identification of each transaction with type `INT`. This is a `PRIMARY` key, which is also a `NOT NULL` value. This key should also `AUTO_INCREMENT`, automatically adding an id for each transaction made by shoppers.
* `shopper_id` is the `foriegn` key for the shoppers table, as one shopper can have many transactions, but a transaction can only be related to a single shopper.
* `product_id` is the `foriegn` key for the products table, as a transaction cann exist for a single product, but a product can have many transaction occurances for it.
* `card_used`is a unique value using type `CHAR(12)` as a `NOT NULL`. This is the `FORIGEN KEY` that relates this table to cards with a one-to-one relationship between cards and transactions.
* `transaction_date` is the date at which the transactionn occured, being type `TIMESTAMP`, with the default as the current time stamp.
* `total-points` which is the total number of points earned for the transaction made.


All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.


### Relationships

![ER Diagram](diagram.png)

* Shoppers to Cards - One-to-One relationship
    * Each shopper is associated with exactly one card, and each card is linked to only one shopper.This ensures each shopper has a uniquq card.
* Bonuses to Products and Shoppers - One-to-One relationship
    * Each product can have only one associated bonus. Each bonus is linked to only one product. This ensures that each product can only have one bonus associated with it.
* Bonuses to Shoppers - Many-to-One relationship
    * Each bonus is linked to one specific shopper, but a shopper can earn multiple bonuses. This allows for tracking which shopper earned each bonus, enabling a single shopper to accumulate multiple bonuses.
* Transactions to Shoppers - Many-to-One relationship
    * Each transaction is linked to one specific shopper, but a shopper can have multiple transactions. This ensures that all transactions are associated with a particular shopper.
* Transactions to Products - Many-to-One Relationship
    * Each transaction involves one specific product, but a product can be involved in multiple transactions.
* Transactions to Cards - Many-to-One Relationship
    * Each transaction records the use of one specific card, but a card can be used in multiple transactions.

## Optimizations

Queries listed in `queires.sql` highlight the demand for customer service queries in the inital phases of application go-live. The increased demand for support will mean things go-wrong, and being able to quickly search where system failures have lead to users not getting points will mean temporary manual intervention. Therefore, searching transactions quickly, and allowing for customer service to see transaction hisotry for a user is key. Indexes on the `Shoppers.card_id`, `Cards.card_id`, and lastly and composite index for `Transactions` on `shopper_id, card_used, and transaction_date`. While this can slow down overall servers, this can be readjusted as we progress and the system becomes better. In this future scenario, indexes can be removed to save space and costs.

## Limitations

* As the database continues to grow, complex queries will take longer to run, requiring new horizontal and vertical scaling arragnements. This can be costly and expensive for a business to upkeep.

* This database may provide some insights into promotional profitability, but additional inventory and pricing databases may be required to further dervie key insights for the CSupermarket brand.
