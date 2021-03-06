---------------------------------
-- Nécessite d'avoir crée une base de données et d'y être connecté
---------------------------------

CREATE TABLE Ingredient (
	id_ingredient   SERIAL PRIMARY KEY,
	ingredient_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Nutritional_Characteristic (
	id_nc   SERIAL PRIMARY KEY,
	nc_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Ingredient_Characteristic (
	id_nc         INT REFERENCES Nutritional_Characteristic (id_nc),
	id_ingredient INT REFERENCES Ingredient (id_ingredient),
	quantity      INT,
	PRIMARY KEY (id_nc, id_ingredient)
);

CREATE TABLE Unit (
	id_unit   SERIAL PRIMARY KEY ,
	unit_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Recipe (
	id_recipe	SERIAL	PRIMARY KEY,
	recipe_name VARCHAR(50) NOT NULL ,
  date_added DATE ,
  preparation_time  INTERVAL ,
  cooking_time  INTERVAL,
  waiting_time INTERVAL,
  servings  INT
);

CREATE TABLE Constitute (
	id_ingredient INT references Ingredient(id_ingredient),
  id_recipe INT REFERENCES Recipe(id_recipe),
  id_unit INT REFERENCES Unit(id_unit),
  quantity INT,
  PRIMARY KEY (id_ingredient,id_recipe,id_unit)
);

CREATE TABLE Category(
  id_category SERIAL PRIMARY KEY ,
  category_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Is_Category(
  id_category INT REFERENCES Category(id_category),
  id_recipe INT REFERENCES Recipe(id_recipe),
  PRIMARY KEY (id_category,id_recipe)
);

CREATE TABLE "user"(
  id_user SERIAL PRIMARY KEY ,
  pseudo VARCHAR(50) UNIQUE
);

CREATE TABLE Menu(
  id_menu SERIAL PRIMARY KEY ,
  menu_name VARCHAR(50) UNIQUE,
  id_user INT REFERENCES "user"(id_user)
);

CREATE TABLE Is_Part_Of(
  id_recipe INT REFERENCES Recipe(id_recipe),
  id_menu INT REFERENCES Menu(id_menu),
  PRIMARY KEY (id_recipe,id_menu)
);

CREATE TABLE Note(
  id_recipe INT REFERENCES Recipe(id_recipe),
  id_user INT REFERENCES "user"(id_user),
  note INT ,
  PRIMARY KEY (id_recipe,id_user)
);

CREATE TABLE Comment(
  id_comment SERIAL PRIMARY KEY ,
  id_recipe INT REFERENCES Recipe(id_recipe),
  id_user INT REFERENCES "user"(id_user) ,
  comment_text TEXT
);

CREATE TABLE Description(
  id_description SERIAL PRIMARY KEY ,
  description_text TEXT ,
  date_added DATE ,
  id_recipe INT REFERENCES Recipe(id_recipe),
  id_user INT REFERENCES "user"(id_user)
);
-- Permet la suppression d'un menu
ALTER TABLE Is_Part_Of
    DROP CONSTRAINT is_part_of_id_menu_fkey;
ALTER TABLE Is_Part_Of
    ADD CONSTRAINT is_part_of_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE;

-- Permet la suppression d'un user
ALTER TABLE Note
    DROP CONSTRAINT note_id_user_fkey;
ALTER TABLE Note
    ADD CONSTRAINT note_id_user_fkey FOREIGN KEY (id_user) REFERENCES "user"(id_user) ON DELETE CASCADE ;

ALTER TABLE Comment
    DROP CONSTRAINT comment_id_user_fkey;
ALTER TABLE Comment
    ADD CONSTRAINT comment_id_user_fkey FOREIGN KEY (id_user) REFERENCES "user"(id_user) ON DELETE CASCADE ;

ALTER TABLE Description
    DROP CONSTRAINT description_id_user_fkey;
ALTER TABLE Description
    ADD CONSTRAINT description_id_user_fkey FOREIGN KEY (id_user) REFERENCES "user"(id_user) ON DELETE SET NULL;

ALTER TABLE Menu
    DROP CONSTRAINT menu_id_user_fkey;
ALTER TABLE Menu
    ADD CONSTRAINT menu_id_user_fkey FOREIGN KEY (id_user) REFERENCES "user"(id_user) ON DELETE SET NULL;