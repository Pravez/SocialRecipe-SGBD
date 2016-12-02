var selected_servings = 0;

$("#servings-list").find("li a").on("click", function(e){
    $("#servings-list").find("li").removeClass("active");
    $(this).parent().addClass("active");
    selected_servings = $(this).parent().attr("id-selection");
    console.log(selected_servings);
});

function search_value(){
    var search_name = $("#search_name");
    var search_servings = $("#search_servings");



}

function search_value(value, expression, attribute, id){
    rows.forEach((e) =>{
        if(!e[value].match(new RegExp(expression, 'i'))){
            document.querySelector('['+attribute+'="'+e[id]+'"]').style.display = "none";
        }else{
            document.querySelector('['+attribute+'="'+e[id]+'"]').style.display = "";
        }
    });
}