--Represents Shoppers who use the rewards program cards
CREATE TABLE Shoppers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email_address TEXT NOT NULL UNIQUE,
    name VARCHAR(32) NOT NULL,
    phone_number TEXT,
    local ENUM('Mount Roskill', 'Three Kings', 'Mount Eden') NOT NULL,
    card_id CHAR(12) NOT NULL UNIQUE,
    total_points INT DEFAULT 0,
    FOREIGN KEY (card) REFERENCES Cards(id)
);

--Represents Cards issued to shoppers
CREATE TABLE Cards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    card_id CHAR(12) NOT NULL UNIQUE,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    shopper_id INT NOT NULL,
    FOREIGN KEY (shopper_id) REFERENCES Shoppers(id)
);

--Represents Products that are sold and the value of points earned when purchased
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    points INT NOT NULL,
    promotional TINYINT(1) NOT NULL DEFAULT 0
);


--Represents bonus points avaliable for a product
CREATE TABLE Bonuses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL UNIQUE,
    shopper_id INT NOT NULL,
    bonus_points INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(id),
    FOREIGN KEY (shopper_id) REFERENCES Shoppers(id)
);


--Represents the transactions made by shoppers to purchase products
CREATE TABLE Transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    shopper_id INT NOT NULL,
    product_id INT NOT NULL,
    card_used CHAR(12) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_points INT NOT NULL,
    points_redeemed INT DEFAULT 0,
    FOREIGN KEY (shopper_id) REFERENCES Shoppers(id),
    FOREIGN KEY (product_id) REFERENCES Products(id),
    FOREIGN KEY (card_used) REFERENCES Cards(card_id)
);


--Create a stored procedure to update the users points when a transaction is made
DELIMITER $$

CREATE PROCEDURE RedeemPoints(
    IN shopper_id INT,
    IN product_id INT,
    IN card_id CHAR(12),
    IN points_to_redeem INT,
    IN total_points_earned INT
)
BEGIN
    DECLARE current_points INT;

    -- Get the current points of the shopper
    SELECT total_points INTO current_points
    FROM Shoppers
    WHERE id = shopper_id;

    -- Check if the shopper has enough points
    IF current_points >= points_to_redeem THEN
        START TRANSACTION;

        -- Deduct the points from the shopper's total points
        UPDATE Shoppers
        SET total_points = total_points - points_to_redeem
        WHERE id = shopper_id;

        -- Record the transaction
        INSERT INTO Transactions (shopper_id, product_id, card_used, total_points, points_redeemed)
        VALUES (shopper_id, product_id, card_id, total_points_earned, points_to_redeem);

        COMMIT;
    ELSE
        -- If not enough points, raise an error
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough points to redeem';
    END IF;
END $$

DELIMITER ;

--Create trigger to ensure card_id format is CS##########, using digits 0-9

DELIMITER $$

CREATE TRIGGER before_insert_cards
BEFORE INSERT ON Cards
FOR EACH ROW
BEGIN
    -- Ensure the card_id follows the format "CS##########"
    IF NEW.card_id NOT REGEXP '^CS[0-9]{10}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid card_id format. It must be "CS" followed by 10 digits.';
    END IF;
END $$

DELIMITER ;


-- Create indexes to speed common searches
CREATE INDEX "Customer_query_shopper_cards" ON Shoppers(card_id);
CREATE INDEX "Customer_query_cards" ON Cards(card_id);;
CREATE INDEX Customer_query_transactions_composite ON Transactions(shopper_id, card_used, transaction_date);




