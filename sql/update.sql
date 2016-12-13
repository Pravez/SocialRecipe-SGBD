-----------------------------------------------------------------------------
--Mises à jour
-----------------------------------------------------------------------------

--TRIGGER --
-- Interdiction d'ajouter un ingrédient qui existe deja
CREATE OR REPLACE FUNCTION test_ingredient() RETURNS trigger AS $test_ingredient$
  BEGIN
    IF (SELECT count(*) FROM ingredient WHERE ingredient_name = NEW.ingredient_name) THEN
      RAISE EXCEPTION 'Cet ingrédient est deja dans la BDD';
    END IF ;
  END
  $test_ingredient$ LANGUAGE plpgsql;

CREATE TRIGGER test_ingredient BEFORE INSERT OR UPDATE ON ingredient
  FOR EACH ROW EXECUTE PROCEDURE test_ingredient();

-- Interdiction d'ajouter une catégorie qui existe deja
CREATE OR REPLACE FUNCTION test_category() RETURNS trigger AS $test_category$
  BEGIN
    IF (SELECT count(*) FROM category WHERE category_name = NEW.category_name) THEN
      RAISE EXCEPTION 'Cette catégorie est deja dans la BDD';
    END IF ;
  END
  $test_category$ LANGUAGE plpgsql;

CREATE TRIGGER test_category BEFORE INSERT OR UPDATE ON category
  FOR EACH ROW EXECUTE PROCEDURE test_category();

-- Interdiction d'ajouter un ingrédient qui existe deja dans une recette
CREATE OR REPLACE FUNCTION test_constitute() RETURNS trigger AS $test_constitute$
  BEGIN
    IF (SELECT count(*) FROM constitute WHERE id_ingredient = NEW.id_ingredient AND
         id_recipe = NEW.id_recipe) THEN
      RAISE EXCEPTION 'Cet ingrédient est deja dans la recette';
    END IF ;
  END
  $test_constitute$ LANGUAGE plpgsql;

CREATE TRIGGER test_constitute BEFORE INSERT OR UPDATE ON constitute
  FOR EACH ROW EXECUTE PROCEDURE test_constitute();


-- Interdiction d'ajouter un menu qui existe deja
CREATE OR REPLACE FUNCTION test_menu() RETURNS trigger AS $test_menu$
  BEGIN
    IF (SELECT count(*) FROM menu WHERE menu_name = NEW.menu_name) THEN
      RAISE EXCEPTION 'Ce menu existe deja';
    END IF ;
  END
  $test_menu$ LANGUAGE plpgsql;

CREATE TRIGGER test_menu BEFORE INSERT OR UPDATE ON menu
  FOR EACH ROW EXECUTE PROCEDURE test_menu();

-- Interdiction d'ajouter deux caractéristique identique
CREATE OR REPLACE FUNCTION test_carac() RETURNS trigger AS $test_carac$
  BEGIN
    IF (SELECT count(*) FROM nutritional_characteristic WHERE nc_name = NEW.nc_name) THEN
      RAISE EXCEPTION 'Cette caractéristique existe deja';
    END IF ;
  END
  $test_carac$ LANGUAGE plpgsql;

CREATE TRIGGER test_carac BEFORE INSERT OR UPDATE ON nutritional_characteristic
  FOR EACH ROW EXECUTE PROCEDURE test_carac();


-- Interdiction d'ajouter une recette qui existe deja
CREATE OR REPLACE FUNCTION test_recipe() RETURNS trigger AS $test_recipe$
  BEGIN
    IF (SELECT count(*) FROM recipe WHERE recipe_name = NEW.recipe_name) THEN
      RAISE EXCEPTION 'Cette recette existe deja';
    END IF ;
  END
  $test_recipe$ LANGUAGE plpgsql;

CREATE TRIGGER test_recipe BEFORE INSERT OR UPDATE ON recipe
  FOR EACH ROW EXECUTE PROCEDURE test_recipe();


-- Interdiction d'ajouter une unité qui existe deja
CREATE OR REPLACE FUNCTION test_unit() RETURNS trigger AS $test_unit$
  BEGIN
    IF (SELECT count(*) FROM unit WHERE unit_name = NEW.unit_name) THEN
      RAISE EXCEPTION 'Cette unité existe deja';
    END IF ;
  END
  $test_unit$ LANGUAGE plpgsql;

CREATE TRIGGER test_unit BEFORE INSERT OR UPDATE ON unit
  FOR EACH ROW EXECUTE PROCEDURE test_unit();

-- Interdiction d'ajouter un utilisateur qui existe deja
CREATE OR REPLACE FUNCTION test_user() RETURNS trigger AS $test_user$
  BEGIN
    IF (SELECT count(*) FROM "user" WHERE pseudo = NEW.pseudo) THEN
      RAISE EXCEPTION 'Cet user existe deja';
    END IF ;
  END
  $test_user$ LANGUAGE plpgsql;

CREATE TRIGGER test_user BEFORE INSERT OR UPDATE ON "user"
  FOR EACH ROW EXECUTE PROCEDURE test_user();

--------------- AJOUT -----------------
--Création d'un ingrédient
INSERT INTO ingredient(ingredient_name) VALUES(@name);

--Création d'une catégorie
INSERT INTO category(category_name) VALUES(@name);

--Création de la recette
INSERT INTO recipe (recipe_name, date_added, preparation_time, cooking_time, waiting_time, servings)
    VALUES (@name, @date, @p_time, @c_time, @w_time, @servings);

--Création du lien avec category
INSERT INTO is_category column (id_category, id_recipe)
    VALUES (@id_ctageory, @id_recipe);

--Création du lien avec ingredient
INSERT INTO constitute (id_recipe, id_ingredient, id_unit, quantity)
    VALUES (@id_recipe, @id_ingredient, @id_unit, @quantity);

--Création d'un commentaire
INSERT INTO comment(id_recipe, id_user, comment_text)
    VALUES (@id_recipe, @id_user, @text);

--Création d'une description
INSERT INTO description(description_text, date_added, id_recipe, id_user)
    VALUES (@description_text, @date_added, @id_recipe, @id_user);

--Creation d'un ingredient_characteristic
INSERT INTO ingredient_characteristic(id_nc, id_ingredient, quantity)
  VALUES (@id_nc, @id_ingredient, @quantity);

--Liaison entre un meny et une recette
INSERT INTO is_part_of(id_recipe, id_menu)
    VALUES (@id_recipe, @id_menu);

-- Creation d'un menu
INSERT INTO menu(menu_name, id_user)
    VALUES (@menu_name,@id_user);

--Creation d'une note
INSERT INTO note(id_recipe, id_user, note)
    VALUES (@id_recipe, @id_user, @note);

-- Creation de nutrional characteristique
INSERT INTO nutritional_characteristic(nc_name)
    VALUES (@name);

--Ajout d'une unité
INSERT INTO unit(unit_name)
    VALUES (@name);

--Ajout d'un user
INSERT INTO "user"(pseudo)
    VALUES (@pseudo);




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



