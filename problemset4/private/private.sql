-- Create a cte that contains all the the first column of sentence id's joined with our new table's id's
CREATE TABLE "white_paper" (
    sentence_id INTEGER,
    first_char INTEGER,
    second_char INTEGER
);

-- Insert into this table, the whitepaper values
INSERT INTO "white_paper" ("sentence_id", "first_char", "second_char") VALUES
(14, 98, 4), (114, 3, 5), (618, 72, 9), (630, 7, 3), (932, 12, 5), (2230, 50, 7), (2346, 44, 10), (3041, 14, 5);

--Create the substr query that will provide the deciphered message
SELECT substr(sentence, "first_char", "second_char") FROM white_paper
    JOIN sentences ON sentences.id = white_paper.sentence_id;

--Create the message view
CREATE VIEW "message" AS
SELECT substr(sentence, "first_char", "second_char") AS "phrase" FROM white_paper
    JOIN sentences ON sentences.id = white_paper.sentence_id;

