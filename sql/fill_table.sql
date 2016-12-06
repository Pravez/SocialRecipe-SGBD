/* INSERT INTO CATEGORIES */

DELETE FROM category;
ALTER SEQUENCE category_id_category_seq RESTART WITH 1;

INSERT INTO category(category_name) VALUES('events');
INSERT INTO category(category_name) VALUES('sweet');
INSERT INTO category(category_name) VALUES('savory');
INSERT INTO category(category_name) VALUES('holidays');
INSERT INTO category(category_name) VALUES('appetizer');
INSERT INTO category(category_name) VALUES('beverage');
INSERT INTO category(category_name) VALUES('bread');
INSERT INTO category(category_name) VALUES('dessert');
INSERT INTO category(category_name) VALUES('pancake');
INSERT INTO category(category_name) VALUES('pasta');
INSERT INTO category(category_name) VALUES('sauce');
INSERT INTO category(category_name) VALUES('salad');
INSERT INTO category(category_name) VALUES('soup');
INSERT INTO category(category_name) VALUES('vegetable');
INSERT INTO category(category_name) VALUES('fried');
INSERT INTO category(category_name) VALUES('starter');
INSERT INTO category(category_name) VALUES('main course');
INSERT INTO category(category_name) VALUES('fish');
INSERT INTO category(category_name) VALUES('breakfast');

/* INSERT INTO USER */
DELETE FROM "user";

ALTER SEQUENCE user_id_user_seq RESTART WITH 1;
INSERT INTO "user"(pseudo) VALUES ('Etchebest');
INSERT INTO "user"(pseudo) VALUES ('Ramsey');
INSERT INTO "user"(pseudo) VALUES ('Ratatouille');
INSERT INTO "user"(pseudo) VALUES ('MarionProChefOfTheDoom');
INSERT INTO "user"(pseudo) VALUES ('Norbert');
INSERT INTO "user"(pseudo) VALUES ('Jean_topchef');
INSERT INTO "user"(pseudo) VALUES ('SebastienF');
INSERT INTO "user"(pseudo) VALUES ('SylvainL');
INSERT INTO "user"(pseudo) VALUES ('LeChefFrancais');
INSERT INTO "user"(pseudo) VALUES ('InLoveWithMayonnaise');
INSERT INTO "user"(pseudo) VALUES ('Nutellman');
INSERT INTO "user"(pseudo) VALUES ('RecipeMaster');
INSERT INTO "user"(pseudo) VALUES ('FiveStarsChief');
INSERT INTO "user"(pseudo) VALUES ('Patoche');
INSERT INTO "user"(pseudo) VALUES ('Miam');
INSERT INTO "user"(pseudo) VALUES ('MmmmmmmBrownies');
INSERT INTO "user"(pseudo) VALUES ('DarkChief33');
INSERT INTO "user"(pseudo) VALUES ('gleu');

/* INSERT INTO RECIPE */
DELETE FROM recipe;
ALTER SEQUENCE recipe_id_recipe_seq RESTART WITH 1;

INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES('Holiday strawberry sauce', '02/02/2010', '5 minutes', '15 minutes', '8 hours', 16);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES('Perfect turkey', '03/06/2012', '30 minutes', '4 hours', '12 hours 30 minutes', 24);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES('MMMMMM... Brownies', '06/05/2013', '25 minutes', '25 minutes', '10 minutes', 16);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES('Grilled fennel', '08/04/2012', '10 minutes', '15 minutes', '0', 4);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES('Valentine ''s salmon', '19/03/2013', '20 minutes', '45 minutes', '0', 4);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES('Pasta Salad', '16/08/2014', '20 minutes', '15 minutes', '13 hours 30 minutes', 6);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES ('Egg in a hole', '02/11/2015', '1 minute', '4 minute', '0', 1);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES ('Chocolated Sardine', '10/02/2015', '20 minutes', '15 minutes' ,'10 minutes', 4);
INSERT INTO recipe(recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings) VALUES ('Honey Turkey', '6/12/2016', '20 minutes', '60 minutes', '5 minutes', 4);

/*INSERT COMMENT*/
DELETE FROM comment;

ALTER SEQUENCE comment_id_comment_seq RESTART WITH 1;
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (1, 1, 'Perfect for relax during holidays');
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (2, 5, 'Really good recipe. A must to taste.');
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (2, 1, 'Awesome ! I really, really, really appreciated it !');
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (2, 1, 'Moreover, all of my family liked it. Proof of excellence.');
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (3, 17,'Hmmmmmmm, so much brownieees');
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (5, 1, 'Not really good');
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (3, 6, 'Mmmm... no.');
INSERT INTO comment(id_recipe, id_user, comment_text) VALUES (7, 7, 'Simple and efficient.');

/* INSERT INTO INGREDIENT*/

DELETE FROM ingredient;
ALTER SEQUENCE ingredient_id_ingredient_seq RESTART WITH 1;

INSERT INTO ingredient(ingredient_name) VALUES ('Dark Chocolate');
INSERT INTO ingredient(ingredient_name) VALUES ('Sardine');
INSERT INTO ingredient(ingredient_name) VALUES ('Strawberry');
INSERT INTO ingredient(ingredient_name) VALUES ('Turkey escalope');
INSERT INTO ingredient(ingredient_name) VALUES ('Flour');
INSERT INTO ingredient(ingredient_name) VALUES ('Sugar');
INSERT INTO ingredient(ingredient_name) VALUES ('Egg');
INSERT INTO ingredient(ingredient_name) VALUES ('Ham');
INSERT INTO ingredient(ingredient_name) VALUES ('Honey');
INSERT INTO ingredient(ingredient_name) VALUES ('Salt');

/* INSERT INTO UNIT */

DELETE FROM unit;

ALTER SEQUENCE unit_id_unit_seq RESTART WITH 1;
INSERT INTO unit(unit_name) VALUES('kilogram');
INSERT INTO unit(unit_name) VALUES('gram');
INSERT INTO unit(unit_name) VALUES('liter');
INSERT INTO unit(unit_name) VALUES('centiliter');
INSERT INTO unit(unit_name) VALUES('spoon');
INSERT INTO unit(unit_name) VALUES('pound');
INSERT INTO unit(unit_name) VALUES('cup');
INSERT INTO unit(unit_name) VALUES('unit');
INSERT INTO unit(unit_name) VALUES('tablespoon');
INSERT INTO unit(unit_name) VALUES('teaspoon');
INSERT INTO unit(unit_name) VALUES('ounce');
INSERT INTO unit(unit_name) VALUES('stick');
INSERT INTO unit(unit_name) VALUES('clove');
INSERT INTO unit(unit_name) VALUES ('pinch');

/* INSERT INTO CONSTITUTE */
DELETE FROM constitute;

INSERT INTO constitute(id_ingredient, id_recipe, id_unit, quantity) VALUES(7, 7, 8, 1);
INSERT INTO constitute(id_ingredient, id_recipe, id_unit, quantity) VALUES(8, 7, 10, 1.5);
INSERT INTO constitute(id_ingredient, id_recipe, id_unit, quantity) VALUES (4, 9, 8, 4);
INSERT INTO constitute(id_ingredient, id_recipe, id_unit, quantity) VALUES (10, 9, 14, 1);
INSERT INTO constitute(id_ingredient, id_recipe, id_unit, quantity) VALUES (9, 9, 9, 3);


/* INSERT INTO MENU*/
DELETE from menu;
ALTER SEQUENCE menu_id_menu_seq RESTART WITH 1;

INSERT INTO menu(menu_name,id_user) VALUES ('Christmas Meal',9);
INSERT INTO menu(menu_name,id_user) VALUES ('Valentines Meal',4);
INSERT INTO menu(menu_name,id_user) VALUES ('Pasta',2);


/* INSERT INTO DESCRIPTION*/
DELETE FROM description;
ALTER SEQUENCE description_id_description_seq RESTART WITH 1;

INSERT INTO description(description_text,date_added,id_recipe,id_user) VALUES (
  'Combine strawberries, sugar, 2 tablespoons water, and balsamic vinegar in a saucepan and bring to simmer over medium heat.
Reduce heat to medium-low, cover, and simmer for 15 minutes.
Whisk 2 tablespoons water and cornstarch in a small bowl.
Whisk cornstarch mixture into strawberry mixture. Cook, stirring constantly, until mixture thickens, 1 to 2 minutes. Remove from heat.
Transfer mixture to a blender and puree until smooth.'
  ,'24/11/2016',1,1);


/* INSERT INTO IS_PART_OF*/
DELETE from is_part_of;

INSERT INTO is_part_of VALUES (5,2);
INSERT INTO is_part_of VALUES (1,2);
INSERT INTO is_part_of VALUES (2,1);
INSERT INTO is_part_of VALUES (3,1);
INSERT INTO is_part_of VALUES (6,3);
INSERT INTO is_part_of VALUES (3,3);

/* INSERT INTO NUTRITIONAL_CHARCACTERISTIC*/
DELETE FROM nutritional_characteristic;

ALTER SEQUENCE nutritional_characteristic_id_nc_seq RESTART WITH 1;
INSERT INTO nutritional_characteristic(nc_name) VALUES ('Calories');
INSERT INTO nutritional_characteristic(nc_name) VALUES ('Protein');
INSERT INTO nutritional_characteristic(nc_name) VALUES ('Carbohydrate');
INSERT INTO nutritional_characteristic(nc_name) VALUES ('Lipid');

/* INSERT INTO INGREDIENT_CHARACTERISTIC*/

DELETE FROM ingredient_characteristic;

INSERT INTO ingredient_characteristic VALUES (1,1,523);
INSERT INTO ingredient_characteristic VALUES (2,1,6);
INSERT INTO ingredient_characteristic VALUES (3,1,52);
INSERT INTO ingredient_characteristic VALUES (4,1,32);

INSERT INTO ingredient_characteristic VALUES (1,2,163);
INSERT INTO ingredient_characteristic VALUES (2,2,20);
INSERT INTO ingredient_characteristic VALUES (3,2,0);
INSERT INTO ingredient_characteristic VALUES (4,2,9);

INSERT INTO ingredient_characteristic VALUES (1,3,32);
INSERT INTO ingredient_characteristic VALUES (2,3,1);
INSERT INTO ingredient_characteristic VALUES (3,3,8);
INSERT INTO ingredient_characteristic VALUES (4,3,0);

INSERT INTO ingredient_characteristic VALUES (1,4,114);
INSERT INTO ingredient_characteristic VALUES (2,4,24);
INSERT INTO ingredient_characteristic VALUES (3,4,0);
INSERT INTO ingredient_characteristic VALUES (4,4,2);

INSERT INTO ingredient_characteristic VALUES (1,5,369);
INSERT INTO ingredient_characteristic VALUES (2,5,10);
INSERT INTO ingredient_characteristic VALUES (3,5,80);
INSERT INTO ingredient_characteristic VALUES (4,5,1);

INSERT INTO ingredient_characteristic VALUES (1,6,400);
INSERT INTO ingredient_characteristic VALUES (2,6,0);
INSERT INTO ingredient_characteristic VALUES (3,6,100);
INSERT INTO ingredient_characteristic VALUES (4,6,0);

INSERT INTO ingredient_characteristic VALUES (1,7,146);
INSERT INTO ingredient_characteristic VALUES (2,7,12);
INSERT INTO ingredient_characteristic VALUES (3,7,0);
INSERT INTO ingredient_characteristic VALUES (4,7,11);

INSERT INTO ingredient_characteristic VALUES (1,8,144);
INSERT INTO ingredient_characteristic VALUES (2,8,20);
INSERT INTO ingredient_characteristic VALUES (3,8,0);
INSERT INTO ingredient_characteristic VALUES (4,8,7);

INSERT INTO ingredient_characteristic VALUES (1,9,300);
INSERT INTO ingredient_characteristic VALUES (2,9,0);
INSERT INTO ingredient_characteristic VALUES (3,9,75);
INSERT INTO ingredient_characteristic VALUES (4,9,0);

INSERT INTO ingredient_characteristic VALUES (1,10,0);
INSERT INTO ingredient_characteristic VALUES (2,10,0);
INSERT INTO ingredient_characteristic VALUES (3,10,0);
INSERT INTO ingredient_characteristic VALUES (4,10,0);

/* INSERT INTO IS_CATEGORY*/
DELETE FROM is_category;

INSERT INTO is_category(id_category, id_recipe)  VALUES (4, 1); /*Holiday strawberry sauce*/
INSERT INTO is_category(id_category, id_recipe)  VALUES (17, 2); /*Perfect turkey*/
INSERT INTO is_category(id_category, id_recipe)  VALUES (8, 3); /*MMMM.. Brownies*/
INSERT INTO is_category(id_category, id_recipe)  VALUES (14, 4); /*Grilled fennel*/
INSERT INTO is_category(id_category, id_recipe)  VALUES (18, 5); /*Valentine's salmon*/
INSERT INTO is_category(id_category, id_recipe)  VALUES (12, 6); /*Pasta Salad*/
INSERT INTO is_category(id_category, id_recipe)  VALUES (19, 7); /*Egg in a hole*/
INSERT INTO is_category(id_category, id_recipe)  VALUES (17, 9);/* Sweet turkey*/

/* INSERT INTO NOTE*/
DELETE FROM note;

INSERT INTO note(id_recipe, id_user, note) VALUES(1, 1, 3);
INSERT INTO note(id_recipe, id_user, note) VALUES(1, 2, 2);
INSERT INTO note(id_recipe, id_user, note) VALUES(2, 1, 3);
INSERT INTO note(id_recipe, id_user, note) VALUES(2, 4, 1);
INSERT INTO note(id_recipe, id_user, note) VALUES(2, 5, 3);
INSERT INTO note(id_recipe, id_user, note) VALUES(2, 8, 3);
INSERT INTO note(id_recipe, id_user, note) VALUES(3, 6, 1);
INSERT INTO note(id_recipe, id_user, note) VALUES(4, 1, 2);
INSERT INTO note(id_recipe, id_user, note) VALUES(5, 1, 1);
INSERT INTO note(id_recipe, id_user, note) VALUES(7, 7, 2);

