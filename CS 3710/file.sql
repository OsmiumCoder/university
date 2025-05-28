DROP DATABASE IF EXISTS midterm;
CREATE DATABASE midterm;

USE midterm;

CREATE TABLE YourTableName (
    varchar_column VARCHAR(255),
    integer_column INT,
    numeric_column NUMERIC(10, 2),
    char_column CHAR(10),
    text_column TEXT(1000)
);

INSERT INTO YourTableName VALUES ('ddd', 4, 4.333, '12345678900000', '1234567890000');