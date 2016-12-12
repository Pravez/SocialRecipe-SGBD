-----------------------------------------------------------------------------
--Statistiques
-----------------------------------------------------------------------------

--nombre de recettes d'une catégorie @category crée depuis le début de l'année @year
-- on crée la date 01/01/year dans @date

SELECT id_category, COUNT(recipe.id_recipe)
JOIN is_category ON recipe.id_recipe=is_category.id_recipe
WHERE category_name=@category AND recipe.date_added >= '01/01/@year' 
GROUP_BY id_category;

--Classement des recettes selon les notes données :

SELECT recipe.id_recipe, AVG(note.note) as average FROM recipe
JOIN note ON recipe.id_recipe = note.id_recipe
GROUP BY recipe.id_recipe
ORDER BY average DESC;

--Pour les menus d'un internaute @user, la moyenne des notes données pour les recettes qu'il comprend

SELECT menu.id_user, AVG(average) as total_average
FROM (  SELECT recipe.id_recipe, AVG(note.note) as average FROM recipe
    	JOIN note ON recipe.id_recipe = note.id_recipe
		GROUP BY recipe.id_recipe) as table1
		JOIN is_part_of ON table1.id_recipe = is_part_of.id_recipe
		JOIN menu ON is_part_of.id_menu = menu.id_menu
		WHERE menu.id_user = @user
		GROUP BY menu.id_user;


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
SELECT AVG(quantity) FROM  ingredient_characteristic
JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
GROUP BY nc_name
HAVING nc_name='Calories';

--Coefficient de commentaire
--calcul du coefficient de commentaire
SELECT SUM(coeff)
FROM (SELECT nbComment,
       CASE WHEN nbComment<=3 THEN 1
            WHEN nbComment<=10 THEN 2
            ELSE 3
       END as coeff
        FROM (SELECT recipe.id_recipe, COUNT(id_comment) as nbComment FROM recipe
              JOIN comment ON recipe.id_recipe = comment.id_recipe
              WHERE recipe.id_recipe = (SELECT recipe.id_recipe from recipe
                                      JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                                      WHERE id_ingredient = 7)
              GROUP BY recipe.id_recipe) as countComment
GROUP BY nbComment) as Coefficient;

----------------CALCUL TOTAL pour l'ingrédient 7:
SELECT id_ingredient,
  (((SELECT quantity FROM ingredient
      JOIN ingredient_characteristic ON ingredient.id_ingredient = ingredient_characteristic.id_ingredient
      JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
      WHERE nc_name = 'Calories' AND ingredient.id_ingredient = 7) / (SELECT AVG(quantity) FROM  ingredient_characteristic
                                                                      JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
                                                                      GROUP BY nc_name
                                                                      HAVING nc_name='Calories')) *
  (SELECT AVG(note) FROM recipe
  JOIN note ON recipe.id_recipe = note.id_recipe
  WHERE recipe.id_recipe = (SELECT recipe.id_recipe from recipe
                            JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                            WHERE id_ingredient = 7)
  GROUP BY recipe.id_recipe)
  *
  (SELECT SUM(coeff)
   FROM (SELECT nbComment,
        CASE WHEN nbComment<=3 THEN 1
             WHEN nbComment<=10 THEN 2
             ELSE 3
        END as coeff
        FROM (SELECT recipe.id_recipe, COUNT(id_comment) as nbComment FROM recipe
              JOIN comment ON recipe.id_recipe = comment.id_recipe
              WHERE recipe.id_recipe = (SELECT recipe.id_recipe from recipe
                                      JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                                      WHERE id_ingredient = 7)
              GROUP BY recipe.id_recipe) as countComment
GROUP BY nbComment) as Coefficient)) as CoeffOfTheDoom
FROM ingredient;

--Transaction pour avoir le coefficient de tous les ingrédients

CREATE OR REPLACE FUNCTION getAllCoeff() RETURNS SETOF BIGINT AS
$BODY$
DECLARE
    r BIGINT;
  Coef BIGINT;
BEGIN
    FOR r IN SELECT id_ingredient FROM ingredient
    LOOP
      SELECT (((SELECT quantity FROM ingredient
                                             JOIN ingredient_characteristic ON ingredient.id_ingredient = ingredient_characteristic.id_ingredient
                                            JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
      WHERE nc_name = 'Calories' AND ingredient.id_ingredient = r / (SELECT AVG(quantity) FROM  ingredient_characteristic
                                                                      JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
                                                                      GROUP BY nc_name
                                                                      HAVING nc_name='Calories')) *
  (SELECT AVG(note) FROM recipe
  JOIN note ON recipe.id_recipe = note.id_recipe
  WHERE recipe.id_recipe = (SELECT recipe.id_recipe from recipe
                            JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                            WHERE id_ingredient = r)
  GROUP BY recipe.id_recipe)
  *
  (SELECT SUM(coeff)
   FROM (SELECT nbComment,
        CASE WHEN nbComment<=3 THEN 1
             WHEN nbComment<=10 THEN 2
             ELSE 3
        END as coeff
        FROM (SELECT recipe.id_recipe, COUNT(id_comment) as nbComment FROM recipe
              JOIN comment ON recipe.id_recipe = comment.id_recipe
              WHERE recipe.id_recipe = (SELECT recipe.id_recipe from recipe
                                      JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                                      WHERE id_ingredient = r)
              GROUP BY recipe.id_recipe) as countComment
GROUP BY nbComment) as Coefficient))) into Coef
    FROM ingredient
    WHERE ingredient.id_ingredient = r;

    RETURN NEXT Coef;
    END LOOP;
    RETURN;
END
$BODY$
LANGUAGE plpgsql;

SELECT * FROM getallCoeff()
ORDER BY "getallcoeff" ASC;
