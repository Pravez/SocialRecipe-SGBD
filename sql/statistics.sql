-----------------------------------------------------------------------------
--Statistiques
-----------------------------------------------------------------------------

--nombre de recettes d'une cat�gorie @category cr�e depuis le d�but de l'ann�e @year
-- on cr�e la date 01/01/year dans @date

SELECT id_category, COUNT(recipe.id_recipe)
JOIN is_category ON recipe.id_recipe=is_category.id_recipe
WHERE category_name=@category AND recipe.date_added >= '01/01/@year' 
GROUP_BY id_category;

--Classement des recettes selon les notes donn�es :

SELECT recipe.id_recipe, AVG(note.note) as average FROM recipe
JOIN note ON recipe.id_recipe = note.id_recipe
GROUP BY recipe.id_recipe
ORDER BY average DESC;

--Pour les menus d'un internaute @user, la moyenne des notes donn�es pour les recettes qu'il comprend

SELECT menu.id_user, AVG(average) as total_average
FROM (  SELECT recipe.id_recipe, AVG(note.note) as average FROM recipe
    	JOIN note ON recipe.id_recipe = note.id_recipe
		GROUP BY recipe.id_recipe) as table1
		JOIN is_part_of ON table1.id_recipe = is_part_of.id_recipe
		JOIN menu ON is_part_of.id_menu = menu.id_menu
		WHERE menu.id_user = @user
		GROUP BY menu.id_user;


--classement fin des ingr�dient : 
--Diff�rentes info � r�cup�rer
--Moyenne des notes des recettes enregistr�es utilisant l'ing�dient.
SELECT AVG(average)
FROM (SELECT recipe.id_recipe, AVG(note) as average FROM recipe
  JOIN note ON recipe.id_recipe = note.id_recipe
  WHERE recipe.id_recipe IN (SELECT id_recipe FROM constitute
              WHERE id_ingredient = 8)
  GROUP BY recipe.id_recipe) as averageNotes
JOIN constitute ON averageNotes.id_recipe = constitute.id_recipe
WHERE constitute.id_ingredient = 8
GROUP BY id_ingredient;

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

----------------CALCUL TOTAL pour l'ingr�dient 7:
SELECT id_ingredient,
  (SELECT (SELECT (SELECT quantity FROM ingredient
      JOIN ingredient_characteristic ON ingredient.id_ingredient = ingredient_characteristic.id_ingredient
      JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
      WHERE nc_name = 'Calories' AND ingredient.id_ingredient = 8) / (SELECT AVG(quantity) FROM  ingredient_characteristic
                                                                      JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
                                                                      GROUP BY nc_name
                                                                      HAVING nc_name='Calories')) *
(SELECT AVG(average)
FROM (SELECT recipe.id_recipe, AVG(note) as average FROM recipe
  JOIN note ON recipe.id_recipe = note.id_recipe
  WHERE recipe.id_recipe IN (SELECT id_recipe FROM constitute
              WHERE id_ingredient = 8)
  GROUP BY recipe.id_recipe) as averageNotes
JOIN constitute ON averageNotes.id_recipe = constitute.id_recipe
WHERE constitute.id_ingredient = 8
GROUP BY id_ingredient)
  *
  (SELECT SUM(coeff)
FROM (SELECT id_recipe, nbComment,
       CASE WHEN nbComment<=3 THEN 1
            WHEN nbComment<=10 THEN 2
            ELSE 3
       END as coeff
        FROM (SELECT recipe.id_recipe, COUNT(id_comment) as nbComment FROM recipe
              JOIN comment ON recipe.id_recipe = comment.id_recipe
              WHERE recipe.id_recipe IN (SELECT recipe.id_recipe from recipe
                                      JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                                      WHERE id_ingredient = 8)
              GROUP BY recipe.id_recipe) as countComment
GROUP BY nbComment, countComment.id_recipe) as Coefficient
GROUP BY Coefficient.id_recipe LIMIT 1)) as CoeffOfTheDoom
FROM ingredient;

--Transaction pour avoir le coefficient de tous les ingr�dients

CREATE OR REPLACE FUNCTION getAllCoeff() RETURNS SETOF decimal AS
$BODY$
DECLARE
    r integer;
  Coef decimal;
BEGIN
    FOR r IN SELECT id_ingredient FROM ingredient
    LOOP
      SELECT (SELECT (SELECT (SELECT quantity FROM ingredient
      JOIN ingredient_characteristic ON ingredient.id_ingredient = ingredient_characteristic.id_ingredient
      JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
      WHERE nc_name = 'Calories' AND ingredient.id_ingredient = r) / (SELECT AVG(quantity) FROM  ingredient_characteristic
                                                                      JOIN nutritional_characteristic ON ingredient_characteristic.id_nc = nutritional_characteristic.id_nc
                                                                      GROUP BY nc_name
                                                                      HAVING nc_name='Calories')) *
(SELECT AVG(average)
FROM (SELECT recipe.id_recipe, AVG(note) as average FROM recipe
  JOIN note ON recipe.id_recipe = note.id_recipe
  WHERE recipe.id_recipe IN (SELECT id_recipe FROM constitute
              WHERE id_ingredient = r)
  GROUP BY recipe.id_recipe) as averageNotes
JOIN constitute ON averageNotes.id_recipe = constitute.id_recipe
WHERE constitute.id_ingredient = r
GROUP BY id_ingredient)
  *
  (SELECT SUM(coeff)
FROM (SELECT id_recipe, nbComment,
       CASE WHEN nbComment<=3 THEN 1
            WHEN nbComment<=10 THEN 2
            ELSE 3
       END as coeff
        FROM (SELECT recipe.id_recipe, COUNT(id_comment) as nbComment FROM recipe
              JOIN comment ON recipe.id_recipe = comment.id_recipe
              WHERE recipe.id_recipe IN (SELECT recipe.id_recipe from recipe
                                      JOIN constitute ON recipe.id_recipe = constitute.id_recipe
                                      WHERE id_ingredient = r)
              GROUP BY recipe.id_recipe) as countComment
GROUP BY nbComment, countComment.id_recipe) as Coefficient
GROUP BY Coefficient.id_recipe LIMIT 1)) into Coef
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
