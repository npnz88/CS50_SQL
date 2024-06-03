--Common queries
--Retrive all shoppers and their assigned cards
SELECT s.id AS shopper_id, s.name, s.email_address, c.card_id
FROM Shoppers s
JOIN Cards c ON s.card_id = c.id;

--Retrive shoppers with top points
SELECT id, name, email_address, total_points
FROM Shoppers
WHERE total_points > 1000;

--List transactions for products in a specific data range, used for analysis
SELECT t.id AS transaction_id, t.transaction_date, p.name AS product_name, t.total_points, t.points_redeemed
FROM Transactions t
JOIN Products p ON t.product_id = p.id
WHERE t.shopper_id = 1;

--Customer Service Query
--List transactions for a specific card
SELECT t.id AS transaction_id, t.transaction_date, s.name AS shopper_name, p.name AS product_name, t.total_points, t.points_redeemed
FROM Transactions t
JOIN Shoppers s ON t.shopper_id = s.id
JOIN Products p ON t.product_id = p.id
WHERE t.card_used = 'CS1234567890';

--List all transactions within a specific date range
SELECT t.id AS transaction_id, s.name AS shopper_name, p.name AS product_name, t.transaction_date, t.total_points
FROM Transactions t
JOIN Shoppers s ON t.shopper_id = s.id
JOIN Products p ON t.product_id = p.id
WHERE t.transaction_date BETWEEN '2024-01-01' AND '2024-12-31';

--Add new shoppers
INSERT INTO Shoppers (id, email_address, name, phone_number, local, card_id, total_points)
VALUES (1, 'john.doe@gmail.com', 'John Doe', '+6482058392', 'Mount Roskill', '1', 0);

INSERT INTO Shoppers (id, email_address, name, phone_number, local, card_id, total_points)
VALUES (2, 'jane.smith@icloud.com', 'Jane Smith', '+6287654321', 'Mount Eden', '2', 0);

--Add new cards
INSERT INTO Cards (id, card_id, issue_date, expiry_date)
VALUES (1, 'CS1234567890', '2024-01-01', '2027-01-01');

INSERT INTO Cards (id, card_id, issue_date, expiry_date)
VALUES (2, 'CS0987654321', '2024-02-01', '2027-02-01');

--Add products
INSERT INTO Products (id, name, description, price, points, promotional)
VALUES (1, 'Soy Milk 1L', 'Sanitarium So Good Soy Milk Lite Long Life Carton 1L', 2.90, 10, 0);

INSERT INTO Products (id, name, description, price, points, promotional)
VALUES (2, 'McCain Family Pizza', 'Mccain Pizza Family Pepperoni 490g', 6.00, 20, 1);

--Add bonuses
INSERT INTO Bonuses (product_id, shopper_id, bonus_points)
VALUES (1, 1, 50);

INSERT INTO Bonuses (product_id, shopper_id, bonus_points)
VALUES (2, 2, 100);

INSERT INTO Transactions (id, shopper_id, product_id, card_used, transaction_date, total_points, points_redeemed)
VALUES (1, 1, 1, 'CS1234567890', CURRENT_TIMESTAMP, 100, 10);

INSERT INTO Transactions (id, shopper_id, product_id, card_used, transaction_date, total_points, points_redeemed)
VALUES (1, 2, 2, 'CS0987654321', CURRENT_TIMESTAMP, 200, 20);

