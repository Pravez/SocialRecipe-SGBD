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

--Suppression d'un lien entre ingrédient et recipe
DELETE FROM constitute
    WHERE id_recipe = @recipe AND id_ingredient = @ingredient;

--Supprimer une characteristique d'un ingrédient
DELETE FROM ingredient_characteristic
    WHERE id_ingredient = @ingredient AND id_nc = @ingredient_characteristic;

--Supprimer une recette d'un menu
DELETE FROM is_part_of
    WHERE id_recipe=@recipe AND id_menu = @menu;

-- Suppression d'une recette dans une catégorie
DELETE FROM is_category
    WHERE id_recipe = @recipe AND id_category = @category;

DELETE FROM is_category
    WHERE id_recipe = 1 AND id_category = @4;


SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'enseirb'
  AND pid <> pg_backend_pid();

