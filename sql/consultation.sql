/* -----------------------------------------------------
Consultation
-------------------------------------------------------- */

/* Informations sur utilisateurs */
SELECT * FROM "user";

/* Informations sur recettes */
SELECT * FROM recipe;

/* Informations sur ingrédients */
SELECT * FROM ingredient;

/* Informations sur menus */
SELECT * FROM menu;

 /* Recette d'une catégorie pour un nombre de personnes donné*/
SELECT * FROM recipe
JOIN is_category ON recipe.id_recipe=is_category.id_recipe
JOIN category ON is_category.id_category=category.id_category
WHERE category_name = 'dessert' AND servings = 16;
