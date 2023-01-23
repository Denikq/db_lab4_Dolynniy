-- Додає час додавання артиста

DROP TRIGGER IF EXISTS added_new_artist ON artist;
DROP FUNCTION IF EXISTS set_data;

CREATE FUNCTION set_data() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS
$$
   BEGIN 
      UPDATE Artist
      SET
		   artist_date = CURRENT_TIMESTAMP(0)
      WHERE 
         artist.artist_id = NEW.artist_id;
      RETURN NULL;
   END;
$$;

CREATE TRIGGER added_new_artist
AFTER INSERT ON Artist
FOR EACH ROW EXECUTE FUNCTION set_data();


CALL add_new_artist('Sholop Nadia', 'Ukraine', 999, 0)
SELECT * FROM artist