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

--Modification d'une recette @recipe

UPDATE recipe
    SET ColumnToChange= newValue
    [ WHERE id_recipe = @recipe


--Modification d'un ingrédient

--Modification d'un menu
