var recipe_index = 0;


function add_recipe(){
    var next_recipe = $(".menu-input").clone()[0];
    next_recipe.name = "recipe_" + recipe_index;
    recipe_index ++;
    $("#recipes").append(next_recipe);
}