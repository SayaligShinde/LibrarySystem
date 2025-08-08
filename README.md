# LibrarySystem
Library Management System (SQL) – A database-driven project to manage books, members, and borrowing records using MySQL. Includes tables for members, books, and transactions, along with stored procedures for issuing and returning books, stock tracking, and availability checks.
## 📚 Library Management System (SQL)
# 📌 Overview
The Library Management System is a MySQL-based database project designed to manage books, members, and borrowing activities efficiently.
It supports adding members, tracking book availability, issuing and returning books, and maintaining transaction history.

# 🚀 Features
📖 Manage Books – Add, update, and track available copies.

👤 Manage Members – Store member details with contact information.

🔄 Borrow & Return Books – Issue books with stock checks, return with status updates.

📅 Transaction History – Maintain borrow records with dates and statuses.

⚠️ Error Handling – Prevent issuing when no copies are available.

# 🗄 Database Structure
Tables
members – Stores member information.

books – Stores book details and availability.

borrow_records – Stores borrowing transactions.

Stored Procedures
issue_book(member_id, book_id) – Issues a book to a member.

return_book(borrow_id) – Returns a book and updates availability.

# 📌 Tech Stack
Database: MySQL

Language: SQL

Tool: MySQL Workbench / MySQL CLI
