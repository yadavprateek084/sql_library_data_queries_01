📚 Library Management System (PostgreSQL)

🚀 Overview

The Library Management System is a relational database project built using PostgreSQL, designed to simulate real-world library operations. It efficiently manages books, members, employees, and transactions such as issuing and returning books.

This project demonstrates strong understanding of database design, normalization, and advanced SQL queries.

🏗️ Database Architecture
📌 Core Tables
branch – Stores branch details
employees – Staff information
books – Book inventory
members – Registered users
issued_status – Issued book records
return_status – Returned book records
🔗 Relationships
Employees are assigned to branches
Books are issued to members via employees
Return records are linked to issued books
⚙️ Features
🔹 CRUD Operations
Add new books
Update member details
Delete issued records
Retrieve issued data
🔹 Analytical Queries
Books by category
Rental revenue calculation
Active members (last 4 years)
Employee & branch insights
🔹 Advanced SQL Concepts
JOINs (INNER, LEFT, RIGHT)
GROUP BY & HAVING
Aggregation (COUNT, SUM)
CTAS (Create Table As Select)
📊 Key Functionalities
✅ Book Management
Insert and categorize books
Identify high-value books
✅ Member Management
Update member details
Track frequent borrowers
✅ Issue & Return System
Track issued books
Detect unreturned books
✅ Reporting & Insights
Rental income by category
Book issue trends
Branch-level analysis
🧠 Sample Queries
🔍 Find Unreturned Books
SELECT isu.*
FROM issued_status isu
LEFT JOIN return_status rs 
ON isu.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;
💰 Rental Income by Category
SELECT 
    b.category,
    COUNT(s.issued_id) AS times_issued,
    SUM(b.rental_price) AS total_rent
FROM books b
JOIN issued_status s 
ON b.isbn = s.issued_book_isbn
GROUP BY b.category;
👥 Frequent Members
SELECT 
    issued_member_id,
    COUNT(*) AS total_books
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(*) > 1;
📁 Project Structure
library-management-system/
│── library_project_01.sql
│── README.md
🛠️ Tech Stack
Database: PostgreSQL
Language: SQL (DDL, DML, DQL)
💡 Real-World Applications
Library automation systems
Inventory management systems
Rental service platforms
Database design practice
🔮 Future Enhancements
Stored Procedures & Triggers
Role-based access control
REST API integration (Node.js)
Frontend dashboard (React)
👨‍💻 Author

Prateek Yadav
B.Tech (CSE)
