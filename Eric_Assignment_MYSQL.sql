-- Q 1) Statement to create the Contact table and company table
-- Q 2) Statement to create the Employee table:
-- Q 3) Statement to create the ContactEmployee table:
-- Q 4) Statement to change Lesley Bland’s phone number in the Employee table:
/* Q 5) Statement to change the name of "Urban Outfitters, Inc."
to "Urban Outfitters" in the Company table: */
/* Q 6) In ContactEmployee table, the statement that removes 
Dianne Connor’s contact event with Jack Lee (one statement). 
HINT: Use the primary key of the ContactEmployee table 
to specify the correct record to remove. */
/* Q 7) Write the SQL SELECT query that displays the names 
of the employees that have contacted Toll Brothers 
(one statement). Run the SQL SELECT query in MySQL Workbench. 
Copy the results below as well. */

-- Answers of Q 1 to Q 7

-- Create the database
CREATE DATABASE IF NOT EXISTS MarketCo;

-- Select the database
USE MarketCo;

-- 3) Create the Company table
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10)
);

-- Create the Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

--  Create the Contact table
CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain BOOLEAN,
    Email VARCHAR(45),
    Phone VARCHAR(12),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

-- Create the ContactEmployee table
CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100),
    FOREIGN KEY (ContactID) REFERENCES Contact(ContactID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Insert sample data into the Company table
INSERT INTO Company (CompanyID, CompanyName, Street, City, State, Zip)
VALUES
(1, 'Urban Outfitters, Inc.', '123 Market St', 'Philadelphia', 'PA', '19107'),
(2, 'Toll Brothers', '456 Main St', 'Horsham', 'PA', '19044'),
(3, 'Target Corporation', '789 Broad St', 'Minneapolis', 'MN', '55402');

-- Insert sample data into the Employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone)
VALUES
(1, 'Lesley', 'Bland', 75000.00, '2018-06-12', 'Manager', 'lesley.bland@example.com', '215-555-1234'),
(2, 'Jack', 'Lee', 65000.00, '2017-04-05', 'Sales Rep', 'jack.lee@example.com', '215-555-5678'),
(3, 'Maria', 'Smith', 82000.00, '2015-08-19', 'VP of Marketing', 'maria.smith@example.com', '312-555-9012');

-- Insert sample data into the Contact table
INSERT INTO Contact (ContactID, CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone)
VALUES
(1, 2, 'Dianne', 'Connor', '123 Elm St', 'Horsham', 'PA', '19044', TRUE, 'dianne.connor@example.com', '215-555-1010'),
(2, 2, 'John', 'Doe', '789 Oak St', 'Horsham', 'PA', '19044', FALSE, 'john.doe@example.com', '215-555-2020'),
(3, 1, 'Amanda', 'Green', '456 Pine St', 'Philadelphia', 'PA', '19107', TRUE, 'amanda.green@example.com', '215-555-3030');

-- Insert sample data into the ContactEmployee table
INSERT INTO ContactEmployee (ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description)
VALUES
(1, 1, 2, '2023-08-15', 'Sales follow-up with Dianne Connor'),
(2, 2, 1, '2023-09-01', 'Meeting with John Doe regarding Toll Brothers partnership'),
(3, 3, 3, '2023-07-10', 'Urban Outfitters marketing strategy discussion');

--  Update Lesley Bland's phone number in the Employee table
UPDATE Employee
SET Phone = '215-555-8800'
WHERE FirstName = 'Lesley' AND LastName = 'Bland';

-- Update the name of Urban Outfitters, Inc. to Urban Outfitters in the Company table
UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyName = 'Urban Outfitters, Inc.';

-- Delete the contact event between Dianne Connor and Jack Lee in the ContactEmployee table
DELETE FROM ContactEmployee
WHERE ContactEmployeeID = (
    SELECT ContactEmployeeID
    FROM ContactEmployee
    JOIN Contact ON ContactEmployee.ContactID = Contact.ContactID
    JOIN Employee ON ContactEmployee.EmployeeID = Employee.EmployeeID
    WHERE Contact.FirstName = 'Dianne' AND Contact.LastName = 'Connor'
    AND Employee.FirstName = 'Jack' AND Employee.LastName = 'Lee'
);

-- Select the names of the employees who have contacted Toll Brothers
SELECT Employee.FirstName, Employee.LastName
FROM ContactEmployee
JOIN Contact ON ContactEmployee.ContactID = Contact.ContactID
JOIN Employee ON ContactEmployee.EmployeeID = Employee.EmployeeID
JOIN Company ON Contact.CompanyID = Company.CompanyID
WHERE Company.CompanyName = 'Toll Brothers';

/* Theory Questions /*

/* A 8) In SQL, the % operator matches any number of characters,
 including zero, and can be used at the beginning, end, 
 or middle of a pattern. The _ operator matches exactly 
 one character and can be used in the middle of a pattern. 
 These wildcards can be used together to create complex 
 patterns. For example, LIKE 'a%_b%' matches any string 
 that starts with 'a', has at least one character after 'a',
 has 'b' after that, and can have any characters after 'b'. */
 
 -- Q 9)Explain normalization in the context of databases. 
 
 /* A 9) Normalization in the context of databases is the
 process of organizing the data in a database to minimize 
 data redundancy and dependency. It involves dividing the
 data into smaller, related tables to improve data 
 integrity, reduce data duplication, and enhance scalability.
There are three main normalization rules:
First Normal Form (1NF): Each table cell must contain 
a single value.
Second Normal Form (2NF): Each non-key attribute in a 
table must depend on the entire primary key.
Third Normal Form (3NF): If a table is in 2NF, 
and a non-key attribute depends on another non-key
 attribute, then it should be moved to a separate table.
Higher levels of normalization, such as Boyce-Codd Normal Form
(BCNF), Fourth Normal Form (4NF), and Fifth Normal Form
(5NF), exist, but they are less commonly used.
Normalization helps to:
Eliminate data redundancy and inconsistencies
Improve data integrity and accuracy
Reduce data storage requirements
Enhance scalability and flexibility
Simplify database maintenance and updates. */

-- 10) What does a join in MySQL mean? 

/* A 10) In MySQL, a join is a way to combine rows from 
two or more tables based on a related column between them. 
It allows you to retrieve data from multiple tables in
 a single query, making it a powerful tool for querying 
 complex data relationships.
There are several types of joins in MySQL:
INNER JOIN: Returns only the rows that have a match in 
both tables.
LEFT JOIN (or LEFT OUTER JOIN): Returns all the rows from 
the left table and the matching rows from the right table. 
If there's no match, the result will contain NULL values.
RIGHT JOIN (or RIGHT OUTER JOIN): Similar to LEFT JOIN, 
but returns all the rows from the right table and the 
matching rows from the left table.
FULL JOIN (or FULL OUTER JOIN): Returns all rows from both
tables, with NULL values in the columns where 
there's no match.
CROSS JOIN: Returns the Cartesian product of both tables,
with each row of one table combined with each row of the
other table.
Joins are essential in MySQL, as they allow you to combine
data from multiple tables to answer complex queries 
and perform data analysis.

/* Q 11) What do you understand about DDL, DCL, and DML 
in MySQL? */

/* A 11) In MySQL, DDL, DCL, and DML are three categories 
of SQL statements that serve different purposes in managing 
and interacting with databases.
DDL (Data Definition Language): DDL statements are used 
to define the structure of a database, including creating, 
modifying, and deleting database objects such as tables, 
indexes, views, and relationships. DDL statements are used 
to define the schema of a database.
Examples of DDL statements in MySQL:
CREATE: Creates a new database object, such as a table, 
index, or view.
ALTER: Modifies the structure of an existing database object.
DROP: Deletes a database object.
TRUNCATE: Empties a table, removing all rows and 
resetting the auto-incrementing ID.
DCL (Data Control Language): DCL statements are used to 
control access to a database, including managing user 
accounts, permissions, and access privileges. DCL statements 
are used to define the security and access control of a 
database.
Examples of DCL statements in MySQL:
GRANT: Assigns privileges to a user or role.
REVOKE: Revokes privileges from a user or role.
CREATE USER: Creates a new user account.
DROP USER: Deletes a user account.
DML (Data Manipulation Language): DML statements are used 
to manipulate data in a database, including inserting, 
updating, and deleting data. DML statements are used to 
perform CRUD (Create, Read, Update, Delete) operations on 
data.
Examples of DML statements in MySQL:
INSERT: Inserts new data into a table.
UPDATE: Modifies existing data in a table.
DELETE: Deletes data from a table.
SELECT: Retrieves data from a table.
These three categories of SQL statements are essential 
in MySQL, as they allow you to define the structure of 
a database, control access to it, and manipulate the data 
it contains.

/* Q 12) What is the role of the MySQL JOIN clause in a 
query, and what are some common types of joins? */

/* A 12) The MySQL JOIN clause combines rows from two 
or more tables based on a related column. 
It's used to retrieve data from multiple tables 
in a single query. There are several types of joins:
INNER JOIN: Returns matching rows from both tables.
LEFT JOIN: Returns all rows from the left table and 
matching rows from the right table.
RIGHT JOIN: Returns all rows from the right table 
and matching rows from the left table.
FULL JOIN: Returns all rows from both tables with NULL values 
where there's no match.
CROSS JOIN: Returns the Cartesian product of both tables.
Each type of join serves a specific purpose, and the 
choice of join depends on the query requirements.

