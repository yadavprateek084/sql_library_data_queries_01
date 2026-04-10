# 📚 Library Management System (PostgreSQL)

## 🚀 Overview

A relational database system built using PostgreSQL to manage library operations such as book inventory, member records, and issue/return tracking.

This project demonstrates strong fundamentals of database design, normalization, and SQL querying.

---

## 🏗️ Database Design

### Tables

* **branch** — Stores branch details
* **employees** — Staff data
* **books** — Book inventory
* **members** — Registered users
* **issued_status** — Issued book records
* **return_status** — Returned book records

### Relationships

* Employees belong to branches
* Books are issued to members via employees
* Return records are linked to issued books

---

## ⚙️ Features

* CRUD operations (Insert, Update, Delete, Select)
* Book issue and return tracking
* Member activity tracking
* Rental revenue analysis
* Identification of unreturned books

---

## 📊 Key Queries

### Find Unreturned Books

```sql
SELECT isu.*
FROM issued_status isu
LEFT JOIN return_status rs 
ON isu.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;
```

### Rental Income by Category

```sql
SELECT 
    b.category,
    COUNT(s.issued_id) AS times_issued,
    SUM(b.rental_price) AS total_rent
FROM books b
JOIN issued_status s 
ON b.isbn = s.issued_book_isbn
GROUP BY b.category;
```

### Frequent Members

```sql
SELECT 
    issued_member_id,
    COUNT(*) AS total_books
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(*) > 1;
```

---

## 🛠️ Tech Stack

* PostgreSQL
* SQL (DDL, DML, DQL)

---

## 📁 Project Structure

library-management-system/
│── library_project_01.sql
│── README.md


---

## 🔮 Future Improvements

* Stored procedures and triggers
* API integration (Node.js)
* Frontend dashboard (React)

---

## 👨‍💻 Author

Prateek Yadav
B.Tech CSE
