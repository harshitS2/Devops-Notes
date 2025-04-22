# SQL Joins and Python-MySQL Connection Learning Session Documentation

**Date:** April 22, 2025  
**Instructor:** Unnamed  
**Session Objective:** Introduce participants to SQL joins for extracting data from multiple tables and demonstrate how to connect Python with MySQL to execute SQL queries programmatically. The session focused on hands-on practice using MySQL Workbench for SQL joins and Jupyter Notebook for Python-MySQL integration, covering database creation, table management, and query execution.

---

## 1. Session Overview

This session followed the previous SQL learning session on the `SELECT` command, transitioning to SQL joins to extract data from multiple tables and introducing Python-MySQL connectivity for programmatic database interaction. Participants learned the concept of joins (inner, left, right, full) to combine data from related tables, reducing data redundancy. They also explored how to use the `mysql-connector-python` library to establish a connection between Python and MySQL, create cursors, and execute SQL queries. The session was highly interactive, with participants executing scripts in MySQL Workbench and Jupyter Notebook, troubleshooting errors, and performing tasks like creating tables, inserting data, and querying results.

### Key Objectives:
- Understand and implement SQL joins (inner, left, right, full) to extract data from multiple tables.
- Create and populate tables in MySQL Workbench to practice joins.
- Learn to connect Python with MySQL using `mysql-connector-python`.
- Execute SQL queries from Python, including creating/deleting databases, tables, inserting data, and querying results.
- Address participant errors and doubts through screen sharing and direct feedback.
- Share SQL and Python scripts for practice and reference.

---

## 2. Session Structure

The session was structured as follows:
1. **Introduction and Recap** (10 minutes)
2. **SQL Joins Theory and Setup** (20 minutes)
3. **Hands-on Joins Practice** (60 minutes, covering inner, left, right, full joins)
4. **Break** (10–15 minutes)
5. **Python-MySQL Connection Setup** (30 minutes)
6. **Hands-on Python-MySQL Query Execution** (60 minutes, including database/table creation, insertion, and querying)
7. **Break** (10–15 minutes)
8. **Doubt Resolution and Feedback** (30 minutes)

---

## 3. Detailed Session Breakdown

### 3.1 Introduction and Recap
- **Context:** The session resumed after a festival break, with the instructor recovering from an illness.
- **Recap of Previous Session:**
  - Confirmed completion of SQL topics: DDL (`CREATE`, `ALTER`, `TRUNCATE`, `DROP`), DML, constraints, and `SELECT` command (DQL).
  - Noted that `SELECT` was partially covered, with joins remaining.
  - TCL and DCL were deemed irrelevant for the curriculum.
- **Session Goals:**
  - Introduce joins to extract data from multiple tables.
  - Teach Python-MySQL connectivity to execute SQL queries programmatically.
  - Ensure hands-on practice with scripts and error resolution.
- **Setup Instructions:**
  - Participants opened MySQL Workbench for joins practice.
  - Later, they opened Jupyter Notebook in their SQL folder, creating a notebook named `Python_connection_with_MySQL.ipynb`.
  - The instructor shared scripts via Zoom chat for execution.

### 3.2 SQL Joins Theory and Setup
The instructor explained the need for joins to extract data from multiple tables, emphasizing data redundancy reduction.

#### Why Multiple Tables?
- **Example Scenario:**
  - **Single Table Approach:** A table with `emp_id`, `emp_name`, `dept_id`, `dept_name`, `head_of_dept` for 10,000 employees and 10 departments.
    - Issue: Redundant `dept_name` and `head_of_dept` repeated for each employee (20,000 values, assuming 10,000 rows × 2 columns).
    - Memory: ~20,000 units (assuming 1 unit per field).
  - **Multiple Tables Approach:**
    - **Employee Table:** `emp_id`, `emp_name`, `dept_id` (10,000 rows × 3 columns = 30,000 values).
    - **Department Table:** `dept_id`, `dept_name`, `head_of_dept` (10 rows × 3 columns = 30 values).
    - Benefit: Reduces redundancy by ~20,000 values, saving memory (30 vs. 20,000 units).
- **Concept:** Separating tables minimizes redundant data, with `dept_id` linking tables for lookups, improving efficiency and flexibility.

#### Joins Overview:
- **Purpose:** Extract data from multiple tables when data is split (e.g., `emp_id`, `emp_name` in `employee` table; `dept_name`, `head_of_dept` in `department` table).
- **Common Column Requirement:** Joins require a common column (e.g., `dept_id`) for matching.
- **Types of Joins (Explained via Venn Diagrams):**
  - **Inner Join:** Returns only matching rows from both tables (intersection).
  - **Left Join:** Returns all rows from the left table, with matching rows from the right table (nulls for non-matches).
  - **Right Join:** Returns all rows from the right table, with matching rows from the left table (nulls for non-matches).
  - **Full Join:** Returns all rows from both tables, with nulls for non-matches (union).
- **Example Data:**
  - **Employee Table (`dept_id`):** 101, 103, 104, 106, 107.
  - **Department Table (`dept_id`):** 101, 102, 103, 104, 105.
  - Common: 101, 103, 104.
  - Unique to Employee: 106, 107.
  - Unique to Department: 102, 105.

#### Database and Table Setup:
- **Database:** Used existing `demo1` database from prior sessions.
- **Tables Created:**
  - **Employee2:** `emp_id`, `emp_name`, `emp_age`, `dept_id`, `salary`.
  - **Department:** `dept_id`, `dept_name`, `head_of_dept`.
- **Script Provided:**
  - Shared `SQL_joins.sql` to create tables and insert data.
  - Inserted rows to include common and unique `dept_id` values for join demonstrations.
- **Execution Instructions:**
  - Open `SQL_joins.sql` in MySQL Workbench.
  - Select all commands and execute using the lightning bolt icon (not `Ctrl+Enter`).
  - Verify with `SELECT * FROM employee2;` (8 rows) and `SELECT * FROM department;` (5 rows).
- **Participant Issue:**
  - **Akash:** Error “unknown database demo1.” Resolved by adding `CREATE DATABASE demo1;` before `USE demo1;`.

```sql
CREATE DATABASE IF NOT EXISTS demo1;
USE demo1;
DROP TABLE IF EXISTS employee2;
DROP TABLE IF EXISTS department;
CREATE TABLE employee2 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    emp_age INT,
    dept_id INT,
    salary INT
);
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    head_of_dept VARCHAR(50)
);
INSERT INTO employee2 VALUES
    (1, 'Abhay', 30, 101, 75000),
    (2, 'Vijay', 28, 103, 80000),
    (3, 'Rohit', 35, 104, 90000),
    (4, 'Sneha', 29, 101, 85000),
    (5, 'Priya', 32, 106, 95000),
    (6, 'Ajay', 27, 107, 70000),
    (7, 'Anita', 31, 103, 82000),
    (8, 'Mohammed', 34, 104, 88000);
INSERT INTO department VALUES
    (101, 'Finance', 'Rahul Sharma'),
    (102, 'Marketing', 'Neha Patel'),
    (103, 'Engineering', 'Suresh Kumar'),
    (104, 'HR', 'Pooja Verma'),
    (105, 'R&D', 'Amit Singh');
SELECT * FROM employee2;
SELECT * FROM department;
```

### 3.3 Hands-on Joins Practice
Participants executed join queries to extract data combining `employee2` and `department` tables.

#### Inner Join:
- **Syntax:**
  ```sql
  SELECT employee2.emp_id, employee2.emp_name, employee2.dept_id, department.dept_name, department.head_of_dept
  FROM employee2
  INNER JOIN department
  ON employee2.dept_id = department.dept_id;
  ```
- **Purpose:** Extracts matching rows (dept_id: 101, 103, 104).
- **Output:** 6 rows (employees with dept_id 101, 103, 104, showing `emp_id`, `emp_name`, `dept_id`, `dept_name`, `head_of_dept`).
- **Explanation:** Only common `dept_id` values appear; 106, 107 (employee2) and 102, 105 (department) are excluded.

#### Left Join:
- **Syntax:**
  ```sql
  SELECT employee2.emp_id, employee2.emp_name, employee2.dept_id, department.dept_name, department.head_of_dept
  FROM employee2
  LEFT JOIN department
  ON employee2.dept_id = department.dept_id;
  ```
- **Purpose:** Includes all `employee2` rows, with nulls for non-matching `dept_id` (106, 107).
- **Output:** 8 rows, with nulls in `dept_name`, `head_of_dept` for dept_id 106, 107.

#### Right Join:
- **Syntax:**
  ```sql
  SELECT employee2.emp_id, employee2.emp_name, employee2.dept_id, department.dept_name, department.head_of_dept
  FROM employee2
  RIGHT JOIN department
  ON employee2.dept_id = department.dept_id;
  ```
- **Purpose:** Includes all `department` rows, with nulls for non-matching `dept_id` (102, 105).
- **Output:** 5 rows, with nulls in `emp_id`, `emp_name` for dept_id 102, 105.

#### Full Join:
- **Challenge:** MySQL lacks a direct `FULL JOIN` command.
- **Solution:** Combine `LEFT JOIN` and `RIGHT JOIN` using `UNION`.
- **Syntax:**
  ```sql
  SELECT employee2.emp_id, employee2.emp_name, employee2.dept_id, department.dept_name, department.head_of_dept
  FROM employee2
  LEFT JOIN department
  ON employee2.dept_id = department.dept_id
  UNION
  SELECT employee2.emp_id, employee2.emp_name, employee2.dept_id, department.dept_name, department.head_of_dept
  FROM employee2
  RIGHT JOIN department
  ON employee2.dept_id = department.dept_id;
  ```
- **Purpose:** Includes all rows from both tables, with nulls for non-matches (dept_id 106, 107 from employee2; 102, 105 from department).
- **Output:** 9 rows (all dept_id: 101, 103, 104, 106, 107, 102, 105).

#### Hands-on Practice:
- Participants executed each join query, verifying results against expected `dept_id` values.
- Encouraged to compare outputs to understand differences (e.g., inner join vs. left join).

#### Common Errors and Fixes:
- **Ambiguous Column Names:** Omitting table prefixes (e.g., `emp_id` vs. `employee2.emp_id`). Fixed by specifying `table.column`.
- **Incorrect Join Type:** Confusion between left and right joins. Clarified using Venn diagrams and result comparisons.
- **Semicolon in Query:** Including semicolons in Python-executed queries. Removed as Python handles it.
- **Execution Order:** Executing queries out of sequence. Emphasized sequential execution in Workbench.

### 3.4 Break
- A 10–15 minute break followed joins practice, allowing participants to review scripts and results.

### 3.5 Python-MySQL Connection Setup
The instructor introduced connecting Python to MySQL using the `mysql-connector-python` library.

#### Key Concepts:
- **Environments:** Python and MySQL are separate environments, requiring a connection for interaction (analogous to file handling with `open()`).
- **Steps:**
  1. **Install Library:** `pip install mysql-connector-python`.
  2. **Make Connection:** Use `mysql.connector.connect()` to create a connection object.
  3. **Create Cursor:** Use connection object to create a cursor for query execution.
  4. **Execute Queries:** Use cursor’s `execute()` or `executemany()` methods.
  5. **Close Connection:** Commit changes (`commit()`) and close connection (`close()`).
- **Library Installation:**
  - Command: `pip install mysql-connector-python`.
  - Output: “Requirement already satisfied” (if installed) or installation progress.
  - Participants confirmed installation via chat (“done”).

#### Connection Setup:
- **Code:**
  ```python
  import mysql.connector
  mydb = mysql.connector.connect(
      host="localhost",
      user="root",
      password="1234"
  )
  mycursor = mydb.cursor()
  ```
- **Explanation:**
  - `host="localhost"`: MySQL server on the local machine.
  - `user="root"`: Default MySQL username.
  - `password="1234"`: Participant-specific password (string).
  - `mydb`: Connection object.
  - `mycursor`: Cursor object for executing queries.

#### Participant Issues:
- **Pallavi:**
  - Issue: Created notebook in home directory, unable to locate SQL folder.
  - Resolution: Guided to create a `data_science` folder, move notebook to `SQL` subfolder, and rename to `Python_connection_with_MySQL.ipynb`.
  - Additional: Noted time zone difference (Pallavi in US, 9 PM).
- **Shalini:** Error due to missing `import mysql.connector`. Fixed by adding import.
- **General:**
  - Incorrect passwords caused connection errors. Participants reminded to use their MySQL password.
  - Confusion with execution order. Clarified to execute cells sequentially.

### 3.6 Hands-on Python-MySQL Query Execution
Participants executed SQL queries from Python, practicing database and table operations.

#### MySQL Environment Connection:
- **Show Databases:**
  ```python
  mycursor.execute("SHOW DATABASES")
  print(list(mycursor))
  # Alternative: for db in mycursor: print(db)
  ```
  - Output: List of databases (e.g., `['demo1', 'mysql', 'information_schema']`).
  - Note: No semicolon needed; Python handles it.
- **Create Database:**
  ```python
  mycursor.execute("CREATE DATABASE demo2")
  mycursor.execute("SHOW DATABASES")
  for db in mycursor:
      print(db)
  ```
  - Output: Confirmed `demo2` in database list.
- **Drop Database:**
  ```python
  mycursor.execute("DROP DATABASE demo2")
  mycursor.execute("SHOW DATABASES")
  print(list(mycursor))
  ```
  - Output: Confirmed `demo2` removed.
- **Close Connection:**
  ```python
  mydb.commit()
  mydb.close()
  ```
  - Purpose: Ensures changes are permanent and closes connection.

#### Specific Database Connection:
- **Connect to `demo1`:**
  ```python
  mydb = mysql.connector.connect(
      host="localhost",
      user="root",
      password="1234",
      database="demo1"
  )
  mycursor = mydb.cursor()
  ```
  - Purpose: Connects to `demo1` for table operations (equivalent to `USE demo1`).
- **Show Tables:**
  ```python
  mycursor.execute("SHOW TABLES")
  for table in mycursor:
      print(table)
  ```
  - Output: `['department', 'employee', 'employee2']`.

#### Table Operations:
- **Drop Table:**
  ```python
  mycursor.execute("DROP TABLE employee")
  mycursor.execute("SHOW TABLES")
  print(list(mycursor))
  ```
  - Output: Confirmed `employee` removed.
- **Create Table:**
  ```python
  query = """
  CREATE TABLE employee (
      emp_id INT PRIMARY KEY,
      name VARCHAR(100),
      age INT,
      city VARCHAR(100)
  )
  """
  mycursor.execute(query)
  mycursor.execute("SHOW TABLES")
  print(list(mycursor))
  ```
  - Output: Confirmed `employee` created.
  - Note: Used triple quotes for multiline query readability.

#### Insert Operations:
- **Single Row Insert:**
  ```python
  query = "INSERT INTO employee (emp_id, name, age, city) VALUES (%s, %s, %s, %s)"
  values = (101, "Abhay", 30, "Delhi")
  mycursor.execute(query, values)
  mycursor.execute("SELECT * FROM employee")
  for row in mycursor:
      print(row)
  ```
  - Output: `(101, 'Abhay', 30, 'Delhi')`.
  - Explanation: `%s` placeholders prevent string formatting issues; values passed as a tuple.
- **Multiple Row Insert:**
  ```python
  query = "INSERT INTO employee (emp_id, name, age, city) VALUES (%s, %s, %s, %s)"
  values = [
      (103, "Jyoti", 28, "Mumbai"),
      (104, "Mohammed", 35, "Hyderabad")
  ]
  mycursor.executemany(query, values)
  mycursor.execute("SELECT * FROM employee")
  for row in mycursor:
      print(row)
  ```
  - Output: Three rows (101, 103, 104).
  - Explanation: `executemany()` handles list of tuples for batch insertion.

#### Query Examples:
- **Filter by Age:**
  ```python
  query = "SELECT * FROM employee WHERE age > 40"
  mycursor.execute(query)
  for row in mycursor:
      print(row)
  ```
  - Output: Employees with `age > 40` (none in this case).
- **Filter by City:**
  ```python
  query = "SELECT * FROM employee WHERE city IN ('Jaipur', 'Delhi', 'Mumbai')"
  mycursor.execute(query)
  for row in mycursor:
      print(row)
  ```
  - Output: `(101, 'Abhay', 30, 'Delhi')`, `(103, 'Jyoti', 28, 'Mumbai')`.
- **Group By (Average Salary per Department):**
  ```python
  query = """
  SELECT department, AVG(salary) AS average_salary
  FROM employee
  GROUP BY department
  ORDER BY average_salary DESC
  """
  mycursor.execute(query)
  for row in mycursor:
      print(row)
  ```
  - Output: Average salaries per department (from `employee` table in `demo1`), in descending order.
  - Task: Participants wrote this query; only Jyoti and Mohammed submitted correct answers initially.
- **Subquery (Salary > Average):**
  ```python
  query = """
  SELECT *
  FROM employee
  WHERE salary > (SELECT AVG(salary) FROM employee)
  """
  mycursor.execute(query)
  for row in mycursor:
      print(row)
  ```
  - Output: Employees with salaries above the average.
- **Inner Join:**
  ```python
  query = """
  SELECT employee2.emp_id, employee2.emp_name, employee2.dept_id, department.dept_name, department.head_of_dept
  FROM employee2
  INNER JOIN department
  ON employee2.dept_id = department.dept_id
  """
  mycursor.execute(query)
  for row in mycursor:
      print(row)
  ```
  - Output: Same as MySQL Workbench inner join (6 rows).

#### Hands-on Practice:
- Participants executed queries to create/delete databases, tables, insert data, and query results.
- Tasks:
  - Write SQL query for average salary per department (group by, order by).
  - Write subquery for employees with above-average salaries.
- Encouraged to use triple quotes for multiline queries and handle cursor results (`list(mycursor)` or `for` loop).

#### Common Errors and Fixes:
- **Unread Cursor Results:** Error “unread result found” when executing a new query without reading prior results. Fixed by accessing results (`list(mycursor)`) before re-executing.
- **Syntax Errors:**
  - `SHOW DATABASE` instead of `SHOW DATABASES` (Abhijit). Corrected query.
  - Missing commas in tuple lists for `executemany()` (Avinash). Added commas.
  - Single quotes in query with single-quoted values (Lenny). Used double quotes externally.
- **Execution Order:** Executing cells out of sequence or without closing connections (Ajay, Anita). Restarted kernel and executed sequentially.
- **Table Name Errors:** `CREATE TABLES` instead of `CREATE TABLE` (Rajeet). Corrected syntax.
- **Connection Not Closed:** Caused errors when reconnecting (Pallavi). Added `mydb.commit()`, `mydb.close()`.

#### Participant Issues:
- **Pallavi:** Multiple errors due to execution order and unread results. Resolved by restarting kernel, executing sequentially, and clearing cursor results.
- **Vidya:** Confusion about cursor result storage. Clarified that `mycursor` stores query output, accessible via `list(mycursor)` or iteration.
- **Raju:** Requested real-world application context. Explained as data analysis (extracting data for Python analysis) and deferred web development discussion.
- **Vishaka:** Repeated library installation. Clarified installation is one-time.
- **Mohammed:** Missing bracket in insert query. Added bracket.
- **Lenny:** Asked how to query average salary. Clarified using `SELECT AVG(salary) FROM employee`.

### 3.7 Break
- A second 10–15 minute break was taken before the doubt session, with the instructor sharing the Jupyter notebook (`Python_connection_with_MySQL.ipynb`).

### 3.8 Doubt Resolution and Feedback
The instructor addressed doubts, shared materials, and collected feedback.

#### Materials Shared:
- **Jupyter Notebook:** `Python_connection_with_MySQL.ipynb`.
- **ZIP Files:**
  - Updated SQL material (DDL, DML, constraints, select, joins).
  - Complete Python material.
- **Instructions:** Save in `data_science` folder, extract for access.

#### Doubts Addressed:
- **Vidya:** Clarified cursor result storage and output access.
- **Rajeet:** Fixed `CREATE TABLES` error and cursor result issue.
- **Pallavi:** Resolved execution order and cursor errors via screen sharing.
- **Abhijit:** Corrected `SHOW DATABASE` to `SHOW DATABASES` and advised on learning resources (HackerRank, YouTube for stored procedures/triggers).
- **Avinash:** Fixed missing commas in `executemany()` and table deletion error.
- **Lenny:** Fixed quote mismatch and clarified average salary query.
- **Raju:** Explained data analysis use case (Python extracts data for analysis).
- **Ajay/Anita:** Fixed execution order issues by restarting kernel and closing connections.

#### Additional Discussions:
- **Learning Resources:** Recommended HackerRank for Python/SQL practice, YouTube for stored procedures/triggers, and provided book PDFs for statistics/ML.
- **Career Advice:** Emphasized practicing Python/SQL through coding, not just reading.
- **Folder Structure:** Advised creating `data_science` folder with subfolders (Python, SQL, assignments).
- **Curriculum Completion:** Completed Python and SQL module; next module (statistics and data analysis) starts tomorrow.

#### Feedback:
- **Poll Results:** ~90% gave 5 stars, ~10% gave 4 stars, indicating positive reception.
- **Issue:** Some panelists couldn’t participate in poll. Resolved by making them attendees.

---

## 4. Challenges and Observations
- **Technical Issues:**
  - Participants struggled with Jupyter Notebook navigation (e.g., Pallavi’s home directory issue).
  - Frequent execution order errors (e.g., not closing connections, skipping imports).
  - Cursor result errors due to unread results were common.
- **Error Management:** Syntax errors (e.g., `SHOW DATABASE`, missing commas) and logical errors (e.g., subquery confusion) required extensive troubleshooting.
- **Participant Engagement:** Varied proficiency; some (Jyoti, Mohammed) excelled in tasks, while others (Pallavi, Ajay) needed basic guidance.
- **Time Management:** Doubt resolution consumed significant time, limiting advanced query practice.
- **Data Quality:** Pre-populated tables ensured consistent join results, but participant errors in query syntax persisted.

---

## 5. Recommendations for Future Sessions
1. **Pre-Session Preparation:**
   - Share Jupyter setup guide (folder structure, notebook creation).
   - Provide checklist for MySQL Workbench and Python environment setup.
2. **Error Handling:**
   - Create a guide for common errors (e.g., unread cursor results, execution order, syntax).
   - Encourage error-sharing via chat for quicker resolution.
3. **Conceptual Clarity:**
   - Use diagrams for Python-MySQL connection flow (connection → cursor → execute).
   - Reinforce cursor result handling with examples.
4. **Practice Opportunities:**
   - Assign SQL query tasks (e.g., 5 join queries, 5 Python-SQL queries).
   - Recommend HackerRank/LeetCode for SQL practice.
5. **Technical Support:**
   - Offer pre-session tech support for Jupyter/MySQL setup.
   - Provide contact for real-time issues.
6. **Time Management:**
   - Limit doubt resolution to 5 minutes per participant.
   - Schedule advanced topics (e.g., stored procedures, triggers) as optional sessions.

---

## 6. Conclusion
The session successfully introduced SQL joins and Python-MySQL connectivity, enabling participants to extract data from multiple tables and execute SQL queries programmatically. Participants practiced joins (inner, left, right, full) in MySQL Workbench and performed database operations in Python, including creating tables, inserting data, and querying results. Shared scripts and doubt resolution ensured accessibility, though execution order and cursor errors posed challenges. The session completed the Python and SQL module, with the next module (statistics and data analysis) starting tomorrow.

**Next Session:** Introduction to statistics and data analysis, continuing in the same Zoom link until next week.

**Prepared by:** Grok 3, xAI  
**Note:** This documentation captures all key points from the transcript, including participant interactions, instructor guidance, and code snippets, structured for clarity and completeness. The SQL script is included as an artifact.