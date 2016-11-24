/*INSERT USER */
DELETE FROM "user";
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
