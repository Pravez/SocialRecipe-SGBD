let selected_servings = 2;

$("#servings-list").find("li a").on("click", function(e){
    $("#servings-list").find("li").removeClass("active");
    $(this).parent().addClass("active");
    selected_servings = parseInt($(this).parent().attr("id-selection"));
    search_value();
});

function test_servings(type, value, totest){
    if(value < 0)
        return true;

    switch(type){
        case 1:
            return value == totest;
        case 2:
            return value >= totest;
        case 3:
            return value <= totest;
    }

    return true;
}

function search_value(){
    let search_name = $("#search_name").val();
    let search_servings = $("#search_servings").val();
    if(search_servings === "")
        search_servings = -1;

    rows.forEach(function(e){
        if(e[name].match(new RegExp(search_name, 'i')) && test_servings(selected_servings, parseInt(search_servings), e[quantity])){
            document.querySelector('['+id_field+'="'+e[id]+'"]').style.display = "";
        }else{
            document.querySelector('['+id_field+'="'+e[id]+'"]').style.display = "none";
        }
    });
}

function search_value_temp(value, expression, attribute, id){
    rows.forEach((e) =>{
        if(!e[value].match(new RegExp(expression, 'i'))){
            document.querySelector('['+attribute+'="'+e[id]+'"]').style.display = "none";
        }else{
            document.querySelector('['+attribute+'="'+e[id]+'"]').style.display = "";
        }
    });
}