
--trigger pour la suppression de l'utilisateur : remplace dans les commentaires et les descriptions par l'utilisateur supprimé et supprime les notes correspondantes.
CREATE OR REPLACE FUNCTION replace() RETURNS trigger AS $replace_user$
DECLARE
  r BIGINT;
BEGIN
    FOR r IN SELECT id_user FROM note
    LOOP
        DELETE FROM note
          WHERE id_user = OLD.id_user;
    END LOOP;
    FOR r IN SELECT id_user FROM comment
    LOOP
        UPDATE comment
          SET id_user = 0
          WHERE id_user = OLD.id_user;
    END LOOP;
    FOR r IN SELECT id_user FROM description
    LOOP
        UPDATE description
          SET id_user = 0
          WHERE id_user = OLD.id_user;
    END LOOP;
    RETURN;
END;
$replace_user$ LANGUAGE plpgsql;

CREATE TRIGGER replace_user
BEFORE DELETE ON "user"
    EXECUTE PROCEDURE replace();
    
