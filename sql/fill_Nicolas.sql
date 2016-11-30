
/* -----------------------------------------------------
INSERTION
-------------------------------------------------------- */

/*INSERT USER */
DELETE FROM user;
ALTER SEQUENCE user_id_user_seq RESTART WITH 1;
INSERT INTO "user"(pseudo) values ('Etchebest');
INSERT INTO "user"(pseudo) values ('Ramsey');
INSERT INTO "user"(pseudo) values ('Ratatouille');
INSERT INTO "user"(pseudo) values ('MarionProChefOfTheDoom');
INSERT INTO "user"(pseudo) values ('Norbert');
INSERT INTO "user"(pseudo) values ('Jean_topchef');
INSERT INTO "user"(pseudo) values ('SebastienF');
INSERT INTO "user"(pseudo) values ('SylvainL');
INSERT INTO "user"(pseudo) values ('LeChefFrancais');
INSERT INTO "user"(pseudo) values ('InLoveWithMayonnaise');
INSERT INTO "user"(pseudo) values ('Nutellman');
INSERT INTO "user"(pseudo) values ('SylvainL');
INSERT INTO "user"(pseudo) values ('RecipeMaster');
INSERT INTO "user"(pseudo) values ('FiveStarsChief');
INSERT INTO "user"(pseudo) values ('Patoche');
INSERT INTO "user"(pseudo) values ('Miam');
INSERT INTO "user"(pseudo) values ('MmmmmmmBrownies');
INSERT INTO "user"(pseudo) values ('DarkChief33');
INSERT INTO "user"(pseudo) values ('gleu');

/*INSERT RECIPE */
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) values ('Chocolated Sardine', '20 minutes', '15 minutes' ,'10 minutes', 4);

/*INSERT CATEGORY*/
INSERT INTO category(category_name) values('main course');
INSERT INTO category(category_name) values('fish');
INSERT INTO category(category_name) values('breakfast');

/*Create link between recipe and category*/

INSERT INTO is_category(id_category, id_recipe)  values (4, 1); /*Holiday strawberry sauce*/
INSERT INTO is_category(id_category, id_recipe)  values (17, 2); /*Perfect turkey*/
INSERT INTO is_category(id_category, id_recipe)  values (8, 3); /*MMMM.. Brownies*/
INSERT INTO is_category(id_category, id_recipe)  values (14, 4); /*Grilled fennel*/
INSERT INTO is_category(id_category, id_recipe)  values (18, 5); /*Valentine's salmon*/
INSERT INTO is_category(id_category, id_recipe)  values (12, 6); /*Pasta Salad*/
INSERT INTO is_category(id_category, id_recipe)  values (19, 7); /*Egg in a hole*/

/*Insert note*/
INSERT INTO note(id_recipe, id_user, note) values(1, 1, 3);
INSERT INTO note(id_recipe, id_user, note) values(1, 2, 2);
INSERT INTO note(id_recipe, id_user, note) values(2, 1, 3);
INSERT INTO note(id_recipe, id_user, note) values(2, 4, 1);
INSERT INTO note(id_recipe, id_user, note) values(2, 5, 3);
INSERT INTO note(id_recipe, id_user, note) values(2, 8, 3);
INSERT INTO note(id_recipe, id_user, note) values(3, 6, 1);
INSERT INTO note(id_recipe, id_user, note) values(4, 1, 2);
INSERT INTO note(id_recipe, id_user, note) values(5, 1, 1);
INSERT INTO note(id_recipe, id_user, note) values(7, 7, 2);

/* Insert comment*/
INSERT INTO comment(id_recipe, id_user, comment_text) values (1, 1, 'Perfect for relax during holidays');
INSERT INTO comment(id_recipe, id_user, comment_text) values (2, 5, 'Really good recipe. A must to taste.');
INSERT INTO comment(id_recipe, id_user, comment_text) values (2, 1, 'Awesome ! I really, really, really appreciated it !');
INSERT INTO comment(id_recipe, id_user, comment_text) values (2, 1, 'Moreover, all of my family liked it. Proof of excellence.');
INSERT INTO comment(id_recipe, id_user, comment_text) values (3, 17,'Hmmmmmmm, so much brownieees');
INSERT INTO comment(id_recipe, id_user, comment_text) values (5, 1, 'Not really good');
INSERT INTO comment(id_recipe, id_user, comment_text) values (3, 6, 'Mmmm... no.');
INSERT INTO comment(id_recipe, id_user, comment_text) values (7, 7, 'Simple and efficient.');

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

