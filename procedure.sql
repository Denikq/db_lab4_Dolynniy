-- ПРОЦЕДУРА (додає нову книгу в таблицю, але без дати)

DROP PROCEDURE add_new_book;

CREATE OR REPLACE PROCEDURE add_new_book(b_name CHAR(1000), b_pages INT, a_id INT, r_id INT)
LANGUAGE'plpgsql'
AS $$
   DECLARE 
      b_id book.book_id%type;
      b_date book.book_date%type := NULL;
   BEGIN
      SELECT (book_id+1) INTO b_id FROM Book ORDER BY book_id DESC LIMIT 1;
      INSERT INTO Book(book_id, book_name, book_pages, book_date, author_id, rating_id)
      VALUES(b_id, b_name, b_pages, b_date, a_id, r_id);
   END;
$$

CALL add_new_book('My book', 100, 0, 0)
SELECT * FROM book