-----------------------------------------------------------------------------
--Mises à jour
-----------------------------------------------------------------------------


--------------- AJOUT D'UNE RECETTE -------------------
--Création de la recette
INSERT INTO recipe (recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings)
    VALUES (@name, @date, @p_time, @c_time, @w_time, @servings);

--Création du lien avec category
INSERT INTO is_category column (id_category, id_recipe)
    VALUES (@id_ctageory, id_recipe);

--Création du lien avec ingredient
INSERT INTO constitute (id_recipe, id_ingredient, id_unit, quantity)
    VALUES (@id_recipe, @id_ingredient, @id_unit, @quantity);


--Suppression de la note de la recette @recipe mise par l'utilisateur @user.

DELETE FROM note
    WHERE id_recipe = @recipe and id_user = @user;
    
--Suppression du commentaire @comment.

DELETE FROM comment
    WHERE id_comment = @comment;
    
--Suppression de l'utilisateur @user.

DELETE FROM 'user'
    WHERE id_user = @user;

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
    
--Modification du champs @champs d'une recette @recipe 

UPDATE recipe
    SET @champs = newValue
    WHERE id_recipe = @recipe

--Modification du champs @champs d'un ingrédient @ingredient

UPDATE ingredient
    SET @champs = newValue
    WHERE id_ingredient = @ingredient

--Modification du champs @champs d'un menu @menu

UPDATE recipe
    SET @champs = newValue
    WHERE id_menu = @menu
