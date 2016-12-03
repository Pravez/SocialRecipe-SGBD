
-----------------------------------------------------------------------------
--Consultations
-----------------------------------------------------------------------------

-- Informations sur recettes :
SELECT * FROM recipe;

-- Informations sur ingrédients :
SELECT * FROM ingredient;

-- Informations sur menus :
SELECT * FROM menu;

--Recette d'une catégorie @category pour un nombre de personne @nb_people donné
SELECT * FROM recipe
INNER JOIN is_category ON recipe.id_recipe=is_category.id_recipe
INNER JOIN category ON is_category.id_category=category.id_category;
WHERE category_name = " + @category + " AND nb_people = " @nb_people";

--Menu avec seulement des recettes ajoutées après une date @date donnée
--Selection de tous les couple menu-recette, group by pour compter combien de recette par menu
--Selection de tous les couples menu-recette avec recette ajouté après date voulue, group by pour compter combien de recette associée il y a
--Selection de tous les menus pour lesquels le nombre de recette total = au nombre de recette post-date
--VALIDEE
SELECT id_menu, re2.menu_name
FROM (  SELECT menu.id_menu as id1, COUNT(is_part_of.id_recipe) as nb_total_recipe FROM menu
        INNER JOIN is_part_of ON menu.id_menu = is_part_of.id_menu
        GROUP BY menu.id_menu) AS re1
INNER JOIN (  SELECT menu.id_menu, menu.menu_name, COUNT(recipe.id_recipe) as nb_recipe_valid FROM menu
        INNER JOIN is_part_of ON menu.id_menu = is_part_of.id_menu
        INNER JOIN recipe ON is_part_of.id_recipe = recipe.id_recipe
        WHERE recipe.date_added >= '01/01/1000'
        GROUP BY menu.id_menu
        )AS re2
ON id1 = re2.id_menu
WHERE  nb_total_recipe=nb_recipe_valid;

--Historique des préparations d'une recette --> historique des descriptions ?
/*SELECT
FROM;*/

--Ensemble des menus contenant des recettes avec des ingrédient peu caloriques

--Sélection des recettes d'un menu @menu:
--VALIDEE
SELECT recipe.id_recipe FROM menu
JOIN is_part_of ON menu.id_menu = is_part_of.id_menu
JOIN recipe ON is_part_of.id_recipe = recipe.id_recipe
WHERE menu.id_menu = @menu;

--==> Sélection pour une recette @recipe des ingrédients et de leurs calories :
--VALIDEE
SELECT ingredient.id_ingredient, nutritional_characteristic.id_nc, ingredient_characteristic.quantity from recipe
JOIN constitute ON recipe.id_recipe = constitute.id_recipe
JOIN ingredient ON constitute.id_ingredient = ingredient.id_ingredient
JOIN ingredient_characteristic ON ingredient.id_ingredient = ingredient_characteristic.id_ingredient
JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
WHERE recipe.id_recipe = 7 and nutritional_characteristic.id_nc=1; --1 parce que c'est les calories


--==> Plus qu'à vérifier la valeur de chaque ingrédient de chaque recette du menu et estimer s'il est peu calorique ou non.

--liste des recettes sucré-salé pour une catégorie (à la fois miel et sel)
--VALIDEE
SELECT id_recipe
FROM (SELECT id_recipe FROM constitute
       JOIN ingredient ON constitute.id_ingredient = ingredient.id_ingredient
        WHERE ingredient_name = 'honey') AS re1
NATURAL JOIN (SELECT id_recipe FROM constitute
       JOIN ingredient ON constitute.id_ingredient = ingredient.id_ingredient
        WHERE ingredient_name = 'salt') AS re2
WHERE re1.id_recipe = re2.recipe;

--liste des top recettes : notés au moins 5 fois à 3
--VALIDEE

SELECT recipe.id_recipe, COUNT(recipe.id_recipe) as nb_vote FROM recipe
JOIN note ON recipe.id_recipe = note.id_recipe
WHERE  note.note >= 3
GROUP BY recipe.id_recipe;
HAVING COUNT(id_user) >=5;

--recettes présentes dans au moins trois menus, ayant au moins 10 notes et au moins 3 com

--Au moins trois menu :

SELECT recipe.id_recipe FROM recipe
JOIN is_part_of ON recipe.id_recipe = is_part_of.id_recipe
GROUP BY recipe.id_recipe
HAVING COUNT(id_menu) >=3;


--Au moins 10 notes :

SELECT recipe.id_recipe FROM recipe
JOIN note ON recipe.id_recipe = note.id_recipe
GROUP BY recipe.id_recipe
HAVING COUNT(id_user) >=10;

--Au moins 3 coms :

SELECT id_recipe FROM recipe
JOIN comment ON recipe.id_recipe = comment.id_recipe
GROUP BY recipe.id_recipe
HAVING COUNT(id_user) >=3;

--==> @REQUETE1 INTERSECT @REQUETE2 INTERSECT @REQUETE3
--VALIDEE
(SELECT recipe.id_recipe FROM recipe
JOIN is_part_of ON recipe.id_recipe = is_part_of.id_recipe
GROUP BY recipe.id_recipe
HAVING COUNT(id_menu) >=3
INTERSECT
SELECT recipe.id_recipe FROM recipe
JOIN note ON recipe.id_recipe = note.id_recipe
GROUP BY recipe.id_recipe
HAVING COUNT(id_user) >=10)
INTERSECT
SELECT recipe.id_recipe FROM recipe
JOIN comment ON recipe.id_recipe = comment.id_recipe
GROUP BY recipe.id_recipe
HAVING COUNT(id_user) >=3;


-----------------------------------------------------------------------------
--Statistiques
-----------------------------------------------------------------------------

--nombre de recettes d'une catégorie @category crée depuis le début de l'année @year
-- on crée la date 01/01/year dans @date
--VALIDEE

SELECT recipe.id_recipe FROM recipe
JOIN is_category ON recipe.id_recipe=is_category.id_recipe
JOIN category ON is_category.id_category=category.id_category
WHERE category_name = @category AND recipe.date_added >= '01/01/@year';

--Classement des recettes selon les notes données :
--VALIDEE

SELECT recipe.id_recipe, AVG(note.note) as average FROM recipe
JOIN note ON recipe.id_recipe = note.id_recipe
GROUP BY recipe.id_recipe
ORDER BY average DESC;

--Pour les menus d'un internaute @user, la moyenne des notes données pour les recettes qu'il comprend
--VALIDEE

SELECT menu.id_menu, AVG(average) as total_average
FROM (  SELECT recipe.id_recipe, AVG(note.note) as average FROM recipe
        JOIN note ON recipe.id_recipe = note.id_recipe
        GROUP BY recipe.id_recipe) as table1
JOIN is_part_of ON table1.id_recipe = is_part_of.id_recipe
JOIN menu ON is_part_of.id_menu = menu.id_menu
WHERE menu.id_user = @user
GROUP BY menu.id_menu;

--classement fin des ingrédient : 
--Différentes info à récupérer
--Moyenne des notes des recettes enregistrées utilsant l'ingédient.
SELECT recipe.id_recipe, AVG(note) FROM recipe
JOIN note ON recipe.id_recipe = note.id_recipe
WHERE recipe.id_recipe = (SELECT recipe.id_recipe from recipe
JOIN constitute ON recipe.id_recipe = constitute.id_recipe
WHERE id_ingredient = 8)
GROUP BY recipe.id_recipe;

--Rcal : nbCalorie / MoyenneCalorieTotal

--nbCalorie est obtenu par :
SELECT quantity FROM ingredient
JOIN ingredient_characteristic ON ingredient.id_ingredient = ingredient_characteristic.id_ingredient
JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
WHERE nc_name = 'Calories' AND ingredient.id_ingredient = @ingredient;

-- Moyenne Totale est obtenue avec :
SELECT nc_name, AVG(quantity) FROM  ingredient_characteristic
JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
GROUP BY nc_name
HAVING nc_name='Calories';

--Coefficient de commentaire
--Nombre de commentaire par recette pour l'ingredient @ingredient
SELECT recipe.id_recipe, COUNT(id_comment) FROM recipe
JOIN comment ON recipe.id_recipe = comment.id_recipe
WHERE recipe.id_recipe = (SELECT recipe.id_recipe from recipe
                          JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                          WHERE id_ingredient = @ingredient)
GROUP BY recipe.id_recipe;

-----------------------------------------------------------------------------
--Mises à jour
-----------------------------------------------------------------------------

--Ajout

--Suppression

--Modification d'une recette

--Modification d'un ingrédient

--Modification d'un menu
