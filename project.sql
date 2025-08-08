-- Create Database
CREATE DATABASE library_system;
USE library_system;

-- Members Table
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    joined_date DATE DEFAULT (CURRENT_DATE)
);

-- Books Table
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    author VARCHAR(100),
    genre VARCHAR(50),
    total_copies INT,
    available_copies INT
);

-- Borrow Table
CREATE TABLE borrow_records (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,
    status ENUM('Issued', 'Returned') DEFAULT 'Issued',
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Sample Data
INSERT INTO members (name, email, phone) VALUES
('Sayali Shinde', 'sayali@example.com', '9876543210'),
('Rohan Patil', 'rohan@example.com', '9876501234');

INSERT INTO books (title, author, genre, total_copies, available_copies) VALUES
('The Alchemist', 'Paulo Coelho', 'Fiction', 5, 5),
('Clean Code', 'Robert C. Martin', 'Programming', 3, 3),
('Data Science Handbook', 'Jake VanderPlas', 'Data Science', 4, 4);

-- Stored Procedure: Issue Book
DELIMITER //
CREATE PROCEDURE issue_book(IN mem_id INT, IN bk_id INT)
BEGIN
    DECLARE copies INT;
    SELECT available_copies INTO copies FROM books WHERE book_id = bk_id;

    IF copies > 0 THEN
        INSERT INTO borrow_records (member_id, book_id) VALUES (mem_id, bk_id);
        UPDATE books SET available_copies = available_copies - 1 WHERE book_id = bk_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No copies available';
    END IF;
END //
DELIMITER ;

-- Stored Procedure: Return Book
DELIMITER //
CREATE PROCEDURE return_book(IN borrowId INT)
BEGIN
    DECLARE bk_id INT;
    SELECT book_id INTO bk_id FROM borrow_records WHERE borrow_id = borrowId AND status = 'Issued';

    IF bk_id IS NOT NULL THEN
        UPDATE borrow_records 
        SET return_date = CURRENT_DATE, status = 'Returned'
        WHERE borrow_id = borrowId;

        UPDATE books SET available_copies = available_copies + 1 WHERE book_id = bk_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Book already returned or invalid borrow ID';
    END IF;
END //
DELIMITER ;

-- Test: Issue a book
CALL issue_book(1, 2);

-- Test: Return a book
CALL return_book(1);

-- View all records
SELECT * FROM borrow_records;
SELECT * FROM books;
