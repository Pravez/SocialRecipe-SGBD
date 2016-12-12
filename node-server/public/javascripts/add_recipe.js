var ingredient_index = 1;

function add_ingredient(){
    var next_ingredient = $("#main").clone();
    next_ingredient.id = "";
    $(next_ingredient).find(".ingredient-name").val("");
    $(next_ingredient).find(".ingredient-id").attr("name", "ingredient_id_" + ingredient_index);
    $(next_ingredient).find(".ingredient-id").val("");
    $(next_ingredient).find(".ingredient-quantity").attr("name", "ingredient_quantity_" + ingredient_index);
    $(next_ingredient).find(".ingredient-quantity").val("");
    $(next_ingredient).find(".ingredient-quantity").prop("required", false);
    $(next_ingredient).find(".ingredient-unit").attr("name", "ingredient_unit_" + ingredient_index++);
    $(next_ingredient).find(".ingredient-unit").val("");
    $(next_ingredient).find(".ingredient-unit").prop("required", false);
    $("#ingredients").append(next_ingredient);
}

var selectedInput;
var same = false;
function select_input(input){
    if (selectedInput == input) same = true;
    else same = false;
    selectedInput = input;
}

function select_ingredient(ingredient){
    if(same === false){
        add_ingredient();
    }else{
        var elem = $(".caption p[id-ingredient=" + $(selectedInput).find(".ingredient-id").val() + "]").parent().parent();
        $(elem).removeClass("active");
        $(elem).css("pointer-events", "auto");
    }
    var ingredient_value = $(ingredient).find(".caption p");
    $(selectedInput).find(".ingredient-name").val(ingredient_value.html());
    $(selectedInput).find(".ingredient-id").val(ingredient_value.attr("id-ingredient"));
    $(selectedInput).find(".ingredient-quantity").prop("required", true);
    $(selectedInput).find(".ingredient-unit").prop("required", true);
}

function remove_input(input){
    if($(input).id != "main" && $(input).find(".ingredient-name").val() != "") {
        var elem = $(".caption p[id-ingredient=" + $(input).find(".ingredient-id").val() + "]").parent().parent();
        $(elem).removeClass("active");
        $(elem).css("pointer-events", "auto");
        $(input).remove();
    }else{
        $(input).find(".ingredient-name").val("");
        $(input).find(".ingredient-id").val("");
        $(input).find(".ingredient-quantity").val("");
        $(input).find(".ingredient-unit").val("");

    }
}