-- ФУНКЦІЯ (кількість книги в яких рейтинг більше n)

DROP FUNCTION IF EXISTS books_func;

CREATE OR REPLACE FUNCTION books_func(n FLOAT)
RETURNS INTEGER
LANGUAGE 'plpgsql'
AS $$
   BEGIN
      RETURN (SELECT COUNT(*) 
              FROM Book, Rating 
              WHERE book.rating_id = rating.rating_id
              AND rating_average > n
              
             );
   END;
$$

SELECT books_func(0)
SELECT books_func(4.45)

SELECT rating_average FROM rating, book
WHERE book.rating_id = rating.rating_id



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


-- ТРІГЕР (додає час додавання книжки)

DROP TRIGGER IF EXISTS added_new_book ON Book;
DROP FUNCTION IF EXISTS set_data;

CREATE FUNCTION set_data() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS
$$
   BEGIN 
      UPDATE Book
      SET
		   book_date = now()
      WHERE 
         book.book_id = NEW.book_id;
      RETURN NULL;
   END;
$$;

CREATE TRIGGER added_new_book
AFTER INSERT ON Book
FOR EACH ROW EXECUTE FUNCTION set_data();


CALL add_new_book('My new book', 150, 1, 1)
SELECT * FROM Book



