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

/* INSERT INTO RECIPE */
DELETE FROM recipe;
ALTER SEQUENCE recipe_id_recipe_seq RESTART WITH 1;
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) VALUES('Holiday strawberry sauce', '5 minutes', '15 minutes', '8 hours', 16);
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) VALUES('Perfect turkey', '30 minutes', '4 hours', '12 hours 30 minutes', 24);
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) VALUES('MMMMMM... Brownies', '25 minutes', '25 minutes', '10 minutes', 16);
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) VALUES('Grilled fennel', '10 minutes', '15 minutes', '0', 4);
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) VALUES('Valentine ''s salmon', '20 minutes', '45 minutes', '0', 4);
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) VALUES('Pasta Salad', '20 minutes', '15 minutes', '13 hours 30 minutes', 6);
INSERT INTO recipe(recipe_name, preparation_time, cooking_time, waiting_time, servings) VALUES ('Egg in a hole', '1 minute', '4 minute', '0', 1);


/* INSERT INTO CONSTITUTE */
DELETE FROM constitute;
INSERT INTO constitute(id_ingredient, id_recipe, id_unit, quantity) VALUES(7, 7, 8, 1);
INSERT INTO constitute(id_ingredient, id_recipe, id_unit, quantity) VALUES(8, 7, 10, 1.5);