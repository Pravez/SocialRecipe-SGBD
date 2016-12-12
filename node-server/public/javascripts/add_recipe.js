var ingredient_index = 1;

function add_ingredient(){
    var next_ingredient = $("#main").clone();
    next_ingredient.id = "";
    $(next_ingredient).find(".ingredient-name").val("");
    $(next_ingredient).find(".ingredient-id").attr("name", "id_ingredient_" + ingredient_index++);
    $(next_ingredient).find(".ingredient-id").val("");
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
    }
}