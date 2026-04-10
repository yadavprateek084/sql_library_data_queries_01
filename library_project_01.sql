--library management system

drop table if exists branch;
create table branch (
	branch_id varchar(10) primary key,
	manager_id varchar(10),
	branch_address varchar(100),
	contact_no varchar(10)
);

drop table if exists employees;
create table employees (
emp_id varchar(10) primary key,
emp_name varchar(30),
position varchar(20),
salary int,
branch_id varchar(10)
);

drop table if exists books;
create table books (
isbn varchar(30) primary key,
book_title varchar(100),
category varchar(20),
rental_price float,
status varchar(10),
author varchar(30),
publisher varchar(50)
);

drop table if exists issued_status;
create table issued_status (
issued_id varchar(10) primary key,
issued_member_id varchar(10),
issued_book_name varchar(100),
issued_date	date,
issued_book_isbn varchar(100),
issued_emp_id varchar(10)
);

drop table if exists members;
create table members (
member_id varchar(10) primary key,
member_name	varchar(30),
member_address varchar(100),
reg_date date
);

drop table if exists return_status;
create table return_status(
return_id varchar(10) primary key,
issued_id varchar(10),
return_book_name varchar(100),
return_date date,
return_book_isbn varchar(30)
);

--foreign key

alter table issued_status
add constraint fk_issued_member_id
foreign key (issued_member_id)
references members(member_id);

alter table issued_status
add constraint fk_issued_book_isbn
foreign key (issued_book_isbn)
references books(isbn);

alter table issued_status
add constraint fk_issued_emp_id
foreign key (issued_emp_id)
references employees(emp_id);

alter table employees
add constraint fk_branch_id
foreign key (branch_id)
references branch(branch_id);

alter table return_status
add constraint fk_issued_id
foreign key (issued_id)
references issued_status(issued_id);

alter table return_status
add constraint fk_return_book_isbn
foreign key (return_book_isbn)
references books(isbn);



select * from books
select * from books_count
select * from members
select * from issued_status
select * from branch
select * from employees


-- Project TASK


-- ### 2. CRUD Operations


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

	insert into books(isbn	,book_title,	category,	rental_price,	status	,author,	publisher)
	values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co');

-- Task 2: Update an Existing Member's Address

	update members
	set member_address = 'jaunpur'
	where member_id='C106'

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

	delete from issued_status
	where issued_id='IS105'

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E104'.

	select
		issued_emp_id,
		issued_book_name
	from issued_status
	where issued_emp_id = 'E104'

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

	select 
		issued_emp_id,
		count(issued_book_name) as Issued_More_Than_One_Book
	from issued_status
	group by 1
	having count(issued_book_name)>1
	order by 1

-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
create table books_count as
	select book_title,count(issued_id)
	from books b
	join issued_status s on b.isbn = s.issued_book_isbn
	group by book_title
	

-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:
	
	select *
	from books
	where Category='Classic'
	
-- Task 8: Find Total Rental Income by Category:

	select 
		b.category,
		count(s.issued_id) as times_issued,
		sum(b.rental_price) as total_rent
	from books b
	join issued_status s on b.isbn = s.issued_book_isbn
	group by 1

-- Task 9. **List Members Who Registered in the Last 4 years**:

	select reg_date
	from members
	where reg_date > CURRENT_DATE  - interval '4 years'
	order by 1

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

	create table manager_name as 
	select b.manager_id,e.emp_name as manager_name
	from employees e
	join branch b on e.branch_id = b.branch_id
	where b.manager_id=e.emp_id
	
	select 
		e.emp_id,
		e.emp_name,
		m.manager_name,
		b.branch_address,
		b.contact_no,position,salary
	from employees e
	right join branch b on e.branch_id = b.branch_id
	right join manager_name m on m.manager_id=b.manager_id
	order by emp_id
	
-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

	create table expensive_books as
	select *
	from books
	where rental_price > 7

-- Task 12: Retrieve the List of Books Not Yet Returned

	select 
		isu.*
	from issued_status isu
	left join return_status rs on isu.issued_id = rs.issued_id
	where rs.return_id is null
		
