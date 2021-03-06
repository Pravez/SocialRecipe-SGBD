var recipe_index = 1;

function add_recipe() {
    var next_recipe = $("#main").clone();
    next_recipe.id = "";
    $(next_recipe).find(".recipe-name").val("");
    $(next_recipe).find(".recipe-id").attr("name", "id_recipe_" + recipe_index++);
    $(next_recipe).find(".recipe-id").val("");
    $("#recipes").append(next_recipe);
}

var selectedInput;
var same = false;
function select_input(input) {
    if (selectedInput == input) same = true;
    else same = false;
    selectedInput = input;
}

function select_recipe(recipe) {
    if (same === false) {
        add_recipe();
    } else {
        var elem = $(".caption p[id-recipe=" + $(selectedInput).find(".recipe-id").val() + "]").parent().parent();
        $(elem).removeClass("active");
        $(elem).css("pointer-events", "auto");
    }
    var recipe_value = $(recipe).find(".caption p");
    $(selectedInput).find(".recipe-name").val(recipe_value.html());
    $(selectedInput).find(".recipe-id").val(recipe_value.attr("id-recipe"));
}

function remove_input(input) {
    if ($(input).id != "main" && $(input).find(".recipe-name").val() != "") {
        var elem = $(".caption p[id-recipe=" + $(input).find(".recipe-id").val() + "]").parent().parent();
        $(elem).removeClass("active");
        $(elem).css("pointer-events", "auto");
        $(input).remove();
    } else {
        $(input).find(".recipe-name").val("");
        $(input).find(".recipe-id").val("");
    }
}

$("#create").click(function (event) {
    if ($(".recipe-name").val() == "") {
        event.preventDefault();
        $(".recipe-name").focus();
    }
});