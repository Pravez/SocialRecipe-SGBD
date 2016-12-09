-----------------------------------------------------------------------------
--Mises à jour
-----------------------------------------------------------------------------

--Ajout recette

INSERT INTO recipe ( column [, ...] ) ]
    { DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) | query }

--Suppression du menu @menu.

DELETE FROM menu
    WHERE id_menu = @menu;
    
--Suppression de la recette @recipe.

DELETE FROM recipe
    WHERE id_recipe = @recipe;
    
--Suppression de l'utilisateur @user.

DELETE FROM 'user'
    WHERE id_user = @user;

--trigger pour la suppression de l'utilisateur
--trigger arguments postgresql
CREATE OR REPLACE FUNCTION replace() RETURNS trigger AS $replace_user$
DECLARE
  r BIGINT;
BEGIN
    FOR r IN SELECT id_user FROM note
    LOOP
        UPDATE note
          SET id_user = 0
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
AFTER DELETE ON "user"
    EXECUTE PROCEDURE replace();
    
--Modification d'une recette @recipe

UPDATE recipe
    SET ColumnToChange= newValue
    [ WHERE id_recipe = @recipe


--Modification d'un ingrédient

--Modification d'un menu
