var recipe_index = 1;

function add_recipe(){
    var next_recipe = $("#main").clone();
    next_recipe.id = "";
    $(next_recipe).find(".recipe-name").attr("name", "recipe_" + recipe_index++);
    $(next_recipe).find(".recipe-name").val("");
    $(next_recipe).find(".recipe-id").attr("name", "id_recipe_" + recipe_index++);
    $(next_recipe).find(".recipe-id").val("");
    $("#recipes").append(next_recipe);
}

var selectedInput;
function select_input(input){
    selectedInput = input;
    console.log(input);
}

function select_recipe(recipe){
    var recipe_value = $(recipe).find(".caption p");
    $(selectedInput).find(".recipe-name").val(recipe_value.html());
    $(selectedInput).find(".recipe-id").val(recipe_value.attr("id-recipe"));
    add_recipe();
}