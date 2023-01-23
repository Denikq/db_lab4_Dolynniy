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