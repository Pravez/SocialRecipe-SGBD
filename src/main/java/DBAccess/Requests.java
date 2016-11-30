package main.java.DBAccess;


public class Requests {

    public static SQLRequest menus_all = new SQLRequest("SELECT * FROM menu WHERE menu_name LIKE '%@param%'");
    public static SQLRequest recipes_all = new SQLRequest("SELECT * FROM recipe WHERE recipe_name LIKE '%@param%'");
    public static SQLRequest ingredients_all = new SQLRequest("SELECT * FROM ingredient WHERE ingredient_name LIKE '%@param%'");

    public static SQLRequest categories_all = new SQLRequest("SELECT * FROM category");

}
