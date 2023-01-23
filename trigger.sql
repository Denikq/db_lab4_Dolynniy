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